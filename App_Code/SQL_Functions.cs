using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SQL_Functions
/// </summary>
public class SQL_Functions
{
	public static DataTable GetCodeExample(int ID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT project_name, project_description,PF.server_location,PF.web_location,LC.language_text, PF.file_name,P.ID FROM PROJECT AS P ";
                   sql += " LEFT JOIN PROJECT_FILE AS PF on PF.ID = P.file_id ";
                   sql += " INNER JOIN LANGUAGE_CODE AS LC on LC.ID = P.language_id ";
                   sql += " where P.active = 1 and PF.active = 1 and P.ID = @ID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@ID", ID));
            using (SqlDataAdapter DA = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                DA.Fill(dt);

                conn.Close();
                conn.Dispose();
                return dt;
            }
            
        }
    }

    public static DataTable GetCodeSamples(int ID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT example_title,example_description,example_body FROM EXAMPLE_CODE WHERE ID=@ExampleID and active=1";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@ExampleID", ID));
            using (SqlDataAdapter DA = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                DA.Fill(dt);
                return dt;
            }
        }
    }

    public static DataTable GetNewestExamples()
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT TOP 10 ID, project_name  FROM PROJECT ORDER BY ID DESC";
            SqlCommand cmd = new SqlCommand(sql, conn);
            using (SqlDataAdapter DA = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                DA.Fill(dt);
                return dt;
            }
        }
    }
}