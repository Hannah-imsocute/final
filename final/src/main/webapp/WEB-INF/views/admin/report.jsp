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
<link rel="stylesheet" href="/dist/css/admin/adminreport.css">
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="content-around">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#">작품신고</a></li>
				<li class="nav-item"><a class="nav-link" href="#">작품후기신고</a></li>
				<li class="nav-item"><a class="nav-link" href="#">댓글신고</a></li>
			</ul>
			<div class="options-cover">
				<select class="form-select category-select" aria-label="카테고리 선택">
					<option selected>카테고리</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select> <select class="form-select category-select" aria-label="검색 조건 선택">
					<option selected>검색</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select> <input type="text" class="form-control search-input"
					placeholder="검색어 입력">

				<button class="btn btn-primary search-btn">
					<i class="bi bi-search"></i>
				</button>
			</div>
			<div class="report-list">
				<jsp:include page="/WEB-INF/views/admin/report_items.jsp" />
			</div>
		</div>
	</main>

</body>
</html>