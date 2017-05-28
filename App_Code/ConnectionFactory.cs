using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConnectionFactory
/// </summary>
public class ConnectionFactory
{
    public static SqlConnection DistributeConnection(string ConnectionID)
    {
        try
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ConnectionString);
            return conn;
        }
        catch (Exception ex)
        {
            throw new Exception("Database not found with given connection Identity");
        }
    }
}