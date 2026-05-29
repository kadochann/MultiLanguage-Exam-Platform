<%@ Page Title="Sonuç" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sonuc.aspx.cs" Inherits="Project.Sonuc" %>

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

    <h2 class="mb-2">
        <%= GetGlobalResourceObject("Resources", "ExamResult") %>
    </h2>
    <h4 class="text-muted mb-4">
        <asp:Label ID="lblCategoryName" runat="server"></asp:Label>
    </h4>

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

    <div class="row mt-4 g-4">
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body d-flex flex-column justify-content-between">
                    <div>
                        <h5 class="card-title mb-3 fw-bold"><%= GetGlobalResourceObject("Resources", "ExamDetails") ?? "Sınav Detayları" %></h5>
                        <p class="fs-5 mb-0">
                            <strong><%= GetGlobalResourceObject("Resources", "Duration") ?? "Süre" %>:</strong> 
                            <asp:Label ID="lblDuration" runat="server" CssClass="fw-semibold text-primary"></asp:Label>
                        </p>
                    </div>
                    <div class="mt-4">
                        <asp:HyperLink ID="lnkHistory" runat="server" NavigateUrl="Gecmis.aspx" CssClass="btn btn-primary w-100 py-2">
                            <i class="bi bi-calendar-event"></i> <asp:Literal runat="server" Text="<%$ Resources:Resources, SeeHistory %>" />
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body d-flex flex-column align-items-center">
                    <h5 class="card-title mb-3 fw-bold w-100 text-center"><%= GetGlobalResourceObject("Resources", "VisualDistribution") ?? "Soru Dağılım Grafiği" %></h5>
                    <div style="width: 200px; height: 200px; position: relative;">
                        <canvas id="resultChart"></canvas>
                    </div>
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
    <input type="hidden" id="hfCorrect" value="<%= CorrectCount %>" />
    <input type="hidden" id="hfWrong" value="<%= WrongCount %>" />
    <input type="hidden" id="hfEmpty" value="<%= EmptyCount %>" />
    <input type="hidden" id="lblCorrectValue" value='<%= GetGlobalResourceObject("Resources", "Correct") ?? "Doğru" %>' />
    <input type="hidden" id="lblWrongValue" value='<%= GetGlobalResourceObject("Resources", "Wrong") ?? "Yanlış" %>' />
    <input type="hidden" id="lblEmptyValue" value='<%= GetGlobalResourceObject("Resources", "Empty") ?? "Boş" %>' />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var correct = parseInt(document.getElementById("hfCorrect").value) || 0;
            var wrong = parseInt(document.getElementById("hfWrong").value) || 0;
            var empty = parseInt(document.getElementById("hfEmpty").value) || 0;

            var correctLabel = document.getElementById("lblCorrectValue").value;
            var wrongLabel = document.getElementById("lblWrongValue").value;
            var emptyLabel = document.getElementById("lblEmptyValue").value;

            var ctx = document.getElementById("resultChart");
            if (ctx) {
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: [correctLabel, wrongLabel, emptyLabel],
                        datasets: [{
                            data: [correct, wrong, empty],
                            backgroundColor: ['#198754', '#dc3545', '#6c757d'],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom'
                            }
                        }
                    }
                });
            }
        });
    </script>
</asp:Content>