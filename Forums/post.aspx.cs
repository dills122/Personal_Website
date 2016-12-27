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
            FillComments();
            Session["UserID"] = "1";

            Button btn = (Button)Content.FindControl("Postbtn");
            btn.Enabled = false;
            TextBox txt = (TextBox)Content.FindControl("CommentBox");
            txt.Enabled = false;
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
            HeaderPnl.CssClass = "page-header";
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
        glob.CloseDB(conn);
    }
    /// <summary>
    /// Creates the Comment Area for posting new replies to a post
    /// </summary>
    protected void NewCommentArea()
    {
        TextBox CommentTxt = new TextBox();
        CommentTxt.ClientIDMode = ClientIDMode.Static;
        CommentTxt.ID = "CommentBox";
        CommentTxt.TextMode = TextBoxMode.MultiLine;
        CommentTxt.Rows = 4;

        Button PostBtn = new Button();
        PostBtn.Text = "Post";
        PostBtn.Click += new EventHandler(PostClick);
        PostBtn.ClientIDMode = ClientIDMode.Static;
        PostBtn.ID = "Postbtn";
        PostBtn.Style.Add("float", "right");
        PostBtn.Style.Add("height", "25px");

        Panel NewComment = new Panel();
        NewComment.CssClass = "CommentArea";
        NewComment.CssClass = "well";

        Panel InnerCommentpnl = new Panel();
        InnerCommentpnl.CssClass = "InnerComment";
        InnerCommentpnl.Controls.Add(new LiteralControl("<h4> Enter New Reply: </h4>"));
        InnerCommentpnl.Controls.Add(CommentTxt);
        InnerCommentpnl.Controls.Add(new LiteralControl("<br/>"));

        Panel Floater = new Panel();
        Floater.Style.Add("padding-top", "5px");
        Floater.Controls.Add(new LiteralControl("<small style=\"float:left;\"> Maximum character count is 500 </small>"));
        Floater.Controls.Add(PostBtn);
        Floater.Controls.Add(new LiteralControl("<br/><br/>"));
        InnerCommentpnl.Controls.Add(Floater);
        NewComment.Controls.Add(InnerCommentpnl);

        Content.Controls.Add(NewComment);
    }

    protected void FillComments()
    {
        SqlConnection conn = glob.Connect();
        conn.Open();
        string sql = "select (U.FName + ' ' + U.LName) as FullName, FGI.ReplyText, FGI.DatePosted FROM FORUM_POST as FP inner join FORUM_GROUP_ITEM as FGI on FGI.GroupID = FP.ReplyGroupID inner join FORUM_USER as U on U.UserID = FP.UserID where FP.PostID = @PostID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@PostID", Request.QueryString["PostID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while(dr.Read())
        {
            Panel NewComment = new Panel();
            NewComment.CssClass = "CommentArea";
            NewComment.CssClass = "well";
     

            NewComment.Controls.Add(new LiteralControl("<h3>" + dr["FullName"] + "</h3>"));
            NewComment.Controls.Add(new LiteralControl("<br/>"));
            NewComment.Controls.Add(new LiteralControl("<p>" + dr["ReplyText"] + "</p>"));
            NewComment.Controls.Add(new LiteralControl("<br/>"));
            NewComment.Controls.Add(new LiteralControl("<p style=\"float:left; font-size:medium;\">" + "<a id=\"testPostbtn\">Comment</a>" + "</p>"));
            NewComment.Controls.Add(new LiteralControl("<small style=\"float:right\">" + dr["DatePosted"] + "</small>"));
            NewComment.Controls.Add(new LiteralControl("<br/>"));
            NewComment.Controls.Add(new LiteralControl("</div><div style=\"clear: both; \"></div>"));        


            Content.Controls.Add(NewComment);
        }
        dr.Close();
    }

    protected void ForgotPasslb_Click(object sender, EventArgs e)
    {

    }

    protected void Loginbtn_Click(object sender, EventArgs e)
    {
        if (glob.AuthenticateUser(UserNametxt.Text,Passwordtxt.Text) == true )
        {
            LoginPanel();
        }
        else
        {

        }
    }

    /// <summary>
    /// Adds the New post to the Database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PostClick(object sender, EventArgs e)
    {
        bool GroupExist = false;
        int GroupID = 0;
        SqlConnection conn = glob.Connect();
        conn.Open();
        string sql = "select ReplyGroupID FROM FORUM_POST where PostID=@PostID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@PostID", Request.QueryString["PostID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if(dr["ReplyGroupID"] != System.DBNull.Value)
            {
                GroupExist = true;
                GroupID = (int)dr["ReplyGroupID"];
            }
            else
            {
                GroupExist = false;
            }
        }
        dr.Close();
            

        if (GroupExist == false)
        {
            sql = "insert into FORUM_GROUP (DateCreated) Output inserted.GroupID Values (GETDATE())";
            cmd = new SqlCommand(sql, conn);
            GroupID = (int)cmd.ExecuteScalar();
        }
        TextBox txt = (TextBox)Content.FindControl("CommentBox");


        sql = "insert into FORUM_GROUP_ITEM (GroupID, ReplyText, UserID, DatePosted) Values (@GroupID, @ReplyText, @UserID, GetDate())";
        cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@GroupID", GroupID));
        cmd.Parameters.Add(new SqlParameter("@ReplyText", txt.Text));
        cmd.Parameters.Add(new SqlParameter("@UserID", Session["UserID"]));
        cmd.ExecuteNonQuery();


    }
}