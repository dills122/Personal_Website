using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Contactbtn_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Nametxt.Text) || !String.IsNullOrEmpty(Emailtxt.Text) || !String.IsNullOrEmpty(Bodytxt.Text))
        {
            if (Email.SendContactEmail(Emailtxt.Text, Bodytxt.Text, Nametxt.Text))
            {
                SetErrorlb(true);
            }
            else
            {
                SetErrorlb(false);
            }
            Page.MaintainScrollPositionOnPostBack = true;
        }
    }

    protected void SetErrorlb(bool type)
    {
        if (type == true)
        {
            errorlb.Text = "Successful";
            errorlb.Visible = true;
            Submitbtn.Visible = false;
            ClearPage();
        }
        else
        {
            errorlb.Text = "Failed to send";
            errorlb.Visible = true;
        }
    }

    protected void ClearPage()
    {
        Nametxt.Text = "";
        Emailtxt.Text = "";
        Bodytxt.Text = "";
    }
}