<%@ Page Title="Soru" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Soru.aspx.cs" Inherits="Project.Soru" %>

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

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <%= GetGlobalResourceObject("Resources", "Question") %>
            <asp:Label ID="lblQuestionNumber" runat="server"></asp:Label>
        </h2>

        <div class="timer-box">
            <%= GetGlobalResourceObject("Resources", "TimeLeft") %>:
            <span id="timer">05:00</span>
        </div>
    </div>

    <asp:Label ID="lblWarning" runat="server" CssClass="text-danger fw-semibold d-block mb-3"></asp:Label>

    <div class="question-card">

        <h4 class="mb-4">
            <asp:Label ID="lblQuestionText" runat="server"></asp:Label>
        </h4>

        <asp:RadioButtonList
            ID="rblOptions"
            runat="server"
            CssClass="mb-4"
            RepeatDirection="Vertical">
        </asp:RadioButtonList>

        <div class="d-flex justify-content-between">

            <asp:Button
                ID="btnPrevious"
                runat="server"
                Text="Geri"
                CssClass="btn btn-outline-secondary"
                OnClick="btnPrevious_Click" />

            <div>
                <asp:Button
                    ID="btnNext"
                    runat="server"
                    Text="İleri"
                    CssClass="btn btn-primary"
                    OnClick="btnNext_Click" />

                <asp:Button
                    ID="btnFinish"
                    runat="server"
                    ClientIDMode="Static"
                    Text="Sınavı Bitir"
                    CssClass="btn btn-success"
                    OnClientClick="sessionStorage.removeItem('remainingSeconds');"
                    OnClick="btnFinish_Click" />
            </div>

        </div>

    </div>

    <asp:HiddenField ID="hfRemainingSeconds" runat="server" ClientIDMode="Static" />

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

    <script>
        // initialRemainingSeconds is declared globally by RegisterClientScriptBlock in code-behind
        let remainingSeconds = sessionStorage.getItem("remainingSeconds");
        if (remainingSeconds === null) {
            remainingSeconds = typeof initialRemainingSeconds !== 'undefined' ? initialRemainingSeconds : 300;
        } else {
            remainingSeconds = parseInt(remainingSeconds);
        }

        function updateTimer() {
            let minutes = Math.floor(remainingSeconds / 60);
            let seconds = remainingSeconds % 60;

            document.getElementById("timer").innerText =
                String(minutes).padStart(2, "0") + ":" + String(seconds).padStart(2, "0");

            let hf = document.getElementById("hfRemainingSeconds");
            if (hf) {
                hf.value = remainingSeconds;
            }

            if (remainingSeconds <= 0) {
                sessionStorage.removeItem("remainingSeconds");
                let btn = document.getElementById("btnFinish");
                if (btn) btn.click();
            } else {
                sessionStorage.setItem("remainingSeconds", remainingSeconds);
                remainingSeconds--;
            }
        }

        setInterval(updateTimer, 1000);
        updateTimer();

        document.addEventListener("visibilitychange", function () {
            if (document.hidden) {
                fetch('Soru.aspx/IncrementWarningCount', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: '{}'
                })
                .then(response => response.json())
                .then(data => {
                    let warningCount = parseInt(data.d);
                    if (warningCount >= 3) {
                        alert("Sınav ekranından 3 kez ayrıldığınız için sınavınız sonlandırılmıştır.");
                        sessionStorage.removeItem("remainingSeconds");
                        let btn = document.getElementById("btnFinish");
                        if (btn) btn.click();
                    } else {
                        alert("Sınav ekranından ayrıldınız! Uyarı " + warningCount + " / 3. 3. uyarıda sınavınız sonlandırılacaktır.");
                    }
                })
                .catch(err => {
                    console.error("Warning count error", err);
                });
            }
        });
    </script>

</asp:Content>