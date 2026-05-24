using System;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.UI;

/// <summary>
/// Tum kullanici (User rolu) sayfalari bu siniftan turer.
/// SPEC.md 5.1 + 5.6:
///   - InitializeCulture() override edilir, Session["Dil"] okunur.
///   - Page_Load basinda login kontrolu yapilir.
///   - Admin rolundeki kullanici normal sayfalara erisemez (admin paneline yonlendirilir).
/// 
/// Public sayfalar (Default, Login, Register) bu sinifi KULLANMAZ.
/// </summary>
public class BasePage : Page
{
    /// <summary>
    /// Sayfa render edilmeden once kultur (TR/EN) ayarlanir.
    /// Bu metot Page_Load'dan ONCE calisir, dolayisiyla resx dosyalari dogru dilde okunur.
    /// </summary>
    protected override void InitializeCulture()
    {
        string dil = "tr-TR"; // Varsayilan dil (SPEC 5.1: ilk girisde TR).

        if (HttpContext.Current != null
            && HttpContext.Current.Session != null
            && HttpContext.Current.Session["Dil"] != null)
        {
            string sessionDil = HttpContext.Current.Session["Dil"].ToString();
            if (sessionDil == "tr-TR" || sessionDil == "en-US")
            {
                dil = sessionDil;
            }
        }

        Thread.CurrentThread.CurrentCulture = new CultureInfo(dil);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(dil);

        base.InitializeCulture();
    }

    /// <summary>
    /// Sayfa yuklenmeden once login kontrolu yapilir.
    /// Yetki yoksa Login.aspx'e yonlendirilir.
    /// Admin rolu varsa admin paneline yonlendirilir.
    /// </summary>
    protected override void OnPreInit(EventArgs e)
    {
        base.OnPreInit(e);

        // Session yoksa veya KullaniciId yoksa -> Login.
        if (Session["KullaniciId"] == null)
        {
            Response.Redirect("~/Login.aspx", true);
            return;
        }

        // Admin rolundeki kullanici normal sayfalara giremez.
        if (Session["Rol"] != null && Session["Rol"].ToString() == "Admin")
        {
            Response.Redirect("~/Admin/SoruListe.aspx", true);
            return;
        }
    }

    /// <summary>
    /// Aktif kullanici ID'sini doner. Login kontrolu OnPreInit'te yapildigi icin
    /// bu property cagrildiginda Session["KullaniciId"] kesin doludur.
    /// </summary>
    protected int KullaniciId
    {
        get
        {
            return Session["KullaniciId"] == null
                ? 0
                : Convert.ToInt32(Session["KullaniciId"]);
        }
    }

    /// <summary>
    /// Aktif kullanici adi.
    /// </summary>
    protected string KullaniciAdi
    {
        get
        {
            return Session["KullaniciAdi"] == null
                ? string.Empty
                : Session["KullaniciAdi"].ToString();
        }
    }

    /// <summary>
    /// Aktif dil kodu (tr-TR / en-US).
    /// </summary>
    protected string AktifDil
    {
        get
        {
            return Session["Dil"] == null
                ? "tr-TR"
                : Session["Dil"].ToString();
        }
    }
}