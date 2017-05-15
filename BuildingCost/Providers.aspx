<%@ Page Title="Поставщики" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Providers.aspx.cs" Inherits="BuildingCost.Providers" %>
<%@ Register assembly="DevExpress.Web.Bootstrap.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.Bootstrap" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <div>

      <dx:BootstrapGridView ID="ProfilesGridView" runat="server" AutoGenerateColumns="False" DataSourceID="UserProfiles" KeyFieldName="usr_id">
         <Settings ShowGroupPanel="True" />
         <SettingsBehavior AllowSelectByRowClick="True" />
         <Columns>
            <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:BootstrapGridViewCommandColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="usr_id" ReadOnly="True" Visible="False" VisibleIndex="1">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="utype_id" Visible="False" VisibleIndex="2">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Наименование" FieldName="co_name" VisibleIndex="4">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Адрес" FieldName="legal_address" VisibleIndex="10">
               <EditFormSettings Caption="Юрид. адрес" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Факт. адрес" FieldName="actual_address" Visible="False" VisibleIndex="11">
               <EditFormSettings Visible="True" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Сайт" FieldName="site" VisibleIndex="12">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="fm" Visible="False" VisibleIndex="7">
               <EditFormSettings Visible="True" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="nm" Visible="False" VisibleIndex="8">
               <EditFormSettings Visible="True" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn FieldName="ft" Visible="False" VisibleIndex="9">
               <EditFormSettings Visible="True" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Должность" FieldName="position" VisibleIndex="6">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Телефон" FieldName="phone1" VisibleIndex="13">
               <EditFormSettings Caption="Телефон 1" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Телефон 2" FieldName="phone2" Visible="False" VisibleIndex="14">
               <EditFormSettings Caption="Телефон 2" Visible="True" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Факс" FieldName="fax" VisibleIndex="15">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Описание" FieldName="description" VisibleIndex="18">
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataCheckColumn FieldName="is_agreement" Visible="False" VisibleIndex="16">
            </dx:BootstrapGridViewDataCheckColumn>
            <dx:BootstrapGridViewDataDateColumn Caption="Дата регис." FieldName="reg_date" VisibleIndex="17">
            </dx:BootstrapGridViewDataDateColumn>
            <dx:BootstrapGridViewDataTextColumn Caption="Контактное лицо" FieldName="fio" VisibleIndex="5">
               <EditFormSettings Visible="False" />
            </dx:BootstrapGridViewDataTextColumn>
            <dx:BootstrapGridViewDataComboBoxColumn Caption="Тип" FieldName="ctype_id" VisibleIndex="3">
               <PropertiesComboBox DataSourceID="TypeOfCompanies" TextField="cabbr" ValueField="ctype_id">
               </PropertiesComboBox>
            </dx:BootstrapGridViewDataComboBoxColumn>
            <dx:BootstrapGridViewDataComboBoxColumn Caption="Регион" FieldName="reg_id" VisibleIndex="19">
               <PropertiesComboBox DataSourceID="Regions" TextField="reg_name" ValueField="reg_id">
               </PropertiesComboBox>
            </dx:BootstrapGridViewDataComboBoxColumn>
         </Columns>
         <SettingsSearchPanel Visible="True" />
      </dx:BootstrapGridView>

   </div>
   <div>

      <asp:SqlDataSource ID="TypeOfCompanies" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [TypeOfCompanies]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="UserProfiles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [UserProfiles] WHERE [usr_id] = @old_usr_id" InsertCommand="INSERT INTO [UserProfiles] ([usr_id], [utype_id], [ctype_id], [reg_id], [co_name], [legal_address], [actual_address], [site], [fm], [nm], [ft], [position], [phone1], [phone2], [fax], [description], [logotype], [photo], [is_agreement], [reg_date]) VALUES (@usr_id, @utype_id, @ctype_id, @reg_id, @co_name, @legal_address, @actual_address, @site, @fm, @nm, @ft, @position, @phone1, @phone2, @fax, @description, @logotype, @photo, @is_agreement, @reg_date)" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT *, CONCAT(fm, N' ', nm, N' ', ft ) fio FROM [UserProfiles] WHERE ([utype_id] = @utype_id)" UpdateCommand="UPDATE [UserProfiles] SET [utype_id] = @utype_id, [ctype_id] = @ctype_id, [reg_id] = @reg_id, [co_name] = @co_name, [legal_address] = @legal_address, [actual_address] = @actual_address, [site] = @site, [fm] = @fm, [nm] = @nm, [ft] = @ft, [position] = @position, [phone1] = @phone1, [phone2] = @phone2, [fax] = @fax, [description] = @description, [logotype] = @logotype, [photo] = @photo, [is_agreement] = @is_agreement, [reg_date] = @reg_date WHERE [usr_id] = @old_usr_id">
         <DeleteParameters>
            <asp:Parameter Name="old_usr_id" Type="String" />
         </DeleteParameters>
         <InsertParameters>
            <asp:Parameter Name="usr_id" Type="String" />
            <asp:Parameter Name="utype_id" Type="Int32" />
            <asp:Parameter Name="ctype_id" Type="Int32" />
            <asp:Parameter Name="reg_id" Type="String" />
            <asp:Parameter Name="co_name" Type="String" />
            <asp:Parameter Name="legal_address" Type="String" />
            <asp:Parameter Name="actual_address" Type="String" />
            <asp:Parameter Name="site" Type="String" />
            <asp:Parameter Name="fm" Type="String" />
            <asp:Parameter Name="nm" Type="String" />
            <asp:Parameter Name="ft" Type="String" />
            <asp:Parameter Name="position" Type="String" />
            <asp:Parameter Name="phone1" Type="String" />
            <asp:Parameter Name="phone2" Type="String" />
            <asp:Parameter Name="fax" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="logotype" Type="Object" />
            <asp:Parameter Name="photo" Type="Object" />
            <asp:Parameter Name="is_agreement" Type="Boolean" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
         </InsertParameters>
         <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="utype_id" Type="Int32" />
         </SelectParameters>
         <UpdateParameters>
            <asp:Parameter Name="utype_id" Type="Int32" />
            <asp:Parameter Name="ctype_id" Type="Int32" />
            <asp:Parameter Name="reg_id" Type="String" />
            <asp:Parameter Name="co_name" Type="String" />
            <asp:Parameter Name="legal_address" Type="String" />
            <asp:Parameter Name="actual_address" Type="String" />
            <asp:Parameter Name="site" Type="String" />
            <asp:Parameter Name="fm" Type="String" />
            <asp:Parameter Name="nm" Type="String" />
            <asp:Parameter Name="ft" Type="String" />
            <asp:Parameter Name="position" Type="String" />
            <asp:Parameter Name="phone1" Type="String" />
            <asp:Parameter Name="phone2" Type="String" />
            <asp:Parameter Name="fax" Type="String" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="logotype" Type="Object" />
            <asp:Parameter Name="photo" Type="Object" />
            <asp:Parameter Name="is_agreement" Type="Boolean" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
            <asp:Parameter Name="old_usr_id" Type="String" />
         </UpdateParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="Regions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [Regions]"></asp:SqlDataSource>

   </div>
</asp:Content>
