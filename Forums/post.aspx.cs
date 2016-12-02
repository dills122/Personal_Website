using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forums_post : System.Web.UI.Page
{
    Global_Functions glob = new Global_Functions();
    protected void Page_Load(object sender, EventArgs e)
    {
        FillNewestPosts();
        if(Request.QueryString["PostID"] != null)
        {
            Post();
            NewCommentArea();
        }
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

    protected void LoginPanel()
    {
        bool Auth = (bool)Session["Login"];
        if (Auth == true)
        {

        }
        else
        {

        }
    }
    /// <summary>
    /// Method for checking if the user is looking for a post or the main page
    /// </summary>
    protected void Post()
    {
        SqlConnection conn = glob.Connect();
        conn.Open();
        string sql = "select PostName, (FU.LName + ', ' + FU.FName) as FullName, FP.PostDate FROM FORUM_POST as FP inner join FORUM_USER as FU on FU.UserID = FP.UserID where PostID = @PostID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@PostID", Request.QueryString["PostID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Panel HeaderPnl = new Panel();
            HeaderPnl.Attributes["class"] = "page-header";
            HeaderPnl.Controls.Add(new LiteralControl("<h1>" + dr["PostName"] + "</h1>"));
            HeaderPnl.Controls.Add(new LiteralControl("<br/>"));
            HeaderPnl.Controls.Add(new LiteralControl("<small>" + dr["FullName"] + "&nbsp;&nbsp;&nbsp;&nbsp;" + dr["PostDate"] + "</small>"));
            Content.Controls.Add(HeaderPnl);
        }
        dr.Close();

        sql = "select PostText FROM FORUM_POST where PostID=@PostID";
        cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@PostID", Request.QueryString["PostID"]));
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Panel Body = new Panel();
            Body.Controls.Add(new LiteralControl("<br/><br/>"));
            Body.Controls.Add(new LiteralControl("<p class=\"lead\">" + dr["PostText"] + "</p>"));
            Content.Controls.Add(Body);
        }
        dr.Close();

    }
    protected void NewCommentArea()
    {
        TextBox CommentTxt = new TextBox();
        CommentTxt.ID = "CommentBox";

        Button PostBtn = new Button();
        PostBtn.Text = "Post";
        PostBtn.Click += new EventHandler(PostClick);

        Panel NewComment = new Panel();
        NewComment.Attributes["class"] = "CommentArea";
        NewComment.Controls.Add(new LiteralControl("<h4> Enter New Reply: </h4>"));
        NewComment.Controls.Add(CommentTxt);
        NewComment.Controls.Add(new LiteralControl("<br/>"));
        NewComment.Controls.Add(new LiteralControl("<small> Maximum character count is 500 </small>"));
        NewComment.Controls.Add(PostBtn);

        Content.Controls.Add(NewComment);
    }


    protected void ForgotPasslb_Click(object sender, EventArgs e)
    {

    }

    protected void Loginbtn_Click(object sender, EventArgs e)
    {

    }

    protected void PostClick(object sender, EventArgs e)
    {

    }
}