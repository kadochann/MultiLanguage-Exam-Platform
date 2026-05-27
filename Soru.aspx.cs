using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace Project
{
    public partial class Soru : BasePage
    {
        public int InitialRemainingSeconds { get; set; } = 300;

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string IncrementWarningCount()
        {
            if (System.Web.HttpContext.Current.Session == null) return "0";
            
            int count = System.Web.HttpContext.Current.Session["FokusUyariSayisi"] != null 
                ? Convert.ToInt32(System.Web.HttpContext.Current.Session["FokusUyariSayisi"]) 
                : 0;
            
            count++;
            System.Web.HttpContext.Current.Session["FokusUyariSayisi"] = count;
            
            return count.ToString();
        }

        private string GetCevaplarJson()
        {
            var answers = Session["Cevaplar"] as Dictionary<int, string>;
            if (answers == null) return "{}";
            
            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var dict = new Dictionary<string, string>();
            foreach (var kvp in answers)
            {
                dict[kvp.Key.ToString()] = kvp.Value;
            }
            return serializer.Serialize(dict);
        }

        private string GetSoruIdListStr(DataTable dt)
        {
            var ids = new List<string>();
            foreach (DataRow row in dt.Rows)
            {
                ids.Add(row["Id"].ToString());
            }
            return string.Join(",", ids);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IsResumeMode"] != null && Convert.ToBoolean(Session["IsResumeMode"]))
                {
                    // Resume mode
                    Session.Remove("IsResumeMode");
                    int kalanSaniye = Session["ResumeKalanSaniye"] != null ? Convert.ToInt32(Session["ResumeKalanSaniye"]) : 300;
                    InitialRemainingSeconds = kalanSaniye;

                    string idListStr = Session["ResumeSoruIdList"].ToString();
                    string sql = $"SELECT * FROM Sorular WHERE Id IN ({idListStr})";
                    DataTable dt = DbHelper.GetDataTable(sql);

                    string[] idArray = idListStr.Split(',');
                    DataTable sortedDt = dt.Clone();
                    foreach (string idStr in idArray)
                    {
                        int id = int.Parse(idStr);
                        foreach (DataRow row in dt.Rows)
                        {
                            if (Convert.ToInt32(row["Id"]) == id)
                            {
                                sortedDt.ImportRow(row);
                                break;
                            }
                        }
                    }
                    Session["Sorular"] = sortedDt;
                }
                else
                {
                    // Start new exam
                    int categoryId = Session["KategoriId"] != null ? Convert.ToInt32(Session["KategoriId"]) : 1;
                    DataRow catRow = DbHelper.GetDataRow("SELECT SoruSayisi, SureSaniye FROM Kategoriler WHERE Id = ?", categoryId);
                    int targetQuestions = catRow != null ? Convert.ToInt32(catRow["SoruSayisi"]) : 5;
                    int sureSaniye = catRow != null ? Convert.ToInt32(catRow["SureSaniye"]) : 300;

                    DataTable allQuestions = DbHelper.GetDataTable("SELECT * FROM Sorular WHERE KategoriId = ?", categoryId);
                    
                    var rows = new List<DataRow>();
                    foreach (DataRow r in allQuestions.Rows) rows.Add(r);
                    var rnd = new Random();
                    int n = rows.Count;
                    while (n > 1)
                    {
                        n--;
                        int k = rnd.Next(n + 1);
                        var value = rows[k];
                        rows[k] = rows[n];
                        rows[n] = value;
                    }

                    DataTable shuffledTable = allQuestions.Clone();
                    for (int i = 0; i < Math.Min(targetQuestions, rows.Count); i++)
                    {
                        shuffledTable.ImportRow(rows[i]);
                    }

                    Session["Sorular"] = shuffledTable;
                    Session["Cevaplar"] = new Dictionary<int, string>();
                    Session["MevcutSoruIndex"] = 0;
                    Session["SinavBaslangic"] = DateTime.Now;

                    string idListStr = GetSoruIdListStr(shuffledTable);
                    Session["ResumeSoruIdList"] = idListStr;
                    InitialRemainingSeconds = sureSaniye;

                    DbHelper.ExecuteNonQuery("DELETE FROM YarimSinavlar WHERE KullaniciId = ?", KullaniciId);
                    string insertSql = @"INSERT INTO YarimSinavlar (KullaniciId, KategoriId, BaslangicZamani, KalanSaniye, MevcutIndex, SoruIdListesi, CevaplarJson) 
                                         VALUES (?, ?, ?, ?, ?, ?, ?)";
                    DbHelper.ExecuteNonQuery(insertSql, KullaniciId, categoryId, Session["SinavBaslangic"], sureSaniye, 0, idListStr, "{}");
                }

                ClientScript.RegisterStartupScript(this.GetType(), "initTimer", $"sessionStorage.setItem('remainingSeconds', {InitialRemainingSeconds});", true);
                ShowQuestion();
            }
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
            else
            {
                // If they uncheck or keep it empty, keep current structure
            }

            Session["Cevaplar"] = answers;

            // Sync with YarimSinavlar in DB
            int kalanSaniye = InitialRemainingSeconds;
            if (!string.IsNullOrEmpty(hfRemainingSeconds.Value) && int.TryParse(hfRemainingSeconds.Value, out int clientKalan))
            {
                kalanSaniye = clientKalan;
            }
            Session["ResumeKalanSaniye"] = kalanSaniye;

            string answersJson = GetCevaplarJson();
            string updateSql = "UPDATE YarimSinavlar SET KalanSaniye = ?, MevcutIndex = ?, CevaplarJson = ? WHERE KullaniciId = ?";
            DbHelper.ExecuteNonQuery(updateSql, kalanSaniye, index, answersJson, KullaniciId);
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
            
            // Sınav bittiği için yarım kalan kaydı temizle
            DbHelper.ExecuteNonQuery("DELETE FROM YarimSinavlar WHERE KullaniciId = ?", KullaniciId);
            
            Response.Redirect("Sonuc.aspx");
        }
    }
}