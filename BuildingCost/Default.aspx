<%@ Page Title="Сборники текущих цен" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BuildingCost._Default" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <style type="text/css">
      .highlight {
         background-color: #ffe266;
         color:black;
      }
   </style>

   <div class="panel panel-default">
      <div class="panel-body">
         <div class="row">
            <div class="form-group">
               <div class="col-md-6">
                  <asp:TextBox runat="server" ID="SearchTxt" CssClass="form-control" TextMode="SingleLine" placeholder="Введите текст для поиска" />
               </div>
               <div class="col-md-2">
                  <dx:ASPxButton ID="SearchBtn" runat="server" CssClass="btn btn-default" Text="Поиск" OnClick="SearchBtn_Click" AutoPostBack="False" />
               </div>
            </div>
         </div>
      </div>
   </div>

   <dx:ASPxTreeList ID="SectionTreeList" runat="server" AutoGenerateColumns="False" DataSourceID="SectionTrees" KeyFieldName="sec_id" ParentFieldName="par_id" Width="100%">
      <Columns>
         <dx:TreeListTextColumn Caption="Код" FieldName="code" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1" Width="80px">
         </dx:TreeListTextColumn>
         <dx:TreeListTextColumn Caption="Разделы" FieldName="sec_name" VisibleIndex="0">
            <CellStyle Wrap="True">
            </CellStyle>
            <DataCellTemplate>
               <%# GetCellText(Container) %>
            </DataCellTemplate>
         </dx:TreeListTextColumn>
         <dx:TreeListTextColumn Caption="ИД" FieldName="par_id" Visible="False" VisibleIndex="2" Width="60px">
         </dx:TreeListTextColumn>
         <dx:TreeListTextColumn Caption="Материалы" Name="OpenMaterialLink" VisibleIndex="3" Width="80px">
            <DataCellTemplate>
               <a id="clickElement" target="_self" href="Materials.aspx?sec_id=<%# Container.NodeKey %>">Открыть</a>
            </DataCellTemplate>
         </dx:TreeListTextColumn>
      </Columns>
      <SettingsBehavior AllowFocusedNode="True" AutoExpandAllNodes="True" />
      <Styles>
         <AlternatingNode Enabled="False">
         </AlternatingNode>
      </Styles>
   </dx:ASPxTreeList>
   <div>

      <asp:SqlDataSource ID="SectionTrees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [SectionTrees]"></asp:SqlDataSource>

   </div>
</asp:Content>
