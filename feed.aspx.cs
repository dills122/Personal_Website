using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class feed : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        WriteFeedNewest();
        WriteVersionNewest();
    }


    protected void WriteFeedNewest()
    {
        foreach (DataRow row in SQL_Functions.GetFeedAnnoucements().Rows)
        {
            HtmlGenericControl FeedContainer = new HtmlGenericControl("div");
            FeedContainer.Attributes.Add("class", "feed-container");

            HtmlGenericControl AnnoucTitle = new HtmlGenericControl("div");
            AnnoucTitle.Attributes.Add("class", "feed-header");
            AnnoucTitle.Controls.Add(new LiteralControl(row["annoucement_title"].ToString()));
            FeedContainer.Controls.Add(AnnoucTitle);

            HtmlGenericControl hr = new HtmlGenericControl("div");
            hr.Attributes.Add("class", "hr-div");
            FeedContainer.Controls.Add(hr);

            HtmlGenericControl PostedDate = new HtmlGenericControl("div");
            PostedDate.Attributes.Add("class", "post-date");
            PostedDate.Controls.Add(new LiteralControl(row["post_date"].ToString()));
            FeedContainer.Controls.Add(PostedDate);



            HtmlGenericControl AnnoucDescrp = new HtmlGenericControl("div");
            AnnoucDescrp.Attributes.Add("class", "feed-description");
            AnnoucDescrp.InnerHtml = row["annoucement_description"].ToString();
            FeedContainer.Controls.Add(AnnoucDescrp);

            FeedContentpnl.Controls.Add(FeedContainer);
        }
    }

    protected void WriteVersionNewest()
    {
        foreach (DataRow row in SQL_Functions.GetNewestVersions().Rows)
        {
            HtmlGenericControl FeedContainer = new HtmlGenericControl("div");
            FeedContainer.Attributes.Add("class", "feed-container");

            HtmlGenericControl AnnoucTitle = new HtmlGenericControl("div");
            AnnoucTitle.Attributes.Add("class", "feed-header");
            AnnoucTitle.Controls.Add(new LiteralControl(row["version_title"].ToString()));
            FeedContainer.Controls.Add(AnnoucTitle);

            HtmlGenericControl hr = new HtmlGenericControl("div");
            hr.Attributes.Add("class", "hr-div");
            FeedContainer.Controls.Add(hr);

            HtmlGenericControl infowrapper = new HtmlGenericControl("div");
            infowrapper.Attributes.Add("class", "padding");

            HtmlGenericControl PostedDate = new HtmlGenericControl("div");
            PostedDate.Attributes.Add("class", "post-date");
            PostedDate.Controls.Add(new LiteralControl(row["post_date"].ToString()));
            infowrapper.Controls.Add(PostedDate);

            HtmlGenericControl Version = new HtmlGenericControl("div");
            Version.Attributes.Add("class", "version");
            Version.Controls.Add(new LiteralControl(row["version"].ToString()));
            infowrapper.Controls.Add(Version);
            infowrapper.Controls.Add(new LiteralControl("<div class:\"clear\"></div>"));

            FeedContainer.Controls.Add(infowrapper);

            HtmlGenericControl AnnoucDescrp = new HtmlGenericControl("div");
            AnnoucDescrp.Attributes.Add("class", "feed-description");
            AnnoucDescrp.InnerHtml = row["version_description"].ToString();
            FeedContainer.Controls.Add(AnnoucDescrp);

            FeedContentpnl.Controls.Add(FeedContainer);
        }
    }
}