using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading.Tasks;
using DevExpress.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace BuildingCost
{
   public partial class Materials : System.Web.UI.Page
   {
      DatabaseHelper helper = new DatabaseHelper();
      static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

      static string userId { get; set; } = string.Empty;
      static string userName { get; set; } = "Unlnown";
      static bool bVisible = false;
      static int sec_id = 0;
      protected void Page_Load(object sender, EventArgs e)
      {
         if (!IsPostBack)
         {
            if (int.TryParse(Request.QueryString["sec_id"].ToString(), out int result))
            {
               sec_id = result;
            }
            Session["sec_id"] = sec_id;

            if (Context.User.Identity.IsAuthenticated)
            {
               userId = Context.User.Identity.GetUserId();
               userName = Context.User.Identity.GetUserName();
               var um = HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
               bVisible = um.IsInRole(userId, "Admin") || um.IsInRole(userId, "Company");
            }
            else
            {
               userId = string.Empty;
               userName = "Unknown";
               bVisible = false;
            }

            MaterialGridView.Columns["price_offer_column"].Visible = bVisible;

         }
      }

      public int GetPriceOffer(object mater_id, string usr_id)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT dbo.GetPriceOffer(@mater_id, @usr_id) AS cnt";
               cmd.Parameters.Add("@mater_id", SqlDbType.Int).Value = mater_id as int? ?? 0;
               cmd.Parameters.Add("usr_id", SqlDbType.NVarChar, 128).Value = usr_id;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }

      public string GetSectionName()
      {
         string result = string.Empty;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.OpenAsync();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT sec_name FROM dbo.SectionTrees WHERE sec_id = @sec_id";
               cmd.Parameters.Add("@sec_id", SqlDbType.Int).Value = sec_id;
               result = cmd.ExecuteScalar().ToString();
            }
         }
         return result;
      }

      protected void hyperLink_Init(object sender, EventArgs e)
      {
         ASPxHyperLink link = (ASPxHyperLink)sender;
         link.EncodeHtml = false;

         GridViewDataItemTemplateContainer templateContainer = (GridViewDataItemTemplateContainer)link.NamingContainer;

         int rowVisibleIndex = templateContainer.VisibleIndex;
         int mater_id = templateContainer.Grid.GetRowValues(rowVisibleIndex, "mater_id") as int? ?? 0;
         string contentUrl = string.Format("{0}?mater_id={1}&usr_id={2}", "PriceOffers.aspx", mater_id, userId);

         link.NavigateUrl = "javascript:void(0);";
         link.Text = string.Format("Открыть <span class=\"badge\">{0}</span>", helper.GetPriceOffer(mater_id, userId));
         link.ClientSideEvents.Click = string.Format("function(s, e) {{ OnMoreInfoClick('{0}'); }}", contentUrl);
      }

      protected void hyperLinkAvg_Init(object sender, EventArgs e)
      {
         ASPxHyperLink link = (ASPxHyperLink)sender;

         GridViewDataItemTemplateContainer templateContainer = (GridViewDataItemTemplateContainer)link.NamingContainer;

         int rowVisibleIndex = templateContainer.VisibleIndex;
         int mater_id = templateContainer.Grid.GetRowValues(rowVisibleIndex, "mater_id") as int? ?? 0;
         decimal avg_price = templateContainer.Grid.GetRowValues(rowVisibleIndex, "avg_price") as decimal? ?? 0;
         string contentUrl = string.Format("{0}?mater_id={1}", "ViewPriceOffers.aspx", mater_id);

         link.NavigateUrl = "javascript:void(0);";
         link.Text = string.Format("{0}", avg_price);
         link.ClientSideEvents.Click = string.Format("function(s, e) {{ OnMoreInfoClick('{0}'); }}", contentUrl);
      }

   }
}