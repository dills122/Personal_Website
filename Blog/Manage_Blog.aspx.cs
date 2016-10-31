using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Blog_Manage_Blog : System.Web.UI.Page
{
    Global_Functions glob = new Global_Functions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            Lockpnl.Visible = true;
            Managepnl.Visible = false;
        }
        else
        {
            if (Session["Pass"].ToString() == "True")
            {
                Managepnl.Visible = true;
                Lockpnl.Visible = false;
            }
        }
    }

    protected void EnterCodebtn_Click(object sender, EventArgs e)
    {
        SqlConnection conn =  glob.Connect();
        conn.Open();
        string sql = "select Passcode FROM PASS_CODES where ID=1";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["Passcode"].ToString() == PassCode.Text.ToString())
            {
                Lockpnl.Visible = false;
                Managepnl.Visible = true;
                Session["Pass"] = "True";
            }
            else
            {
                Errorlb.Visible = true;
                Session["Pass"] = "False";
            }
        }
        dr.Close();
        glob.CloseDB(conn);
    }


    protected void NewPost_Click(object sender, EventArgs e)
    {
        if(Postpnl.Visible == false)
        {
            Postpnl.Visible = true;
        }
        else
        {
            Postpnl.Visible = false;
        }
    }

    /// <summary>
    /// Adding New Post to the Blog
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Unnamed_Click(object sender, EventArgs e)
    {
        if(String.IsNullOrEmpty(PostNametb.Text.ToString()) == false || String.IsNullOrEmpty(Bodytb.Text.ToString()) == false )
        {
            SqlConnection conn = glob.Connect();
            conn.Open();
            string sql = "insert into BLOG_POSTS (BlogName, Text, Date) Values (@Name, @Text, @Date)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@Name", PostNametb.Text.ToString()));
            cmd.Parameters.Add(new SqlParameter("@Text", Bodytb.Text.ToString()));
            cmd.Parameters.Add(new SqlParameter("@Date", DateTime.Now.ToString()));
            cmd.ExecuteNonQuery();
        }
        else
        {

        }
    }
    /// <summary>
    /// Handles Setting the Session Variables 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Unnamed_Click1(object sender, EventArgs e)
    {
        Session["PageContents"] = Bodytb.Text;
         
    }
}