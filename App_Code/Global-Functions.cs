using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Global_Functions
/// </summary>
public class Global_Functions
{


    public void CloseDB(SqlConnection conn)
    {
        conn.Close();
    }

    


    /// <summary>
    /// Checks to make sure a user is logged in
    /// </summary>
    /// <returns></returns>
    public  bool CheckAuthentication()
    {
        if (HttpContext.Current.Session["Auth"] != null)
        {
            if ((bool)HttpContext.Current.Session["Auth"] == true)
            {
                return true;
            }
            
        }
        return false;
    }
    /// <summary>
    /// Gets First and Last Name and UserID from UserName
    /// </summary>
    /// <param name="UserName"></param>
    /// <returns>returns concat String 1-FName,2-LName,3-UserID</returns>
    public string GetUserInfo(string UserName)
    {
        string returnString = "";
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
        {
            
            conn.Open();
            string sql = "select FName,LName,UserID FROM FORUM_USER where UserName=@UserName";
            SqlCommand cmd = new SqlCommand(sql,conn);
            cmd.Parameters.Add(new SqlParameter("@UserName", UserName));
            SqlDataReader dr = cmd.ExecuteReader();
            while(dr.Read())
            {
                returnString = (string)dr["FName"];
                returnString += "-";
                returnString += (string)dr["LName"];
                returnString += "-";
                returnString += (string)dr["UserID"].ToString();
            }
            dr.Close();
            conn.Dispose();
        }
        return returnString;
    }
}