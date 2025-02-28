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
	max-width: 1200px;
}
.clickable { cursor: pointer; }


</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/boot-board.css" type="text/css">
</head>
<body>
<header>
<jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>
</header>
<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>
<main>

	<div class="wrapper">
		<div class="body-container">
		    <div class="body-title">
				<h3><i class="bi bi-app"></i> ${title} </h3>
		    </div>
		    
		    <div class="body-main">

		        <div class="row board-list-header">
					<div class="col-auto me-auto">
		            	${dataCount}개(${page}/${total_page} 페이지)
					</div>
		            <div class="col-auto">&nbsp;</div>
		        </div>
	
				<table class="table table-hover board-list align-middle">
					<thead class="table-light">
						<tr>
							<th width="160">주문번호</th>
							<th width="100">주문자</th>
							<th>상품명</th>
							<th width="130">옵션</th>
							<th width="75">주문수량</th>
							<th width="100">주문총금액</th>
							<th width="110">주문상태</th>
							<th width="100">주문일자</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="clickable" 
									onclick="location.href='${pageContext.request.contextPath}/artist/orderManage/detailManage/${tebNum}/${dto.item_code}?${query}';">
								<td>${dto.item_code}</td>
								<td>${dto.nickName}</td>
								<td class="text-start">${dto.item}</td>
								<td class="text-start">${dto.options}</td>
								<td>${dto.totalQty}</td>
								<td><fmt:formatNumber value="${dto.orderPrice}"/></td>
								<td>${dto.orderStateInfo}</td>
								<td>${fn:substring(dto.order_Date, 0, 10)}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
	
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 주문정보가 없습니다." : paging}
				</div>
	
				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/artist/order/detailManage/${tebNum}';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
					</div>
					<div class="col-6 text-center">
						<form class="row" name="searchForm">
							<div class="col-auto p-1">
								<select name="schType" class="form-select">
									<option value="item_code" ${schType=="item_code"?"selected":""}>주문번호</option>
									<option value="nickName" ${schType=="nickName"?"selected":""}>주문자</option>
									<option value="order_Date" ${schType=="orderDate"?"selected":""}>주문일자</option>
									<option value="item" ${schType=="item"?"selected":""}>상품이름</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="kwd" value="${kwd}" class="form-control">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
							</div>
						</form>
					</div>
					<div class="col text-end">
						&nbsp;
					</div>
				</div>

			</div>
		</div>		
	</div>
</main>

<script type="text/javascript">
// 검색
window.addEventListener('load', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
	    if(evt.key === 'Enter') {
	    	evt.preventDefault();
	    	
	    	searchList();
	    }
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	f.kwd.value = f.kwd.value.trim();
	
	const formData = new FormData(f);
	let requestParams = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/order/detailManage/${tebNum}';
	location.href = url + '?' + requestParams;
}
</script>


</body>
</html>