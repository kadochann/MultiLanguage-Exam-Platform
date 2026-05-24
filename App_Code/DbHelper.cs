using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Diagnostics;

/// <summary>
/// MS Access (OleDb) tabanli veritabani yardimci sinifi.
/// SPEC.md 5.x bolumlerine gore tum veri erisimi bu sinif uzerinden yapilir.
/// 
/// Onemli OleDb notlari:
/// - Parametre placeholder'i "?" karakteridir, isim DEGIL. (@param calismaz)
/// - Parametreler SQL icinde gectigi SIRAYA gore eklenmelidir.
/// - SELECT TOP N ... ORDER BY Rnd(Id) -> Access'te rastgele kayit cekme.
/// </summary>
public static class DbHelper
{
    /// <summary>
    /// Web.config'deki "DefaultConnection" baglanti string'ini doner.
    /// </summary>
    private static string ConnectionString
    {
        get
        {
            var cs = ConfigurationManager.ConnectionStrings["DefaultConnection"];
            if (cs == null || string.IsNullOrWhiteSpace(cs.ConnectionString))
                throw new ConfigurationErrorsException(
                    "Web.config'de 'DefaultConnection' baglanti string'i bulunamadi.");
            return cs.ConnectionString;
        }
    }

    /// <summary>
    /// Yeni bir OleDbConnection doner. Cagiranin using blogu icinde kullanmasi beklenir.
    /// </summary>
    public static OleDbConnection GetConnection()
    {
        return new OleDbConnection(ConnectionString);
    }

    /// <summary>
    /// INSERT, UPDATE, DELETE gibi sorgular icin. Etkilenen satir sayisini doner.
    /// </summary>
    /// <param name="sql">SQL sorgusu (? placeholder'li)</param>
    /// <param name="parameters">Sirali parametre degerleri</param>
    public static int ExecuteNonQuery(string sql, params object[] parameters)
    {
        try
        {
            using (var conn = GetConnection())
            using (var cmd = new OleDbCommand(sql, conn))
            {
                AddParameters(cmd, parameters);
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine("[DbHelper.ExecuteNonQuery] " + ex.Message + " | SQL: " + sql);
            throw;
        }
    }

    /// <summary>
    /// Tek bir deger donduren sorgular icin (COUNT, SUM, tek bir kolon).
    /// </summary>
    public static object ExecuteScalar(string sql, params object[] parameters)
    {
        try
        {
            using (var conn = GetConnection())
            using (var cmd = new OleDbCommand(sql, conn))
            {
                AddParameters(cmd, parameters);
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine("[DbHelper.ExecuteScalar] " + ex.Message + " | SQL: " + sql);
            throw;
        }
    }

    /// <summary>
    /// INSERT sonrasi @@IDENTITY ile yeni eklenen kaydin ID'sini doner.
    /// Access'te INSERT + SELECT @@IDENTITY ayni baglanti uzerinden calistirilmalidir.
    /// </summary>
    public static int ExecuteInsertAndGetId(string insertSql, params object[] parameters)
    {
        try
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                using (var cmd = new OleDbCommand(insertSql, conn))
                {
                    AddParameters(cmd, parameters);
                    cmd.ExecuteNonQuery();
                }
                using (var idCmd = new OleDbCommand("SELECT @@IDENTITY", conn))
                {
                    object result = idCmd.ExecuteScalar();
                    return result == null || result == DBNull.Value
                        ? 0
                        : Convert.ToInt32(result);
                }
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine("[DbHelper.ExecuteInsertAndGetId] " + ex.Message + " | SQL: " + insertSql);
            throw;
        }
    }

    /// <summary>
    /// DataReader doner. ONEMLI: Cagiran baglanti yonetimini ustlenmelidir.
    /// Kullanim kolayligi icin GetDataTable veya GetDataRow tercih edilmelidir.
    /// </summary>
    public static OleDbDataReader ExecuteReader(string sql, params object[] parameters)
    {
        try
        {
            var conn = GetConnection();
            var cmd = new OleDbCommand(sql, conn);
            AddParameters(cmd, parameters);
            conn.Open();
            // CommandBehavior.CloseConnection: Reader kapaninca baglanti da kapanir.
            return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("[DbHelper.ExecuteReader] " + ex.Message + " | SQL: " + sql);
            throw;
        }
    }

    /// <summary>
    /// Sorgu sonucunu DataTable olarak doner. GridView/Repeater bind icin pratik.
    /// </summary>
    public static DataTable GetDataTable(string sql, params object[] parameters)
    {
        try
        {
            var dt = new DataTable();
            using (var conn = GetConnection())
            using (var cmd = new OleDbCommand(sql, conn))
            {
                AddParameters(cmd, parameters);
                using (var adapter = new OleDbDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }
            return dt;
        }
        catch (Exception ex)
        {
            Debug.WriteLine("[DbHelper.GetDataTable] " + ex.Message + " | SQL: " + sql);
            throw;
        }
    }

    /// <summary>
    /// Tek bir DataRow doner (yoksa null). Login gibi tek kayit sorgularinda pratik.
    /// </summary>
    public static DataRow GetDataRow(string sql, params object[] parameters)
    {
        var dt = GetDataTable(sql, parameters);
        return dt.Rows.Count == 0 ? null : dt.Rows[0];
    }

    /// <summary>
    /// Sorguda kayit var mi kontrol eder. Login validasyonu vb. icin.
    /// </summary>
    public static bool Exists(string sql, params object[] parameters)
    {
        var dt = GetDataTable(sql, parameters);
        return dt.Rows.Count > 0;
    }

    /// <summary>
    /// OleDbCommand'a sirali parametre ekler.
    /// OleDb parametre isimlerini ONEMSEMEZ, sadece sirayi dikkate alir.
    /// </summary>
    private static void AddParameters(OleDbCommand cmd, object[] parameters)
    {
        if (parameters == null || parameters.Length == 0) return;

        for (int i = 0; i < parameters.Length; i++)
        {
            // Isim sadece okunabilirlik icin; OleDb sirayla eslestirir.
            var paramName = "@p" + i;
            var value = parameters[i] ?? DBNull.Value;
            cmd.Parameters.AddWithValue(paramName, value);
        }
    }
}