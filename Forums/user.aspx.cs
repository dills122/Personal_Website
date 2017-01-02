using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forums_user : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ActivateStr = (string)Request.QueryString["Activate"];
        if (ActivateStr != null)
        {
            if (Forum.ActivateUser(ActivateStr) == true )
            {
                NewUser.Visible = false;
                ForgotPass.Visible = false;
                form1.Controls.Add(new LiteralControl("Account is Active!"));
            }
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
            Regex regex = new Regex(@"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
            Match match = regex.Match(ConfirmPass.Value.ToString());

            //get way to get the text from the control on the front whether it is true or false
            if(match.Success)
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