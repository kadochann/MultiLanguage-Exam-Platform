using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace Project
{
    public partial class Soru : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciId"] == null)
            {
                // Test aşamasında login yoksa geçici kullanıcı veriyoruz.
                Session["KullaniciId"] = 1;
            }

            if (!IsPostBack)
            {
                if (Session["Sorular"] == null)
                {
                    Session["Sorular"] = LoadMockQuestions();
                    Session["Cevaplar"] = new Dictionary<int, string>();
                    Session["MevcutSoruIndex"] = 0;
                    Session["SinavBaslangic"] = DateTime.Now;
                }

                ShowQuestion();
            }
        }

        private DataTable LoadMockQuestions()
        {
            DataTable table = new DataTable();

            table.Columns.Add("Id", typeof(int));
            table.Columns.Add("SoruMetniTR");
            table.Columns.Add("SoruMetniEN");
            table.Columns.Add("SecenekATR");
            table.Columns.Add("SecenekBTR");
            table.Columns.Add("SecenekCTR");
            table.Columns.Add("SecenekDTR");
            table.Columns.Add("SecenekAEN");
            table.Columns.Add("SecenekBEN");
            table.Columns.Add("SecenekCEN");
            table.Columns.Add("SecenekDEN");
            table.Columns.Add("DogruCevap");

            table.Rows.Add(
                1,
                "Türkiye'nin başkenti neresidir?",
                "What is the capital of Turkey?",
                "İstanbul",
                "Ankara",
                "İzmir",
                "Bursa",
                "Istanbul",
                "Ankara",
                "Izmir",
                "Bursa",
                "B"
            );

            table.Rows.Add(
                2,
                "HTML ne için kullanılır?",
                "What is HTML used for?",
                "Veritabanı",
                "Web sayfası",
                "Oyun motoru",
                "İşletim sistemi",
                "Database",
                "Web page",
                "Game engine",
                "Operating system",
                "B"
            );

            table.Rows.Add(
                3,
                "C# hangi tür bir dildir?",
                "What type of language is C#?",
                "Programlama dili",
                "Veritabanı",
                "Tarayıcı",
                "Donanım",
                "Programming language",
                "Database",
                "Browser",
                "Hardware",
                "A"
            );

            return table;
        }

        private void ShowQuestion()
        {
            DataTable questions = Session["Sorular"] as DataTable;
            int index = Convert.ToInt32(Session["MevcutSoruIndex"]);

            if (questions == null || questions.Rows.Count == 0)
            {
                lblWarning.Text = "Soru bulunamadı.";
                return;
            }

            DataRow row = questions.Rows[index];

            string dil = Session["Dil"] as string ?? "tr-TR";

            int soruId = Convert.ToInt32(row["Id"]);

            lblQuestionNumber.Text = (index + 1) + " / " + questions.Rows.Count;

            string soruMetni;
            string secenekA;
            string secenekB;
            string secenekC;
            string secenekD;

            if (dil == "en-US")
            {
                soruMetni = row["SoruMetniEN"].ToString();
                secenekA = row["SecenekAEN"].ToString();
                secenekB = row["SecenekBEN"].ToString();
                secenekC = row["SecenekCEN"].ToString();
                secenekD = row["SecenekDEN"].ToString();
            }
            else
            {
                soruMetni = row["SoruMetniTR"].ToString();
                secenekA = row["SecenekATR"].ToString();
                secenekB = row["SecenekBTR"].ToString();
                secenekC = row["SecenekCTR"].ToString();
                secenekD = row["SecenekDTR"].ToString();
            }

            lblQuestionText.Text = soruMetni;

            if (string.IsNullOrWhiteSpace(soruMetni))
            {
                object warningText = GetGlobalResourceObject("Resources", "NotTranslated");
                lblWarning.Text = warningText != null ? warningText.ToString() : "Bu soru henüz çevrilmemiştir.";
            }
            else
            {
                lblWarning.Text = "";
            }

            rblOptions.Items.Clear();
            rblOptions.Items.Add(new ListItem("A) " + secenekA, "A"));
            rblOptions.Items.Add(new ListItem("B) " + secenekB, "B"));
            rblOptions.Items.Add(new ListItem("C) " + secenekC, "C"));
            rblOptions.Items.Add(new ListItem("D) " + secenekD, "D"));

            Dictionary<int, string> answers = Session["Cevaplar"] as Dictionary<int, string>;

            if (answers != null && answers.ContainsKey(soruId))
            {
                rblOptions.SelectedValue = answers[soruId];
            }

            btnPrevious.Enabled = index > 0;
            btnNext.Visible = index < questions.Rows.Count - 1;
            btnFinish.Visible = index == questions.Rows.Count - 1;
        }

        private void SaveCurrentAnswer()
        {
            DataTable questions = Session["Sorular"] as DataTable;
            int index = Convert.ToInt32(Session["MevcutSoruIndex"]);

            if (questions == null)
            {
                return;
            }

            int soruId = Convert.ToInt32(questions.Rows[index]["Id"]);

            Dictionary<int, string> answers = Session["Cevaplar"] as Dictionary<int, string>;

            if (answers == null)
            {
                answers = new Dictionary<int, string>();
            }

            if (!string.IsNullOrEmpty(rblOptions.SelectedValue))
            {
                answers[soruId] = rblOptions.SelectedValue;
            }

            Session["Cevaplar"] = answers;
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();

            int index = Convert.ToInt32(Session["MevcutSoruIndex"]);

            if (index > 0)
            {
                Session["MevcutSoruIndex"] = index - 1;
            }

            ShowQuestion();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();

            DataTable questions = Session["Sorular"] as DataTable;
            int index = Convert.ToInt32(Session["MevcutSoruIndex"]);

            if (questions != null && index < questions.Rows.Count - 1)
            {
                Session["MevcutSoruIndex"] = index + 1;
            }

            ShowQuestion();
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer();
            Response.Redirect("Sonuc.aspx");
        }
    }
}