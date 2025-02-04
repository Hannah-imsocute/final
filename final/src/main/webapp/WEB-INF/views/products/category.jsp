<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boooooot</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
	<div class="container body-container">
	    <div class="inner-page">
	
			<h5 class="fw-semibold mt-3">${categoryName}카테고리 이름</h5>
			<hr>
			
			<div class="row px-4">
				<c:forEach var="dto" items="${list}" varStatus="status">
					<div class="col-md-4 col-lg-3 mt-4">
						<div class="border rounded product-item" data-productNum="${dto.productNum}">
							<img class="thumbnail-img" src="${pageContext.request.contextPath}/uploads/products/${dto.thumbnail}">
							<div class="p-2">
								<div class="text-truncate fw-semibold pb-1">
									${dto.productName}작품 이름
								</div>
								<div class="pb-1">
									<c:if test="${dto.discountRate != 0}">
								  		<label class="fs-5 pe-2 text-danger">${dto.discountRate}%</label>
									</c:if>
								  	<label class="fs-5 pe-2 fw-semibold"><fmt:formatNumber value="${dto.salePrice}"/>200,000원</label>
									<c:if test="${dto.discountRate != 0}">
								  		<label class="fs-6 fw-light text-decoration-line-through"><fmt:formatNumber value="${dto.price}"/>180,000원</label>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			
			<div class="page-navigation mt-5">
				${dataCount == 0 ? "등록된 상품이 없습니다." : paging}
			</div>
	
		</div>
	</div>
</main>

<script type="text/javascript">
$(function(){
	$('.product-item').mouseenter(function(e){
		// 마우스가 요소에 들어갈 때
		// 해당 요소에 마우스가 처음 들어갔을 때만 발생하고, 자식 요소에 마우스가 올려져도 이벤트가 발생하지 않는다.
		$(this).find('img').css('transform', 'scale(1.05)');
		$(this).find('img').css('overflow', 'hidden');
		$(this).find('img').css('transition', 'all 0.5s');
	});
	
	$('.product-item').mouseleave(function(e){
		// 마우스가 요소에서 나갈 때
		$(this).find('img').css('transform', 'scale(1)');
		$(this).find('img').css('transition', 'all 0.5s');
	});
});

$(function(){
	$('.product-item').click(function(){
		let productNum = $(this).attr('data-productNum');
		let url = '${pageContext.request.contextPath}/products/' + productNum;
		location.href = url;
	});
});
</script>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>
</html>