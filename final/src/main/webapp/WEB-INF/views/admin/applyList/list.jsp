<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>


<table class="table table-borderless mt-0 mb-0 bg-transparent">
	<tr>
		<td align="left" width="50%" valign="bottom" class="bg-transparent">
			<p class="form-control-plaintext p-0">
				${dataCount}개(${page}/${total_page} 페이지)</p>
		</td>
		<td align="right" class="bg-transparent">
			<div class="wrap-search-check">
				<div class="form-check-inline">
					<input type="checkbox" id="applyCheck1" class="form-check-input"
						${agreed == '0' ? "checked" : ""}
						onclick="toggleCheckbox('applyCheck1')"> <label
						class="form-check-label" for="applyCheck1">승인</label>
				</div>
				<div class="form-check-inline">
					<input type="checkbox" id="applyCheck2" class="form-check-input"
						${agreed == '1' ? "checked" : ""}
						onclick="toggleCheckbox('applyCheck2')"> <label
						class="form-check-label" for="applyCheck2">미승인</label>
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
			<tr class="hover"
				onclick="apply('${dto.sellerApplyNum}', '${page}');">
				<td>${dataCount - (page-1) * size - status.index}</td>
				<td>${dto.name}</td>
				<td>${dto.phone}</td>
				<td>${dto.brandName}</td>
				<td>${dto.introPeice}</td>
				<td>${dto.agreed==0 ? "승인" : "미승인"}</td>
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
					<option value="name" ${schType=="name" ? "selected":""}>이름</option>
					<option value="brandName" ${schType=="brandName" ? "selected":""}>브랜드이름</option>
					<option value="phone" ${schType=="phone" ? "selected":""}>전화번호</option>
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


<div class="modal fade" id="sellerStatusDetailesDialogModal"
	tabindex="-1" aria-labelledby="sellerStatusDetailesDialogModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered"
		style="max-width: 850px;">
		<div class="modal-content">
			<div class="modal-header border-bottom border-3 border-warning">
				<h5 class="modal-title fw-bold fs-9 text-dark"
					id="sellerStatusDetailesModalLabel">입점 신청 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h3 class="form-control-plaintext fs-6 fw-semibold pt-1">
					<i class="bi bi-chevron-double-right"></i> 입점 상세 정보
				</h3>
				<form name="sellerStatusDetailesForm" id="sellerStatusDetailesForm"
					method="post">
					<table class="table table-bordered mb-1">
						<tr>
							<td class="bg-light col-sm-2 align-middle" style="width: 10%;">작가이름</td>
							<td class="align-middle" style="width: 30%;">
								<p class="col-sm-4 m-0" id="sellerName"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
							<td class="bg-light col-sm-2 align-middle" style="width: 10%;">브랜드이름</td>
							<td class="align-middle" style="width: 30%;">
								<p class="col-sm-4 m-0" id="sellerBrandName"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2 align-middle">이메일</td>
							<td class="align-middle">
								<p class="col-sm-4 m-0" id="sellerEmail"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
							<td class="bg-light col-sm-2 align-middle">전화번호</td>
							<td class="align-middle">
								<p class="col-sm-4 m-0" id="sellerPhone"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
						</tr>

						<tr>
							<td class="bg-light align-middle">브랜드설명</td>
							<td colspan="4">
								<p class="form-control-plaintext" id="sellerBrandIntro"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
						</tr>

						<tr>
							<td class="bg-light align-middle">승인여부</td>
							<td colspan="4">
								<p class="form-control-plaintext" id="sellerAgreed"></p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
						</tr>
					</table>


					<h3 class="form-control-plaintext fs-6 fw-semibold pt-3">
						<i class="bi bi-chevron-double-right"></i> 반려사유
					</h3>

					<table class="table table-bordered">
						<tr>
							<td class="bg-light col-sm-2 align-middle" style="width: 10%;">작가이름</td>
							<td class="align-middle">
								<p class="col-sm-4 m-0" id="sellerName2">${sellerName}</p> <!-- 서버 측에서 데이터 렌더링 -->
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2 align-middle" style="width: 10%;">반려사유</td>
							<td>
								<!-- 반려 사유를 선택할 수 있는 셀렉트 박스 추가 --> <select class="form-control"
								style="width: 100%;" id="rejectionReason">
									<option value="">반려 사유를 선택하세요</option>
									<option value="서비스 또는 상품 카테고리 부적합">서비스 또는 상품 카테고리 부적합</option>
									<option value="불성실한 신청서 작성">불성실한 신청서 작성</option>
									<option value="플랫폼의 정책이나 조건을 위반">플랫폼의 정책이나 조건을 위반</option>
									<option value="상품 품질 미비">상품 품질 미비</option>
									<option value="기타">기타</option>
							</select>
							</td>
						</tr>
					</table>




					<div class="text-center">
						<input type="hidden" name="sellerApplyNum" id="sellerApplyNum">
						<input type="hidden" id="hiddenAgreed">

						<button type="button" class="btn btn-warning"
							onclick="updateStatusOk('1');">승인</button>
						<button type="button" class="btn btn-warning"
							onclick="updateStatusReject();">반려</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
