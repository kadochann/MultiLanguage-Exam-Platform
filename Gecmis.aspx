<%@ Page Title="Geçmiş" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gecmis.aspx.cs" Inherits="Project.Gecmis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Top Text Ads --%>
    <div class="google-ad-container google-ad-top">
        <div class="google-ad-header">
            <span class="google-ad-badge">Sponsorlu</span>
            <span class="google-ad-powered">
                <svg class="google-ad-logo" viewBox="0 0 48 48" width="14" height="14">
                    <circle cx="24" cy="24" r="22" fill="#4285F4" />
                    <text x="50%" y="55%" text-anchor="middle" fill="white" font-size="24" font-weight="bold" dominant-baseline="middle">G</text>
                </svg>
                Google Ads
            </span>
        </div>
        <div class="google-ad-cards">
            <div class="google-ad-card" onclick="window.open('https://mediamarkt.com.tr', '_blank')">
                <div class="google-ad-card-icon"><i class="bi bi-cpu-fill"></i></div>
                <div class="google-ad-card-content">
                    <div class="google-ad-card-title">Teknoloji Fırsatları - MediaMarkt</div>
                    <div class="google-ad-card-desc">En son teknoloji ürünlerinde kaçırılmayacak fırsatlar!</div>
                    <div class="google-ad-card-link">mediamarkt.com.tr <i class="bi bi-box-arrow-up-right"></i></div>
                </div>
            </div>
            <div class="google-ad-card" onclick="window.open('https://samsung.com/tr', '_blank')">
                <img src='<%= ResolveUrl("~/images/phone_1.jpg") %>' alt="Ad Icon" style="width: 42px; height: 42px; border-radius: 8px; object-fit: cover; flex-shrink: 0;" />
                <div class="google-ad-card-content">
                    <div class="google-ad-card-title">Samsung Galaxy S24 Ultra</div>
                    <div class="google-ad-card-desc">Yapay zeka destekli yeni nesil akıllı telefon. Hemen keşfet!</div>
                    <div class="google-ad-card-link">samsung.com/tr <i class="bi bi-box-arrow-up-right"></i></div>
                </div>
            </div>
            <div class="google-ad-card" onclick="window.open('https://boyner.com.tr', '_blank')">
                <div class="google-ad-card-icon"><i class="bi bi-percent"></i></div>
                <div class="google-ad-card-content">
                    <div class="google-ad-card-title">Sezon Sonu İndirimi - %80'e Varan</div>
                    <div class="google-ad-card-desc">Moda markalarında büyük sezon sonu indirimi başladı!</div>
                    <div class="google-ad-card-link">boyner.com.tr <i class="bi bi-box-arrow-up-right"></i></div>
                </div>
            </div>
        </div>
    </div>

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
            <asp:BoundField DataField="Kategori" HeaderText="<%$ Resources:Resources, Category %>" />
            <asp:BoundField DataField="Tarih" HeaderText="<%$ Resources:Resources, Date %>" />
            <asp:BoundField DataField="Dogru" HeaderText="<%$ Resources:Resources, Correct %>" />
            <asp:BoundField DataField="Yanlis" HeaderText="<%$ Resources:Resources, Wrong %>" />
            <asp:BoundField DataField="Bos" HeaderText="<%$ Resources:Resources, Empty %>" />
            <asp:BoundField DataField="Skor" HeaderText="<%$ Resources:Resources, Score %>" />
        </Columns>
    </asp:GridView>

    <div class="row mt-4 g-4">
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold"><%= GetGlobalResourceObject("Resources", "AverageSuccessByCategory") ?? "Kategori Bazlı Ortalama Başarı" %></h5>
                    <canvas id="historyChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold"><%= GetGlobalResourceObject("Resources", "ExamSuccessProgress") ?? "Sınav Başarı Gelişimi" %></h5>
                    <canvas id="progressChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <%-- Bottom Display Ads --%>
    <div class="google-ad-container google-ad-bottom">
        <div class="google-ad-header">
            <span class="google-ad-badge">Sponsorlu</span>
            <span class="google-ad-powered">
                <svg class="google-ad-logo" viewBox="0 0 48 48" width="14" height="14">
                    <circle cx="24" cy="24" r="22" fill="#4285F4" />
                    <text x="50%" y="55%" text-anchor="middle" fill="white" font-size="24" font-weight="bold" dominant-baseline="middle">G</text>
                </svg>
                Google Ads
            </span>
        </div>
        <div class="google-ad-display-grid">
            <div class="google-ad-display" onclick="window.open('https://trendyol.com', '_blank')">
                <img src='<%= ResolveUrl("~/images/cloth_2.jpg") %>' alt="Trendyol Kampanya" style="width: 100%; height: 100px; object-fit: cover; display: block;" />
                <div class="google-ad-display-info">
                    <strong>Trendyol</strong>
                    <small>%70'e varan indirim fırsatları</small>
                </div>
            </div>
            <div class="google-ad-display" onclick="window.open('https://hepsiburada.com', '_blank')">
                <img src='<%= ResolveUrl("~/images/shoes_1.jpg") %>' alt="Hepsiburada Kampanya" style="width: 100%; height: 100px; object-fit: cover; display: block;" />
                <div class="google-ad-display-info">
                    <strong>Hepsiburada</strong>
                    <small>50 TL anında indirim kuponu</small>
                </div>
            </div>
            <div class="google-ad-display" onclick="window.open('https://amazon.com.tr', '_blank')">
                <img src='<%= ResolveUrl("~/images/watch_1.jpg") %>' alt="Amazon Kampanya" style="width: 100%; height: 100px; object-fit: cover; display: block;" />
                <div class="google-ad-display-info">
                    <strong>Amazon.com.tr</strong>
                    <small>Prime üyelere özel ayrıcalıklar</small>
                </div>
            </div>
            <div class="google-ad-display" onclick="window.open('https://n11.com', '_blank')">
                <img src='<%= ResolveUrl("~/images/home_1.jpg") %>' alt="N11 Kampanya" style="width: 100%; height: 100px; object-fit: cover; display: block;" />
                <div class="google-ad-display-info">
                    <strong>N11.com</strong>
                    <small>12 aya varan taksit seçenekleri</small>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Scripts" runat="server">
    <!-- Hidden fields to pass code-behind data to client-side scripts without IDE syntax errors -->
    <input type="hidden" id="hfBarLabels" value='<%= BarChartLabelsJson %>' />
    <input type="hidden" id="hfBarValues" value='<%= BarChartValuesJson %>' />
    <input type="hidden" id="hfLineLabels" value='<%= LineChartLabelsJson %>' />
    <input type="hidden" id="hfLineValues" value='<%= LineChartValuesJson %>' />
    <input type="hidden" id="lblSuccessLabel" value='<%= GetGlobalResourceObject("Resources", "SuccessPercentage")?.ToString() ?? "Başarı (%)" %>' />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            // Retrieve and parse data from hidden inputs to avoid IDE syntax squiggles
            var barLabels = JSON.parse(document.getElementById("hfBarLabels").value || "[]");
            var barValues = JSON.parse(document.getElementById("hfBarValues").value || "[]");
            var lineLabels = JSON.parse(document.getElementById("hfLineLabels").value || "[]");
            var lineValues = JSON.parse(document.getElementById("hfLineValues").value || "[]");
            var successLabel = document.getElementById("lblSuccessLabel").value;

            // 1. Bar Chart: Category Average Success
            var ctxBar = document.getElementById("historyChart");
            if (ctxBar) {
                new Chart(ctxBar, {
                    type: "bar",
                    data: {
                        labels: barLabels,
                        datasets: [{
                            label: successLabel,
                            data: barValues,
                            backgroundColor: '#0d6efd',
                            borderColor: '#0a58ca',
                            borderWidth: 1
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

            // 2. Line Chart: Exam Success Progress over Time
            var ctxLine = document.getElementById("progressChart");
            if (ctxLine) {
                new Chart(ctxLine, {
                    type: "line",
                    data: {
                        labels: lineLabels,
                        datasets: [{
                            label: successLabel,
                            data: lineValues,
                            borderColor: '#198754',
                            backgroundColor: 'rgba(25, 135, 84, 0.1)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.1
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
        });
    </script>
</asp:Content>