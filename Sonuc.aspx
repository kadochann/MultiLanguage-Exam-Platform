<%@ Page Title="Sonuç" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sonuc.aspx.cs" Inherits="Project.Sonuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-4">
        <%= GetGlobalResourceObject("Resources", "ExamResult") %>
    </h2>

    <div class="row g-4">

        <div class="col-md-3">
            <div class="result-card">
                <h3><asp:Label ID="lblCorrect" runat="server"></asp:Label></h3>
                <p><%= GetGlobalResourceObject("Resources", "Correct") %></p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="result-card">
                <h3><asp:Label ID="lblWrong" runat="server"></asp:Label></h3>
                <p><%= GetGlobalResourceObject("Resources", "Wrong") %></p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="result-card">
                <h3><asp:Label ID="lblEmpty" runat="server"></asp:Label></h3>
                <p><%= GetGlobalResourceObject("Resources", "Empty") %></p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="result-card">
                <h3><asp:Label ID="lblScore" runat="server"></asp:Label></h3>
                <p><%= GetGlobalResourceObject("Resources", "Score") %></p>
            </div>
        </div>

    </div>

    <div class="mt-4">
        <asp:Label ID="lblDuration" runat="server" CssClass="fw-semibold"></asp:Label>
    </div>

    <div class="mt-4">
        <asp:HyperLink ID="lnkHistory" runat="server" NavigateUrl="Gecmis.aspx" CssClass="btn btn-primary">
            Geçmişi Gör
        </asp:HyperLink>
    </div>

</asp:Content>