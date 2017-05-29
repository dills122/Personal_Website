using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Non Postback Events
        if (!IsPostBack)
        {
            int ExampleID = Convert.ToInt16(Request.QueryString["XID"]);

            if (ExampleID != 0)
            {
                WriteCodeExample(ExampleID);
            }
        }
        WriteTopNewLinks();
        WriteTopLanguageLinks();
        CheckAuth();
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
            UserNametxt.Attributes.Add("class","");
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
    /// Fills in a Code Example if an ID is avaliable
    /// </summary>
    /// <param name="CodeExampleID"></param>
    protected void WriteCodeExample(int CodeExampleID)
    {
        DataTable dt = SQL_Functions.GetCodeExample(CodeExampleID);

        foreach (DataRow row in dt.Rows)
        {
            HtmlGenericControl Container = new HtmlGenericControl("div");
            Container.Attributes.Add("class", "code-container");
            //Add A CSS Class

            //Adds Header to Container
            HtmlGenericControl Header = new HtmlGenericControl("span");
            Header.Attributes.Add("class", "code-header");
            Header.InnerText = row["project_name"].ToString();
            Container.Controls.Add(Header);


            //Horizontal Line
            Container.Controls.Add(new LiteralControl("<hr/>"));

            HtmlGenericControl p = new HtmlGenericControl("p");
            p.InnerText = row["project_description"].ToString();

            Container.Controls.Add(p);

            //Gets A code Snippet Example Block
            foreach (DataRow ExampleRow in SQL_Functions.GetCodeSamples((int)row["ID"]).Rows)
            {
                HtmlGenericControl ExampleHeader = new HtmlGenericControl("span");
                ExampleHeader.InnerText = (string)ExampleRow["example_title"];
                ExampleHeader.Attributes.Add("class", "example-header");
                Container.Controls.Add(new LiteralControl("<br/><br/>"));
                Container.Controls.Add(ExampleHeader);
                Container.Controls.Add(new LiteralControl("<br/>"));
                HtmlGenericControl ExampleDescr = new HtmlGenericControl("p");
                ExampleDescr.InnerText = (string)ExampleRow["example_description"];
                Container.Controls.Add(ExampleDescr);

                HtmlGenericControl preCon = new HtmlGenericControl("pre");
                preCon.Attributes.Add("class", "pre-scrollable");

                HtmlGenericControl codeCont = new HtmlGenericControl("code");
                codeCont.Attributes.Add("class", row["language_text"].ToString());
                codeCont.InnerText = (string)ExampleRow["example_body"];

                preCon.Controls.Add(codeCont);
                Container.Controls.Add(preCon);
                Container.Controls.Add(new LiteralControl("<br/><br/>"));
            }

            //Adds in download links 
            if (row["server_location"] != DBNull.Value && row["web_location"] != DBNull.Value)
            {
                Container.Controls.Add(new LiteralControl("<hr/>"));
                HtmlGenericControl FileHeader = new HtmlGenericControl("span");
                FileHeader.InnerText = "Download the Source Files Here:";
                Container.Controls.Add(FileHeader);
                Container.Controls.Add(new LiteralControl("<br/><br/>"));
                HtmlGenericControl a = new HtmlGenericControl("a");
                a.Attributes.Add("href", row["web_location"].ToString());
                a.InnerText = row["file_name"].ToString();
                Container.Controls.Add(a);
            }

            contentArea.Controls.Add(Container);

            Global_Functions.SetLanguageSession((int)row["language_id"], (string)row["language_text"]);
        }
    }
    /// <summary>
    /// Creates the Homepage main content
    /// </summary>
    protected void WriteHomePage()
    {

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