<%@ Page Title="Материалы" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Materials.aspx.cs" Inherits="BuildingCost.Materials" Async="true" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <script type="text/javascript">
      function OnMoreInfoClick(contentUrl) {
         clientPopupControl.SetContentUrl(contentUrl);
         clientPopupControl.Show();
      }
   </script>

   <div class="list-group">
      <a href="#" class="list-group=item active">
         <h5 class="list-group-item-heading">Раздел: </h5>
         <p class="list-group-item-text"><%: GetSectionName() %></p>
      </a>
   </div>
   <div>
      <dx:BootstrapGridView ID="MaterialGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MaterialSource" KeyFieldName="mater_id">
         <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
         <Columns>
            <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:BootstrapGridViewCommandColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="mater_id" ReadOnly="True" Visible="False" VisibleIndex="1">
               <EditFormSettings Visible="False" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="sec_id" Visible="False" VisibleIndex="2">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Код" FieldName="code" VisibleIndex="3">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Наименование" FieldName="mater_name" VisibleIndex="4">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Ед. изм." FieldName="unit_id" VisibleIndex="5">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="class_weight" VisibleIndex="6" Caption="Класс груза" Visible="False">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="gross_weight" VisibleIndex="7" Caption="Масса брутто, кг">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="release_price" VisibleIndex="8" Caption="Отпускная цена, тг">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="calculate_price" VisibleIndex="9" Caption="Сметная цена, тг">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="reg_id" VisibleIndex="10" Visible="False">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="avg_price" VisibleIndex="11" Caption="Ср. цена" Visible="False">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="tree" ReadOnly="True" VisibleIndex="12" Visible="False">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Ср. цена &amp;#9759" Name="avg_price_column" VisibleIndex="13">
               <DataItemTemplate>
                  <a id="avg_price_link" target="_self" href="ViewPriceOffers.aspx?mater_id=<%# Container.KeyValue %>"><%# Container.Grid.GetRowValues(Container.VisibleIndex, "avg_price") %> &#8376;</a>
               </DataItemTemplate>
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Ценов. предл. &amp;#9759" Name="price_offer_column" VisibleIndex="14">
               <DataItemTemplate>
                  <a id="clickElement" target="_self" href="PriceOffers.aspx?mater_id=<%# Container.KeyValue %>&usr_id=<%# Context.User.Identity.GetUserId() %>">Открыть <span class="badge"><%# GetPriceOffer(Container.KeyValue, Context.User.Identity.GetUserId()) %></span></a>
                  <%--                  <dx:ASPxHyperLink ID="hyperLink" runat="server" OnInit="hyperLink_Init">
                  </dx:ASPxHyperLink>--%>
               </DataItemTemplate>
            </dx:BootstrapGridViewDataTextColumn>
         </Columns>
         <SettingsSearchPanel Visible="True" />
      </dx:BootstrapGridView>
   </div>

   <div class="row">
      <div class="col-md-1 col-md-offset-11">
         <%--<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">Закрыть</button>--%>
         <a href="Default.aspx" target="_parent">&larr;Закрыть</a>
      </div>
   </div>

   <div>
      <dx:BootstrapPopupControl ID="popupControl" runat="server" AllowDragging="True" AllowResize="True" CloseAction="CloseButton" PopupAnimationType="None" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1100px">
      </dx:BootstrapPopupControl>
   </div>
   <div>

      <asp:SqlDataSource ID="MaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Materials] WHERE [mater_id] = @old_mater_id" InsertCommand="INSERT INTO [Materials] ([sec_id], [code], [mater_name], [unit_id], [class_weight], [gross_weight], [release_price], [calculate_price], [reg_id], [avg_price]) VALUES (@sec_id, @code, @mater_name, @unit_id, @class_weight, @gross_weight, @release_price, @calculate_price, @reg_id, @avg_price)" OldValuesParameterFormatString="old_{0}" SelectCommand="GetMaterials" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Materials] SET [sec_id] = @sec_id, [code] = @code, [mater_name] = @mater_name, [unit_id] = @unit_id, [class_weight] = @class_weight, [gross_weight] = @gross_weight, [release_price] = @release_price, [calculate_price] = @calculate_price, [reg_id] = @reg_id, [avg_price] = @avg_price WHERE [mater_id] = @old_mater_id">
         <DeleteParameters>
            <asp:Parameter Name="old_mater_id" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
            <asp:Parameter Name="sec_id" Type="Int32" />
            <asp:Parameter Name="code" Type="String" />
            <asp:Parameter Name="mater_name" Type="String" />
            <asp:Parameter Name="unit_id" Type="String" />
            <asp:Parameter Name="class_weight" Type="Int32" />
            <asp:Parameter Name="gross_weight" Type="Decimal" />
            <asp:Parameter Name="release_price" Type="Decimal" />
            <asp:Parameter Name="calculate_price" Type="Decimal" />
            <asp:Parameter Name="reg_id" Type="String" />
            <asp:Parameter Name="avg_price" Type="Decimal" />
         </InsertParameters>
         <SelectParameters>
            <asp:SessionParameter Name="sec_id" SessionField="sec_id" Type="Int32" />
            <asp:SessionParameter DefaultValue="01" Name="reg_id" SessionField="reg_id" Type="String" />
         </SelectParameters>
         <UpdateParameters>
            <asp:Parameter Name="sec_id" Type="Int32" />
            <asp:Parameter Name="code" Type="String" />
            <asp:Parameter Name="mater_name" Type="String" />
            <asp:Parameter Name="unit_id" Type="String" />
            <asp:Parameter Name="class_weight" Type="Int32" />
            <asp:Parameter Name="gross_weight" Type="Decimal" />
            <asp:Parameter Name="release_price" Type="Decimal" />
            <asp:Parameter Name="calculate_price" Type="Decimal" />
            <asp:Parameter Name="reg_id" Type="String" />
            <asp:Parameter Name="old_mater_id" Type="Int32" />
            <asp:Parameter Name="avg_price" Type="Decimal" />
         </UpdateParameters>
      </asp:SqlDataSource>

   </div>
</asp:Content>
