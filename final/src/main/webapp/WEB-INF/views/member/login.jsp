<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>뚝딱뚝딱 - 로그인</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/login.css">

    <%--    <script defer src="${pageContext.request.contextPath}/dist/js/validate/login.js"></script>--%>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<div class="login-wrapper">
    <div class="login-container">
        <div class="login-logo">
            <h1 style="font-size:2rem; color:#FF8000; margin:0;">뚝딱뚝딱</h1>
        </div>
        <div class="login-title">로그인이 필요한 서비스입니다.</div>

        <!-- 간편 로그인 -->
        <div class="section-title">회원가입</div>
        <button class="simple-login-btn kakao-btn" onclick="location.href='${pageContext.request.contextPath}/kakao/callback'">
            <i class="fas fa-comment"></i> 카카오로 시작하기
        </button>
        <button class="simple-login-btn email-btn">이메일로 가입하기</button>

        <!-- 소셜 로그인 -->
        <div class="icon-list">
            <span style="font-weight:bold; font-size:1.2rem; color:green; cursor:pointer;">N</span>
            <i class="fab fa-facebook" style="color:#1877f2;"></i>
            <i class="fab fa-apple" style="color:#000;"></i>
        </div>

        <!-- 이메일 로그인 -->
        <!-- form 태그에 login-form 클래스를 추가 -->
        <form name="loginForm" class="login-form" action="" method="post">
            <div class="section-title">이메일 로그인</div>
            <input type="email" name="email" value = "test2@naver.com" placeholder="이메일" required />
            <div style="position: relative;">
                <input type="password" name="pwd" value = "han123"  placeholder="비밀번호" style="padding-right: 40px;" required />
                <i class="fas fa-eye toggle-password" style="
                    position:absolute;
                    right:10px;
                    top:50%;
                    transform:translateY(-50%);
                    color:#aaa;
                    cursor:pointer;
                "></i>
            </div>
            <div class="options">
                <label>
                    <input type="checkbox" name="saveEmail" /> 이메일 저장하기
                </label>
                <a href="#">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/member/pwdFind">비밀번호 찾기</a>
                <a href="${pageContext.request.contextPath}/member/account" class="text-decoration-none">회원가입</a>
            </div>
            <button type="button" class="login-submit" onclick="sendLogin();">로그인</button>
        </form>
    </div>

    <div class="footer">
        Copyright &copy;
        <script>document.write(new Date().getFullYear());</script>
        뚝딱뚝딱. All rights reserved.
    </div>
</div>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script type="text/javascript">
    function sendLogin() {
        const f = document.forms["loginForm"];
        if (!f) {
            console.error("loginForm이 존재하지 않습니다.");
            return;
        }

        let email = f.email.value.trim();
        if (!email) {
            alert("이메일을 입력해주세요.");
            f.email.focus();
            return;
        }

        let password = f.pwd.value.trim();
        if (!password) {
            alert("비밀번호를 입력해주세요.");
            f.pwd.focus();
            return;
        }

        f.action = '${pageContext.request.contextPath}/member/login';
        f.submit();
    }

    // 비밀번호 보이기/숨기기 토글 기능
    document.addEventListener("DOMContentLoaded", function() {
        const togglePassword = document.querySelector(".toggle-password");
        const passwordField = document.querySelector("input[name='pwd']");

        if (togglePassword && passwordField) {
            togglePassword.addEventListener("click", function() {
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    togglePassword.classList.remove("fa-eye");
                    togglePassword.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    togglePassword.classList.remove("fa-eye-slash");
                    togglePassword.classList.add("fa-eye");
                }
            });
        }
    });
</script>

</body>
</html>
