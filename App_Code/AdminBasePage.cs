using System;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.UI;

/// <summary>
/// Tum Admin sayfalari (Admin/ klasoru altindakiler) bu siniftan turer.
/// SPEC.md 5.6: Sadece Rol == "Admin" olan kullanicilar erisebilir.
/// </summary>
public class AdminBasePage : Page
{
    /// <summary>
    /// Admin panelinde de dil destegi var (TR/EN), o yuzden InitializeCulture override.
    /// </summary>
    protected override void InitializeCulture()
    {
        string dil = "tr-TR";

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
    /// Sayfa yuklenmeden once admin yetki kontrolu yapilir.
    /// - Session yoksa Login.aspx'e gider.
    /// - Rol Admin degilse Login.aspx'e gider (yetkisiz).
    /// </summary>
    protected override void OnPreInit(EventArgs e)
    {
        base.OnPreInit(e);

        // Session yoksa -> Login.
        if (Session["KullaniciId"] == null)
        {
            Response.Redirect("~/Login.aspx", true);
            return;
        }

        // Rol Admin degilse -> Login (yetkisiz erisim).
        if (Session["Rol"] == null || Session["Rol"].ToString() != "Admin")
        {
            Response.Redirect("~/Login.aspx", true);
            return;
        }
    }

    /// <summary>
    /// Aktif admin ID'si.
    /// </summary>
    protected int AdminId
    {
        get
        {
            return Session["KullaniciId"] == null
                ? 0
                : Convert.ToInt32(Session["KullaniciId"]);
        }
    }

    /// <summary>
    /// Aktif admin kullanici adi.
    /// </summary>
    protected string AdminAdi
    {
        get
        {
            return Session["KullaniciAdi"] == null
                ? string.Empty
                : Session["KullaniciAdi"].ToString();
        }
    }
}