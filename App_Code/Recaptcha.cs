using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for Recaptcha
/// </summary>
public class Recaptcha
{
    public class MyObject
    {
        public string success { get; set; }
    }
    //public bool Validate()
    //{
    //    //string Response = Request["g-recaptcha-response"];//Getting Response String Append to Post Method
    //    bool Valid = false;
    //    //Request to Google Server
    //    HttpWebRequest req = (HttpWebRequest)WebRequest.Create
    //    (" https://www.google.com/recaptcha/api/siteverify?secret=YOUR SECRATE KEY &response=" + Response);
    //    try
    //    {
    //        //Google recaptcha Response
    //        using (WebResponse wResponse = req.GetResponse())
    //        {

    //            using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
    //            {
    //                string jsonResponse = readStream.ReadToEnd();

    //                JavaScriptSerializer js = new JavaScriptSerializer();
    //                MyObject data = js.Deserialize<MyObject>(jsonResponse);// Deserialize Json

    //                Valid = Convert.ToBoolean(data.success);
    //            }
    //        }

    //        return Valid;
    //    }
    //    catch (WebException ex)
    //    {
    //        throw ex;
    //    }
    //}
}