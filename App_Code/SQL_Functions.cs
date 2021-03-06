﻿using System;
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
            string sql = "SELECT project_name, project_description,LC.language_text,P.ID, P.language_id FROM PROJECT AS P ";
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
            string sql = "SELECT TOP 10 ID, project_name FROM PROJECT WHERE active=1 ORDER BY ID DESC";
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
    /// Gets all of the files for the project
    /// </summary>
    /// <param name="ID"></param>
    /// <returns></returns>
    public static DataTable GetCodeFiles(int ID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT file_name,web_location,server_location FROM PROJECT_FILE WHERE project_id=@project_id and active=1";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@project_id", ID));
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
            string sql = "SELECT TOP 10 ID, project_name FROM PROJECT WHERE language_id=@LanguageID AND active=1 ORDER BY ID DESC";
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

   public static bool InsertSpecialAnnouc(string title, string description, string postDate)
    {

        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "INSERT INTO SPECIAL_ANNOUCEMENT (annoucement_title, annoucement_description, post_date, created_date, active) VALUES (@annoucement_title, @annoucement_description, @post_date, @created_date, @active)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@annoucement_title", title));
            cmd.Parameters.Add(new SqlParameter("@annoucement_description", description));
            cmd.Parameters.Add(new SqlParameter("@post_date", postDate));
            cmd.Parameters.Add(new SqlParameter("@created_date", DateTime.Now.ToShortDateString()));
            cmd.Parameters.Add(new SqlParameter("@active", 1));

           if( cmd.ExecuteNonQuery() > 0)
            {
                conn.Close();
                conn.Dispose();
                return true;
            }
            conn.Close();
            conn.Dispose();
            return false;
        }
       
    }

    public static DataTable GetFeedAnnoucements()
    {

        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT ID, annoucement_title, annoucement_description, post_date FROM SPECIAL_ANNOUCEMENT WHERE active=1 and post_date<=GETDATE() ORDER BY post_date DESC";
            SqlCommand cmd = new SqlCommand(sql, conn);

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

    public static DataTable GetNewestVersions()
    {

        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "SELECT ID,version,version_title, version_description, post_date FROM VERSION_ANNOUCEMENT WHERE active=1 AND post_date<= GETDATE() ORDER BY post_date DESC";
            SqlCommand cmd = new SqlCommand(sql, conn);

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

    public static bool InsertVersion(string title, string description,string version, string postDate)
    {

        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "INSERT INTO VERSION_ANNOUCEMENT (version, version_title,version_description, post_date, created_date, active) VALUES (@version, @version_title,@version_description, @post_date, @created_date, @active)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@version", version));
            cmd.Parameters.Add(new SqlParameter("@version_title", title));
            cmd.Parameters.Add(new SqlParameter("@version_description", description));
            cmd.Parameters.Add(new SqlParameter("@post_date", postDate));
            cmd.Parameters.Add(new SqlParameter("@created_date", DateTime.Now.ToShortDateString()));
            cmd.Parameters.Add(new SqlParameter("@active", 1));

            if (cmd.ExecuteNonQuery() > 0)
            {
                conn.Close();
                conn.Dispose();
                return true;
            }
            conn.Close();
            conn.Dispose();
            return false;
        }

    }

    public static int InsertProject(string name, string description, int langID, int fileID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "";
            if (fileID == 0)
            {
                sql = "INSERT INTO PROJECT ( language_id, project_description, project_name, active) OUTPUT INSERTED.ID VALUES ( @language_id, @project_description, @project_name, @active)";
            }
            else
            {
                sql = "INSERT INTO PROJECT ( language_id, project_description, project_name, active,file_id) OUTPUT INSERTED.ID VALUES ( @language_id, @project_description, @project_name, @active,@file_id)";
            }
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@project_name", name));
            cmd.Parameters.Add(new SqlParameter("@project_description", description));
            cmd.Parameters.Add(new SqlParameter("@language_id", langID));
            if(fileID > 0)
            {
                cmd.Parameters.Add(new SqlParameter("@file_id", fileID));
            }        
            cmd.Parameters.Add(new SqlParameter("@active", 1));

            int ProjID = cmd.ExecuteNonQuery();
            if (ProjID > 0)
            {
                conn.Close();
                conn.Dispose();
                return ProjID;
            }
            conn.Close();
            conn.Dispose();
            return 0;
        }
    }

    public static int InsertProjectFile(string name, string webLocation, int fileType)
    {
        string serverLoc = webLocation.Replace('/', '\\');
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "INSERT INTO PROJECT_FILE(file_name,file_type,server_location,web_location,active) OUTPUT INSERTED.ID VALUES(@file_name,@file_type,@server_location,@web_location,@active)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@file_name", name));
            cmd.Parameters.Add(new SqlParameter("@file_type", fileType));
            cmd.Parameters.Add(new SqlParameter("@server_location", serverLoc));
            cmd.Parameters.Add(new SqlParameter("@web_location", webLocation));
            cmd.Parameters.Add(new SqlParameter("@active", 1));

            int id = cmd.ExecuteNonQuery();
            if ( id > 0)
            {
                conn.Close();
                conn.Dispose();
                return id;
            }
            conn.Close();
            conn.Dispose();
            return 0;
        }
    }

    public static bool InsertExampleCode(string title, string description, string body, int ProjectID)
    {
        using (SqlConnection conn = ConnectionFactory.DistributeConnection("DB"))
        {
            conn.Open();
            string sql = "INSERT INTO EXAMPLE_CODE (ID, example_title, example_description, active, example_body) VALUES (@ID, @example_title, @example_description, @active, @example_body)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@ID", ProjectID));
            cmd.Parameters.Add(new SqlParameter("@example_title", title));
            cmd.Parameters.Add(new SqlParameter("@example_description", description));
            cmd.Parameters.Add(new SqlParameter("@example_body", body));
            cmd.Parameters.Add(new SqlParameter("@active", 1));

            if (cmd.ExecuteNonQuery() > 0)
            {
                conn.Close();
                conn.Dispose();
                return true;
            }
            conn.Close();
            conn.Dispose();
            return false;
        }
    }
}