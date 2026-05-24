<%@ Page Title="<%$ Resources:Resources, GirisYapTitle %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineSinavSistemi.Login" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center mt-5">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body p-4">
                    <h3 class="card-title text-center mb-4">
                        <asp:Literal ID="ltGirisYap" runat="server" Text="<%$ Resources:Resources, GirisYap %>" />
                    </h3>

                    <%-- Hata mesaji --%>
                    <asp:Panel ID="pnlHata" runat="server" CssClass="alert alert-danger" Visible="false">
                        <asp:Label ID="lblHata" runat="server" />
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
                            ValidationGroup="LoginGrup"
                            ErrorMessage="<%$ Resources:Resources, KullaniciAdiZorunlu %>" />
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
                            ValidationGroup="LoginGrup"
                            ErrorMessage="<%$ Resources:Resources, SifreZorunlu %>" />
                    </div>

                    <%-- Giris butonu --%>
                    <div class="d-grid mb-3">
                        <asp:Button ID="btnGiris" runat="server"
                            Text="<%$ Resources:Resources, GirisYap %>"
                            CssClass="btn btn-primary"
                            ValidationGroup="LoginGrup"
                            OnClick="btnGiris_Click" />
                    </div>

                    <%-- Kayit linki --%>
                    <div class="text-center">
                        <asp:Literal ID="ltHesabinizYok" runat="server" Text="<%$ Resources:Resources, HesabinizYokMu %>" />
                        <a href="Register.aspx">
                            <asp:Literal ID="ltKayitOl" runat="server" Text="<%$ Resources:Resources, KayitOl %>" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>