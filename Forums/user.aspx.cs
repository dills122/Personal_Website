using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forums_user : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Activate"] != null)
        {
            
        }
    }

    protected void SubNewUserbtn_Click(object sender, EventArgs e)
    {
        if (CheckInput() == false)
        {
            Errorlb.Visible = true;
        }
        else
        {
            //get way to get the text from the control on the front whether it is true or false
            if(Validationlb.Text == "true")
            {
                Forum forum = new Forum();
                forum.CreateUser(FName.Value.ToString(), LName.Value.ToString(), UserID.Value.ToString(), Pass.Value.ToString(), Email.Value.ToString());
            }
            else if (Validationlb.Text == "false")
            {
                Requirementlb.Visible = true;
            }
            
        }
    }


    protected bool CheckInput()
    {
        bool returnbool = true;
        if (FName.Value == "")
        {
            FName.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (LName.Value == "")
        {
            LName.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (UserID.Value == "")
        {
            UserID.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (Pass.Value == "")
        {
            Pass.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (ConfirmPass.Value == "")
        {
            ConfirmPass.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (Email.Value == "")
        {
            Email.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }
        if (ConfirmEmail.Value == "")
        {
            ConfirmEmail.Style.Add("border", "solid #cc0000");
            returnbool = false;
        }

        return returnbool;
    }
}