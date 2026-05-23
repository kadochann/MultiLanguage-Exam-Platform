<%@ Page Title="Sınava Başla" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SinavBasla.aspx.cs" Inherits="Project.SinavBasla" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-4">
        <%= GetGlobalResourceObject("Resources", "Categories") %>
    </h2>

    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-semibold"></asp:Label>

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