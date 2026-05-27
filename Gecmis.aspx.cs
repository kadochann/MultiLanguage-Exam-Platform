using System;
using System.Data;
using System.Web.Script.Serialization;

namespace Project
{
    public partial class Gecmis : BasePage
    {
        public string ChartLabelsJson { get; set; } = "[]";
        public string ChartValuesJson { get; set; } = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHistory();
            }
        }

        private void LoadHistory()
        {
            DataTable table = new DataTable();

            table.Columns.Add("Kategori");
            table.Columns.Add("Tarih");
            table.Columns.Add("Dogru");
            table.Columns.Add("Yanlis");
            table.Columns.Add("Bos");
            table.Columns.Add("Skor");

            string dil = Session["Dil"] as string ?? "tr-TR";
            string adKolonu = "AdTR";
            if (dil == "en-US") adKolonu = "AdEN";
            else if (dil == "ar-SA") adKolonu = "AdAR";

            string sql = $@"
                SELECT 
                    K.{adKolonu} AS KategoriAd,
                    S.SinavTarihi, 
                    S.DogruSayisi, 
                    S.YanlisSayisi
                FROM SinavSonuclari S
                INNER JOIN Kategoriler K ON S.KategoriId = K.Id
                WHERE S.KullaniciId = ?
                ORDER BY S.SinavTarihi ASC";
                
            DataTable results = DbHelper.GetDataTable(sql, KullaniciId);

            var labels = new System.Collections.Generic.List<string>();
            var values = new System.Collections.Generic.List<int>();

            foreach(DataRow row in results.Rows)
            {
                string kat = row["KategoriAd"].ToString();
                DateTime tarih = Convert.ToDateTime(row["SinavTarihi"]);
                int dogru = Convert.ToInt32(row["DogruSayisi"]);
                int yanlis = Convert.ToInt32(row["YanlisSayisi"]);
                int toplam = 5; // Assuming 5 questions per default
                int bos = toplam - (dogru + yanlis);
                if (bos < 0) bos = 0;
                
                int totalS = dogru + yanlis + bos;
                int skor = totalS == 0 ? 0 : (dogru * 100) / totalS;

                table.Rows.Add(kat, tarih.ToString("dd.MM.yyyy HH:mm"), dogru.ToString(), yanlis.ToString(), bos.ToString(), "%" + skor);

                labels.Add(kat);
                values.Add(skor);
            }

            gvHistory.DataSource = table;
            gvHistory.DataBind();

            if (table.Rows.Count == 0)
            {
                object noHistoryText = GetGlobalResourceObject("Resources", "NoHistory");
                lblMessage.Text = noHistoryText != null ? noHistoryText.ToString() : "Henüz sınav geçmişiniz bulunmuyor.";
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            ChartLabelsJson = serializer.Serialize(labels);
            ChartValuesJson = serializer.Serialize(values);
        }
    }
}