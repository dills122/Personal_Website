<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Task_Scheduler.aspx.cs" Inherits="Other_Pages_Task_Scheduler" MasterPageFile="~/MasterPage.master" %>

<asp:Content ContentPlaceHolderID="Content1" runat="server">
    <link rel="stylesheet" href="../css/foundation.css">
    <script src="../js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <h2 style="text-align: center">Task Scheduler System</h2>
    <p style="font-size: medium; text-align: center; width: 80%; margin: auto; text-align: center">
        This is a system I created for an employer that needed a replacement to the Windows Task Scheduler 
        it uses <a href="http://www.quartz-scheduler.net/">Quartz.NET</a> to schedule tasks. This system functions
        by using the Global.asax Application_Start Method to pull all tasks that are stored on the DataBase into the
        scheduler after starting the scheduler. New tasks can be added to the system through the WebForm NewTask.aspx.
        Adding a task through this WebForm will also add it to the DataBase. Both major class are show below and also the 
        button even for submitting a new task.
    </p>
    <br />
    <br />
    <h2>Job Scheduler Class</h2>
    <pre class="pre-scrollable" style="max-height: 800px"><code >
using Quartz;
using Quartz.Impl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



/// <summary>
/// Summary description for JobScheduler
/// </summary>
public class JobScheduler
{
    private static IScheduler sc;

    

    /// <summary>
    /// Creates a Job and Trigger for Scheduling
    /// </summary>
    /// <param name="JobIdentity">Job Name</param>
    /// <param name="TriggerIdentity">Trigger Name</param>
    /// <param name="URL">URL to Poke</param>
    /// <param name="ScheduledTime">Input String for the Trigger Time</param>
    /// <returns>an Object that can be</returns>
    public static object CreateJob(string JobIdentity, string TriggerIdentity, string URL, string ScheduledTime)
    {
        IJobDetail job = JobBuilder.Create<Jobs>()
            .WithIdentity(JobIdentity)
            .UsingJobData("URL", URL)
            .Build();

        ITrigger trigger = TriggerBuilder.Create()
                                         .ForJob(job)
                                         .WithIdentity(TriggerIdentity)
                                         .WithCronSchedule(ScheduledTime)
                                         .Build();

        NewJob JobObj = new NewJob(job, trigger);

        return JobObj;

    }

   

    /// <summary>
    /// Allows a User to Schedule a Task
    /// </summary>
    /// <param name="job">Job to be scheduled</param>
    /// <param name="trigger">Trigger that starts the Scheduled Job</param>
    public static int ScheduleJob(IJobDetail job, ITrigger trigger)
    {
        try
        {
            sc.ScheduleJob(job, trigger);

            System.Diagnostics.Debug.WriteLine("Job Scheduled Successfully");
            Global.WriteToTextFile("Job Scheduled Successfully" + DateTime.Now.ToString());
            Global.WriteToTextFile(job.ToString());
            return 1;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex);
            Global.WriteToTextFile(ex.ToString());
            return 0;
        }
        
    }

    /// <summary>
    /// Starts the Scheduler on Application Load Via Global.asax
    /// </summary>
    public static void Start()
    {


        ISchedulerFactory sf = new StdSchedulerFactory();
        sc = sf.GetScheduler();
        sc.Start();

    }
    /// <summary>
    /// Ends the Scheduler
    /// </summary>
    public static void End()
    {
        if (sc.IsShutdown == false)
        {
            sc.Shutdown();
            System.Diagnostics.Debug.WriteLine("Scheduler ShutDown");
        }
    }
}

            </code></pre>
    <br />
    <br />
    <h2>Execute Job Class</h2>
    <pre class="pre-scrollable" style="max-height: 800px"><code >
using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;

/// <summary>
/// Summary description for Jobs
/// </summary>
public class Jobs : IJob
{
    
    public void Execute(IJobExecutionContext context)
    {
        JobKey key = context.JobDetail.Key;
        JobDataMap dataMap = context.JobDetail.JobDataMap;

        string URL = dataMap.GetString("URL");

        HitRequestSite(URL);
    }

    public void HitRequestSite(string URL)
    {
        WebClient client = new WebClient();
        client.DownloadData(URL);
    }

}
            </code></pre>
    <br />
    <br />
    <h2>Submit new task event</h2>
    <pre class="pre-scrollable" style="max-height: 800px"><code >
 protected void Submitbtn_Click(object sender, EventArgs e)
    {
        string TriggerID = "";
        string JobID = "";

        string TriggerTime = (string)TriggerTimeddl.SelectedValue;
        string URLText = "";

        //Checks URL to make sure it isn't Empty or in bad format
        if (Uri.IsWellFormedUriString(URLtxt.Text, UriKind.Absolute) == true && String.IsNullOrEmpty(URLtxt.Text) == false)
        {
             URLText = (string)URLtxt.Text;

            int Max = (Global.GetMaxID() + 1) * 100;
            JobID = "Job" + Max;
            TriggerID = "Trig" + Max;
            Global.AddTaskToDB(JobID, TriggerID, URLText, TriggerTime);

            //Creates the Job and schedules it
            NewJob JobObj = (NewJob)JobScheduler.CreateJob(JobID, TriggerID, URLText, TriggerTime);
            int i = JobScheduler.ScheduleJob(JobObj.job, JobObj.trigger);
            if (i == 1)
            {
                JobScheduledlb.Visible = true;
            }
            else
            {
                JobScheduledlb.Visible = true;
                JobScheduledlb.Text = "Unsuccessful job!";
            }

        }
        else
        {
            Errorlb.Text = "URL was not in good format";
        }
        
    }
        </code></pre>
    <!-- Add in new pictures of the page -->

    <br />
    <br />
    <div style="text-align: center">
        <h4>The code can be downloaded here: </h4>
        <a href="../Documents/Task_Scheduler.zip">Complete Task Scheduler Code</a>
        <br />
        <br />

    </div>
</asp:Content>
