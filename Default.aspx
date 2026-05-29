<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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