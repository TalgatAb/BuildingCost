<%@ Page Title="Ценовые предложения" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewPriceOffers.aspx.cs" Inherits="BuildingCost.ViewPriceOffers" %>
<%@ Register assembly="DevExpress.Web.Bootstrap.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.Bootstrap" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="hero-unit">
      <h4>Наименование материала по каталогу: <%: GetMaterials() %></h4>
   </div>
   <div>
      <dx:BootstrapGridView ID="PriceOffersGridView" runat="server" AutoGenerateColumns="False" DataSourceID="GetPriceOffers" KeyFieldName="usr_id">
         <SettingsBehavior AllowSelectByRowClick="True" />
         <Columns>
            <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:BootstrapGridViewCommandColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="usr_id" ReadOnly="True" Visible="False" VisibleIndex="1">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataDateColumn Caption="Дата" FieldName="ads_date" VisibleIndex="2">
            </dx:BootstrapGridViewDataDateColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Компания" FieldName="co_name" ReadOnly="True" VisibleIndex="3">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="mater_id" Visible="False" VisibleIndex="4">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Наименование материала" FieldName="mater_name" VisibleIndex="5">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Розн. цена" FieldName="retail_price" VisibleIndex="6">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Опт. цена" FieldName="trade_price" VisibleIndex="7">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="от" FieldName="from_unit" VisibleIndex="8">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="cur_code" Visible="False" VisibleIndex="10">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Вал." FieldName="cur_symbol" VisibleIndex="11">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Ед. изм." FieldName="unit_id" VisibleIndex="9">
            </dx:BootstrapGridViewDataTextColumn>
         </Columns>
         <SettingsSearchPanel Visible="True" />
      </dx:BootstrapGridView>

   </div>
   <div class="row">
      <div class="col-md-1 col-md-offset-11">
         <a href="javascript:history.go(-1)">&larr;Закрыть</a>
      </div>
   </div>
   <div>

      <asp:SqlDataSource ID="GetPriceOffers" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="GetPriceOffers" SelectCommandType="StoredProcedure">
         <SelectParameters>
            <asp:QueryStringParameter Name="mater_id" QueryStringField="mater_id" Type="Int32" />
         </SelectParameters>
      </asp:SqlDataSource>

   </div>
</asp:Content>
