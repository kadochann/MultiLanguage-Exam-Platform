using System;
using System.Globalization;
using System.Threading;
using System.Web;

namespace Project
{
    public partial class _Default : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            string dil = "tr-TR";

            if (HttpContext.Current != null
                && HttpContext.Current.Session != null
                && HttpContext.Current.Session["Dil"] != null)
            {
                string sessionDil = HttpContext.Current.Session["Dil"].ToString();
                if (sessionDil == "tr-TR" || sessionDil == "en-US" || sessionDil == "ar-SA")
                {
                    dil = sessionDil;
                }
            }

            Thread.CurrentThread.CurrentCulture = new CultureInfo(dil);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(dil);

            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            object startText = GetGlobalResourceObject("Resources", "StartExam");

            if (startText != null)
            {
                lnkStartExam.Text = startText.ToString();
            }
        }

        protected void btnTR_Click(object sender, EventArgs e)
        {
            Session["Dil"] = "tr-TR";
            Response.Redirect("Default.aspx", true);
        }

        protected void btnEN_Click(object sender, EventArgs e)
        {
            Session["Dil"] = "en-US";
            Response.Redirect("Default.aspx", true);
        }
    }
}