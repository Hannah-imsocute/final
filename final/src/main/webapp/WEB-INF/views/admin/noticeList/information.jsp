<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ttshop 관리자 - 공지사항</title>
<link rel="icon" href="data:image/png;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
<style>
body {
	background-color: #f5f5f5;
	font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
}
/* 중앙 컨테이너 */
.main-container {
	max-width: 1100px;
	min-width: 900px; margin : 250px auto;
	background: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 30px;
	margin: 250px auto;
}
/* 네비게이션 탭 */
.nav-tabs .nav-link {
	font-weight: 600;
	color: #555;
}

.nav-tabs .nav-link.active {
	background-color: #007bff;
	color: #fff;
	border-color: #007bff #007bff #fff;
	border-radius: 5px 5px 0 0;
}
/* 테이블 스타일 */
.table thead th {
	background-color: #007bff;
	color: #fff;
}

.table tbody tr:hover {
	background-color: #f1f1f1;
}
/* 제목 링크 스타일 */
.subject-link {
	text-decoration: none;
	color: #333;
}

.subject-link:hover {
	color: #007bff;
}
/* 버튼 스타일 */
.btn-primary {
	border-radius: 5px;
	font-weight: 600;
}
</style>
</head>
<body>

	<!-- 헤더 및 사이드바 -->
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<!-- 메인 컨텐츠 -->
	<main class="main-container">
		<!-- 탭 네비게이션 -->
		<ul class="nav nav-tabs mb-4">
			<li class="nav-item"><a class="nav-link " href="#">공지사항</a>
			</li>
			<li class="nav-item"><a class="nav-link active" href="#">문의사항</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<!-- 오른쪽 정렬 -->
			<li class="nav-item ms-auto">
				<button type="button" class="btn btn-primary"
					onclick="location.href='${pageContext.request.contextPath}/admin/notice/write'">
					공지등록</button>
			</li>
		</ul>

		<!-- 테이블 영역 -->
		<div class="table-responsive">
			<table class="table table-striped align-middle">
				<thead>
					<tr>
						<th scope="col" style="width: 5%;">#</th>
						<th scope="col" style="width: 55%;">글제목</th>
						<th scope="col" style="width: 20%;">게시일</th>
						<th scope="col" style="width: 20%;">작성자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<th scope="row">${status.count}</th>
							<td data-num="${dto.evt_not_num}">${dto.fixed == 1 ? '[FAQ] ' : '[공지] '}
								<a
								href="${pageContext.request.contextPath}/admin/notice/article/${dto.evt_not_num}"
								class="subject-link"> ${dto.subject} </a>
							</td>
							<td>${dto.create_date}</td>
							<td>${dto.nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div>${paging}</div>
		</div>
	</main>

</body>
</html>
