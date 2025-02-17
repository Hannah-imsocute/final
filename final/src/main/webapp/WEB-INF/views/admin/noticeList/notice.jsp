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
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main style="width: 80%; margin-top: 200px; margin-left: 300px;">
		<div>
			<ul class="nav nav-tabs d-flex">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#">공지사항</a></li>
				<li class="nav-item"><a class="nav-link" href="#">문의사항</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
				<li class="nav-item"><a class="nav-link disabled" href="#"
					tabindex="-1" aria-disabled="true">Disabled</a></li>
				<!-- 오른쪽 끝 버튼 -->
				<li class="nav-item ms-auto">
					<button type="button" class="btn btn-primary"
						onclick="location.href='${pageContext.request.contextPath}/admin/notice/write'">공지등록</button>
				</li>
			</ul>
		</div>
		<div>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">글제목</th>
						<th scope="col">게시일</th>
						<th scope="col">작성자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<th scope="row">${status.count}</th>
							<td data-num="${dto.evt_not_num}">${dto.fixed == 1 ? '[FAQ]':'[공지]'}<a href="${pageContext.request.contextPath}/admin/notice/article/${dto.evt_not_num}"> ${dto.subject}</a></td>
							<td>${dto.create_date }</td>
							<td>${dto.nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</main>

	<script type="text/javascript">
		
	</script>
</body>
</html>