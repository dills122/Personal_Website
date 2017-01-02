using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class contact_me : System.Web.UI.Page
{
    Email email = new Email();

    protected void Page_Load(object sender, EventArgs e)
    {


    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        string EncodedResponse = Request.Form["g-Recaptcha-Response"];
        bool IsCaptchaValid = Convert.ToBoolean((ReCaptchaClass.Validate(EncodedResponse)));

        if (IsCaptchaValid)
        {   
            if (CheckControls() == true)
            {
                string Name = Nametb.Text;
                string Subject = Subjecttb.Text;
                string Body = Bodytb.Text;
                string ModBody = Name + "," + Environment.NewLine + Body;
                email.SendQCEmail(Subject, ModBody);
            }
        }
        Nametb.Text = "";
        Subjecttb.Text = "";
        Bodytb.Text = "";
    }

    protected bool CheckControls()
    {
        bool returnVal = true;
        if (Nametb.Text == "" || String.IsNullOrEmpty(Nametb.Text))
        {
            Nametb.ForeColor = System.Drawing.Color.Red;
            returnVal = false;
        }
        if (Subjecttb.Text == "" || String.IsNullOrEmpty(Subjecttb.Text))
        {
            Subjecttb.ForeColor = System.Drawing.Color.Red;
            returnVal = false;
        }
        if (Bodytb.Text == "" || String.IsNullOrEmpty(Bodytb.Text))
        {
            Bodytb.ForeColor = System.Drawing.Color.Red;
            returnVal = false;
        }
        return returnVal;
    }
}