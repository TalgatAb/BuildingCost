using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BuildingCost
{
   public partial class PriceOffers : System.Web.UI.Page
   {
      static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
      public static string UsrId { get; set; }
      public static int MaterId { get; set; }
      DatabaseHelper helper = new DatabaseHelper();

      protected void Page_Load(object sender, EventArgs e)
      {
         if (!IsPostBack)
         {
            UsrId = Request.QueryString["usr_id"].ToString();
            MaterId = 0;
            if (int.TryParse(Request.QueryString["mater_id"].ToString(), out int result))
            {
               MaterId = result;
            }
            PhotoRepeater.DataSource = null;
            Session["ads_id"] = null;
         }
      }

      public string GetCompanyName()
      {
         var Company = helper.GetCompany(UsrId);
         return Company.CompanyName;
      }

      protected void PhotoCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
      {
         List<AdvertPhoto> photoList = new List<AdvertPhoto>();
         DataTable PhotoTable = new DataTable();

         int rowIndex = int.TryParse(e.Parameter, out int result) ? result : -1;
         if (rowIndex >= 0)
         {
            int ads_photo_id = PhotoGridView.GetRowValues(rowIndex, "ads_photo_id") as int? ?? 0;
            using (var cnn = new SqlConnection(connectionString))
            {
               cnn.Open();
               using (var cmd = cnn.CreateCommand())
               {
                  cmd.CommandText = "SELECT * FROM dbo.AdvertPhotos WHERE ads_photo_id = @ads_photo_id";
                  cmd.Parameters.Add("@ads_photo_id", SqlDbType.Int).Value = ads_photo_id;
                  PhotoTable.Load(cmd.ExecuteReader());
                  foreach (DataRow row in PhotoTable.Rows)
                  {
                     photoList.Add(new AdvertPhoto()
                     {
                        ads_photo_id = int.Parse(row["ads_photo_id"].ToString()),
                        ads_id = int.Parse(row["ads_id"].ToString()),
                        file_name = row["file_name"].ToString(),
                        photo = (byte[])row["photo"]
                     });
                     row["url"] = string.Format("~/PhotoHandler.ashx?ads_photo_id={0}", row["ads_photo_id"].ToString());
                     PhotoTable.AcceptChanges();

                     Session["photo_url"] = photoList;
                     PhotoRepeater.DataSource = PhotoTable;
                     PhotoRepeater.DataBind();
                  }
               }
            }
         }
      }

      protected void PhotoGridView_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
      {
         int rowIndex = int.TryParse(e.Parameters, out int result) ? result : -1;
         Session["ads_id"] = AdvertGridView.GetRowValues(rowIndex, "ads_id");
         PhotoGridView.DataBind();
      }

      protected void PhotoUploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
      {
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "INSERT INTO dbo.AdvertPhotos (ads_id, file_name, photo, url) VALUES (@ads_id, @file_name, @photo, @url)";
               cmd.Parameters.Add("@ads_id", SqlDbType.Int).Value = Session["ads_id"];
               cmd.Parameters.Add("@file_name", SqlDbType.NVarChar, 100).Value = e.UploadedFile.FileName;
               cmd.Parameters.Add("@photo", SqlDbType.VarBinary).Value = e.UploadedFile.FileBytes;
               cmd.Parameters.Add("@url", SqlDbType.NVarChar, 255).Value = "~/PhotoHandler.ashx?ads_photo_id=0";
               cmd.ExecuteNonQuery();
            }
         }
         e.CallbackData = "Ok!";

         //PhotoGridView.DataBind();
      }

      protected void PhotoGridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
      {
         ASPxUploadControl uc = PhotoGridView.FindEditRowCellTemplateControl((GridViewDataColumn)PhotoGridView.Columns["file_name"], "PhotoUploadControl") as ASPxUploadControl;
         if (uc != null)
         {
            uc.Visible = false;
         }
         e.Cancel = true;
         PhotoGridView.CancelEdit();
      }

      protected void AdvertGridView_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
      {
         var Products = helper.GetMaterials(MaterId);
         foreach (var m in Products)
         {
            e.NewValues["mater_name"] = m.MaterName;
            e.NewValues["unit_id"] = m.UnitId;
         }
         e.NewValues["cur_code"] = "KZT";
      }

      protected void AdvertGridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
      {
         e.NewValues["usr_id"] = UsrId;
         e.NewValues["mater_id"] = MaterId;
         e.NewValues["ads_date"] = DateTime.Now;
      }
   }
}