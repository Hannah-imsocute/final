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
<link rel="stylesheet" href="/dist/css/layout/main.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
		<div id="carouselExampleIndicators" class="carousel slide">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src=""
					class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src=""
					class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src=""
					class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>

	<section class="best-items-section">
		<h2>BEST ITEMS</h2>
		<div class="best-items-wrap">
			<!-- 상품 카드 #1 -->
			<div class="best-item">
				<div class="best-item-img"></div>
				<p class="best-item-desc">핸드메이드 케이스</p>
				<button class="heart-btn">♥</button>
			</div>

			<!-- 상품 카드 #2 -->
			<div class="best-item">
				<div class="best-item-img"></div>
				<p class="best-item-desc">핸드메이드 케이스</p>
				<button class="heart-btn">♥</button>
			</div>

			<!-- 상품 카드 #3 -->
			<div class="best-item">
				<div class="best-item-img"></div>
				<p class="best-item-desc">핸드메이드 케이스</p>
				<button class="heart-btn">♥</button>
			</div>

			<!-- 상품 카드 #4 -->
			<div class="best-item">
				<div class="best-item-img"></div>
				<p class="best-item-desc">핸드메이드 케이스</p>
				<button class="heart-btn">♥</button>
			</div>

			<!-- 상품 카드 #5 -->
			<div class="best-item">
				<div class="best-item-img"></div>
				<p class="best-item-desc">핸드메이드 케이스</p>
				<button class="heart-btn">♥</button>
			</div>
		</div>

		<!-- 작품 더보기 버튼 -->
		<button class="more-btn">작품 더보기</button>
	</section>
	
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>
</html>