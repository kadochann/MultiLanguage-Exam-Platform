using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace Project
{
    public partial class SinavBasla : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckUnfinishedExam();
                LoadCategories();
            }
        }

        private void CheckUnfinishedExam()
        {
            string dil = Session["Dil"] as string ?? "tr-TR";
            string adKolonu = (dil == "en-US") ? "AdEN" : "AdTR";

            string sql = $@"
                SELECT Y.Id, Y.KategoriId, K.{adKolonu} AS KategoriAd 
                FROM YarimSinavlar Y 
                INNER JOIN Kategoriler K ON Y.KategoriId = K.Id 
                WHERE Y.KullaniciId = ?";
            
            DataRow row = DbHelper.GetDataRow(sql, KullaniciId);
            if (row != null)
            {
                pnlResume.Visible = true;
                string katAd = row["KategoriAd"].ToString();
                string formatStr = GetGlobalResourceObject("Resources", "ResumeExamText") as string 
                    ?? "Daha önce yarım bıraktığınız bir sınav var ({0}). Kaldığınız yerden devam etmek ister misiniz?";
                litResumeMessage.Text = string.Format(formatStr, katAd);
                
                Session["ResumeYarimSinavId"] = Convert.ToInt32(row["Id"]);
                Session["ResumeKategoriId"] = Convert.ToInt32(row["KategoriId"]);
            }
            else
            {
                pnlResume.Visible = false;
                Session.Remove("ResumeYarimSinavId");
                Session.Remove("ResumeKategoriId");
            }
        }

        protected void btnResume_Click(object sender, EventArgs e)
        {
            if (Session["ResumeYarimSinavId"] != null)
            {
                int yarimId = Convert.ToInt32(Session["ResumeYarimSinavId"]);
                
                string sql = "SELECT KategoriId, SoruIdListesi, CevaplarJson, MevcutIndex, KalanSaniye, BaslangicZamani FROM YarimSinavlar WHERE Id = ?";
                DataRow row = DbHelper.GetDataRow(sql, yarimId);
                if (row != null)
                {
                    int kategoriId = Convert.ToInt32(row["KategoriId"]);
                    string soruIdListesi = row["SoruIdListesi"].ToString();
                    string cevaplarJson = row["CevaplarJson"].ToString();
                    int mevcutIndex = Convert.ToInt32(row["MevcutIndex"]);
                    int kalanSaniye = Convert.ToInt32(row["KalanSaniye"]);
                    DateTime baslangic = Convert.ToDateTime(row["BaslangicZamani"]);

                    Session["KategoriId"] = kategoriId;
                    Session["MevcutSoruIndex"] = mevcutIndex;
                    
                    Session["IsResumeMode"] = true;
                    Session["ResumeSoruIdList"] = soruIdListesi;
                    Session["ResumeKalanSaniye"] = kalanSaniye;
                    Session["SinavBaslangic"] = baslangic;
                    
                    var answers = new Dictionary<int, string>();
                    if (!string.IsNullOrEmpty(cevaplarJson))
                    {
                        try
                        {
                            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                            var dict = serializer.Deserialize<Dictionary<string, string>>(cevaplarJson);
                            if (dict != null)
                            {
                                foreach (var kvp in dict)
                                {
                                    answers[int.Parse(kvp.Key)] = kvp.Value;
                                }
                            }
                        }
                        catch { }
                    }
                    Session["Cevaplar"] = answers;
                    Session["FokusUyariSayisi"] = 0;

                    Response.Redirect("Soru.aspx");
                }
            }
        }

        protected void btnIgnoreResume_Click(object sender, EventArgs e)
        {
            if (Session["ResumeYarimSinavId"] != null)
            {
                int yarimId = Convert.ToInt32(Session["ResumeYarimSinavId"]);
                DbHelper.ExecuteNonQuery("DELETE FROM YarimSinavlar WHERE Id = ?", yarimId);
                
                Session.Remove("ResumeYarimSinavId");
                Session.Remove("ResumeKategoriId");
                pnlResume.Visible = false;
            }
        }

        private void LoadCategories()
        {
            // SPEC'te 'Kategoriler' tablosu var: Id, AdTR, AdEN, AdAR
            string dil = Session["Dil"] as string ?? "tr-TR";
            string adKolonu = (dil == "en-US") ? "AdEN" : "AdTR";

            string sql = $@"
                SELECT 
                    Id, 
                    {adKolonu} AS Ad, 
                    SoruSayisi, 
                    SureSaniye 
                FROM Kategoriler
            ";

            DataTable table = DbHelper.GetDataTable(sql);

            rptCategories.DataSource = table;
            rptCategories.DataBind();
        }

        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "StartExam")
            {
                int kategoriId = Convert.ToInt32(e.CommandArgument);

                // Sil varsa eski yarım kalan sınav
                DbHelper.ExecuteNonQuery("DELETE FROM YarimSinavlar WHERE KullaniciId = ?", KullaniciId);

                Session["KategoriId"] = kategoriId;
                Session["MevcutSoruIndex"] = 0;
                Session["SinavBaslangic"] = DateTime.Now;
                Session["FokusUyariSayisi"] = 0;
                Session.Remove("IsResumeMode");
                Session.Remove("ResumeSoruIdList");
                Session.Remove("ResumeKalanSaniye");

                Response.Redirect("Soru.aspx");
            }
        }
    }
}