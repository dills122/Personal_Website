using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

/// <summary>
/// Summary description for Email
/// </summary>
public class Email
{
    public Email()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// Logs into the Mail server
    /// </summary>
    /// <returns>returns the smtpclient that allows the user to send emails through the SYSTEM address</returns>
    protected SmtpClient GetCredentials()
    {
        SmtpClient smtpClient = new SmtpClient();
        smtpClient.Host = "mail.dssteele.com";
        smtpClient.Port = 8889;

        NetworkCredential Credentials = new NetworkCredential("Get From", "File On Drive");
        smtpClient.Credentials = Credentials;
        return smtpClient;
    }
    /// <summary>
    /// Finish adding the actual email information
    /// </summary>
    /// <param name="Subject"></param>
    /// <param name="body"></param>
    /// <returns></returns>
    public Boolean SendEmail(string Subject, string body)
    {
        try
        {
            SmtpClient smtp = GetCredentials();
            //Creates the message object
            MailMessage mailMessage = new MailMessage();
            //Sets the To and From info
            mailMessage.To.Add("dylansteele57@gmail.com");
            mailMessage.From = new MailAddress("SYSTEM@dssteele.com");
            //sets the body and subject of the message
            mailMessage.Subject = Subject;
            mailMessage.Body = body;

            smtp.Send(mailMessage);
        }
        catch (Exception ex)
        {

        }



        return true;
    }

    /// <summary>
    /// Send Email to a user
    /// </summary>
    /// <param name="Subject"></param>
    /// <param name="body"></param>
    /// <param name="Email"></param>
    /// <returns></returns>
    public Boolean SendEmail(string Subject, string body, string Email)
    {
        try
        {
            SmtpClient smtp = GetCredentials();
            //Creates the message object
            MailMessage mailMessage = new MailMessage();
            //Sets the To and From info
            mailMessage.To.Add(Email);
            mailMessage.From = new MailAddress("SYSTEM@dssteele.com");
            //sets the body and subject of the message
            mailMessage.Subject = Subject;
            mailMessage.Body = body;

            smtp.Send(mailMessage);
        }
        catch (Exception ex)
        {

        }



        return true;
    }

    public void ForumActivationEmail(string Email)
    {
        try
        {
            string body = "";
            //Need to add code for adding users name
            body = "<p>Dear [USER],</p>";
            body += "< p > &nbsp;</ p >";
            body += "< p > you have requested to create an account with dssteele.com forums. If you believe this is incorrect please contact the system administrator at .</ p >";
            body += "< p > &nbsp;</ p >";
            body += "< p > If you have created an account please follow the link below to activate your account.</ p >";
            body += "< p > &nbsp;</ p >";
            body += "< p >< a href = \"mailto:ISSUE@dssteele.com\" > ISSUE@dssteele.com </ a ></ p >";
            body += "< p > &nbsp;</ p >";
            body += "< p > Dylan Steele &#39;s Portfolio</p>";
            body += "< p > dssteele.com </ p > ";

            SmtpClient smtp = GetCredentials();
            //Creates the message object
            MailMessage mailMessage = new MailMessage();
            //Sets the To and From info
            mailMessage.To.Add(Email);
            mailMessage.From = new MailAddress("SYSTEM@dssteele.com");
            //sets the body and subject of the message
            mailMessage.Subject = "Activate your account";
            mailMessage.Body = body;

            smtp.Send(mailMessage);
        }
        catch (Exception ex)
        {

        }
    }
}