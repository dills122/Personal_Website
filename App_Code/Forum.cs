using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for Forum
/// </summary>
public class Forum
{
    Global_Functions glob = new Global_Functions();
    public Forum()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    /// <summary>
    /// Method Used for getting all the Parent Comments on a Post
    /// </summary>
    /// <param name="PostID"></param>
    /// <returns></returns>
    public DataSet GetParentComments(int PostID)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {
            conn.Open();
            string sql = "select FCT.UserID, CommentText, FCT.DatePosted FROM FORUM_COMMENT_TREE as FCT inner join FORUM_POST as FP on FP.ReplyGroupID = FCT.GroupID where FP.PostID = @PostID and ParentID is null";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@PostID", PostID));
            SqlDataAdapter DA = new SqlDataAdapter();
            DataSet DS = new DataSet();
            DA.Fill(DS, "ParentComments");

            glob.CloseDB(conn);
            return DS;
        }
        
    }

    /// <summary>
    /// Method used for getting all of the child comments for a specific parent comment
    /// </summary>
    /// <param name="ParentID"></param>
    /// <returns></returns>
    public DataSet GetChildComments(int ParentID)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {
            conn.Open();
            string sql = "select UserID, CommentText, DatePosted FROM FORUM_COMMENT_TREE where ParentID=@ParentID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@ParentID", ParentID));
            SqlDataAdapter DA = new SqlDataAdapter();
            DataSet DS = new DataSet();
            DA.Fill(DS, "ChildComments");

            glob.CloseDB(conn);
            return DS;
        }
    }

    public void CreateUser(string FName, string LName, string UserName, string Pass, string Email)
    {
        string EncryptPass = Encryption.Encrypt(Pass, Encryption.GetPassPhrase());

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {
            conn.Open();
            string sql = "insert into FORUM_USER (FName,LName,UserName, Email, Password,Created) Values (@FName, @LName, @UserName, @Email, @Pass, @Created)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@FName", FName));
            cmd.Parameters.Add(new SqlParameter("@LName", LName));
            cmd.Parameters.Add(new SqlParameter("@UserName", UserName));
            cmd.Parameters.Add(new SqlParameter("@Pass", EncryptPass));
            cmd.Parameters.Add(new SqlParameter("@Email", Email));
            cmd.Parameters.Add(new SqlParameter("@Created", DateTime.Now.ToString()));
            cmd.ExecuteNonQuery();
        }
    }

    public static bool ActivateUser(string ActivateKey)
    {
        bool returnval = false;
        int UserID = 0;
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ConnectionString))
        {
            conn.Open();
            string sql = "select UserID FROM FORUM_ACTIVATE where ValidationKey=@ValidationKey";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@Activate", ActivateKey));
            SqlDataReader dr = cmd.ExecuteReader();
            
            while(dr.Read())
            {
                UserID = (int)dr["UserID"];
                dr.Close();
                
                sql = "UPDATE FORUM_ACTIVATE SET Active=1 where UserID=@UserID";
                cmd = new SqlCommand(sql, conn);
                if (cmd.ExecuteNonQuery() > 0)
                {
                    returnval = true;
                }
            }
            dr.Close();
            
        }
        return returnval;
    }
    public static bool AuthenticateUser(string UserName, string Password)
    {

        bool Valid = false;
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {


            conn.Open();
            String sql = "select Password, UserID, FName, LName FROM FORUM_USER where UserName=@UserName";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@UserName", UserName));
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    if (Password == Encryption.Decrypt(dr["Password"].ToString(), Encryption.GetPassPhrase().ToString()))
                    {
                        Valid = true;
                        
                    }
                    else
                    {
                        Valid = false;
                    }
                }
            }
            else
            {
                Valid = false;
            }

            dr.Close();
            Global_Functions globl = new Global_Functions();
            globl.CloseDB(conn);
        }
        return Valid;
    }
}