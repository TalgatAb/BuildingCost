using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace BuildingCost
{
   public partial class UserReg : System.Web.UI.Page
   {
      static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
      protected void Page_Load(object sender, EventArgs e)
      {
         if (!IsPostBack)
         {
            if (Context.User.Identity.IsAuthenticated)
            {
               string usrId = Context.User.Identity.GetUserId();
               using (var cnn = new SqlConnection(connectionString))
               {
                  cnn.Open();
                  using (var cmd = cnn.CreateCommand())
                  {
                     cmd.CommandType = CommandType.Text;
                     cmd.CommandText = "SELECT * FROM dbo.UserProfiles WHERE usr_id = @usr_id";
                     cmd.Parameters.Add("@usr_id", SqlDbType.NVarChar, 128).Value = usrId;
                     using (var dr = cmd.ExecuteReader())
                     {
                        if (dr.HasRows)
                        {
                           if (dr.Read())
                           {
                              CompanyTypeList.SelectedValue = dr["ctype_id"].ToString();
                              txtCompanyName.Text = dr["co_name"].ToString();
                              txtLegalAddress.Text = dr["legal_address"].ToString();
                              txtActualAddress.Text = dr["actual_address"].ToString();
                              txtSite.Text = dr["site"].ToString();
                              txtFm.Text = dr["fm"].ToString();
                              txtNm.Text = dr["nm"].ToString();
                              txtFt.Text = dr["ft"].ToString();
                              txtPosition.Text = dr["position"].ToString();
                              txtPhone1.Text = dr["phone1"].ToString();
                              txtPhone2.Text = dr["phone2"].ToString();
                              txtFax.Text = dr["fax"].ToString();
                              txtDescription.Text = dr["description"].ToString();
                              string reg_id = dr?["reg_id"].ToString() ?? "02";
                              RegionsList.SelectedValue = string.IsNullOrWhiteSpace(reg_id) ? "02" : reg_id;
                           }
                        }
                        else
                        {
                           CompanyTypeList.SelectedValue = "2";
                           RegionsList.SelectedValue = "02";
                        }
                     }
                  }
               }
            }
         }
      }

      protected void PostBtn_Click(object sender, EventArgs e)
      {
         int uTypeId = string.IsNullOrEmpty(txtCompanyName.Text) ? 1 : 2;
         if (Context.User.Identity.IsAuthenticated)
         {
            string usrId = Context.User.Identity.GetUserId();
            if (!string.IsNullOrEmpty(usrId))
            {
               if (IsValid)
               {
                  using (var cnn = new SqlConnection(connectionString))
                  {
                     cnn.Open();
                     using (var cmd = cnn.CreateCommand())
                     {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "MergeUserProfiles";
                        cmd.Parameters.Add("@usr_id", SqlDbType.NVarChar, 128).Value = usrId;
                        cmd.Parameters.Add("@utype_id", SqlDbType.Int).Value = uTypeId;
                        cmd.Parameters.Add("@ctype_id", SqlDbType.Int).Value = int.Parse(CompanyTypeList.SelectedValue);
                        cmd.Parameters.Add("@reg_id", SqlDbType.NChar, 2).Value = RegionsList.SelectedValue;
                        cmd.Parameters.Add("@co_name", SqlDbType.NVarChar, 150).Value = txtCompanyName.Text;
                        cmd.Parameters.Add("@legal_address", SqlDbType.NVarChar, 512).Value = txtLegalAddress.Text;
                        cmd.Parameters.Add("@actual_address", SqlDbType.NVarChar, 512).Value = txtActualAddress.Text;
                        cmd.Parameters.Add("@site", SqlDbType.NVarChar, 255).Value = txtSite.Text;
                        cmd.Parameters.Add("@fm", SqlDbType.NVarChar, 50).Value = txtFm.Text;
                        cmd.Parameters.Add("@nm", SqlDbType.NVarChar, 50).Value = txtNm.Text;
                        cmd.Parameters.Add("@ft", SqlDbType.NVarChar, 50).Value = txtFt.Text;
                        cmd.Parameters.Add("@position", SqlDbType.NVarChar, 50).Value = txtPosition.Text;
                        cmd.Parameters.Add("@phone1", SqlDbType.NVarChar, 20).Value = txtPhone1.Text;
                        cmd.Parameters.Add("@phone2", SqlDbType.NVarChar, 20).Value = txtPhone2.Text;
                        cmd.Parameters.Add("@fax", SqlDbType.NVarChar, 20).Value = txtFax.Text;
                        cmd.Parameters.Add("@description", SqlDbType.NVarChar, 512).Value = txtDescription.Text;
                        cmd.Parameters.Add("@is_agreement", SqlDbType.Bit).Value = true;
                        cmd.Parameters.Add("@reg_date", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.ExecuteNonQuery();

                        var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                        var roles = manager.GetRoles(usrId);
                        if (uTypeId == (int)AppUtils.uTypes.utype_company)
                        {
                           if (!roles.Contains("Company"))
                           {
                              manager.AddToRole(usrId, "Company");
                           }
                        }
                        else
                        {
                           manager.RemoveFromRole(usrId, "Company");
                        }

                        Response.Redirect("~/Cabinet.aspx", true);
                     }
                  }
               }
            }
         }
      }
   }
}