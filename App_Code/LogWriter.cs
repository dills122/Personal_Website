using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LogWriter
/// </summary>
public class LogWriter
{
    public static bool WriteError(Exception Excpt)
    {
        try
        {
            if (File.Exists(ConfigurationManager.AppSettings["LogFile"]))
            {
                using (StreamWriter strm = new StreamWriter(ConfigurationManager.AppSettings["LogFile"]))
                {
                    strm.WriteLine("**********************************************************************************");
                    strm.WriteLine("**********************************************************************************");
                    strm.WriteLine("**********************************************************************************");
                    strm.WriteLine("Error Time: " + DateTime.Now);
                    strm.WriteLine("Message: " + Excpt.Message);
                    strm.WriteLine("Stack Trace: ");
                    strm.WriteLine(Excpt.StackTrace);
                    strm.WriteLine("Inner Exception: ");
                    strm.WriteLine(Excpt.InnerException);
                    strm.WriteLine("Source: ");
                    strm.WriteLine(Excpt.Source);
                }
            }
            else
            {

            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        
    }

}