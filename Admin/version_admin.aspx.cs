using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_version_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckAdmin();
    }

    /// <summary>
    /// Verifies that the user is an admin
    /// </summary>
    protected void CheckAdmin()
    {
        if(!Global_Functions.CheckAdminLogin())
        {
            Response.Redirect("~/Home.aspx");
        }
    }

    /// <summary>
    /// Post button that submits to DB
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Postbtn_Click(object sender, EventArgs e)
    {

        if (CheckValid())
        {
            string PostDate = Request.Form[txtDate.UniqueID];

            PostDate = DateTime.Parse(PostDate).ToString();

            if (SQL_Functions.InsertVersion(Titletxt.Text, CKEditor1.Text,versiontxt.Text, PostDate))
            {
                Postbtn.Visible = false;
                Errorlb.Visible = true;
                Errorlb.Text = "Annoucement Posted";
                EmptyPage();
            }
            else
            {
                Postbtn.Visible = true;
                Errorlb.Visible = true;
                Errorlb.Text = "Annoucement Post Failed";
            }
        }
    }
    /// <summary>
    /// Makes sure the page is completed
    /// </summary>
    /// <returns></returns>
    protected bool CheckValid()
    {

        if (string.IsNullOrEmpty(Titletxt.Text))
        {
            return false;
        }
        if (string.IsNullOrEmpty(CKEditor1.Text))
        {
            return false;
        }
        string PostDate = Request.Form[txtDate.UniqueID];
        if (string.IsNullOrEmpty(PostDate))
        {
            return false;
        }
        if(string.IsNullOrEmpty(versiontxt.Text))
        {
            return false;
        }
        return true;
    }

    /// <summary>
    /// Empties the page
    /// </summary>
    protected void EmptyPage()
    {
        Titletxt.Text = "";
        CKEditor1.Text = "";
        txtDate.Text = "";
        versiontxt.Text = "";
    }
}