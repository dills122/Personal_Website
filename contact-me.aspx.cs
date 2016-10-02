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
        string Name = Nametb.Text;
        string Subject = Subjecttb.Text;
        string Body = Bodytb.Text;
        string ModBody = Name + "," + Environment.NewLine + Body;
        email.SendEmail(Subject, Body);
    }
}