using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

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
        using (SqlConnection conn = glob.Connect())
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
        using (SqlConnection conn = glob.Connect())
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

}