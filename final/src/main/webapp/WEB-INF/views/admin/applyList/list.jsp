<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
		
<table class="table table-borderless mt-0 mb-0 bg-transparent">
	<tr>
		<td align="left" width="50%" valign="bottom" class="bg-transparent">
			<p class="form-control-plaintext p-0">
				${dataCount}개(${page}/${total_page} 페이지)
			</p>
		</td>
		<td align="right" class="bg-transparent">
			<div class="wrap-search-check">
				<div class="form-check-inline">
					<input type="checkbox" id="blockCheck1" class="form-check-input" ${block == '0' || block == '' ? "checked":""}>
					<label class="form-check-label" for="blockCheck1">활성</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="blockCheck2" class="form-check-input" ${block == '1' || block == '' ? "checked":""}>
					<label class="form-check-label" for="blockCheck2">비활성</label>
				</div>
			</div>
		</td>
	</tr>
</table>
	
<table class="table table-hover board-list">
	<thead class="table-light">
		<tr> 
			<th width="50">번호</th>
			<th width="160">아이디</th>
			<th width="80">이름</th>
			<th width="130">생년월일</th>
			<th width="150">전화번호</th>
			<th width="100">권한</th>
			<th width="100">상태</th>
			<th>이메일</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="hover" onclick="profile('${dto.memberIdx}', '${page}');"> 
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td>${dto.email}</td>
				<td>${dto.nickname}</td>
				<td>${dto.dob}</td>
				<td>${dto.phone}</td>
				<td>
					<c:choose>
						<c:when test="${dto.authority=='USER'}">회원</c:when>
						<c:when test="${dto.authority=='AUTHOR'}">작가</c:when>
						<c:when test="${dto.authority=='ADMIN'}">관리자</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose>
				</td>
				<td>${dto.block==0?"활성":"차단"}</td>
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
					<option value="email"     ${schType=="email" ? "selected":""}>아이디</option>
					<option value="nickname"   ${schType=="nickname" ? "selected":""}>이름</option>
					<option value="phone"        ${schType=="phone" ? "selected":""}>전화번호</option>
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


<table class="table table-borderless bg-transparent">
	<tr> 
		<td class="text-end bg-transparent">
			<button type="button" class="btn btn-warning fw-bold" onclick="statusDetailesMember();">계정상태</button>
			<c:if test="${dto.authority =='USER' }">
				<button type="button" class="btn btn-warning fw-bold" onclick="updateMember();">수정</button>
				<button type="button" class="btn btn-warning fw-bold" onclick="deleteMember('${dto.memberIdx}');">삭제</button>
			</c:if>
			<button type="button" class="btn btn-warning fw-bold" onclick="listMember('${page}');">리스트</button>
		</td>
	</tr>
</table>

<!-- 수정 대화상자 -->
<div class="modal fade" data-bs-backdrop="static" id="memberUpdateDialogModal" tabindex="-1" aria-labelledby="memberUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memberUpdateDialogModalLabel">회원정보수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			
				<form name="memberUpdateForm" id="memberUpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td width="110" class="bg-light">아이디</td>
							<td><p class="form-control-plaintext">${dto.email}</p></td>
						</tr>
						<tr>
							<td class="bg-light">이름</td>
							<td>
								<input type="text" name="userName" class="form-control" value="${dto.nickname}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">생년월일</td>
							<td>
								<input type="date" name="birth" class="form-control" value="${dto.dob}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">권한</td>
							<td>
								<select name="authority" class="form-select" style="width: 95%;">
											<option value="USER" ${dto.authority=='USER' ? "selected":""}>일반회원</option>
											<option value="AUTHOR" ${dto.authority=='AUTHOR' ? "selected":""}>작가</option>
											<option value="ADMIN" ${dto.authority=='ADMIN' ? "selected":""}>관리자</option>
								</select>
							</td>
						</tr>
					</table>
					<div class="text-end">
						<input type="hidden" name="memberIdx" value="${dto.memberIdx}">
						<input type="hidden" name="email" value="${dto.email}">
						<input type="hidden" name="block" value="${dto.block}">
						
						<button type="button" class="btn btn-light" onclick="updateMemberOk('${page}');">수정완료</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>