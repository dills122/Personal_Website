using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Stock_Trader_sign_up : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Submitbtn_Click(object sender, EventArgs e)
    {
        if (CheckPage() == true)
        {


            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DB"].ToString()))
            {
                try
                {
                    conn.Open();
                    string sql = "SELECT UserID FROM STOCK_USER where Username=@Username";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.Add(new SqlParameter("@Username", Usernametb.Text.ToString()));
                    string str = (string)cmd.ExecuteScalar();
                    if ((string)cmd.ExecuteScalar() == null)
                    {
                        string HashedPass = Encryption.HashPassword(Passwordtb.Text);
                        sql = "INSERT INTO STOCK_USER (Username, Password_Hash, FName, LName) Values (@Username, @Password_Hash, @FName, @LName)";
                        cmd = new SqlCommand(sql, conn);
                        cmd.Parameters.Add(new SqlParameter("@Username", Usernametb.Text));
                        cmd.Parameters.Add(new SqlParameter("@Password_Hash", HashedPass));
                        cmd.Parameters.Add(new SqlParameter("@FName", Fnametb.Text));
                        cmd.Parameters.Add(new SqlParameter("@LName", Lnametb.Text));
                        if (cmd.ExecuteNonQuery() > 0)
                        {
                            SetResultLabel(true);
                        }
                        else
                        {
                            SetResultLabel(false);
                        }

                    }
                    else { SetResultLabel(false); }
                }
                catch (Exception ex)
                {
                    Debug.Write(ex);
                    
                }
                

            }
        }
        else { SetResultLabel(false); }
    }

    protected void SetResultLabel(bool Success)
    {
        if (Success == true)
        {
            Resultlb.Text = "<span class=\"Success\">Account Created</span>";
        }
        else
        {
            Resultlb.Text = "<span class=\"Failure\">Account Creation Failed</span>";
        }

    }

    protected bool CheckPage()
    {
        bool returnval = true;
        if (String.IsNullOrEmpty(Fnametb.Text)) { returnval = false; }
        if (String.IsNullOrEmpty(Lnametb.Text)) { returnval = false; }
        if (String.IsNullOrEmpty(Usernametb.Text)) { returnval = false; }
        if (String.IsNullOrEmpty(Passwordtb.Text)) { returnval = false; }
        if (String.IsNullOrEmpty(VPasswordtb.Text)) { returnval = false; }

        if (Passwordtb.Text == VPasswordtb.Text)
        {
            if (!Regex.Match(Passwordtb.Text, "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$").Success)
            {
                returnval = false;
            }
        }
        else
        {
            returnval = false;
        }

        return returnval;
    }
}