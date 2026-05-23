using System;
using System.Data;
using System.Web.Script.Serialization;

namespace Project
{
    public partial class Gecmis : System.Web.UI.Page
    {
        public string ChartLabelsJson { get; set; } = "[]";
        public string ChartValuesJson { get; set; } = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciId"] == null)
            {
                Session["KullaniciId"] = 1;
            }

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

            table.Rows.Add("Genel Kültür", DateTime.Now.AddDays(-2).ToString("dd.MM.yyyy"), "4", "1", "0", "%80");
            table.Rows.Add("Bilgi Teknolojileri", DateTime.Now.AddDays(-1).ToString("dd.MM.yyyy"), "3", "2", "0", "%60");

            gvHistory.DataSource = table;
            gvHistory.DataBind();

            if (table.Rows.Count == 0)
            {
                object noHistoryText = GetGlobalResourceObject("Resources", "NoHistory");
                lblMessage.Text = noHistoryText != null ? noHistoryText.ToString() : "Henüz sınav geçmişiniz bulunmuyor.";
            }

            string[] labels = { "Genel Kültür", "Bilgi Teknolojileri" };
            int[] values = { 80, 60 };

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            ChartLabelsJson = serializer.Serialize(labels);
            ChartValuesJson = serializer.Serialize(values);
        }
    }
}