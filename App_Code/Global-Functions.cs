using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Global_Functions
/// </summary>
public class Global_Functions
{
    public string conString = "Data Source=SQL5016.SmarterASP.NET;Initial Catalog=DB_A105F9_WEBSITE;User Id=DB_A105F9_WEBSITE_admin;Password=Skittles122;";


    public string getConString()
    {
        return conString;
    }
    public SqlConnection Connect()
    {
        SqlConnection conn = new SqlConnection(conString);
        return conn;
    }
    public void CloseDB(SqlConnection conn)
    {
        conn.Close();
    }

    public bool AuthenticateUser(string UserName, string Password)
    {
        
        bool Valid = false;
        SqlConnection conn = Connect();
        conn.Open();
        String sql = "select Password FROM FORUM_USER where UserName=@UserName";
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
        CloseDB(conn);

        return Valid;
    }



    public void SetSession()
    {
        HttpContext.Current.Session["Auth"] = true;
        HttpContext.Current.Session["Auth"] = true;
    }
}