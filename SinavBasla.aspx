<%@ Page Title="Sınava Başla" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SinavBasla.aspx.cs" Inherits="Project.SinavBasla" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-4">
        <%= GetGlobalResourceObject("Resources", "Categories") %>
    </h2>

    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-semibold d-block mb-3"></asp:Label>

    <asp:Panel ID="pnlResume" runat="server" CssClass="alert alert-info d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3 shadow-sm border-info" Visible="false">
        <div>
            <h5 class="alert-heading fw-bold mb-1">
                <%= GetGlobalResourceObject("Resources", "ResumeExamTitle") %>
            </h5>
            <p class="mb-0">
                <asp:Literal ID="litResumeMessage" runat="server"></asp:Literal>
            </p>
        </div>
        <div class="d-flex gap-2 align-items-center">
            <asp:Button ID="btnResume" runat="server" CssClass="btn btn-primary" Text="<%$ Resources:Resources, ResumeButton %>" OnClick="btnResume_Click" />
            <asp:Button ID="btnIgnoreResume" runat="server" CssClass="btn btn-outline-danger btn-sm" Text="<%$ Resources:Resources, IgnoreResumeButton %>" OnClick="btnIgnoreResume_Click" />
        </div>
    </asp:Panel>

    <div class="row g-4 mt-2">

        <asp:Repeater ID="rptCategories" runat="server" OnItemCommand="rptCategories_ItemCommand">
            <ItemTemplate>
                <div class="col-md-4">
                    <div class="category-card">

                        <h4><%# Eval("Ad") %></h4>

                        <p class="text-muted mb-2">
                            Soru Sayısı: <%# Eval("SoruSayisi") %>
                        </p>

                        <p class="text-muted">
                            Süre: <%# Eval("SureSaniye") %> saniye
                        </p>

                        <asp:Button
                            ID="btnStart"
                            runat="server"
                            Text="Başla"
                            CssClass="btn btn-primary w-100"
                            CommandName="StartExam"
                            CommandArgument='<%# Eval("Id") %>' />

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>

</asp:Content>