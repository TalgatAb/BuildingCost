<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PriceOffers.aspx.cs" Inherits="BuildingCost.PriceOffers" %>

<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="hero-unit">
      <h4><%: GetCompanyName() %></h4>
   </div>
   <div>
      <dx:ASPxGridView ID="AdvertGridView" runat="server" AutoGenerateColumns="False" ClientInstanceName="AdvertGridView" DataSourceID="Adverts" KeyFieldName="ads_id" OnInitNewRow="AdvertGridView_InitNewRow" OnRowInserting="AdvertGridView_RowInserting" Width="100%">
         <ClientSideEvents FocusedRowChanged="function(s, e) {
	PhotoGridView.PerformCallback(s.GetFocusedRowIndex());
}" />
         <SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True" />
         <SettingsResizing ColumnResizeMode="Control" />
         <SettingsCommandButton RenderMode="Image">
            <NewButton>
               <Image IconID="actions_add_16x16">
               </Image>
            </NewButton>
            <UpdateButton ButtonType="Link" RenderMode="Link">
            </UpdateButton>
            <CancelButton ButtonType="Link" RenderMode="Link">
            </CancelButton>
            <EditButton>
               <Image IconID="edit_edit_16x16">
               </Image>
            </EditButton>
            <DeleteButton>
               <Image IconID="edit_delete_16x16">
               </Image>
            </DeleteButton>
         </SettingsCommandButton>
         <SettingsSearchPanel Visible="True" />
         <SettingsText ConfirmDelete="Подтверждаете удаление?" />
         <EditFormLayoutProperties ColCount="3">
            <Items>
               <dx:GridViewColumnLayoutItem ColSpan="3" ColumnName="mater_name">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColumnName="retail_price">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColumnName="trade_price">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColumnName="from_unit">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColumnName="unit_id">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColSpan="2" ColumnName="cur_code">
               </dx:GridViewColumnLayoutItem>
               <dx:GridViewColumnLayoutItem ColSpan="3" ColumnName="mater_desc">
               </dx:GridViewColumnLayoutItem>
               <dx:EditModeCommandLayoutItem ColSpan="3" HorizontalAlign="Right">
               </dx:EditModeCommandLayoutItem>
            </Items>
         </EditFormLayoutProperties>
         <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="80px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ads_id" ReadOnly="True" Visible="False" VisibleIndex="1">
               <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Дата" FieldName="ads_date" VisibleIndex="2" Width="80px">
               <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="usr_id" Visible="False" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="mater_id" Visible="False" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Наименование материала" FieldName="mater_name" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Розн. цена" FieldName="retail_price" VisibleIndex="6" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="от" FieldName="from_unit" VisibleIndex="8" Width="80px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Опт. цена" FieldName="trade_price" VisibleIndex="7" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ед. изм." FieldName="unit_id" VisibleIndex="9" Width="80px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="вал" FieldName="cur_code" ReadOnly="True" VisibleIndex="10" Width="60px">
               <PropertiesComboBox DataSourceID="Currencies" TextField="cur_symbol" ValueField="cur_code">
                  <Columns>
                     <dx:ListBoxColumn Caption="Код" FieldName="cur_code" Visible="False">
                     </dx:ListBoxColumn>
                     <dx:ListBoxColumn Caption="вал" FieldName="cur_symbol">
                     </dx:ListBoxColumn>
                  </Columns>
               </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataMemoColumn Caption="Описание" FieldName="mater_desc" Visible="False" VisibleIndex="11">
               <EditFormSettings Visible="True" />
            </dx:GridViewDataMemoColumn>
         </Columns>
      </dx:ASPxGridView>
   </div>
   <div>
      <dx:ASPxSplitter ID="PhotoSplitter" runat="server" ClientInstanceName="PhotoSplitter">
         <Panes>
            <dx:SplitterPane Size="50%">
               <ContentCollection>
                  <dx:SplitterContentControl runat="server">
                     <dx:ASPxGridView ID="PhotoGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AdvertPhotos" KeyFieldName="ads_photo_id" Width="100%" ClientInstanceName="PhotoGridView" OnCustomCallback="PhotoGridView_CustomCallback" OnRowInserting="PhotoGridView_RowInserting">
                        <ClientSideEvents FocusedRowChanged="function(s, e) {
	PhotoCallbackPanel.PerformCallback(s.GetFocusedRowIndex());
}" />
                        <SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True" />
                        <SettingsCommandButton RenderMode="Image">
                           <NewButton>
                              <Image IconID="actions_add_16x16">
                              </Image>
                           </NewButton>
                           <CancelButton ButtonType="Link" RenderMode="Link">
                           </CancelButton>
                           <EditButton>
                              <Image IconID="edit_edit_16x16">
                              </Image>
                           </EditButton>
                           <DeleteButton>
                              <Image IconID="edit_delete_16x16">
                              </Image>
                           </DeleteButton>
                        </SettingsCommandButton>
                        <SettingsText ConfirmDelete="Подтверждаете удаление?" />
                        <Columns>
                           <dx:GridViewCommandColumn ShowDeleteButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px">
                           </dx:GridViewCommandColumn>
                           <dx:GridViewDataTextColumn FieldName="ads_photo_id" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                              <EditFormSettings Visible="False" />
                           </dx:GridViewDataTextColumn>
                           <dx:GridViewDataTextColumn FieldName="ads_id" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                           </dx:GridViewDataTextColumn>
                           <dx:GridViewDataTextColumn Caption="Фото" FieldName="file_name" ShowInCustomizationForm="True" VisibleIndex="3">
                              <EditItemTemplate>
                                 <dx:ASPxUploadControl ID="PhotoUploadControl" runat="server" NullText="Выберите фото" OnFileUploadComplete="PhotoUploadControl_FileUploadComplete" ShowProgressPanel="True" ShowUploadButton="True" UploadMode="Advanced" Width="100%">
                                    <RemoveButton Text="Удалить">
                                    </RemoveButton>
                                    <UploadButton Text="Загрузить">
                                    </UploadButton>
                                    <CancelButton Text="Отмена">
                                    </CancelButton>
                                    <AdvancedModeSettings EnableFileList="True">
                                    </AdvancedModeSettings>
                                    <ValidationSettings MaxFileSize="112640" AllowedFileExtensions=".jpg,.jpeg,.gif,.png">
                                    </ValidationSettings>
                                 </dx:ASPxUploadControl>
                              </EditItemTemplate>
                           </dx:GridViewDataTextColumn>
                        </Columns>
                     </dx:ASPxGridView>
                  </dx:SplitterContentControl>
               </ContentCollection>
            </dx:SplitterPane>
            <dx:SplitterPane Size="50%">
               <ContentCollection>
                  <dx:SplitterContentControl runat="server">
                     <dx:ASPxCallbackPanel ID="PhotoCallbackPanel" runat="server" ClientInstanceName="PhotoCallbackPanel" OnCallback="PhotoCallbackPanel_Callback">
                        <PanelCollection>
                           <dx:PanelContent>
                              <div class="row">
                                 <div class="col-md-4">
                                    <div class="thumbnail">
                                       <asp:Repeater ID="PhotoRepeater" runat="server">
                                          <ItemTemplate>
                                             <asp:Image ID="PhotoImage" runat="server" Width="300px" Height="300px" ImageUrl="<%# Bind('url') %>" />
                                          </ItemTemplate>
                                       </asp:Repeater>
                                    </div>
                                 </div>
                              </div>
                           </dx:PanelContent>
                        </PanelCollection>
                     </dx:ASPxCallbackPanel>
                  </dx:SplitterContentControl>
               </ContentCollection>
            </dx:SplitterPane>
         </Panes>
      </dx:ASPxSplitter>
   </div>

   <div class="container">
      <div class="row justify-content-md-center">
         <div class="col-md-1 col-md-offset-11">
            <a href="javascript:history.go(-1)">&larr;Закрыть</a>
         </div>
      </div>
   </div>
   <div>

      <asp:SqlDataSource ID="Adverts" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [Adverts] WHERE (([mater_id] = @mater_id) AND ([usr_id] = @usr_id))">
         <SelectParameters>
            <asp:QueryStringParameter Name="mater_id" QueryStringField="mater_id" Type="Int32" />
            <asp:QueryStringParameter Name="usr_id" QueryStringField="usr_id" Type="String" />
         </SelectParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="Currencies" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT * FROM [Currencies]"></asp:SqlDataSource>

      <asp:SqlDataSource ID="AdvertPhotos" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" OldValuesParameterFormatString="old_{0}" SelectCommand="SELECT [ads_photo_id], [ads_id], [file_name] FROM [AdvertPhotos] WHERE ([ads_id] = @ads_id)" DeleteCommand="DELETE FROM [AdvertPhotos] WHERE [ads_photo_id] = @old_ads_photo_id" InsertCommand="INSERT INTO [AdvertPhotos] ([ads_id], [file_name]) VALUES (@ads_id, @file_name)" UpdateCommand="UPDATE [AdvertPhotos] SET [ads_id] = @ads_id, [file_name] = @file_name WHERE [ads_photo_id] = @old_ads_photo_id">
         <DeleteParameters>
            <asp:Parameter Name="old_ads_photo_id" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
            <asp:Parameter Name="ads_id" Type="Int32" />
            <asp:Parameter Name="file_name" Type="String" />
         </InsertParameters>
         <SelectParameters>
            <asp:SessionParameter Name="ads_id" SessionField="ads_id" Type="Int32" />
         </SelectParameters>
         <UpdateParameters>
            <asp:Parameter Name="ads_id" Type="Int32" />
            <asp:Parameter Name="file_name" Type="String" />
            <asp:Parameter Name="old_ads_photo_id" Type="Int32" />
         </UpdateParameters>
      </asp:SqlDataSource>

   </div>
</asp:Content>
