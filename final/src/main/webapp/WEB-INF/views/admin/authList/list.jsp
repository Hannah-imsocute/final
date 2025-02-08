<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
		
<table class="table table-borderless mt-2 mb-0">
	<tr>
		<td align="left" width="50%" valign="bottom">
			<p class="form-control-plaintext p-0">
				${dataCount}개(${page}/${total_page} 페이지)
			</p>
		</td>
		<td align="right">
			<div class="wrap-search-check">
				<div class="form-check-inline">
					<input type="checkbox" id="enabledCheck1" class="form-check-input" ${enabled == '1' || enabled == '' ? "checked":""}>
					<label class="form-check-label" for="enabledCheck1">활성</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="enabledCheck2" class="form-check-input" ${enabled == '0' || enabled == '' ? "checked":""}>
					<label class="form-check-label" for="enabledCheck2">비활성</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="nonMemberCheckbox" class="form-check-input" ${non == 1 ? "checked":""}>
					<label class="form-check-label" for="nonMemberCheckbox">비회원 포함</label>
				</div>
			</div>
		</td>
	</tr>
</table>
	
<table class="table table-hover board-list">
	<thead class="table-light">
		<tr> 
			<th width="70">번호</th>
			<th width="130">아이디</th>
			<th width="100">이름</th>
			<th width="100">생년월일</th>
			<th width="120">전화번호</th>
			<th width="80">권한</th>
			<th width="70">상태</th>
			<th>이메일</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="hover" onclick="profile('${dto.memberIdx}', '${page}');"> 
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td>${dto.userId}</td>
				<td>${dto.userName}</td>
				<td>${dto.birth}</td>
				<td>${dto.tel}</td>
				<td>
					<c:choose>
						<c:when test="${dto.authority=='USER'}">회원</c:when>
						<c:when test="${dto.authority=='INSTRUCTOR'}">강사</c:when>
						<c:when test="${dto.authority=='INACTIVE'}">비회원</c:when>
						<c:when test="${dto.authority=='EMP'}">사원</c:when>
						<c:when test="${dto.authority=='EX_EMP'}">퇴사</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose>
				</td>
				<td>${dto.enabled==1?"활성":"잠금"}</td>
				<td>${dto.email}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
		 
<div class="page-navigation">
	${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>

<div class="row board-list-footer">
	<div class="col">
		<button type="button" class="btn btn-light" onclick="resetList();" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
	</div>
	<div class="col-6 text-center">
		<div class="row">
			<div class="col-auto p-1">
				<select id="searchType" name="schType" class="form-select">
					<option value="userId"     ${schType=="userId" ? "selected":""}>아이디</option>
					<option value="userName"   ${schType=="userName" ? "selected":""}>이름</option>
					<option value="email"      ${schType=="email" ? "selected":""}>이메일</option>
					<option value="tel"        ${schType=="tel" ? "selected":""}>전화번호</option>
				</select>
			</div>
			<div class="col-auto p-1">
				<input type="text" id="keyword" name="kwd" value="${kwd}" class="form-control">
			</div>
			<div class="col-auto p-1">
				<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
			</div>
		</div>
	</div>
	<div class="col text-end">
		&nbsp;
	</div>
</div>
