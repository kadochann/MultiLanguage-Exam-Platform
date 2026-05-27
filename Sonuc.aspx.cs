using System;
using System.Collections.Generic;
using System.Data;

namespace Project
{
    public partial class Sonuc : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CalculateResult();
            }
        }

        private void CalculateResult()
        {
            DataTable questions = Session["Sorular"] as DataTable;
            Dictionary<int, string> answers = Session["Cevaplar"] as Dictionary<int, string>;

            if (questions == null)
            {
                Response.Redirect("SinavBasla.aspx");
                return;
            }

            int correct = 0;
            int wrong = 0;
            int empty = 0;

            foreach (DataRow row in questions.Rows)
            {
                int soruId = Convert.ToInt32(row["Id"]);
                string correctAnswer = row["DogruCevap"].ToString();

                if (answers == null || !answers.ContainsKey(soruId))
                {
                    empty++;
                }
                else if (answers[soruId] == correctAnswer)
                {
                    correct++;
                }
                else
                {
                    wrong++;
                }
            }

            int total = questions.Rows.Count;
            double score = total == 0 ? 0 : ((double)correct / total) * 100;

            lblCorrect.Text = correct.ToString();
            lblWrong.Text = wrong.ToString();
            lblEmpty.Text = empty.ToString();
            lblScore.Text = "%" + score.ToString("0.##");

            DateTime start = Session["SinavBaslangic"] != null
                ? Convert.ToDateTime(Session["SinavBaslangic"])
                : DateTime.Now;

            TimeSpan duration = DateTime.Now - start;

            object durationText = GetGlobalResourceObject("Resources", "Duration");

            lblDuration.Text =
                (durationText != null ? durationText.ToString() : "Süre") +
                ": " +
                duration.Minutes +
                " dakika " +
                duration.Seconds +
                " saniye";

            int kId = Session["KategoriId"] != null ? Convert.ToInt32(Session["KategoriId"]) : 1;
            int sure = (int)duration.TotalSeconds;

            string insertSql = @"
                INSERT INTO SinavSonuclari (KullaniciId, KategoriId, DogruSayisi, YanlisSayisi, BosSayisi, SureSaniye, SinavTarihi)
                VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            DbHelper.ExecuteNonQuery(insertSql, KullaniciId, kId, correct, wrong, empty, sure, DateTime.Now);

            // Temizle yarım kalan sınav verisini
            DbHelper.ExecuteNonQuery("DELETE FROM YarimSinavlar WHERE KullaniciId = ?", KullaniciId);

            Session.Remove("Sorular");
            Session.Remove("Cevaplar");
            Session.Remove("MevcutSoruIndex");
            Session.Remove("SinavBaslangic");
            Session.Remove("KategoriId");
        }
    }
}