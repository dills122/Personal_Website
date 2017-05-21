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
        string PageContents = Session["PageContents"].ToString();

        Previewpnl.Controls.Add(new LiteralControl(PageContents));


        //if (PreviousPage != null)
        //{
        //    TextBox SourceTextBox =
        //        (TextBox)PreviousPage.FindControl("Bodytb");
        //    if (SourceTextBox != null)
        //    {
        //        Previewpnl.Controls.Add(new LiteralControl(SourceTextBox.Text));
        //    }
        //}

    }
}