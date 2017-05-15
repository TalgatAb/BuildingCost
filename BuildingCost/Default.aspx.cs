using DevExpress.Web.ASPxTreeList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuildingCost
{
   public partial class _Default : Page
   {
      protected void Page_Load(object sender, EventArgs e)
      {

      }

      protected void SearchBtn_Click(object sender, EventArgs e)
      {
         TreeListNodeIterator iterator = new TreeListNodeIterator(SectionTreeList.RootNode);
         while (iterator.Current != null)
         {
            CheckNode(iterator.Current);
            iterator.GetNext();
         }
      }

      private void CheckNode(TreeListNode node)
      {
         string s_text = SearchTxt.Text.ToLower();
         object node_value = node.GetValue("sec_name");
         if (node_value == null)
            return;
         if (node_value.ToString().ToLower().IndexOf(s_text) >= 0)
            node.MakeVisible();
      }

      protected string GetCellText(TreeListDataCellTemplateContainer container)
      {
         string searchText = SearchTxt.Text;
         string cell_text = container.Text;
         if (searchText.Length > cell_text.Length)
            return cell_text;

         if (searchText != "")
         {
            string cell_text_lower = cell_text.ToLower();
            string serchText_lower = searchText.ToLower();
            int start_pos = cell_text_lower.IndexOf(serchText_lower);
            int span_length = ("<span class='highlight'>").Length;
            if (start_pos >= 0)
            {
               cell_text = cell_text.Insert(start_pos, "<span class='highlight'>");
               cell_text = cell_text.Insert(start_pos + span_length + serchText_lower.Length, "</span>");
            }
         }
         return cell_text;
      }

   }
}