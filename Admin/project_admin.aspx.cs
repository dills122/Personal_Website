using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_project_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    protected bool InsertIntoDB()
    {
        if (CheckPage())
        {
            int FileID = 0;
            if(Fileupload.HasFile)
            {
                FileID = SQL_Functions.InsertProjectFile(Fileupload.FileName, "/Files/" + Fileupload.FileName, 1);
            }
            int ProjID = SQL_Functions.InsertProject(Nametxt.Text, Descrtxt.Text, Convert.ToInt16(Languageddl.SelectedValue), FileID);

            //TODO Add in Dynamic Examples
        }
        return true;
    }

    protected bool CheckPage()
    {
        if(string.IsNullOrEmpty(Nametxt.Text))
        {
            return false;
        }
        if (string.IsNullOrEmpty(Descrtxt.Text))
        {
            return false;
        }
        if (Languageddl.SelectedValue == "0")
        {
            return false;
        }
        return true;
    }

    protected void Submitbtn_Click(object sender, EventArgs e)
    {
        Control cntrl = ExampleCode.Controls[1];
        Control cnt = ExampleCode.Controls[2];
     //   Control cntrl = ;
        //if (cntrl != null)
        //{
        //    int test = 0;
        //}
    }
}