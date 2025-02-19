<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style type="text/css">
/* reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f8f8;
}

/* 기존 .customer-center -> .cs-center */
.cs-center {
	text-align: center;
	background-color: #fff;
	margin: 40px auto;
	padding: 60px 30px;
	max-width: 1000px;
	border-radius: 12px;
	margin-top: 100px;
}

/* 기존 .title -> .cs-title */
.cs-title {
	font-size: 36px;
	font-weight: bold;
	margin-bottom: 10px;
}

/* 기존 .subtitle -> .cs-subtitle */
.cs-subtitle {
	font-size: 20px;
	color: #666;
	margin-bottom: 30px;
}

/* 기존 .divider -> .cs-divider */
.cs-divider {
	border-bottom: 2px solid #ddd;
	margin: 30px 0;
}

/* 기존 .tab-menu -> .cs-tab-menu */
.cs-tab-menu {
	display: flex;
	justify-content: space-around;
	margin-bottom: 20px;
	list-style: none;
	padding: 0;
}

/* 기존 .nav-link -> .cs-tab-link */
/* (주의) Bootstrap .nav-link와 겹칠 수 있으므로 커스텀 스타일은 .cs-tab-link에 적용 */
.cs-tab-menu .cs-tab-link {
	font-size: 20px;
	padding: 20px 50px;
	font-weight: bold;
	color: #555;
	width: 100%;
	text-align: center;
	background-color: #f0f0f0;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.cs-tab-menu .cs-tab-link:hover {
	background-color: #ddd;
}

.cs-tab-menu .cs-tab-link.active {
	background-color: #333;
	color: #fff;
}

/* 기존 .notice-post -> .cs-notice-post */
.cs-notice-post {
	text-align: left;
	margin-top: 40px;
	/* 필요 시 추가 스타일 가능 */
}

/* 기존 .post-title -> .cs-post-title */
.cs-post-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

/* 기존 .post-date -> .cs-post-date */
.cs-post-date {
	font-size: 14px;
	color: #999;
	margin-bottom: 30px;
}

/* 기존 .post-content -> .cs-post-content */
.cs-post-content {
	line-height: 1.6;
	color: #333;
}

.cs-post-content h4 {
	font-size: 18px;
	font-weight: bold;
	margin-top: 20px;
	margin-bottom: 10px;
}

.cs-post-content table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

.cs-post-content table thead {
	background-color: #f0f0f0;
}

.cs-post-content table th, .cs-post-content table td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: center;
}

/* 반응형 예시 */
@media ( max-width : 768px) {
	.cs-tab-menu {
		flex-direction: column;
	}
	.cs-tab-menu .cs-tab-link {
		margin-bottom: 10px;
	}
	.cs-post-content table, .cs-post-content table th, .cs-post-content table td
		{
		font-size: 14px;
	}
}

/* 게시글 하단 네비게이션 */
.cs-post-nav {
	margin-top: 30px;
	border-top: 1px solid #ddd;
	padding-top: 20px;
}

.cs-post-nav ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

.cs-post-nav li {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	margin-bottom: 8px;
	font-size: 16px;
}

.cs-post-nav .cs-nav-label {
	width: 80px; /* "다음글", "이전글" 정도의 라벨 영역 */
	font-weight: bold;
	color: #333;
}

.cs-post-nav .cs-nav-title {
	color: #555;
}

/* 목록보기 버튼 영역 */
.cs-btn-area {
	text-align: center;
	margin-top: 30px;
}

.cs-btn-list {
	background-color: #7cc05f; /* 원하는 색상 */
	color: #fff;
	font-size: 16px;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.cs-btn-list:hover {
	background-color: #6ab24f; /* 호버 시 색상 살짝 어둡게 */
}

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="cs-center" style="margin-top: 250px;">
		<h2 class="cs-title">고객센터</h2>
		<p class="cs-subtitle">무엇을 도와드릴까요?</p>

		<div class="cs-divider"></div>

		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs cs-tab-menu" id="customerTab" role="tablist">
			<li class="nav-item">
				<!-- Bootstrap .nav-link는 유지하되, 커스텀 스타일은 .cs-tab-link로 제어 -->
				<button class="nav-link cs-tab-link" id="faq-tab"
					data-bs-toggle="tab" data-bs-target="#faq" type="button" role="tab">FAQ</button>
			</li>
			<li class="nav-item">
				<button class="nav-link cs-tab-link" id="inquiry-tab"
					data-bs-toggle="tab" data-bs-target="#inquiry" type="button"
					role="tab">1:1문의</button>
			</li>
			<li class="nav-item">
				<button class="nav-link cs-tab-link active" id="notice-tab"
					data-bs-toggle="tab" data-bs-target="#notice" type="button"
					role="tab">공지사항</button>
			</li>
		</ul>

		<div class="cs-divider"></div>

		<!-- 단일 게시글 영역 -->
		<article class="cs-notice-post">
			<h3 class="cs-post-title">&lt; 공지 &gt; ${dto.subject}</h3>
			<p class="cs-post-date">${dto.create_date }</p>

			<div class="cs-post-content">${dto.textcontent}</div>
		</article>

		<div class="cs-divider"></div>

		<div class="cs-post-nav">
			<ul>
				<li><span class="cs-nav-label">다음글</span> <span
					class="cs-nav-title">없음</span></li>
				<li><span class="cs-nav-label">이전글</span> <span
					class="cs-nav-title">&lt;사치인TM&gt; 정성코멘 이벤트 당첨자 발표</span></li>
			</ul>
		</div>

		<div class="cs-btn-area">
			<button type="button" class="cs-btn-list">목록보기</button>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>
</html>
