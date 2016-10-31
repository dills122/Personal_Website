using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Blog_Blog_Preview : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)   
    {
        string Test = Session["PageContents"].ToString();

        if (Session["Pass"].ToString() == "Password")
        {
            Previewpnl.Controls.Add(new LiteralControl(Session["PageContents"].ToString()));
        }
    }
}