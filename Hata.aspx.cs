using System;

namespace OnlineSinavSistemi
{
    /// <summary>
    /// Genel hata sayfasi. Web.config customErrors yonlendirmesi buraya gelir.
    /// </summary>
    public partial class Hata : System.Web.UI.Page
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
            // customErrors uzerinden gelen ?aspxerrorpath varsa log'la.
            string yol = Request.QueryString["aspxerrorpath"];
            if (!string.IsNullOrEmpty(yol))
            {
                System.Diagnostics.Debug.WriteLine("[Hata.aspx] Hata olusan yol: " + yol);
            }
        }
    }
}