using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BuildingCost
{
   public class DatabaseHelper
   {
      static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

      public string SectionTreesSelectSql()
      {
         return "SELECT * FROM dbo.SectionTrees";
      }

      public class Material
      {
         public int MaterId { get; set; }
         public int SecId { get; set; }
         public string Code { get; set; }
         public string MaterName { get; set; }
         public string UnitId { get; set; }
         public int ClassWeight { get; set; }
         public decimal GrossWeight { get; set; }
         public decimal ReleasePrice { get; set; }
         public decimal CalculatePrice { get; set; }
         public string RegId { get; set; }
         public decimal AvgPrice { get; set; }
      }

      public class UserProfile
      {
         public string UsrId { get; set; }
         public string CompanyName { get; set; }
      }

      public UserProfile GetCompany(string UsrId)
      {
         UserProfile Profile = new UserProfile();
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT u.usr_id, CONCAT(t.cabbr, ' ', u.co_name) AS co_name FROM dbo.UserProfiles u ";
               cmd.CommandText += "LEFT JOIN dbo.TypeOfCompanies t ON (t.ctype_id = u.ctype_id) WHERE usr_id = @usr_id";
               cmd.Parameters.Add("@usr_id", SqlDbType.NVarChar, 128).Value = UsrId;
               using (var dr = cmd.ExecuteReader())
               {
                  while (dr.Read())
                  {
                     Profile.UsrId = dr.IsDBNull(0) ? "" : dr.GetString(0);
                     Profile.CompanyName = dr.IsDBNull(1) ? "" : dr.GetString(1);
                  }
               }
            }
         }
         return Profile;
      }

      public List<Material> GetMaterials(int mater_id)
      {
         List<Material> materials = new List<Material>();
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT * FROM dbo.Materials WHERE mater_id = @mater_id";
               cmd.Parameters.Add("@mater_id", SqlDbType.Int).Value = mater_id;
               using (var dr = cmd.ExecuteReader())
               {
                  while (dr.Read())
                  {
                     materials.Add(new Material()
                     {
                        MaterId = dr.GetInt32(0),
                        SecId = dr.GetInt32(1),
                        Code = dr.IsDBNull(2) ? "" : dr.GetString(2),
                        MaterName = dr.IsDBNull(3) ? "" : dr.GetString(3),
                        UnitId = dr.IsDBNull(4) ? "" : dr.GetString(4),
                        ClassWeight = dr.IsDBNull(5) ? 0 : dr.GetInt32(5),
                        GrossWeight = dr.IsDBNull(6) ? 0 : dr.GetDecimal(6),
                        ReleasePrice = dr.IsDBNull(7) ? 0 : dr.GetDecimal(7),
                        CalculatePrice = dr.IsDBNull(8) ? 0 : dr.GetDecimal(8),
                        RegId = dr.IsDBNull(9) ? "" : dr.GetString(9),
                        AvgPrice = dr.IsDBNull(10) ? 0 : dr.GetDecimal(10)
                     });
                  }
               }
            }
            return materials;
         }
      }

      public int GetPriceOffer(int mater_id, string usr_id)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT dbo.GetPriceOffer(@mater_id, @usr_id) AS cnt";
               cmd.Parameters.Add("@mater_id", SqlDbType.Int).Value = mater_id;
               cmd.Parameters.Add("usr_id", SqlDbType.NVarChar, 128).Value = usr_id;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }
   }
}