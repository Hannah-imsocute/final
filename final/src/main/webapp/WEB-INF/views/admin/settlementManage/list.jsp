<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
a.profile:link {
	text-decoration: none;
}

a.profile:hover {
	color: orange !important;
	text-decoration: underline;
}
</style>

<table class="table table-borderless mt-0 mb-0 bg-transparent">
	<tr>
		<td align="left" width="50%" valign="bottom" class="bg-transparent">
			<p id="dataCount" class="form-control-plaintext p-0">
				<c:choose>
					<c:when test="${mainTab == 1 && subTab == 1}">
						${dataCount}개(${page}/${total_page} 페이지)
					</c:when>
					<c:when test="${mainTab == 1 && subTab == 2}">
						${dataCount2}개(${page}/${total_page} 페이지)
					</c:when>
					
				</c:choose>
			</p>
		</td>
		<td align="right" class="bg-transparent">
			<div class="wrap-search-check">
				<div class="form-check-inline">
					<input type="checkbox" id="blockCheck1" class="form-check-input"
						${block == '0' || block == '' ? "checked":""}> <label
						class="form-check-label" for="blockCheck1">활성</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="blockCheck2" class="form-check-input"
						${block == '1' || block == '' ? "checked":""}> <label
						class="form-check-label" for="blockCheck2">비활성</label>
				</div>
			</div>
		</td>
	</tr>
</table>

<table class="table table-hover board-list">
	<thead class="table-light">
		<tr>
			<th width="70">번호</th>
			<c:choose>
				<c:when test="${mainTab == 1 && subTab == 1}">
					<th width="130">정산번호</th>
					<th width="130">브랜드이름</th>
					<th width="130">정산금액</th>
					<th width="130">날짜</th>
					<th width="100">상태</th>
					<th width="100"></th>
				</c:when>
				<c:when test="${mainTab == 1 && subTab == 2}">
					<th width="130">정산번호</th>
					<th width="130">브랜드이름</th>
					<th width="130">정산금액</th>
					<th width="130">수수료</th>
					<th width="130">날짜</th>
					<th width="100">상태</th>
					<th width="100"></th>
				</c:when>
			</c:choose>
		</tr>
	</thead>

	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="hover">
				<c:choose>
					<c:when test="${mainTab == 1 && subTab == 1}">
						<td>${dataCount - (page-1) * size - status.index}</td>
						<td>${dto.settlement_num}</td>
						<td>${dto.brandname}</td>
						<td>${dto.point_amount}</td>
						<td>${dto.settlement_date}</td>
						<td>${dto.state == 1 ? "완료" : "대기"}</td>
					</c:when>
					<c:when test="${mainTab == 1 && subTab == 2}">
						<td>${dataCount2 - (page-1) * size - status.index}</td>
						<td>${dto.withdraw_num}</td>
						<td>${dto.brandname}</td>
						<td>${dto.point_amount2}</td>
						<td>${dto.surcharge}</td>
						<td>${dto.withdraw_date}</td>
						<td>${dto.state2 == 1 ? "완료" : "대기"}</td>
					</c:when>
				</c:choose>
				<td><a class="profile"
					href="${pageContext.request.contextPath}/admin/settlementManage/profile?settlement_num=${dto.settlement_num}&page=${page}"><font
						color="gray"> 상세보기 </font></a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-navigation">${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>

<div class="row board-list-footer">
	<div class="col">
		<button type="button" class="btn btn-light" onclick="resetList();"
			title="새로고침">
			<i class="bi bi-arrow-counterclockwise"></i>
		</button>
	</div>
	<div class="col-6 text-center">
		<div class="row">
			<div class="col-auto p-1">
				<select id="searchType" name="schType" class="form-select">
					<option value="email" ${schType=="email" ? "selected":""}>아이디</option>
					<option value="nickname" ${schType=="nickname" ? "selected":""}>이름</option>

				</select>
			</div>
			<div class="col-auto p-1">
				<input type="text" id="keyword" name="kwd" value="${kwd}"
					class="form-control">
			</div>
			<div class="col-auto p-1">
				<button type="button" class="btn btn-light" onclick="searchList()">
					<i class="bi bi-search"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="col text-end">&nbsp;</div>
</div>
