document.addEventListener("DOMContentLoaded", function () {
    function sendLogin(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const form = document.querySelector(".login-form"); // 로그인 폼 선택
        const emailInput = form.querySelector("input[name='userEmail']");
        const passwordInput = form.querySelector("input[name='userPwd']");

        if (!emailInput.value.trim()) {
            alert("이메일을 입력해주세요.");
            emailInput.focus();
            return;
        }

        if (!passwordInput.value.trim()) {
            alert("비밀번호를 입력해주세요.");
            passwordInput.focus();
            return;
        }

        // 로그인 폼 제출
        // form.action = `${window.location.origin}${form.dataset.action}`;
        form.submit();
    }

    // 로그인 버튼 이벤트 리스너 추가
    const loginButton = document.querySelector(".login-submit");
    if (loginButton) {
        loginButton.addEventListener("click", sendLogin);
    }
});
