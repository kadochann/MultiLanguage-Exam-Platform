<%@ Page Title="<%$ Resources:Resources, GirisYapTitle %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineSinavSistemi.Login" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="row justify-content-center" style="padding-top:48px;">
    <div class="col-md-5 col-lg-4">

        <div class="text-center mb-4">
            <div style="width:56px;height:56px;background:var(--primary);border-radius:16px;display:grid;place-items:center;margin:0 auto 16px;font-size:1.5rem;color:#fff;">
                <i class="bi bi-person-fill"></i>
            </div>
            <h2 style="font-weight:800;font-size:1.6rem;letter-spacing:-.5px;">
                <asp:Literal ID="ltGirisYap" runat="server" Text="<%$ Resources:Resources, GirisYap %>" />
            </h2>
            <p style="color:var(--text-muted);font-size:.9rem;"><asp:Literal runat="server" Text="<%$ Resources:Resources, HesabinizaGirisYapin %>" /></p>
        </div>

        <div class="card">
            <div class="card-body">

                <asp:Panel ID="pnlHata" runat="server" CssClass="alert alert-danger mb-3" Visible="false">
                    <asp:Label ID="lblHata" runat="server" />
                </asp:Panel>

                <div class="mb-3">
                    <label for="<%= txtKullaniciAdi.ClientID %>" class="form-label">
                        <asp:Literal ID="ltKullaniciAdi" runat="server" Text="<%$ Resources:Resources, KullaniciAdi %>" />
                    </label>
                    <asp:TextBox ID="txtKullaniciAdi" runat="server" CssClass="form-control" MaxLength="50" />
                    <asp:RequiredFieldValidator ID="rfvKullaniciAdi" runat="server" ControlToValidate="txtKullaniciAdi"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="LoginGrup"
                        ErrorMessage="<%$ Resources:Resources, KullaniciAdiZorunlu %>" />
                </div>

                <div class="mb-4">
                    <label for="<%= txtSifre.ClientID %>" class="form-label">
                        <asp:Literal ID="ltSifre" runat="server" Text="<%$ Resources:Resources, Sifre %>" />
                    </label>
                    <asp:TextBox ID="txtSifre" runat="server" CssClass="form-control" TextMode="Password" MaxLength="50" />
                    <asp:RequiredFieldValidator ID="rfvSifre" runat="server" ControlToValidate="txtSifre"
                        CssClass="text-danger small" Display="Dynamic" ValidationGroup="LoginGrup"
                        ErrorMessage="<%$ Resources:Resources, SifreZorunlu %>" />
                </div>

                <div class="d-grid mb-3">
                    <asp:Button ID="btnGiris" runat="server"
                        Text="<%$ Resources:Resources, GirisYap %>"
                        CssClass="btn btn-primary btn-lg"
                        ValidationGroup="LoginGrup"
                        OnClick="btnGiris_Click" />
                </div>

                <div class="text-center" style="font-size:.875rem;color:var(--text-muted);">
                    <asp:Literal ID="ltHesabinizYok" runat="server" Text="<%$ Resources:Resources, HesabinizYokMu %>" />
                    <a href="Register.aspx" style="color:var(--primary);font-weight:600;">
                        <asp:Literal ID="ltKayitOl" runat="server" Text="<%$ Resources:Resources, KayitOl %>" />
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>
</asp:Content>