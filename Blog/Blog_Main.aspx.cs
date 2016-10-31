using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Blog_Blog_Main : System.Web.UI.Page
{
    Global_Functions glob = new Global_Functions();

    protected void Page_Load(object sender, EventArgs e)
    {
        Mainpnl.Visible = false;
             Postpnl.Visible = true;

        //if (IsPostBack == true)
        //{
        //    int ID = Convert.ToInt16(Request.QueryString["ID"]);
        //    if (ID != 0)
        //    {
        //        Mainpnl.Visible = false;
        //        Postpnl.Visible = true;
        //        ConstructTextField(ID);
        //        ConstructCommentArea(ID);
        //    }
        //}
        //else
        //{
        //    //Fills the Current Posts Area 
        //    SqlConnection conn =  glob.Connect();
        //    conn.Open();
        //    //SQL for retrieving the 10 most recent posts
        //    string sql = "";
        //    SqlCommand cmd = new SqlCommand(sql, conn);
        //    SqlDataReader dr = cmd.ExecuteReader();
        //    while(dr.Read())
        //    {

        //    }
        //    dr.Close();
        //    glob.CloseDB(conn);
        //}
    }

    protected void ConstructTextField(int ID)
    {
        SqlConnection conn = glob.Connect();
        conn.Open();
        
        string sql = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
    }
    protected void ConstructCommentArea(int ID)
    {
        
        //Commentspnl.Controls.Add();

        SqlConnection conn = glob.Connect();
        conn.Open();
        
        string sql = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
    }

    protected void NewCommentbtn_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrWhiteSpace(NewComment.Text.ToString()) == false || String.IsNullOrEmpty(NewComment.Text.ToString()) == false)
        {
            SqlConnection conn = glob.Connect();
            conn.Open();
            //Add the new comment to the database
            string sql = "";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
        }
        else
        {

        }
    }
}