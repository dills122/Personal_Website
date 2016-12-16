using System;
using System.Collections.Generic;
using System.Linq;
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
        SmtpClient smtpClient = new SmtpClient("mail.dssteele.com", 25);

        smtpClient.Credentials = new System.Net.NetworkCredential("SYSTEM@dssteele.com", "Skittles122!");
        smtpClient.UseDefaultCredentials = true;
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtpClient.EnableSsl = true;
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
}