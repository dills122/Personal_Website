using System;
using System.Collections.Generic;
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
    }

    protected void FillNewestPosts()
    {
        SqlConnection conn = glob.Connect();
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

    protected void ForgotPasslb_Click(object sender, EventArgs e)
    {

    }

    protected void Loginbtn_Click(object sender, EventArgs e)
    {

    }

    /// <summary>
    /// Handles Storing the new post in the database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PostUpload_Click(object sender, EventArgs e)
    {
        if( String.IsNullOrEmpty(PostTitle.Text) != true && String.IsNullOrEmpty(ContentBodytb.Text) != true)
        {
            //Doesn't Work yet need to add in user login so Sessions Work
            SqlConnection conn = glob.Connect();
            conn.Open();
            string sql = "insert into FORUM_POST (PostName, PostText, UserID, PostDate) Values (@PostName, @PostText, @UserID, @PostDate)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@PostName", PostTitle.Text));
            cmd.Parameters.Add(new SqlParameter("@PostText", ContentBodytb.Text));
            cmd.Parameters.Add(new SqlParameter("@UserID", Session["UserID"]));
            cmd.Parameters.Add(new SqlParameter("@PostDate", DateTime.Now));
            int rows = cmd.ExecuteNonQuery();

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
            HeaderPnl.Controls.Add(new LiteralControl("<small>" + "Test, Post" + "&nbsp;&nbsp;&nbsp;&nbsp;" + DateTime.Now + "</small>"));
            Previewpnl.Controls.Add(HeaderPnl);

            Previewpnl.Controls.Add(new LiteralControl(ContentBodytb.Text));
            Previewpnl.Controls.Add(new LiteralControl("<br/>"));
            Previewpnl.Visible = true;
            Previewtxt.Visible = true;
        }
    }
}