using System;
using System.Data;
using System.Resources;

namespace OnlineSinavSistemi
{
    /// <summary>
    /// Giris sayfasi. Kullanici adi + sifre hash karsilastirmasi yapar,
    /// role gore yonlendirir (Admin -> /Admin/SoruListe.aspx, User -> Default.aspx).
    /// </summary>
    public partial class Login : System.Web.UI.Page
    {
        /// <summary>
        /// Session["Dil"] icin kultur ayari (public sayfa oldugu icin BasePage'den turetilmemis).
        /// </summary>
        protected override void InitializeCulture()
        {
            string dil = "tr-TR";
            if (Session != null && Session["Dil"] != null)
            {
                string s = Session["Dil"].ToString();
                if (s == "tr-TR" || s == "en-US") dil = s;
            }
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(dil);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(dil);
            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Zaten girisli kullanici varsa rolune gore yonlendir.
            if (!IsPostBack && Session["KullaniciId"] != null)
            {
                YonlendirRoleGore();
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            pnlHata.Visible = false;

            string kullaniciAdi = (txtKullaniciAdi.Text ?? string.Empty).Trim();
            string sifre = txtSifre.Text ?? string.Empty;

            if (string.IsNullOrEmpty(kullaniciAdi) || string.IsNullOrEmpty(sifre))
            {
                GosterHata(Resources.Resources.GirisHatali);
                return;
            }

            try
            {
                // Kullaniciyi DB'den cek.
                string sql = "SELECT Id, KullaniciAdi, Sifre, Rol FROM Kullanicilar WHERE KullaniciAdi = ?";
                DataRow row = DbHelper.GetDataRow(sql, kullaniciAdi);

                if (row == null)
                {
                    GosterHata(Resources.Resources.GirisHatali);
                    return;
                }

                string storedHash = row["Sifre"].ToString();

                if (!SecurityHelper.VerifyPassword(sifre, storedHash))
                {
                    GosterHata(Resources.Resources.GirisHatali);
                    return;
                }

                // Basarili giris -> Session'a yaz.
                Session["KullaniciId"] = Convert.ToInt32(row["Id"]);
                Session["KullaniciAdi"] = row["KullaniciAdi"].ToString();
                Session["Rol"] = row["Rol"].ToString();

                YonlendirRoleGore();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("[Login.btnGiris_Click] " + ex.Message);
                GosterHata(Resources.Resources.GenelHata);
            }
        }

        /// <summary>
        /// Role gore ana sayfaya yonlendirir.
        /// SPEC 5.6: Admin -> /Admin/SoruListe.aspx, User -> Default.aspx
        /// </summary>
        private void YonlendirRoleGore()
        {
            string rol = Session["Rol"] == null ? "User" : Session["Rol"].ToString();

            if (rol == "Admin")
            {
                Response.Redirect("~/Admin/SoruListe.aspx");
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        private void GosterHata(string mesaj)
        {
            lblHata.Text = mesaj;
            pnlHata.Visible = true;
        }
    }
}