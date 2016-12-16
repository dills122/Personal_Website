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


}