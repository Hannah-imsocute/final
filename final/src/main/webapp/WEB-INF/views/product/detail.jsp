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
<link rel="stylesheet" href="/dist/css/productDetail.css">

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	
	<main class="container">
        <section class="product-detail">
            <div class="product-images">
                <img src="${pageContext.request.contextPath}/uploads/product/${dto.thumbnail}" class="main-image">
                <div class="thumbnail-list">
                    <img src="${pageContext.request.contextPath}" class="thumbnail">
                    <img src="${pageContext.request.contextPath}" class="thumbnail">
                    <img src="${pageContext.request.contextPath}" class="thumbnail">
                </div>
            </div>

            <div class="product-info">
                <p class="seller">📢 판매자: <span>${dto.brandName}</span></p>
                <h2 class="product-name">${dto.item}</h2>
                <div class="rating">
                    ⭐⭐⭐⭐ 4.9 (312)
                </div>
                <p class="discount">${dto.discount }% <span class="original-price">${fmdPrice}원</span></p>
                <h3 class="price">${fmdSalePrice}원</h3>
 
                <div class="promotion">
                    결제 혜택: 포토 리뷰 작성 시 500 포인트 적립
                    <br>똑딱똑딱 전상품 무료배송!
                </div>

                <div class="buttons">
                    <button class="btn cart-btn">장바구니</button>
                    <button class="btn buy-btn">바로구매</button>
                </div>

                <button class="btn inquiry-btn">📩 작품문의</button>
            </div>
        </section>

        <section class="tabs">
            <button class="tab active">작품정보</button>
            <button class="tab active">후기 </button>
        </section>
    </main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>



</html>
