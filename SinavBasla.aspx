<%@ Page Title="Sınava Başla" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SinavBasla.aspx.cs" Inherits="Project.SinavBasla" %>

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
                            <%# GetGlobalResourceObject("Resources", "QuestionCount") %>: <%# Eval("SoruSayisi") %>
                        </p>

                        <p class="text-muted">
                            <%# GetGlobalResourceObject("Resources", "Duration") %>: <%# Eval("SureSaniye") %> <%# GetGlobalResourceObject("Resources", "Seconds") %>
                        </p>

                        <asp:Button
                            ID="btnStart"
                            runat="server"
                            Text='<%# GetGlobalResourceObject("Resources", "Start") %>'
                            CssClass="btn btn-primary w-100"
                            CommandName="StartExam"
                            CommandArgument='<%# Eval("Id") %>' />

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

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