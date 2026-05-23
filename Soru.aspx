<%@ Page Title="Soru" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Soru.aspx.cs" Inherits="Project.Soru" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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
                    Text="Sınavı Bitir"
                    CssClass="btn btn-success"
                    OnClick="btnFinish_Click" />
            </div>

        </div>

    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Scripts" runat="server">

    <script>
        let remainingSeconds = 300;

        function updateTimer() {
            let minutes = Math.floor(remainingSeconds / 60);
            let seconds = remainingSeconds % 60;

            document.getElementById("timer").innerText =
                String(minutes).padStart(2, "0") + ":" + String(seconds).padStart(2, "0");

            if (remainingSeconds <= 0) {
                document.getElementById("<%= btnFinish.ClientID %>").click();
            }

            remainingSeconds--;
        }

        setInterval(updateTimer, 1000);
        updateTimer();

        document.addEventListener("visibilitychange", function () {
            if (document.hidden) {
                alert("Sınav ekranından ayrıldınız. Bu durum uyarı olarak sayılabilir.");
            }
        });
    </script>

</asp:Content>