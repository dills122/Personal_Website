using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web;

/// <summary>
/// Summary description for Email
/// </summary>
public class Email
{
    public static bool SendEmail(string To, string cc, string body, string Subject)
    {
        try
        {
            using (SmtpClient client = new SmtpClient())
            {
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("SYSTEM@dssteele.com");

                if (String.IsNullOrEmpty(cc) == false)
                {
                    msg.CC.Add(new MailAddress(cc));
                }
                msg.To.Add(new MailAddress(To));

                msg.Body = body;

                msg.Subject = Subject;

                msg.IsBodyHtml = true;

                client.Send(msg);
                return true;
            }
        }
        catch (Exception ex)
        {
            return false;
            //TODO Implement Log Writer
        }
        
    }

    /// <summary>
    /// Sends a Contact me info to my email
    /// </summary>
    /// <param name="Contact">Submitter</param>
    /// <param name="body"></param>
    /// <param name="Name">Submitter Name</param>
    /// <returns></returns>
    public static bool SendContactEmail(string Contact, string body, string Name)
    {
        try
        {
            using (SmtpClient client = new SmtpClient())
            {
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("CONTACT@dssteele.com");

                msg.To.Add(new MailAddress(ConfigurationManager.AppSettings["AdminEmail"]));

                string bodystr = "Name: " + Name + "<br/><br/>";
                bodystr += "Contact Email: " + Contact + "<br/><br/>";
                bodystr += "Body: " + "<br/><br/>";
                bodystr += body;

                msg.Body = bodystr;

                msg.Subject = "Contact " + Name + " Submitted a Message";

                
                msg.IsBodyHtml = true;

                client.Send(msg);
                return true;
            }
        }
        catch (Exception ex)
        {
            return false;
            //TODO Implement Log Writer
        }

    }

    public static bool SendErrorEmail(Exception ex, string UrlString)
    {
        try
        {
            using (SmtpClient client = new SmtpClient())
            {
                

                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("SYSTEM@dssteele.com");

                msg.To.Add(new MailAddress(ConfigurationManager.AppSettings["AdminEmail"]));

                string body = "";

                body = "Website error recieved on: " + DateTime.Now;
                body += "<br/><br/>";
                body += "Message: " + ex.Message;
                body += "<br/><br/>";
                body += "Stack Trace: " + "<br/><br/>";
                body += "<pre>" + ex.StackTrace + "</pre>";
                body += "<br/><br/>";
                body += "Message: " + "<br/><br/>";
                body += "<pre>" + ex.InnerException + "</pre>";
                body += "<br/><br/>";
                body += "Source: " + "<br/><br/>";
                body += "<pre>" + ex.Source + "</pre>";

                msg.Subject = "An error has occured on the site" ;

                msg.IsBodyHtml = true;

                client.Send(msg);

                return true;
            }
        }
        catch (Exception extp)
        {
            return false;
            //TODO Implement Log Writer
        }
    }
}