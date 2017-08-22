using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class title : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Contactbtn_Click(object sender, EventArgs e)
    {
        if (Validate())
        {


            if (!String.IsNullOrEmpty(nametxt.Value) || !String.IsNullOrEmpty(emailtxt.Value) || !String.IsNullOrEmpty(bodytxt.Value))
            {
                if (Email.SendContactEmail(emailtxt.Value, bodytxt.Value, nametxt.Value))
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
    }

    protected void SetErrorlb(bool type)
    {
        if (type == true)
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

    public bool Validate()
    {

        string Response = Request["g-recaptcha-response"];//Getting Response String Appned to Post Method

        bool Valid = false;
        //Request to Google Server
        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(" https://www.google.com/recaptcha/api/siteverify?secret=6LfOYgkUAAAAABIwODfxpYnwKJTOOjhtMyFOLY8_&response=" + Response);

        try
        {
            //Google recaptcha Responce 
            using (WebResponse wResponse = req.GetResponse())

            {

                using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                {
                    string jsonResponse = readStream.ReadToEnd();

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    MyObject data = js.Deserialize<MyObject>(jsonResponse);// Deserialize Json 

                    Valid = Convert.ToBoolean(data.success);


                }
            }

            return Valid;

        }
        catch (WebException ex)
        {
            throw ex;
        }


    }


    public class MyObject
    {
        public string success { get; set; }


    }
}