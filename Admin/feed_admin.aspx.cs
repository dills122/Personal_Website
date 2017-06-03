using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_feed_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    /// <summary>
    /// Button event to submit Annoucement to DB
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Postbtn_Click(object sender, EventArgs e)
    {

        if (CheckValid())
        {
            string PostDate = Request.Form[txtDate.UniqueID];

            PostDate = DateTime.Parse(PostDate).ToString();

            if (SQL_Functions.InsertSpecialAnnouc(Titletxt.Text, CKEditor1.Text, PostDate))
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
    /// Makes sure the form is completed
    /// </summary>
    /// <returns></returns>
    protected bool CheckValid()
    {
        
        if(string.IsNullOrEmpty(Titletxt.Text))
        {
            return false;
        }
        if(string.IsNullOrEmpty(CKEditor1.Text))
        {
            return false;
        }
        string PostDate = Request.Form[txtDate.UniqueID];
        if (string.IsNullOrEmpty(PostDate))
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
    }
}