using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for Global_Functions
/// </summary>
public class Global_Functions
{
    /// <summary>
    /// Hasher Function
    /// </summary>
    /// <param name="inputString"></param>
    /// <param name="Salt"></param>
    /// <returns></returns>
    public static byte[] GetHash(string inputString, string Salt)
    {
        HashAlgorithm algorithm = SHA512.Create();  //or use SHA256.Create();
        return algorithm.ComputeHash(Encoding.UTF8.GetBytes(String.Concat(inputString,Salt)));
    }
    /// <summary>
    /// Hashes a String with Salt
    /// </summary>
    /// <param name="Password"></param>
    /// <param name="Salt"></param>
    /// <returns></returns>
    public static string GetHashString(string Password, string Salt)
    {
        StringBuilder sb = new StringBuilder();
        foreach (byte b in GetHash(Password,Salt))
            sb.Append(b.ToString("X2"));

        return sb.ToString();
    }
    /// <summary>
    /// Random Salt Generator
    /// </summary>
    /// <returns></returns>
    public static string SaltGenerator()
    {
        int StrLen = 50;
        Random rnd = new Random();
        string AllowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz123456789";

        string RtrnStr = "";
        for(int i =0; i < StrLen; i++)
        {
            RtrnStr += AllowedChars[rnd.Next(AllowedChars.Length)];
        }
        return RtrnStr;
    }
    /// <summary>
    /// Creates Users Session
    /// </summary>
    /// <param name="Username"></param>
    public static void SetSessionUp(string Username)
    {
        HttpContext.Current.Session["Authenticated"] = true;
        HttpContext.Current.Session["Username"] = Username;
        HttpContext.Current.Session["LastLogin"] = DateTime.Now;
    }
    /// <summary>
    /// Disposes a Users Session
    /// </summary>
    public static void DisposeSession()
    {
        HttpContext.Current.Session["Authenticated"] = false;
        HttpContext.Current.Session["Username"] = "";
        HttpContext.Current.Session["LastLogin"] = "";
        HttpContext.Current.Session.Abandon();
    }
    /// <summary>
    /// Set Language Sessions
    /// </summary>
    /// <param name="LanguageID"></param>
    /// <param name="LanguageText"></param>
    public static void SetLanguageSession(int LanguageID, string LanguageText)
    {
        HttpContext.Current.Session["LanguageID"] = LanguageID;
        HttpContext.Current.Session["LanguageText"] = LanguageText;
    }
}