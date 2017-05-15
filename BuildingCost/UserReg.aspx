<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserReg.aspx.cs" Inherits="BuildingCost.UserReg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <asp:ValidationSummary runat="server" CssClass="text-danger" />
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#company">Компания</a></li>
        <%--<li><a data-toggle="tab" href="#person">Частное лицо</a></li>--%>
    </ul>
    <div class="tab-content">
        <div id="company" class="tab-pane fade in active">
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="CompanyTypeList" CssClass="col-md-2 control-label">Название компании</asp:Label>
                    <div class="col-md-2">
                        <asp:DropDownList ID="CompanyTypeList" runat="server" DataSourceID="TypeOfCompanies" DataTextField="cabbr" DataValueField="ctype_id" CssClass="form-control"></asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="CompanyTypeList" CssClass="text-danger" ErrorMessage="Не выбрана форма собственности"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-8">
                        <asp:TextBox runat="server" ID="txtCompanyName" CssClass="form-control" TextMode="SingleLine" placeholder="введите название" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCompanyName"
                            CssClass="text-danger" ErrorMessage="Не указано название компании" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtLegalAddress" CssClass="col-md-3 control-label">Юридический адрес</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtLegalAddress" CssClass="form-control" TextMode="SingleLine" placeholder="Город, улица, дом, офис" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLegalAddress"
                            CssClass="text-danger" ErrorMessage="Не полный адрес" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtActualAddress" CssClass="col-md-3 control-label">Фактический адрес</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtActualAddress" CssClass="form-control" TextMode="SingleLine" placeholder="Город, улица, дом, офис" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtActualAddress"
                            CssClass="text-danger" ErrorMessage="Не полный адрес" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtSite" CssClass="col-md-3 control-label">Веб сайт</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtSite" CssClass="form-control" TextMode="SingleLine" placeholder="site.kz" />
                        <small class="text-muted">&nbsp</small>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Контактное лицо</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtFm" CssClass="col-md-3 control-label">Фамилия</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtFm" CssClass="form-control" TextMode="SingleLine" placeholder="Фамилия" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFm"
                                    CssClass="text-danger" ErrorMessage="Не заполнена Фамилия" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtNm" CssClass="col-md-3 control-label">Имя</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtNm" CssClass="form-control" TextMode="SingleLine" placeholder="Имя" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNm"
                                    CssClass="text-danger" ErrorMessage="Не заполнено Имя" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtFt" CssClass="col-md-3 control-label">Отчество</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtFt" CssClass="form-control" TextMode="SingleLine" placeholder="Отчество" />
                                <small class="text-muted">&nbsp</small>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtPosition" CssClass="col-md-3 control-label">Должность</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtPosition" CssClass="form-control" TextMode="SingleLine" placeholder="Укажите должность" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPosition"
                                    CssClass="text-danger" ErrorMessage="Не заполнено поле должность" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtPhone1" CssClass="col-md-3 control-label">Телефон 1</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtPhone1" CssClass="form-control" TextMode="Phone" placeholder="+7 (XXX) XXX XXXX" />
                                <small class="text-muted">Пример ввода телефона: +7 (XXX) XXX XXXX</small>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="text-danger" ErrorMessage="Неверный номер телефона" ControlToValidate="txtPhone1" ValidationExpression="\+7 \(?\d{3}\)?-? *\d{3}-? *-?\d{4}"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtPhone2" CssClass="col-md-3 control-label">Телефон 2</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtPhone2" CssClass="form-control" TextMode="Phone" placeholder="+7 (XXX) XXX XXXX" />
                                <small class="text-muted">Пример ввода телефона: +7 (XXX) XXX XXXX</small>
                                <asp:RegularExpressionValidator ID="Phone2Valid" runat="server" CssClass="text-danger" ErrorMessage="Неверный номер телефона" ControlToValidate="txtPhone2" ValidationExpression="\+7 \(?\d{3}\)?-? *\d{3}-? *-?\d{4}"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="txtFax" CssClass="col-md-3 control-label">Факс</asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtFax" CssClass="form-control" TextMode="Phone" placeholder="+7 (XXX) XXX XXXX" />
                                <small class="text-muted">Пример ввода телефона: +7 (XXX) XXX XXXX</small>
                                <asp:RegularExpressionValidator ID="FaxValidator" runat="server" CssClass="text-danger" ErrorMessage="Неверный номер телефона" ControlToValidate="txtFax" ValidationExpression="\+7 \(?\d{3}\)?-? *\d{3}-? *-?\d{4}"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtDescription" CssClass="col-md-3 control-label">Деятельность компании</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control" TextMode="MultiLine" placeholder="введите текст" />
                        <small class="text-muted">Описание должно быть не менее 50 символов</small>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription"
                            CssClass="text-danger" ErrorMessage="Описание должно быть не менее 50 символов" />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="RegionsList" CssClass="col-md-3 control-label">Регион</asp:Label>
                    <div class="col-md-9">
                        <asp:DropDownList ID="RegionsList" runat="server" DataSourceID="Regions" DataTextField="reg_name" DataValueField="reg_id" CssClass="form-control"></asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="RegionsList" CssClass="text-danger" ErrorMessage="Необходимо выбрать регион"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-4 col-md-10">
                    <asp:Button ID="PostBtn" runat="server" Text="Сохранить" CssClass="btn btn-default" OnClick="PostBtn_Click" />
                </div>
            </div>

        </div>

        <%--        <div id="person" class="tab-pane fade">
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtFm2" CssClass="col-md-3 control-label">Фамилия</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtFm2" CssClass="form-control" TextMode="SingleLine" placeholder="Фамилия" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFm2"
                            CssClass="text-danger" ErrorMessage="Не заполнена Фамилия" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtNm2" CssClass="col-md-3 control-label">Имя</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtNm2" CssClass="form-control" TextMode="SingleLine" placeholder="Имя" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNm2"
                            CssClass="text-danger" ErrorMessage="Не заполнено Имя" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtFt2" CssClass="col-md-3 control-label">Отчество</asp:Label>
                    <div class="col-md-9">
                        <asp:TextBox runat="server" ID="txtFt2" CssClass="form-control" TextMode="SingleLine" placeholder="Отчество" />
                        <small class="text-muted">&nbsp</small>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
    <div>
        <asp:SqlDataSource ID="TypeOfCompanies" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [TypeOfCompanies]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Regions" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [Regions]"></asp:SqlDataSource>
    </div>

</asp:Content>
