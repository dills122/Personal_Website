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
    /// <summary>
    /// Gets the information for a Code Example
    /// </summary>
    /// <param name="ID"></param>
    /// <returns></returns>
	public static DataTable GetCodeExample(int ID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT project_name, project_description,PF.server_location,PF.web_location,LC.language_text, PF.file_name,P.ID, P.language_id FROM PROJECT AS P ";
                   sql += " LEFT JOIN PROJECT_FILE AS PF on PF.ID = P.file_id ";
                   sql += " INNER JOIN LANGUAGE_CODE AS LC on LC.ID = P.language_id ";
                   sql += " where P.active = 1  and P.ID = @ID";
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
    /// <summary>
    /// Gets Code Blocks Snippets for a code example
    /// </summary>
    /// <param name="ID"></param>
    /// <returns></returns>
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
    /// <summary>
    /// Gets the Top 10 Newst Projects
    /// </summary>
    /// <returns></returns>
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
    /// <summary>
    /// Used to Create a New Admin Account
    /// </summary>
    /// <param name="UserName"></param>
    /// <param name="Password"></param>
    public static void InsertAdmin(string UserName, string Password)
    {
        string salt = Global_Functions.SaltGenerator();
        string hashPass = Global_Functions.GetHashString(Password,salt);

        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "INSERT INTO WEBSITE_ADMIN (username, password,last_login,active,salt) VALUES (@Username, @Password, @LastLogin, @Active, @Salt)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@Username", UserName));
            cmd.Parameters.Add(new SqlParameter("@Password", hashPass));
            cmd.Parameters.Add(new SqlParameter("@Salt", salt));
            cmd.Parameters.Add(new SqlParameter("@LastLogin", DateTime.Now));
            cmd.Parameters.Add(new SqlParameter("@Active", 1));
            cmd.ExecuteNonQuery();
        }
            
    }
    /// <summary>
    /// Verifies Login Information
    /// </summary>
    /// <param name="UserName"></param>
    /// <param name="Password"></param>
    /// <returns></returns>
    public static bool CheckLogin(string UserName, string Password)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT salt,password FROM WEBSITE_ADMIN WHERE username=@Username";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@Username", UserName));
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    if(Global_Functions.GetHashString(Password, dr["salt"].ToString()) == dr["password"].ToString())
                    {
                        UpdateLastLogin(UserName);
                        dr.Close();
                        conn.Close();
                        conn.Dispose();
                        return true;
                    }
                }
                dr.Close();
            }
        }
        return false;
    }
    /// <summary>
    /// Adds a New Login Time Stamp
    /// </summary>
    /// <param name="UserName"></param>
    public static void UpdateLastLogin(string UserName)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "UPDATE WEBSITE_ADMIN SET last_login=@LastLogin WHERE username=@Username";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@LastLogin", DateTime.Now));
            cmd.Parameters.Add(new SqlParameter("@Username", UserName));
            cmd.ExecuteNonQuery();

            conn.Close();
            conn.Dispose();
        }
    }
    /// <summary>
    /// Gets Top 10 Language Projects
    /// </summary>
    /// <param name="LanguageID"></param>
    /// <returns></returns>
    public static DataTable GetTopLanguageProjects(int LanguageID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT TOP 10 ID, project_name  FROM PROJECT WHERE language_id=@LanguageID ORDER BY ID DESC";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@LanguageID", LanguageID));
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

   
}