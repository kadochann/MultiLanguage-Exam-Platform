using System;
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
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            // SPEC'te 'Kategoriler' tablosu var: Id, AdTR, AdEN, AdAR
            string dil = Session["Dil"] as string ?? "tr-TR";
            string adKolonu = "AdTR";
            
            if (dil == "en-US") adKolonu = "AdEN";
            else if (dil == "ar-SA") adKolonu = "AdAR";

            string sql = $@"
                SELECT 
                    Id, 
                    {adKolonu} AS Ad, 
                    5 AS SoruSayisi, 
                    300 AS SureSaniye 
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

                Session["KategoriId"] = kategoriId;
                Session["MevcutSoruIndex"] = 0;
                Session["SinavBaslangic"] = DateTime.Now;
                Session["FokusUyariSayisi"] = 0;

                Response.Redirect("Soru.aspx");
            }
        }
    }
}