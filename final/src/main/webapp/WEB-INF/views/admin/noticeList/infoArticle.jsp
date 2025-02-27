<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boooooot</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
<style>
/* 전체 컨테이너 */
.admin-inquiry-container {
	width: 80%;
	max-width: 1000px;
	margin: 260px auto;
	padding: 40px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	font-family: 'Noto Sans KR', sans-serif;
}

/* 제목 */
.admin-inquiry-title {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
}

/* 문의 정보 테이블 */
.admin-inquiry-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

.admin-inquiry-table th, .admin-inquiry-table td {
	padding: 12px;
	border: 1px solid #ddd;
	vertical-align: top;
}

.admin-inquiry-table th {
	width: 140px; /* 라벨 열 너비 (필요에 따라 조정) */
	background-color: #f9f9f9;
	text-align: left;
	font-weight: bold;
	color: #333;
}

.admin-inquiry-table td {
	text-align: left;
	color: #555;
}

/* 문의 내용 - 가독성을 위해 여백 */
.admin-inquiry-text {
	line-height: 1.6;
	white-space: pre-wrap; /* 줄바꿈 적용 (DB에서 \n이 넘어올 경우) */
}

/* 이미 등록된 답변 정보를 담는 섹션 */
.admin-answer-exist {
	border: 1px solid #ddd;
	padding: 10px;
	border-radius: 4px;
	margin-bottom: 20px;
	background-color: #f9f9f9;
}

/* 답변 메타 정보(답변자, 답변일)를 한 줄로 표기 */
.admin-answer-meta {
	color: #666;
	font-size: 14px;
	margin-bottom: 10px;
	display: flex;
	gap: 20px; /* 답변자 / 답변일 간격 */
}

/* 답변 내용 */
.admin-answer-text {
	color: blue;
	white-space: pre-wrap; /* 답변에 줄바꿈이 있을 경우 그대로 표시 */
	line-height: 1.6;
}

/* 답변 작성 폼 */
.admin-answer-form {
	display: flex;
	flex-direction: column;
	gap: 10px;
	margin-top: 10px;
}

.admin-answer-textarea {
	width: 100%;
	min-height: 150px;
	padding: 10px;
	font-size: 14px;
	resize: vertical;
	border: 1px solid #ccc;
	border-radius: 4px;
	line-height: 1.5;
}

.admin-answer-button {
	align-self: flex-end; /* 버튼을 오른쪽에 위치시키고 싶을 때 */
	background-color: #7cc05f;
	color: #fff;
	font-size: 16px;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.admin-answer-button:hover {
	background-color: #6ab24f;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<div class="admin-inquiry-container">
		<!-- 페이지 제목 -->
		<h1 class="admin-inquiry-title">1:1 문의 상세</h1>

		<!-- 문의글 정보 테이블 -->
		<table class="admin-inquiry-table">
			<tbody>
				<tr>
					<th>제목</th>
					<td>${dto.subject}</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${dto.catename}</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${dto.nickname}</td>
				</tr>
				<tr>
					<th>문의 날짜</th>
					<td>${dto.apply_date}</td>
				</tr>
				<tr>
					<th>문의 내용</th>
					<td class="admin-inquiry-text">${dto.textcontent}</td>
				</tr>
			</tbody>
		</table>

		<!-- 관리자 답변 섹션 -->
		<div class="admin-answer-section">
			<h2 class="admin-answer-title">답변 작성</h2>

			<!-- 이미 등록된 답변이 있을 경우 보여주기 -->
			<c:if test="${not empty dto.answer_content}">
				<div class="admin-answer-exist">
					<!-- 답변 메타 정보 (답변자, 답변일) -->
					<div class="admin-answer-meta">
						<span class="answer-writer">답변자: </span> <span
							class="answer-date">답변일: ${dto.answer_date}</span>
					</div>
					<!-- 답변 내용 -->
					<div class="admin-answer-text">${dto.answer_content}</div>
				</div>
			</c:if>

			<c:if test="${empty dto.answer_content}">
				<!-- 답변 입력 폼 (POST 등 원하는 대로 action 지정) -->
				<form class="admin-answer-form" action="${pageContext.request.contextPath}/admin/notice/reply"
					method="post">
					<!-- 보통 hidden으로 info_num 등 PK 전달 -->
					<input type="hidden" name="info_num" value="${dto.info_num}" />

					<textarea class="admin-answer-textarea" name="answer"
						placeholder="여기에 답변을 작성하세요"></textarea>

					<!-- 등록 버튼 -->
					<button type="submit" class="admin-answer-button">등록</button>
				</form>
			</c:if>
		</div>
	</div>
</body>
</html>