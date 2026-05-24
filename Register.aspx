<%@ Page Title="<%$ Resources:Resources, KayitOlTitle %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineSinavSistemi.Register" %>

<asp:Content ID="RegisterContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center mt-5">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body p-4">
                    <h3 class="card-title text-center mb-4">
                        <asp:Literal ID="ltKayitOlBaslik" runat="server" Text="<%$ Resources:Resources, KayitOl %>" />
                    </h3>

                    <%-- Hata / basari paneli --%>
                    <asp:Panel ID="pnlMesaj" runat="server" Visible="false">
                        <asp:Label ID="lblMesaj" runat="server" />
                    </asp:Panel>

                    <%-- Kullanici adi --%>
                    <div class="mb-3">
                        <label for="<%= txtKullaniciAdi.ClientID %>" class="form-label">
                            <asp:Literal ID="ltKullaniciAdi" runat="server" Text="<%$ Resources:Resources, KullaniciAdi %>" />
                        </label>
                        <asp:TextBox ID="txtKullaniciAdi" runat="server" CssClass="form-control" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvKullaniciAdi" runat="server"
                            ControlToValidate="txtKullaniciAdi"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ErrorMessage="<%$ Resources:Resources, KullaniciAdiZorunlu %>" />
                    </div>

                    <%-- Email --%>
                    <div class="mb-3">
                        <label for="<%= txtEmail.ClientID %>" class="form-label">
                            <asp:Literal ID="ltEmail" runat="server" Text="<%$ Resources:Resources, Email %>" />
                        </label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="100" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ErrorMessage="<%$ Resources:Resources, EmailZorunlu %>" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                            ErrorMessage="<%$ Resources:Resources, EmailGecersiz %>" />
                    </div>

                    <%-- Sifre --%>
                    <div class="mb-3">
                        <label for="<%= txtSifre.ClientID %>" class="form-label">
                            <asp:Literal ID="ltSifre" runat="server" Text="<%$ Resources:Resources, Sifre %>" />
                        </label>
                        <asp:TextBox ID="txtSifre" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvSifre" runat="server"
                            ControlToValidate="txtSifre"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ErrorMessage="<%$ Resources:Resources, SifreZorunlu %>" />
                    </div>

                    <%-- Sifre tekrar --%>
                    <div class="mb-3">
                        <label for="<%= txtSifreTekrar.ClientID %>" class="form-label">
                            <asp:Literal ID="ltSifreTekrar" runat="server" Text="<%$ Resources:Resources, SifreTekrar %>" />
                        </label>
                        <asp:TextBox ID="txtSifreTekrar" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                        <asp:RequiredFieldValidator ID="rfvSifreTekrar" runat="server"
                            ControlToValidate="txtSifreTekrar"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ErrorMessage="<%$ Resources:Resources, SifreTekrarZorunlu %>" />
                        <asp:CompareValidator ID="cvSifre" runat="server"
                            ControlToValidate="txtSifreTekrar"
                            ControlToCompare="txtSifre"
                            CssClass="text-danger small"
                            Display="Dynamic"
                            ValidationGroup="RegGrup"
                            ErrorMessage="<%$ Resources:Resources, SifrelerEslesmiyor %>" />
                    </div>

                    <%-- Kayit butonu --%>
                    <div class="d-grid mb-3">
                        <asp:Button ID="btnKayit" runat="server"
                            Text="<%$ Resources:Resources, KayitOl %>"
                            CssClass="btn btn-primary"
                            ValidationGroup="RegGrup"
                            OnClick="btnKayit_Click" />
                    </div>

                    <%-- Login linki --%>
                    <div class="text-center">
                        <asp:Literal ID="ltZatenUye" runat="server" Text="<%$ Resources:Resources, ZatenUyeMisiniz %>" />
                        <a href="Login.aspx">
                            <asp:Literal ID="ltGiris" runat="server" Text="<%$ Resources:Resources, GirisYap %>" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>