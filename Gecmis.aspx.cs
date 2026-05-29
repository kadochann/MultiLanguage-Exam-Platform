using System;
using System.Data;
using System.Web.Script.Serialization;

namespace Project
{
    public partial class Gecmis : BasePage
    {
        public string ChartLabelsJson { get; set; } = "[]";
        public string ChartValuesJson { get; set; } = "[]";

        public string BarChartLabelsJson { get; set; } = "[]";
        public string BarChartValuesJson { get; set; } = "[]";

        public string LineChartLabelsJson { get; set; } = "[]";
        public string LineChartValuesJson { get; set; } = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            Title = GetGlobalResourceObject("Resources", "ExamHistory")?.ToString() ?? "Geçmiş Sınavlar";
            LoadHistory();
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
            string adKolonu = (dil == "en-US") ? "AdEN" : "AdTR";

            string sql = $@"
                SELECT 
                    K.{adKolonu} AS KategoriAd,
                    S.SinavTarihi, 
                    S.DogruSayisi, 
                    S.YanlisSayisi,
                    S.BosSayisi
                FROM SinavSonuclari S
                INNER JOIN Kategoriler K ON S.KategoriId = K.Id
                WHERE S.KullaniciId = ?
                ORDER BY S.SinavTarihi ASC";
                
            DataTable results = DbHelper.GetDataTable(sql, KullaniciId);

            var categoryScores = new System.Collections.Generic.Dictionary<string, System.Collections.Generic.List<int>>();
            var lineLabels = new System.Collections.Generic.List<string>();
            var lineValues = new System.Collections.Generic.List<int>();

            foreach(DataRow row in results.Rows)
            {
                string kat = row["KategoriAd"].ToString();
                DateTime tarih = Convert.ToDateTime(row["SinavTarihi"]);
                int dogru = Convert.ToInt32(row["DogruSayisi"]);
                int yanlis = Convert.ToInt32(row["YanlisSayisi"]);
                int bos = row["BosSayisi"] != DBNull.Value ? Convert.ToInt32(row["BosSayisi"]) : 0;
                
                int totalS = dogru + yanlis + bos;
                int skor = totalS == 0 ? 0 : (dogru * 100) / totalS;

                table.Rows.Add(kat, tarih.ToString("dd.MM.yyyy HH:mm"), dogru.ToString(), yanlis.ToString(), bos.ToString(), "%" + skor);

                // Group by category to compute average score
                if (!categoryScores.ContainsKey(kat))
                {
                    categoryScores[kat] = new System.Collections.Generic.List<int>();
                }
                categoryScores[kat].Add(skor);

                // Chronological exam timeline data
                string dateStr = tarih.ToString("dd.MM.yyyy HH:mm");
                lineLabels.Add($"{kat} ({dateStr})");
                lineValues.Add(skor);
            }

            // Compute averages for Bar Chart
            var barLabels = new System.Collections.Generic.List<string>();
            var barValues = new System.Collections.Generic.List<int>();
            foreach (var kvp in categoryScores)
            {
                barLabels.Add(kvp.Key);
                double avg = System.Linq.Enumerable.Average(kvp.Value);
                barValues.Add((int)Math.Round(avg));
            }

            gvHistory.DataSource = table;
            gvHistory.DataBind();

            if (table.Rows.Count == 0)
            {
                object noHistoryText = GetGlobalResourceObject("Resources", "NoHistory");
                lblMessage.Text = noHistoryText != null ? noHistoryText.ToString() : "Henüz sınav geçmişiniz bulunmuyor.";
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            BarChartLabelsJson = serializer.Serialize(barLabels);
            BarChartValuesJson = serializer.Serialize(barValues);

            LineChartLabelsJson = serializer.Serialize(lineLabels);
            LineChartValuesJson = serializer.Serialize(lineValues);

            // Backward compatibility
            ChartLabelsJson = BarChartLabelsJson;
            ChartValuesJson = BarChartValuesJson;

            string successLabel = GetGlobalResourceObject("Resources", "SuccessPercentage")?.ToString() ?? "Başarı (%)";
            string script = $@"
                var chartLabels = {ChartLabelsJson};
                var chartValues = {ChartValuesJson};
                var chartSuccessLabel = '{successLabel}';
            ";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "chartData", script, true);
        }
    }
}