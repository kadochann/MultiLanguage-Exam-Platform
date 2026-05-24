<%@ Page Title="<%$ Resources:Resources, HataTitle %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Hata.aspx.cs" Inherits="OnlineSinavSistemi.Hata" %>

<asp:Content ID="HataContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center mt-5">
        <div class="col-md-7">
            <div class="card border-danger shadow">
                <div class="card-body text-center p-5">
                    <div class="mb-3" style="font-size: 4rem;">⚠️</div>
                    <h2 class="text-danger mb-3">
                        <asp:Literal ID="ltHataBaslik" runat="server" Text="<%$ Resources:Resources, HataBaslik %>" />
                    </h2>
                    <p class="lead">
                        <asp:Literal ID="ltHataMesaj" runat="server" Text="<%$ Resources:Resources, HataMesaj %>" />
                    </p>
                    <div class="mt-4">
                        <a href="Default.aspx" class="btn btn-primary">
                            <asp:Literal ID="ltAnaSayfa" runat="server" Text="<%$ Resources:Resources, AnaSayfa %>" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>