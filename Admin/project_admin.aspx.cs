using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_project_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

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
}