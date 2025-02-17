<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>뚝딱뚝딱 입점 신청서</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        background-color: #f8f8f8;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container-form {
        background: white;
        padding: 30px;
        max-width: 500px; /* 폼 너비 줄이기 */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .logo {
        width: 180px;
        margin-bottom: 20px;
    }

    .form-control {
        padding: 12px;
        border-radius: 6px;
    }
</style>
</head>
<body>
    <div class="container container-form text-center">
        <img src="/dist/images/layout/top_logo.png" alt="뚝딱뚝딱 로고" class="logo">
        <h3 class="mb-3">입점 신청서</h3>
        <p class="mb-4">아래 정보를 입력해주세요.</p>

        <form action="${pageContext.request.contextPath}/main/write" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="name" placeholder="작가 이름">
            </div>
            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="작가 이메일">
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="phone" placeholder="작가 연락처">
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="brandName" placeholder="브랜드명">
            </div>
            <div class="mb-3">
                <textarea class="form-control" name="brandIntro" placeholder="브랜드 소개" rows="3"></textarea>
            </div>
            <div class="mb-3">
                <textarea class="form-control" name="introPeice" placeholder="대표 작품" rows="3"></textarea>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="forExtra" placeholder="대표 작품 설명">
            </div>

			<div class="form-check mb-3">
			    <input type="checkbox" class="form-check-input" id="agreed" name="agreed" value="1">
			    <label class="form-check-label" for="agreed">개인정보 수집·이용 동의 (필수)</label>
			</div>


            <button type="submit" class="btn btn-warning w-100">입점 신청</button>
        </form>
    </div>
</body>
</html>
