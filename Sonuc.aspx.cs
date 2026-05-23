using System;
using System.Collections.Generic;
using System.Data;

namespace Project
{
    public partial class Sonuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciId"] == null)
            {
                Session["KullaniciId"] = 1;
            }

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

            Session.Remove("Sorular");
            Session.Remove("Cevaplar");
            Session.Remove("MevcutSoruIndex");
            Session.Remove("SinavBaslangic");
            Session.Remove("KategoriId");
        }
    }
}