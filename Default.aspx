<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div class="hero-card text-center">

            <h1 class="mb-3">
                <%= GetGlobalResourceObject("Resources", "WelcomeTitle") %>
            </h1>

            <p class="lead text-muted mb-4">
                <%= GetGlobalResourceObject("Resources", "WelcomeText") %>
            </p>

            <div class="mb-4">
                <span class="fw-semibold">
                    <%= GetGlobalResourceObject("Resources", "SelectLanguage") %>:
                </span>

                <asp:Button
                    ID="btnTR"
                    runat="server"
                    Text="Türkçe"
                    CssClass="btn btn-outline-primary ms-2"
                    OnClick="btnTR_Click" />

                <asp:Button
                    ID="btnEN"
                    runat="server"
                    Text="English"
                    CssClass="btn btn-outline-primary ms-2"
                    OnClick="btnEN_Click" />
            </div>

            <asp:HyperLink
                ID="lnkStartExam"
                runat="server"
                NavigateUrl="SinavBasla.aspx"
                CssClass="btn btn-primary btn-lg">
                Sınava Başla
            </asp:HyperLink>

        </div>
    </main>

</asp:Content>