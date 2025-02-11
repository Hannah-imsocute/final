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
<link rel="stylesheet" href="/dist/css/product.css">

<style type="text/css">
body {
    font-family: Arial, sans-serif;
    margin-top: 200px;
  
}

.container {
    width: 80%;
    margin: auto;
    padding: 20px;
}

.product-detail {
    display: flex;
    gap: 20px;
}

.product-images {
    flex: 1;
}

.main-image {
    width: 100%;
    border: 1px solid #ddd;
}

.thumbnail-list {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}

.thumbnail {
    width: 60px;
    height: 60px;
    border: 1px solid #ddd;
    cursor: pointer;
}

.product-info {
    flex: 1;
}

.product-name {
    font-size: 24px;
    font-weight: bold;
}

.seller {
    font-size: 14px;
    color: #555;
}

.rating {
    margin: 10px 0;
}

.discount {
    color: red;
    font-size: 18px;
}

.original-price {
    text-decoration: line-through;
    color: #888;
    margin-left: 5px;
}

.price {
    font-size: 24px;
    font-weight: bold;
}

.promotion {
    background-color: #f8f8f8;
    padding: 10px;
    margin-top: 10px;
    border-radius: 5px;
}

.buttons {
    margin-top: 20px;
}

.btn {
    padding: 10px 15px;
    border: none;
    font-size: 16px;
    cursor: pointer;
    margin-right: 10px;
}

.cart-btn {
    background-color: #ff9800;
    color: white;
}

.buy-btn {
    background-color: #ff5722;
    color: white;
}

.inquiry-btn {
    display: block;
    margin-top: 10px;
    background-color: #007BFF;
    color: white;
    padding: 10px;
    text-align: center;
}

.tabs {
    margin-top: 30px;
    border-top: 2px solid #ddd;
    padding-top: 10px;
}

.tab {
    background: none;
    border: none;
    font-size: 16px;
    cursor: pointer;
    margin-right: 20px;
}

.tab.active {
    font-weight: bold;
    color: #ff6600;
}



</style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	
	<main class="container">
        <section class="product-detail">
            <div class="product-images">
                <img src="${pageContext.request.contextPath}/uploads/product/bread.jpg" class="main-image">
                <div class="thumbnail-list">
                    <img src="${pageContext.request.contextPath}/uploads/product/sample1.jpg" class="thumbnail">
                    <img src="${pageContext.request.contextPath}/uploads/product/sample2.jpg" class="thumbnail">
                    <img src="${pageContext.request.contextPath}/uploads/product/sample3.jpg" class="thumbnail">
                </div>
            </div>

            <div class="product-info">
                <h2 class="product-name">⭐ 건강한 전역을 위한 아이템</h2>
                <p class="seller">📢 판매자: <span>청정조아</span></p>
                <div class="rating">
                    ⭐⭐⭐⭐ 4.9 (312)
                </div>
                <p class="discount">18% <span class="original-price">15,104원</span></p>
                <h3 class="price">12,800원</h3>

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
