<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

	<jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>


<style type="text/css">
.body-container {
	max-width: 1000px;
}

.detailState-form textarea { width: 100%; height: 75px; resize: none; }
textarea::placeholder{ opacity: 1; color: #333; text-align: center; line-height: 60px; }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/boot-board.css" type="text/css">

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>

</header>
	
<main>
	<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>

	<div class="wrapper">
		<div class="body-container">
		    <div class="body-title">
				<h3><i class="bi bi-app"></i> 주문 상세정보 </h3>
		    </div>
		    
		    <div class="body-main">

				<div class="mt-3">
					<div class="p-3 shadow bg-body rounded mb-2">
						<p class="fs-6 fw-semibold mb-0">구매 상품</p> 
					</div>
					
					<table class="table table-bordered mb-1">
						<tr>
							<td class="table-light" width="140">상품명</td>
							<td colspan="5">
								${dto.item}
							</td>
						</tr>
	
						<tr>
							<td class="table-light" width="140">옵 션</td>
							<td width="180">
								${dto.options}
							</td>
							<td class="table-light" width="140">주문상태</td>
							<td width="180">${dto.orderStateInfo}</td>
							<td class="table-light" width="140">상품가격</td>
							<td width="180"><fmt:formatNumber value="${dto.salePrice}"/></td>
						</tr>
						
						<tr>
							<td class="table-light" width="140">주문수량</td>
							<td width="180">${dto.totalQty}</td>
							<td class="table-light" width="140">구매총금액</td>
							<td width="180"><fmt:formatNumber value="${dto.totalMoney}"/></td>
							<td class="table-light" width="140"></td>
							<td width="180"></td>
						</tr>
						
						<tr>
							<td class="table-light" width="140">구매자</td>
							<td width="180">${dto.nickName}</td>
							<td class="table-light" width="140">회원번호</td>
							<td width="180">${dto.memberIdx}</td>
							<td class="table-light" width="140">아이디</td>
							<td width="180">${dto.userId}</td>
						</tr>
	
						<tr>
							<td class="table-light" width="140">구매일자</td>
							<td width="180">${dto.order_Date}</td>
							<td class="table-light" width="140">택배사</td>
							<td width="180">${dto.company_name}</td>
							<td class="table-light" width="140">송장번호</td>
							<td width="180">${dto.invoiceNumber}</td>
						</tr>
					</table>
					
					<table class="table table-borderless">
						<tr>
							<td width="50%">
							</td>
							<td class="text-end">
								<button type="button" class="btn btn-light" onclick="listDetailState();">상태확인</button>
								<c:if test="${!(dto.orderState==6 || dto.orderState==8 || dto.orderState==1 || dto.orderState==2 || dto.orderState==3)}">
									<button type="button" class="btn btn-light" onclick="detailStateUpdate();">상태변경</button>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
			
				<c:if test="${listBuy.size() > 1}">
					<div class="mt-3">
						<div class="p-3 shadow bg-body rounded mb-2">
							<p class="fs-6 fw-semibold mb-0">함께 구매한 상품</p> 
						</div>
						
						<table class="table table-bordered mb-1">
							<c:forEach var="vo" items="${listBuy}">
								<c:if test="${dto.orderDetailNum != vo.orderDetailNum}">
									<tr>
										<td class="table-light" width="140">상품명</td>
										<td colspan="3">
											${vo.item}
										${vo.options},
											&nbsp;수량 : ${vo.totalQty}
										</td>
										<td class="table-light" width="140">금 액</td>
										<td width="180">
											<fmt:formatNumber value="${vo.productMoney}"/>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</div>
				</c:if>
	
				<div class="mt-4">
					<div class="p-3 shadow bg-body rounded mb-2">
						<p class="fs-6 fw-semibold mb-0">결제 정보</p> 
					</div>
					
					<table class="table table-bordered mb-1">
						<tr>
							<td class="table-light" width="140">결제카드</td>
							<td width="180">${payDetail.PROVIDER}</td>
							<td class="table-light" width="140">승인일자</td>
							<td colspan="3">${payDetail.CONFIRM_DATE}</td>
						</tr>
						<tr>
							<td class="table-light" width="140">총금액</td>
							<td width="180"><fmt:formatNumber value="${dto.totalMoney }"/></td>
							<td class="table-light" width="140">포인트사용액</td>
							<td width="180"><fmt:formatNumber value="${dto.usedSaved}"/></td>
							<td class="table-light" width="140">결제금액</td>
							<td width="180"><fmt:formatNumber value="${dto.totalMoney - dto.usedSaved}"/></td>
						</tr>
					</table>
				</div>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<button type="button" class="btn btn-light">이전주문</button>
							<button type="button" class="btn btn-light">다음주문</button>
						</td>
						<td class="text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/artist/orderManage/detailManage/${tebNum}?${query}';">리스트</button>
						</td>
					</tr>
				</table>

			</div>
		</div>		
	</div>
</main>

<!-- 주문상세정보-상태확인 대화상자  -->
<div class="modal fade" id="detailStateInfoDialogModal" tabindex="-1" aria-labelledby="detailStateInfoDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="detailStateInfoDialogModalLabel">주문상세정보 상태 확인</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-3">
				<table class="table board-list">
					<thead class="table-light">
						<tr>
							<td width="50">코드</td>
							<td width="120">구분</td>
							<td width="90">작성자</td>
							<td width="120">날짜</td>
							<td>설명</td>
						</tr>
					</thead>
					<tbody class="detailState-list"></tbody>	
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 주문상세정보-수정 대화상자 -->
<div class="modal fade" id="detailStateUpdateDialogModal" tabindex="-1" aria-labelledby="detailStateUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="detailStateUpdateDialogModalLabel">주문상세정보 상태 변경</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<form name="detailStateForm" class="justify-content-center detailState-form">
					<div class="row">
						<div class="col-auto p-1">
							<select name="orderState" class="form-select">
								<c:choose>
									<c:when test="${(dto.orderState==1 ) || dto.orderState==6 || dto.orderState==12 || dto.orderState==15}">
										<option value="19">기타</option>
									</c:when>
									<c:when test="${dto.orderState==4}">
										<option value="8">주문취소완료</option>
									</c:when>
									<c:when test="${dto.orderState==9}">
										<option value="10">교환접수</option>
										<option value="12">교환발송완료</option>
										<option value="11">교환불가</option>
									</c:when>
									<c:when test="${dto.orderState==10}">
										<option value="12">교환발송완료</option>
										<option value="11">교환불가</option>
									</c:when>
									<c:when test="${dto.orderState==13}">
										<option value="14">반품접수</option>
										<option value="15">반품완료</option>
										<option value="16">반품불가</option>
									</c:when>
									<c:when test="${dto.orderState==14}">
										<option value="15">반품완료</option>
										<option value="16">반품불가</option>
									</c:when>
									<c:otherwise>
										<c:if test="${dto.orderState==5}">
											<option value="2">자동구매확정</option>
										</c:if>
										<c:if test="${dto.orderState!=5}">
											<option value="3">판매취소</option>
										</c:if>
										<option value="19">기타</option>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col p-1">
							<textarea class="form-control" name="stateMemo" placeholder="상태 메시지 입력"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col p-1 text-end">
							<input type="hidden" name="item_code" value="${dto.item_code}">
							<input type="hidden" name="orderDetailNum" value="${dto.orderDetailNum}">
							<input type="hidden" name="productNum" value="${dto.item}">
							<input type="hidden" name="usedSaved" value="${dto.usedSaved}">
							<input type="hidden" name="payment" value="${dto.payment}">
							<input type="hidden" name="userId" value="${dto.userId}">
							<input type="hidden" name="order_Date" value="${dto.order_Date}">
							<input type="hidden" name="optionCount" value="${dto.optionCount}">
							<input type="hidden" name="detailNum" value="${dto.detailNum}">
							<input type="hidden" name="detailNum2" value="${dto.detailNum2}">
							<input type="hidden" name="qty" value="${dto.totalQty}">
							<input type="hidden" name="productMoney" value="${dto.productMoney}">
							<input type="hidden" name="savedMoney" value="${dto.savedMoney}">
							<input type="hidden" name="cancelAmount" value="${dto.cancelAmount}">

							<button type="button" class="btn btn-light btnDetailStateUpdateOk"> 변경 </button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function detailStateUpdate() {
	$('#detailStateUpdateDialogModal').modal('show');
}

$(function(){
	$('.btnDetailStateUpdateOk').click(function(){
		const f = document.detailStateForm;
		if(! f.stateMemo.value.trim()) {
			alert('상태 메시지를 등록하세요');
			f.stateMemo.focus();
			return false;
		}
		
		let requestParams = $('form[name=detailStateForm]').serialize();
		let url = '${pageContext.request.contextPath}/artist/orderManage/updateChangeState';
		
		const fn = function(data) {
			console.log("data"+data)
			let reloadUrl = '${pageContext.request.contextPath}/artist/orderManage/detailManage/${tebNum}/${dto.item_code}?${query}';
			console.log(reloadUrl)
			location.href = reloadUrl;
		};
	
		ajaxRequest(url, 'post', requestParams, 'json', fn);
	});
});

function listDetailState() {
	// orderstate도 넘겨줘야하는데
	$('.detailState-list').empty();
	$('#detailStateInfoDialogModal').modal('show');
	
	let orderState = '${dto.orderState}';
	let itemCode = '${dto.item_code}';
	let requestParams = 'orderState=' + orderState+'&item_code='+itemCode;
	let url = '${pageContext.request.contextPath}/artist/orderManage/listDetailState';

		console.log("1234")
	const fn = function(data) {
	 console.log(data)

		let out = '';
		for(let item of data.list) {
			out += '<tr>';
			out += '  <td>' + item.ID + '</td>';
			out += '  <td>' + item.STATE + '</td>';
			out += '  <td>' + item.NICKNAME + '</td>';
			out += '  <td>' + item.REQUEST_DATE + '</td>';
			out += '  <td align="left">' + item.REQUEST_REASON + '</td>';
			out += '</tr>';
		}
		if(out) {
			$('.detailState-list').append(out);
		}
	};
	
	ajaxRequest(url, 'get', requestParams, 'json', fn);
}

$(function(){
	$('#detailStateInfoDialogModal').on('hide.bs.modal', function () {
		$('button, input, select, textarea, div').each(function () {
	        $(this).blur();
	    });
	});
	
	$('#detailStateUpdateDialogModal').on('hide.bs.modal', function () {
		$('button, input, select, textarea, div').each(function () {
	        $(this).blur();
	    });
	});
});	
</script>


</body>
</html>