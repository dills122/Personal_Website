<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hashing_Salting.aspx.cs" Inherits="Other_Pages_Hashing_Salting" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <link rel="stylesheet" href="../css/foundation.css">
    <script src="../js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <h2 style="text-align: center">Hashing Salting Application</h2>
    <p style="font-size: medium; text-align: center; width: 80%; margin: auto; text-align: center">
        This is a Windows Form application that hashes passwords and adds salt to the end of the string
        before hashing. Then allows the user to check the hashed password against another string entered
        below the hashed string.
    </p>
    <br />
    <br />
<h2>Methods</h2>
    <pre class="pre-scrollable" style="max-height: 800px"><code >
        /// <summary>
        /// Hashes and Salts the String
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Hashbtn_Click(object sender, EventArgs e)
        {
            Salt = CreateRandomSalt();
            HashedPass.Text = Hash(PlainPass.Text, Salt);
        }
        /// <summary>
        /// Creates Random Salt for a hashed password
        /// </summary>
        /// <returns></returns>
        static string CreateRandomSalt()
        {
            string mix = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+=][}{<>";
            string salt = "";
            Random rnd = new Random();
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i <100; i++)
            {
                int x = rnd.Next(0, mix.Length - 1);
                salt += (mix.Substring(x, 1));
            }
            return salt;
        }
        /// <summary>
        /// Hashes the password
        /// </summary>
        /// <param name="input"></param>
        /// <param name="salt"></param>
        /// <returns></returns>
        static string Hash(string input, string salt)
        {
            Byte[] convertedToBytes = Encoding.UTF8.GetBytes(input + salt);
            HashAlgorithm hashType = new SHA512Managed();
            Byte[] hashBytes = hashType.ComputeHash(convertedToBytes);
            string hashedResults = Convert.ToBase64String(hashBytes);

            
            return hashedResults;
        }
        /// <summary>
        /// Compares the strings after hashing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Checkbtn_Click(object sender, EventArgs e)
        {
            if (HashedPass.Text != "")
            {
                string CheckedHash = Hash(Checktxt.Text, Salt);

                bool result = HashedPass.Text.ToString().Equals(CheckedHash, StringComparison.Ordinal);
                if (result == true )
                {
                    Checklb.Text = "Match!";
                    Checklb.ForeColor = Color.Green;
                    Checklb.Visible = true;
                
                }
                else
                {
                    Checklb.Text = "Wrong!";
                    Checklb.ForeColor = Color.Red;
                    Checklb.Visible = true;
                }
            }
        }

        </code></pre>
 <br />
    <br />
    <div style="text-align: center">
        <h4>The code can be downloaded here: </h4>
        <a href="../Documents/Salting.zip">Complete Hashing Salting Code</a>
        <br />
        <br />

    </div>
</asp:Content>
