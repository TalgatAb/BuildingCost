using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BuildingCost
{
   public partial class ViewPriceOffers : System.Web.UI.Page
   {
      static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
      public static int MaterId { get; set; }

      protected void Page_Load(object sender, EventArgs e)
      {
         MaterId = 0;
         if (int.TryParse(Request.QueryString["mater_id"].ToString(), out int result))
         {
            MaterId = result;
         }
      }

      public string GetMaterials()
      {
         string result = "Не найдено";
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT CONCAT(code, ' ', mater_name) mater_name FROM dbo.Materials WHERE mater_id = @mater_id";
               cmd.Parameters.Add("@mater_id", SqlDbType.Int).Value = MaterId;
               result = cmd.ExecuteScalar() as string ?? "";
            }
         }
         return result;
      }
   }
}