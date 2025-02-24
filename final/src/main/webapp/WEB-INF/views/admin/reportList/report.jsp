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
					<option selected value="0">카테고리</option>
					<c:forEach var="dto" items="${categorylist}">
						<option value="${dto.category_num }">${dto.category_name}</option>
					</c:forEach>
				</select> <input type="text" class="form-control search-input"
					placeholder="검색어 입력">

				<button class="btn btn-primary search-btn">
					<i class="bi bi-search"></i>
				</button>
			</div>
			<div class="report-list">
				<table>
					<thead>
						<tr>
							<th>신고번호</th>
							<th>상품코드</th>
							<!--  신고종류에 따라 이름만 바꾸기 상품 | 댓글 | 후기  -->
							<th>신고자</th>
							<th>신고사유</th>
							<th>신고일자</th>
							<th>카테고리</th>
							<th>처리상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>1</td>
								<td>${dto.productcode }</td>
								<td>ujin</td>
								<td>just</td>
								<td>${dto.report_date }</td>
								<td>${dto.category_num}</td>
								<td>not yet</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div>${paging}</div>
		</div>
	</main>

</body>
</html>