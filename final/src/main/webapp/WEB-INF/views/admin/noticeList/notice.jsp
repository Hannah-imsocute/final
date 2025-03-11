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
	background-color: #f0f2f5;
	font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
}
/* 중앙 컨테이너 */
.main-container {
	max-width: 1100px;
	min-width: 900px;
	margin: 250px auto;
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	padding: 30px;
}
/* 네비게이션 탭 */
.nav-tabs .nav-link {
	font-weight: 600;
	color: #555;
}

.nav-tabs .nav-link.active {
	background-color: #6c757d;
	color: #fff;
	border-color: #6c757d #6c757d #fff;
	border-radius: 5px 5px 0 0;
}
/* 테이블 스타일 */
.table thead th {
	background-color: #6c757d;
	color: #fff;
	border: none;
}

.table tbody tr:hover {
	background-color: #f8f9fa;
}
/* 제목 링크 스타일 */
.subject-link {
	text-decoration: none;
	color: #333;
	transition: color 0.2s ease-in-out;
}

.subject-link:hover {
	color: #6c757d;
}
/* 버튼 스타일 */
.btn-primary {
	border-radius: 5px;
	font-weight: 600;
	background-color: #6c757d;
	border-color: #6c757d;
}

.btn-primary:hover {
	background-color: #545b62;
	border-color: #4e555b;
}
/* 검색창 스타일 */
.search-container {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 20px;
}

.search-container input[type="text"] {
	border-radius: 5px 0 0 5px;
	border: 1px solid #ced4da;
	padding: 8px 12px;
	width: 250px;
}

.search-container button {
	border-radius: 0 5px 5px 0;
	border: 1px solid #6c757d;
	background-color: #6c757d;
	color: #fff;
	padding: 8px 12px;
	transition: background-color 0.2s ease-in-out;
}

.search-container button:hover {
	background-color: #545b62;
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
			<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/notice/main">공지사항</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/notice/info">문의사항</a></li>
			<li class="nav-item ms-auto">
				<button type="button" class="btn btn-primary"
					onclick="location.href='${pageContext.request.contextPath}/admin/notice/write'">
					공지등록</button>
			</li>
		</ul>

		<!-- 검색창 영역 (왼쪽 정렬) -->
		<div class="search-container">
				<input type="text" name="title"  placeholder="제목 검색"
					aria-label="제목 검색">
				<button type="button" class="search-btn">검색</button>
		</div>

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
	
	<script type="text/javascript">
		$(function(){
			$('.search-btn').click(function(){
				let kwd = $('input[name=title]').val();
				let url = '${pageContext.request.contextPath}/admin/notice/main?kwd='+encodeURIComponent(kwd);
				
				location.href = url;
			});
		});
	</script>
</body>
</html>
