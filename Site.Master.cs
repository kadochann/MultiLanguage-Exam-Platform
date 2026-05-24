using System;

namespace Project
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Dil dropdown'unu sadece ilk yuklemede senkronize et.
            // ONEMLI: PostBack'te kullanicinin secimini EZMEYELIM,
            // yoksa TR'den EN'e gecince hemen TR'ye donerdi.
            if (!IsPostBack)
            {
                string dil = Session["Dil"] as string ?? "tr-TR";
                if (ddlLanguage.Items.FindByValue(dil) != null)
                {
                    ddlLanguage.SelectedValue = dil;
                }
            }

            // Login durumuna gore menuyu duzenle.
            // Bu kisim her zaman calismali (login/logout sonrasi guncellensin).
            bool girisYapildi = Session["KullaniciId"] != null;
            string rol = Session["Rol"] as string ?? "";

            if (girisYapildi)
            {
                string kullaniciAdi = Session["KullaniciAdi"] as string ?? "";
                lblHosgeldin.Text = kullaniciAdi;
                lblHosgeldin.Visible = true;

                lnkLogin.Visible = false;
                lnkRegister.Visible = false;
                btnLogout.Visible = true;

                if (rol == "Admin")
                {
                    phAdminMenu.Visible = true;
                    phUserMenu.Visible = false;
                }
                else
                {
                    phAdminMenu.Visible = false;
                    phUserMenu.Visible = true;
                }
            }
            else
            {
                lblHosgeldin.Visible = false;
                lnkLogin.Visible = true;
                lnkRegister.Visible = true;
                btnLogout.Visible = false;

                phAdminMenu.Visible = false;
                phUserMenu.Visible = false;
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
            Response.Redirect("~/Default.aspx");
        }
    }
}