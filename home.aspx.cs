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
            else
            {
                
            }
        }
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

            Container.Controls.Add(new LiteralControl("<hr/> "));

            //Adds in download links 
            foreach (DataRow FileRow in SQL_Functions.GetCodeFiles((int)row["ID"]).Rows)
            { 
                
                HtmlGenericControl FileHeader = new HtmlGenericControl("span");
                FileHeader.InnerText = "Download the Source Files Here:";
                Container.Controls.Add(FileHeader);
                Container.Controls.Add(new LiteralControl("<br/><br/>"));
                HtmlGenericControl a = new HtmlGenericControl("a");
                a.Attributes.Add("href", FileRow["web_location"].ToString());
                a.InnerText = FileRow["file_name"].ToString();
                Container.Controls.Add(a);
            }

            contentpnl.Controls.Add(Container);

            Global_Functions.SetLanguageSession((int)row["language_id"], (string)row["language_text"]);
        }
    }
    /// <summary>
    /// Creates the Homepage main content
    /// </summary>
    protected void WriteHomePage()
    {

    }
    
    protected void WriteErrorPage()
    {
        //TODO Create Logic to write the 404 Page
    }
}