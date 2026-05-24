using System;
using System.Security.Cryptography;
using System.Text;

/// <summary>
/// Sifre guvenligi yardimcisi. SPEC.md 5.2 bolumune gore sifreler SHA256 hash olarak saklanir.
/// "Sifremi unuttum" ozelligi yoktur, dolayisiyla salt + iteration kullanmiyoruz (spec geregi).
/// </summary>
public static class SecurityHelper
{
    /// <summary>
    /// Verilen sifreyi SHA256 ile hashleyip Hex string olarak doner.
    /// Ornek: HashPassword("admin123") -> "240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9"
    /// </summary>
    public static string HashPassword(string plainPassword)
    {
        if (plainPassword == null)
            throw new ArgumentNullException("plainPassword");

        using (var sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(plainPassword);
            byte[] hash = sha256.ComputeHash(bytes);

            var sb = new StringBuilder(hash.Length * 2);
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("x2"));
            }
            return sb.ToString();
        }
    }

    /// <summary>
    /// Kullanicidan gelen ham sifre ile DB'deki hash'i karsilastirir.
    /// Login.aspx.cs icinde kullanilir.
    /// </summary>
    /// <param name="plainPassword">Kullanicidan gelen ham sifre</param>
    /// <param name="storedHash">DB'de saklanan hash</param>
    /// <returns>Eslesiyorsa true</returns>
    public static bool VerifyPassword(string plainPassword, string storedHash)
    {
        if (string.IsNullOrEmpty(plainPassword) || string.IsNullOrEmpty(storedHash))
            return false;

        string computed = HashPassword(plainPassword);

        // Case-insensitive karsilastirma (hex hash buyuk/kucuk fark etmez).
        return string.Equals(computed, storedHash, StringComparison.OrdinalIgnoreCase);
    }
}