using System;

namespace OnlineSinavSistemi
{
    /// <summary>
    /// Kullanici kayit sayfasi. Yeni kullaniciyi "User" rolu ile DB'ye ekler.
    /// Sifre SHA256 hash olarak saklanir.
    /// </summary>
    public partial class Register : System.Web.UI.Page
    {
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
            // Zaten girisli kullanici varsa Default'a yonlendir.
            if (!IsPostBack && Session["KullaniciId"] != null)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnKayit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            pnlMesaj.Visible = false;

            string kullaniciAdi = (txtKullaniciAdi.Text ?? string.Empty).Trim();
            string email = (txtEmail.Text ?? string.Empty).Trim();
            string sifre = txtSifre.Text ?? string.Empty;

            // Sunucu tarafi ek validasyon (uzunluk vb.)
            if (kullaniciAdi.Length < 3)
            {
                GosterHata(Resources.Resources.KullaniciAdiKisa);
                return;
            }

            if (sifre.Length < 4)
            {
                GosterHata(Resources.Resources.SifreKisa);
                return;
            }

            try
            {
                // Ayni kullanici adi var mi kontrol et.
                // Not: SPEC 4.1 unique constraint yok ama UX icin biz kontrol ediyoruz.
                string kontrolSql = "SELECT COUNT(*) FROM Kullanicilar WHERE KullaniciAdi = ?";
                int sayi = Convert.ToInt32(DbHelper.ExecuteScalar(kontrolSql, kullaniciAdi));

                if (sayi > 0)
                {
                    GosterHata(Resources.Resources.KullaniciAdiKullanimda);
                    return;
                }

                // Sifreyi hashle.
                string hash = SecurityHelper.HashPassword(sifre);

                // Kullaniciyi ekle. Rol = "User" sabit.
                // KayitTarihi'ni Now() ile manuel veriyoruz (MDB'de DEFAULT calismayabilir).
                string insertSql =
                    "INSERT INTO Kullanicilar (KullaniciAdi, Sifre, Email, Rol, KayitTarihi) VALUES (?, ?, ?, ?, Now())";
                DbHelper.ExecuteNonQuery(insertSql, kullaniciAdi, hash, email, "User");

                // Basarili -> mesaj goster ve Login'e yonlendir.
                pnlMesaj.CssClass = "alert alert-success";
                lblMesaj.Text = Resources.Resources.KayitBasarili;
                pnlMesaj.Visible = true;

                // 2 saniye sonra Login'e yonlendir.
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
            catch (Exception ex)
            {
                // Gercek hata Debug Output'a (VS -> View -> Output -> Debug) yazilir.
                // Kullaniciya sadece dostane mesaj gosterilir (SPEC 5.7).
                System.Diagnostics.Debug.WriteLine("[Register.btnKayit_Click] " + ex.Message);
                if (ex.InnerException != null)
                {
                    System.Diagnostics.Debug.WriteLine("[Register.btnKayit_Click] Inner: " + ex.InnerException.Message);
                }
                GosterHata(Resources.Resources.GenelHata);
            }
        }

        private void GosterHata(string mesaj)
        {
            pnlMesaj.CssClass = "alert alert-danger";
            lblMesaj.Text = mesaj;
            pnlMesaj.Visible = true;
        }
    }
}