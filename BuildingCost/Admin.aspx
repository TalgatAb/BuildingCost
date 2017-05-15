<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="BuildingCost.Admin" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <script type="text/javascript">
      function AddRole() {
         MUserInRolesGridView.PerformCallback("add");
      }

      function DelRole() {
         MUserInRolesGridView.PerformCallback("del");
      }

      function OnGetSelectedFieldValues(values) {
         s = "";
         for (i = 0; i < values.length; i++) {
            s = s + values[i];
         }
         MUserInRolesGridView.PerformCallback(s);
      }
   </script>
   <dx:BootstrapPageControl ID="AdminPageControl" runat="server" ActiveTabIndex="2" Width="100%">
      <TabPages>
         <dx:BootstrapTabPage Name="UsersTab" Text="Пользователи">
            <ContentCollection>
               <dx:ContentControl runat="server">
                  <dx:BootstrapGridView ID="UsersGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AspNetUsers" KeyFieldName="Id" OnCustomErrorText="UsersGridView_CustomErrorText" OnRowDeleting="UsersGridView_RowDeleting" OnRowInserting="UsersGridView_RowInserting" OnRowUpdating="UsersGridView_RowUpdating" OnRowValidating="UsersGridView_RowValidating">
                     <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                     <SettingsCommandButton RenderMode="Image">
                        <NewButton IconCssClass="glyphicon glyphicon-plus" />
                        <UpdateButton ButtonType="Link" RenderMode="Link" />
                        <CancelButton ButtonType="Link" RenderMode="Link" />
                        <EditButton IconCssClass="glyphicon glyphicon-pencil" />
                        <DeleteButton IconCssClass="glyphicon glyphicon-minus" />
                     </SettingsCommandButton>
                     <SettingsText ConfirmDelete="Подтверждаете удаление?" />
                     <Columns>
                        <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" ShowSelectCheckbox="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="1" Visible="False">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="Email" VisibleIndex="3" Caption="Email">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataCheckColumn FieldName="EmailConfirmed" Visible="False" VisibleIndex="5">
                        </dx:BootstrapGridViewDataCheckColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="PasswordHash" Visible="False" VisibleIndex="6">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="SecurityStamp" Visible="False" VisibleIndex="7">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataTextColumn Caption="Номер телефона" FieldName="PhoneNumber" VisibleIndex="4">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataCheckColumn FieldName="PhoneNumberConfirmed" Visible="False" VisibleIndex="8">
                        </dx:BootstrapGridViewDataCheckColumn>
                        <dx:BootstrapGridViewDataCheckColumn FieldName="TwoFactorEnabled" Visible="False" VisibleIndex="9">
                        </dx:BootstrapGridViewDataCheckColumn>
                        <dx:BootstrapGridViewDataDateColumn FieldName="LockoutEndDateUtc" Visible="False" VisibleIndex="10">
                        </dx:BootstrapGridViewDataDateColumn>
                        <dx:BootstrapGridViewDataCheckColumn FieldName="LockoutEnabled" Visible="False" VisibleIndex="11">
                        </dx:BootstrapGridViewDataCheckColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="AccessFailedCount" Visible="False" VisibleIndex="12">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataTextColumn Caption="Имя пользователя" FieldName="UserName" VisibleIndex="2">
                        </dx:BootstrapGridViewDataTextColumn>
                     </Columns>
                     <SettingsSearchPanel Visible="True" />
                  </dx:BootstrapGridView>
               </dx:ContentControl>
            </ContentCollection>
         </dx:BootstrapTabPage>
         <dx:BootstrapTabPage Name="RolesTab" Text="Роли">
            <ContentCollection>
               <dx:ContentControl runat="server">
                  <dx:BootstrapGridView ID="RolesGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AspNetRoles" KeyFieldName="Id" OnCustomErrorText="RolesGridView_CustomErrorText" OnRowDeleting="RolesGridView_RowDeleting" OnRowInserting="RolesGridView_RowInserting" OnRowUpdating="RolesGridView_RowUpdating" OnRowValidating="RolesGridView_RowValidating">
                     <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                     <SettingsCommandButton RenderMode="Image">
                        <NewButton IconCssClass="glyphicon glyphicon-plus" />
                        <UpdateButton ButtonType="Link" RenderMode="Link" />
                        <CancelButton ButtonType="Link" RenderMode="Link" />
                        <EditButton IconCssClass="glyphicon glyphicon-pencil" />
                        <DeleteButton IconCssClass="glyphicon glyphicon-minus" />
                     </SettingsCommandButton>
                     <SettingsText ConfirmDelete="Подтверждаете удаление?" />
                     <Columns>
                        <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" ShowSelectCheckbox="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewDataTextColumn FieldName="Id" ReadOnly="True" Visible="False" VisibleIndex="1">
                        </dx:BootstrapGridViewDataTextColumn>
                        <dx:BootstrapGridViewDataTextColumn Caption="Роль" FieldName="Name" VisibleIndex="2">
                        </dx:BootstrapGridViewDataTextColumn>
                     </Columns>
                     <SettingsSearchPanel Visible="True" />
                  </dx:BootstrapGridView>
               </dx:ContentControl>
            </ContentCollection>
         </dx:BootstrapTabPage>
         <dx:BootstrapTabPage Name="ManageTab" Text="Управление ролями">
            <ContentCollection>
               <dx:ContentControl runat="server">
                  <dx:ASPxSplitter ID="ManageSplitter" runat="server">
                     <Panes>
                        <dx:SplitterPane AutoHeight="True" Name="UserPane" Size="31%">
                           <ContentCollection>
                              <dx:SplitterContentControl runat="server">
                                 <dx:BootstrapGridView ID="MUsersGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MAspNetUsers" KeyFieldName="Id" Width="100%" ClientInstanceName="MUsersGridView">
                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                    <Columns>
                                       <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
                                       </dx:BootstrapGridViewCommandColumn>
                                       <dx:BootstrapGridViewDataTextColumn FieldName="Id" ReadOnly="True" Visible="False" VisibleIndex="1">
                                       </dx:BootstrapGridViewDataTextColumn>
                                       <dx:BootstrapGridViewDataTextColumn Caption="Пользователи" FieldName="UserName" VisibleIndex="2">
                                       </dx:BootstrapGridViewDataTextColumn>
                                    </Columns>
                                    <ClientSideEvents SelectionChanged="function(s, e) {
	MUsersGridView.GetSelectedFieldValues('Id', OnGetSelectedFieldValues);
}" />
                                    <SettingsSearchPanel Visible="True" />
                                 </dx:BootstrapGridView>
                              </dx:SplitterContentControl>
                           </ContentCollection>
                        </dx:SplitterPane>
                        <dx:SplitterPane AutoHeight="True" Name="UserInRolePane" Size="31%">
                           <ContentCollection>
                              <dx:SplitterContentControl runat="server">
                                 <dx:BootstrapGridView ID="MUserInRolesGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MAspNetUserRoles" KeyFieldName="UserId; RoleId" OnCustomCallback="MUserInRolesGridView_CustomCallback" ClientInstanceName="MUserInRolesGridView">
                                    <SettingsBehavior AllowSelectByRowClick="True" />
                                    <Columns>
                                       <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
                                       </dx:BootstrapGridViewCommandColumn>
                                       <dx:BootstrapGridViewDataTextColumn FieldName="UserId" ReadOnly="True" Visible="False" VisibleIndex="1">
                                       </dx:BootstrapGridViewDataTextColumn>
                                       <dx:BootstrapGridViewDataComboBoxColumn Caption="Привязанные роли" FieldName="RoleId" ReadOnly="True" VisibleIndex="2">
                                          <PropertiesComboBox DataSourceID="AspNetRoles" TextField="Name" ValueField="Id">
                                          </PropertiesComboBox>
                                       </dx:BootstrapGridViewDataComboBoxColumn>
                                    </Columns>
                                 </dx:BootstrapGridView>
                              </dx:SplitterContentControl>
                           </ContentCollection>
                        </dx:SplitterPane>
                        <dx:SplitterPane Name="CommonPane" Size="7%">
                           <ContentCollection>
                              <dx:SplitterContentControl runat="server">
                                 <p>
                                    <button type="button" class="btn btn-link" onclick="javascript:AddRole()">Доб.</button>
                                 </p>
                                 <p>
                                    <button type="button" class="btn btn-link" onclick="javascript:DelRole()">Удал.</button>
                                 </p>
                              </dx:SplitterContentControl>
                           </ContentCollection>
                        </dx:SplitterPane>
                        <dx:SplitterPane AutoHeight="True" Name="RolesPane" Size="31%">
                           <ContentCollection>
                              <dx:SplitterContentControl runat="server">
                                 <dx:BootstrapGridView ID="MRolesGridView" runat="server" AutoGenerateColumns="False" DataSourceID="MAspNetRoles" KeyFieldName="Id" Width="100%" ClientInstanceName="MRolesGridView">
                                    <SettingsBehavior AllowSelectByRowClick="True" ConfirmDelete="True" />
                                    <Columns>
                                       <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
                                       </dx:BootstrapGridViewCommandColumn>
                                       <dx:BootstrapGridViewDataTextColumn FieldName="Id" ReadOnly="True" Visible="False" VisibleIndex="1">
                                       </dx:BootstrapGridViewDataTextColumn>
                                       <dx:BootstrapGridViewDataTextColumn Caption="Роли" FieldName="Name" VisibleIndex="2">
                                       </dx:BootstrapGridViewDataTextColumn>
                                    </Columns>
                                 </dx:BootstrapGridView>
                              </dx:SplitterContentControl>
                           </ContentCollection>
                        </dx:SplitterPane>
                     </Panes>
                  </dx:ASPxSplitter>
               </dx:ContentControl>
            </ContentCollection>
         </dx:BootstrapTabPage>
         <dx:BootstrapTabPage Name="LogsTab" Text="Журнал ошибок">
            <ContentCollection>
               <dx:ContentControl runat="server">
               </dx:ContentControl>
            </ContentCollection>
         </dx:BootstrapTabPage>
      </TabPages>
   </dx:BootstrapPageControl>
   <div>
      <dx:ASPxListBox ID="tmpList" runat="server" Visible="false"></dx:ASPxListBox>
   </div>
   <div>

      <asp:SqlDataSource ID="AspNetRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetRoles] WHERE [Id] = @old_Id" InsertCommand="INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (@Id, @Name)" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [AspNetRoles]" UpdateCommand="UPDATE [AspNetRoles] SET [Name] = @Name WHERE [Id] = @old_Id">
         <DeleteParameters>
            <asp:Parameter Name="old_Id" Type="String" />
         </DeleteParameters>
         <InsertParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
         </InsertParameters>
         <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="old_Id" Type="String" />
         </UpdateParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="AspNetUsers" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetUsers] WHERE [Id] = @old_Id" InsertCommand="INSERT INTO [AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (@Id, @Email, @EmailConfirmed, @PasswordHash, @SecurityStamp, @PhoneNumber, @PhoneNumberConfirmed, @TwoFactorEnabled, @LockoutEndDateUtc, @LockoutEnabled, @AccessFailedCount, @UserName)" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [AspNetUsers]" UpdateCommand="UPDATE [AspNetUsers] SET [Email] = @Email, [EmailConfirmed] = @EmailConfirmed, [PasswordHash] = @PasswordHash, [SecurityStamp] = @SecurityStamp, [PhoneNumber] = @PhoneNumber, [PhoneNumberConfirmed] = @PhoneNumberConfirmed, [TwoFactorEnabled] = @TwoFactorEnabled, [LockoutEndDateUtc] = @LockoutEndDateUtc, [LockoutEnabled] = @LockoutEnabled, [AccessFailedCount] = @AccessFailedCount, [UserName] = @UserName WHERE [Id] = @old_Id">
         <DeleteParameters>
            <asp:Parameter Name="old_Id" Type="String" />
         </DeleteParameters>
         <InsertParameters>
            <asp:Parameter Name="Id" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="EmailConfirmed" Type="Boolean" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="SecurityStamp" Type="String" />
            <asp:Parameter Name="PhoneNumber" Type="String" />
            <asp:Parameter Name="PhoneNumberConfirmed" Type="Boolean" />
            <asp:Parameter Name="TwoFactorEnabled" Type="Boolean" />
            <asp:Parameter Name="LockoutEndDateUtc" Type="DateTime" />
            <asp:Parameter Name="LockoutEnabled" Type="Boolean" />
            <asp:Parameter Name="AccessFailedCount" Type="Int32" />
            <asp:Parameter Name="UserName" Type="String" />
         </InsertParameters>
         <UpdateParameters>
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="EmailConfirmed" Type="Boolean" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="SecurityStamp" Type="String" />
            <asp:Parameter Name="PhoneNumber" Type="String" />
            <asp:Parameter Name="PhoneNumberConfirmed" Type="Boolean" />
            <asp:Parameter Name="TwoFactorEnabled" Type="Boolean" />
            <asp:Parameter Name="LockoutEndDateUtc" Type="DateTime" />
            <asp:Parameter Name="LockoutEnabled" Type="Boolean" />
            <asp:Parameter Name="AccessFailedCount" Type="Int32" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="old_Id" Type="String" />
         </UpdateParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="MAspNetUsers" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id], [UserName] FROM [AspNetUsers]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="MAspNetUserRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [AspNetUserRoles] WHERE ([UserId] = @UserId)">
         <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" Type="String" />
         </SelectParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="MAspNetRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [AspNetRoles]"></asp:SqlDataSource>
   </div>
</asp:Content>
