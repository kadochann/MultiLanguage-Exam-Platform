$connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=App_Data\Database.mdb;"
$conn = New-Object System.Data.OleDb.OleDbConnection($connStr)
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = "SELECT * FROM Kullanicilar"
$reader = $cmd.ExecuteReader()
while ($reader.Read()) {
    Write-Output "Id: $($reader['Id']) | KullaniciAdi: $($reader['KullaniciAdi']) | Rol: $($reader['Rol'])"
}
$reader.Close()
$conn.Close()
