using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class title : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Contactbtn_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(nametxt.Value) || !String.IsNullOrEmpty(emailtxt.Value) || !String.IsNullOrEmpty(bodytxt.Value))
        {
            if(Email.SendContactEmail(emailtxt.Value, bodytxt.Value, nametxt.Value))
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
        if(type == true)
        {
            errorlb.Text = "Successful";
            errorlb.Visible = true;
            Contactbtn.Visible = false;
        }
        else
        {
            errorlb.Text = "Failed to send";
            errorlb.Visible = true; 
        }
    }
}