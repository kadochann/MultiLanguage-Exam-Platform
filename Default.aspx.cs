using System;

namespace Project
{
    public partial class _Default : System.Web.UI.Page
    {
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
            Response.Redirect("Default.aspx");
        }

        protected void btnEN_Click(object sender, EventArgs e)
        {
            Session["Dil"] = "en-US";
            Response.Redirect("Default.aspx");
        }
    }
}