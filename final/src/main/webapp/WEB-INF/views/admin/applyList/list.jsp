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
					<input type="checkbox" id="applyCheck1" class="form-check-input" ${block == '0' || block == '' ? "checked":""}>
					<label class="form-check-label" for="applyCheck1">승인</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="applyCheck2" class="form-check-input" ${block == '1' || block == '' ? "checked":""}>
					<label class="form-check-label" for="applyCheck2">미승인</label>
				</div>
			</div>
		</td>
	</tr>
</table>
	
<table class="table table-hover board-list">
	<thead class="table-light">
		<tr> 
			<th width="70">번호</th>
			<th width="120">작가이름</th>
			<th width="120">전화번호</th>
			<th width="120">브랜드명</th>
			<th width="120">대표작품명</th>
			<th width="80">승인여부</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<tr class="hover" onclick="apply('${dto.sellerApplyNum}', '${page}');"> 
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td>${dto.name}</td>
				<td>${dto.phone}</td>
				<td>${dto.brandName}</td>
				<td>${dto.introPeice}</td>
				<td>${dto.agreed==0?"승인":"미승인"}</td>
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

<!-- JSP 코드 -->
<div class="modal fade" data-bs-backdrop="static" id="sellerStatusDetailesDialogModal" tabindex="-1" aria-labelledby="sellerStatusDetailesDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 650px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sellerStatusDetailesModalLabel">작가상세정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h3 class="form-control-plaintext fs-6 fw-semibold pt-1"><i class="bi bi-chevron-double-right"></i> 상태 변경</h3>            
                <form name="sellerStatusDetailesForm" id="sellerStatusDetailesForm" method="post">
                    <table class="table table-bordered mb-1">
                        <tr>
                            <td width="110" class="bg-light align-middle">이름(아이디)</td>
                            <td>
                                <p class="form-control-plaintext">${dto.name}(${dto.email})</p> <!-- 서버 측에서 데이터 렌더링 -->
                            </td>
                        </tr>
                        <tr>
                            <td class="bg-light align-middle">계정상태</td>
                            <td>
                                <p class="form-control-plaintext">${dto.agreed}</p> <!-- 서버 측에서 데이터 렌더링 -->
                            </td>
                        </tr>
                    </table>
                    <div class="text-end">
                        <input type="hidden" name="sellerApplyNum" value="${dto.sellerApplyNum}">
                        <input type="hidden" name="page" value="${page}">
                        <button type="button" class="btn btn-light" onclick="updateStatusOk('${page}');">상태변경</button>
                    </div>
                </form> 
            </div>
        </div>
    </div>
</div>

