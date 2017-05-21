using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forums_new_post : System.Web.UI.Page
{
    Global_Functions glob = new Global_Functions();
    protected void Page_Load(object sender, EventArgs e)
    {
        FillNewestPosts();
        LoginPanel();
        AuthCheck();
        
    }
    protected void AuthCheck()
    {
        if (Session["Auth"] != null)
        {
            if ((bool)Session["Auth"] == true)
            {
                InnerContent.Visible = true;

            }
            else
            {
                InnerContent.Visible = false;
                NewPostContent.Controls.Add(new LiteralControl("You are not Logged in. <br/>Please login to continue,"));
            }
        }
        else
        {
            InnerContent.Visible = false;
            NewPostContent.Controls.Add(new LiteralControl("You are not Logged in. <br/>Please login to continue,"));
        }
    }

    protected void FillNewestPosts()
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {
            conn.Open();
            string sql = "select PostName, PostID FROM FORUM_POST where PostID between (select MAX(PostID) FROM FORUM_POST) - 10 and (select MAX(PostID) FROM FORUM_POST)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                string baseURL = Request.Url.Scheme + "://" + Request.Url.Authority +
                Request.ApplicationPath.TrimEnd('/') + "/";


                Posts.Controls.Add(new LiteralControl("<b>Current Posts</b>"));
                Posts.Controls.Add(new LiteralControl("<br/><br/>"));

                while (dr.Read())
                {
                    if (Posts != null)
                    {
                        string linkstr = "<a href=\"" + baseURL + "/Forums/post.aspx?PostID=" + dr["PostID"] + "\">" + dr["PostName"] + "</a>";
                        //Add in the code to create a link to the recent posts
                        Posts.Controls.Add(new LiteralControl(linkstr));
                        Posts.Controls.Add(new LiteralControl("<br/>"));
                    }
                }
            }
            dr.Close();
        }
    }

    protected void ForgotPasslb_Click(object sender, EventArgs e)
    {

    }

    protected void Loginbtn_Click(object sender, EventArgs e)
    {
        if (Forum.AuthenticateUser(UserNametxt.Text, Passwordtxt.Text) == true)
        {
            string[] UserArry = glob.GetUserInfo(UserNametxt.Text).Split('-');
            //Sets the Session Variables
            HttpContext.Current.Session["Auth"] = true;
            HttpContext.Current.Session["UserID"] = UserArry[2];
            HttpContext.Current.Session["FName"] = UserArry[0];
            HttpContext.Current.Session["LName"] = UserArry[1];

            LoginPanel();
            AuthCheck();
            
        }
        else
        {

        }
    }
    /// <summary>
    /// Sets the Login Panel visibility
    /// </summary>
    protected void LoginPanel()
    {
        if (Session["Auth"] != null)
        {
            if ((bool)Session["Auth"] == true)
            {
                Loginpnl.Visible = false;
                LoggedInpnl.Visible = true;
                //LoggedInpnl.Controls.Add(new LiteralControl("<br/><br/>"));
                LoggedInpnl.Controls.Add(new LiteralControl("Welcome,<br/>"));
                LoggedInpnl.Controls.Add(new LiteralControl(Session["FName"].ToString() + " " + Session["LName"].ToString()));
                Button LogOffBtn = new Button();
                LogOffBtn.Text = "Log Off";
                LogOffBtn.Click += new EventHandler(this.LogOff_Click);
                LoggedInpnl.Controls.Add(new LiteralControl("<br/><br/>"));
                LoggedInpnl.Controls.Add(LogOffBtn);

            }
            else
            {
                Loginpnl.Visible = true;
                LoggedInpnl.Visible = false;
            }
        }
    }

    /// <summary>
    /// Handles Storing the new post in the database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PostUpload_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(PostTitle.Text) != true && String.IsNullOrEmpty(ContentBodytb.Text) != true)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
            {
                conn.Open();
                string sql = "insert into FORUM_POST (PostName, PostText, UserID, PostDate) Values (@PostName, @PostText, @UserID, @PostDate)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add(new SqlParameter("@PostName", PostTitle.Text));
                cmd.Parameters.Add(new SqlParameter("@PostText", ContentBodytb.Text));
                cmd.Parameters.Add(new SqlParameter("@UserID", Session["UserID"]));
                cmd.Parameters.Add(new SqlParameter("@PostDate", DateTime.Now));
                int rows = cmd.ExecuteNonQuery();
                FillNewestPosts();
            }
        }
    }

    protected void Previewbtn_Click(object sender, EventArgs e)
    {
        if( String.IsNullOrEmpty(ContentBodytb.Text) != true && String.IsNullOrEmpty(PostTitle.Text) != true)
        {

            Panel HeaderPnl = new Panel();
            HeaderPnl.CssClass = "page-header";
            HeaderPnl.Controls.Add(new LiteralControl("<h1>" + PostTitle.Text + "</h1>"));
            HeaderPnl.Controls.Add(new LiteralControl("<br/>"));
            HeaderPnl.Controls.Add(new LiteralControl("<small>" + Session["LName"] + ", " + Session["FName"]  + "&nbsp;&nbsp;&nbsp;&nbsp;" + DateTime.Now + "</small>"));
            Previewpnl.Controls.Add(HeaderPnl);

            Previewpnl.Controls.Add(new LiteralControl(ContentBodytb.Text));
            Previewpnl.Controls.Add(new LiteralControl("<br/>"));
            Previewpnl.Visible = true;
            Previewtxt.Visible = true;
        }

    }
    protected void LogOff_Click(object sender, EventArgs e)
    {
        Session["Auth"] = false;
        Session["UserID"] = "";
        Session["FName"] = "";
        Session["LName"] = "";
        LoginPanel();
    }
}