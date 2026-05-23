<%@ Page Title="Geçmiş" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gecmis.aspx.cs" Inherits="Project.Gecmis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-4">
        <%= GetGlobalResourceObject("Resources", "ExamHistory") %>
    </h2>

    <asp:Label ID="lblMessage" runat="server" CssClass="text-muted"></asp:Label>

    <asp:GridView
        ID="gvHistory"
        runat="server"
        CssClass="table table-striped table-bordered"
        AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Kategori" HeaderText="Kategori" />
            <asp:BoundField DataField="Tarih" HeaderText="Tarih" />
            <asp:BoundField DataField="Dogru" HeaderText="Doğru" />
            <asp:BoundField DataField="Yanlis" HeaderText="Yanlış" />
            <asp:BoundField DataField="Bos" HeaderText="Boş" />
            <asp:BoundField DataField="Skor" HeaderText="Skor" />
        </Columns>
    </asp:GridView>

    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Kategori Bazlı Ortalama Başarı</h5>
            <canvas id="historyChart"></canvas>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Scripts" runat="server">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script type="text/javascript">
        var labels = ["Genel Kültür", "Bilgi Teknolojileri"];
        var values = [80, 60];

        var ctx = document.getElementById("historyChart");

        if (ctx) {
            new Chart(ctx, {
                type: "bar",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "Başarı (%)",
                        data: values
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    }
                }
            });
        }
    </script>

</asp:Content>