<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>뚝딱뚝딱 입점 신청서</title>
<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f8f8f8;
}

.container {
	background: white;
	padding: 20px;
	width: 350px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.logo {
	width: 200px;
	margin-bottom: 20px;
}

input, textarea {
	width: 100%;
	padding: 8px;
	margin: 5px 0;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.image-upload {
	display: flex;
	justify-content: space-between;
	margin: 10px 0;
}

.image-upload div {
	width: 50px;
	height: 50px;
	border: 1px solid #ddd;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

button {
	width: 100%;
	padding: 10px;
	background-color: orange;
	color: white;
	border: none;
	cursor: pointer;
}
</style>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="/dist/css/layout/main.css">
</head>
<body>
	<div class="container">
		<img src="/dist/images/layout/top_logo.png" alt="뚝딱뚝딱 로고" class="logo">
		<!-- 로고 이미지 삽입 -->
		<h3>뚝딱뚝딱 입점 신청서</h3>
		<p>아래 정보를 입력해주세요.</p>

		<form action="${pageContext.request.contextPath}/main/apply"
			method="post">
			<input type="text" class="form-control mb-2" name="name"
				placeholder="작가 이름"> <input type="email"
				class="form-control mb-2" name="email" placeholder="작가 이메일">
			<input type="text" class="form-control mb-2" name="phone"
				placeholder="작가 연락처"> <input type="text"
				class="form-control mb-2" name="brandname" placeholder="브랜드명">
			<textarea class="form-control mb-2" name="brandintro"
				placeholder="브랜드 소개"></textarea>

			<textarea class="form-control mb-2" name="intropeice"
				placeholder="작품 설명"></textarea>
			<input type="text" class="form-control mb-2" name="forextra"
				placeholder="추가 정보">

			<div class="form-check mb-3">
				<input type="checkbox" class="form-check-input" id="agreed"
					name="agreed" value="true"> <label class="form-check-label"
					for="agreed">개인정보 수집·이용 동의 (필수)</label>
			</div>

			<button type="submit" class="btn btn-warning w-100">입점 신청</button>
		</form>

	</div>
</body>
</html>
