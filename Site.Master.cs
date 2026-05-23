using System;

namespace Project
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string dil = Session["Dil"] as string ?? "tr-TR";

                if (ddlLanguage.Items.FindByValue(dil) != null)
                {
                    ddlLanguage.SelectedValue = dil;
                }

                bool girisYapildi = Session["KullaniciId"] != null;

                lnkLogin.Visible = !girisYapildi;
                btnLogout.Visible = girisYapildi;
            }
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["Dil"] = ddlLanguage.SelectedValue;
            Response.Redirect(Request.RawUrl);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}