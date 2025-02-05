<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
<style type="text/css">
.content-around {
	margin-left: 200px;
}

.btn-cover {
	margin-top: 30px;
}

.eventList {
	margin-top: 30px;
}

/* 테이블 공통 스타일 */
table {
	width: 90%;
	border-collapse: collapse; /* 테두리 겹침 제거 */
	margin-bottom: 20px;
}

thead {
	background-color: #dbc2a6; /* 헤더 배경색 (샘플) */
	color: #fff; /* 헤더 글씨 색상 (샘플) */
}

thead th {
	padding: 10px;
	text-align: left;
	font-weight: bold;
}

tbody tr:nth-child(even) {
	background-color: #f9f9f9; /* 짝수 행 배경색 */
}

tbody td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

/* 상태나 수정 버튼 등에 스타일을 주고 싶다면 예시 추가 */
.status {
	font-weight: bold;
	color: #008000; /* 진행중일 때 초록색 예시 */
}

.edit-btn {
	background-color: #eee;
	border: none;
	padding: 6px 12px;
	cursor: pointer;
}

.edit-btn:hover {
	background-color: #ccc;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="content-around">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link"	aria-current="page" href="#">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link active" href="#">종료된 이벤트</a></li>
				<li class="nav-item"><a class="nav-link" href="#">당첨자발표</a></li>
			</ul>
			<div class="btn-cover">
				<button class="btn btn-outline-dark">쿠폰등록</button>
				<button class="btn btn-outline-dark">출석체크이벤트 등록</button>
				<button class="btn btn-outline-dark">댓글이벤트 등록</button>
			</div>
			<div class="eventList">
				<jsp:include page="/WEB-INF/views/admin/eventList.jsp" />
			</div>
		</div>
	</main>

</body>
</html>