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
    /// Finish adding the actual email information
    /// </summary>
    /// <param name="Subject"></param>
    /// <param name="body"></param>
    /// <returns></returns>
    public Boolean SendEmail(string Subject, string body)
    {
        try
        {
            MailMessage mailMessage = new MailMessage();
            mailMessage.To.Add("dylansteele57@gmail.com");
            mailMessage.From = new MailAddress("SYSTEM@dssteele.com");
            mailMessage.Subject = Subject;
            mailMessage.Body = body;
            SmtpClient smtpClient = new SmtpClient("smtp.your-isp.com");
            smtpClient.Send(mailMessage);
        }
        catch (Exception ex)
        {

        }



        return true;
    }
}