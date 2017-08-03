using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Master_Pages_main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckAuth();
        WriteTopNewLinks();
        WriteTopLanguageLinks();
    }
    /// <summary>
    /// Login Button Event
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Submitbtn_Click(object sender, EventArgs e)
    {
        if (SQL_Functions.CheckLogin(UserNametxt.Text, Passwordtxt.Text) == true)
        {
            UserNametxt.Attributes.Add("class", "");
            Passwordtxt.Attributes.Add("class", "");
            Errorlb.Visible = false;

            Global_Functions.SetSessionUp(UserNametxt.Text);
            CheckAuth();
        }
        else
        {
            UserNametxt.Attributes.Add("class", "error");
            Passwordtxt.Attributes.Add("class", "error");
            Errorlb.Visible = true;
        }
    }
    /// <summary>
    /// Logoff Button Event
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Logoffbtn_Click(object sender, EventArgs e)
    {
        Global_Functions.DisposeSession();
        CheckAuth();
    }

    /// <summary>
    /// Checks if a user is logined
    /// Sets the Login Panel
    /// </summary>
    protected void CheckAuth()
    {
        if (Session["Authenticated"] != null)
        {
            if ((bool)Session["Authenticated"] == true)
            {
                form1.Visible = false;
                form2.Visible = true;

                Usernamelb.Text = "Logged In as: " + Session["Username"].ToString();
                Loginlb.Text = "Logged In: " + DateTime.Now.ToString();
            }
            else
            {
                form1.Visible = true;
                form2.Visible = false;
            }
            EmptyControls();
        }
    }
    /// <summary>
    /// Blanks the textboxes
    /// </summary>
    protected void EmptyControls()
    {
        UserNametxt.Text = "";
        Passwordtxt.Text = "";
    }

    /// <summary>
    /// Creates Link Well for Top 10 Newest Projects
    /// </summary>
    protected void WriteTopNewLinks()
    {
        topLinks.Controls.Add(new LiteralControl("Top Examples"));
        topLinks.Controls.Add(new LiteralControl("<br/>"));

        foreach (DataRow row in SQL_Functions.GetNewestExamples().Rows)
        {
            HtmlGenericControl a = new HtmlGenericControl("a");
            string url = Request.Url.ToString();
            url = url.Split('?')[0];
            a.Attributes.Add("href", url + "?XID=" + row["ID"]);
            a.InnerText = row["project_name"].ToString();

            topLinks.Controls.Add(a);
            topLinks.Controls.Add(new LiteralControl("<br/>"));
        }
    }
    /// <summary>
    /// Writes Top 10 Language Projects, get LanguageID from Session
    /// </summary>
    protected void WriteTopLanguageLinks()
    {
        //Checks the LanguageID Session Variable to get links
        int languageID = 1;
        if (Session["LanguageID"] != null)
        {
            languageID = (int)Session["LanguageID"];
        }

        languageIDdiv.Controls.Add(new LiteralControl("Top " + Session["LanguageText"] + " Examples"));
        languageIDdiv.Controls.Add(new LiteralControl("<br/>"));

        foreach (DataRow row in SQL_Functions.GetTopLanguageProjects(languageID).Rows)
        {
            HtmlGenericControl a = new HtmlGenericControl("a");
            string url = Request.Url.ToString();
            url = url.Split('?')[0];
            a.Attributes.Add("href", url + "?XID=" + row["ID"]);
            a.InnerText = row["project_name"].ToString();

            languageIDdiv.Controls.Add(a);
            languageIDdiv.Controls.Add(new LiteralControl("<br/>"));
        }
    }
}
