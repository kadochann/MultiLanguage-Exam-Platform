<%@ Page Title="<%$ Resources:Resources, KayitOlTitle %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineSinavSistemi.Register" %>

<asp:Content ID="RegisterContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="row justify-content-center" style="padding-top:48px;">
    <div class="col-md-5 col-lg-4">

        <div class="text-center mb-4">
            <div style="width:56px;height:56px;background:var(--primary);border-radius:16px;display:grid;place-items:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;">
                <i class="bi bi-person-plus-fill"></i>
            </div>
            <h2 style="font-weight:800;font-size:1.6rem;letter-spacing:-.5px;">
                <asp:Literal ID="ltKayitOlBaslik" runat="server" Text="<%$ Resources:Resources, KayitOl %>" />
            </h2>
            <p style="color:var(--text-muted);font-size:.9rem;"><asp:Literal runat="server" Text="<%$ Resources:Resources, YeniHesapOlusturun %>" /></p>
        </div>

        <div class="card">
            <div class="card-body">

                <asp:Panel ID="pnlMesaj" runat="server" Visible="false">
                    <asp:Label ID="lblMesaj" runat="server" />
                </asp:Panel>

                <div class="mb-3">
                    <label for="<%= txtKullaniciAdi.ClientID %>" class="form-label">
                        <asp:Literal ID="ltKullaniciAdi" runat="server" Text="<%$ Resources:Resources, KullaniciAdi %>" />
                    </label>
                    <asp:TextBox ID="txtKullaniciAdi" runat="server" CssClass="form-control" MaxLength="50" />
                    <asp:RequiredFieldValidator ID="rfvKullaniciAdi" runat="server" ControlToValidate="txtKullaniciAdi"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ErrorMessage="<%$ Resources:Resources, KullaniciAdiZorunlu %>" />
                </div>

                <div class="mb-3">
                    <label for="<%= txtEmail.ClientID %>" class="form-label">
                        <asp:Literal ID="ltEmail" runat="server" Text="<%$ Resources:Resources, Email %>" />
                    </label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="100" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ErrorMessage="<%$ Resources:Resources, EmailZorunlu %>" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                        ErrorMessage="<%$ Resources:Resources, EmailGecersiz %>" />
                </div>

                <div class="mb-3">
                    <label for="<%= txtSifre.ClientID %>" class="form-label">
                        <asp:Literal ID="ltSifre" runat="server" Text="<%$ Resources:Resources, Sifre %>" />
                    </label>
                    <asp:TextBox ID="txtSifre" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                    <asp:RequiredFieldValidator ID="rfvSifre" runat="server" ControlToValidate="txtSifre"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ErrorMessage="<%$ Resources:Resources, SifreZorunlu %>" />
                </div>

                <div class="mb-4">
                    <label for="<%= txtSifreTekrar.ClientID %>" class="form-label">
                        <asp:Literal ID="ltSifreTekrar" runat="server" Text="<%$ Resources:Resources, SifreTekrar %>" />
                    </label>
                    <asp:TextBox ID="txtSifreTekrar" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                    <asp:RequiredFieldValidator ID="rfvSifreTekrar" runat="server" ControlToValidate="txtSifreTekrar"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ErrorMessage="<%$ Resources:Resources, SifreTekrarZorunlu %>" />
                    <asp:CompareValidator ID="cvSifre" runat="server"
                        ControlToValidate="txtSifreTekrar" ControlToCompare="txtSifre"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="RegGrup"
                        ErrorMessage="<%$ Resources:Resources, SifrelerEslesmiyor %>" />
                </div>

                <div class="d-grid mb-3">
                    <asp:Button ID="btnKayit" runat="server"
                        Text="<%$ Resources:Resources, KayitOl %>"
                        CssClass="btn btn-primary btn-lg"
                        ValidationGroup="RegGrup"
                        OnClick="btnKayit_Click" />
                </div>

                <div class="text-center" style="font-size:.875rem;color:var(--text-muted);">
                    <asp:Literal ID="ltZatenUye" runat="server" Text="<%$ Resources:Resources, ZatenUyeMisiniz %>" />
                    <a href="Login.aspx" style="color:var(--primary);font-weight:600;">
                        <asp:Literal ID="ltGiris" runat="server" Text="<%$ Resources:Resources, GirisYap %>" />
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>
</asp:Content>