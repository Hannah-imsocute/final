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

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
		<div class="container">
			<!-- 왼쪽 패널 -->
			<div class="left-panel">
				<div class="left-menu">
					<h3>전체 카테고리</h3>
					<ul>
						<li>식품 ▾
							<ul class="sub-menu">
								<li><a href="#">   베이커리/떡/간식</a></li>
								<li><a href="#">   음료/주류</a></li>
								<li><a href="#">   요리/간편식</a></li>
								<li><a href="#">   농수산품</a></li>
							</ul>
						</li>

						<li>패션 ▾
							<ul class="sub-menu">
								<li><a href="#">의류</a></li>
								<li><a href="#">주얼리</a></li>
								<li><a href="#">패션잡화</a></li>
							</ul>
						</li>

						<li>리빙 ▾
							<ul class="sub-menu">
								<li><a href="#">캠핑</a></li>
								<li><a href="#">가구</a></li>
								<li><a href="#">홈데코</a></li>
								<li><a href="#">주방용품</a></li>
								<li><a href="#">욕실용품</a></li>
							</ul>
						</li>

						<li>문구/기타용품 ▾
							<ul class="sub-menu">
								<li><a href="#">케이스</a></li>
								<li><a href="#">문구용품</a></li>
								<li><a href="#">파티용품</a></li>
								<li><a href="#">차량용품</a></li>
							</ul>
						</li>

						<li>뷰티 ▾
							<ul class="sub-menu">
								<li><a href="#">스킨케어</a></li>
								<li><a href="#">헤어/바디/클렌징</a></li>
								<li><a href="#">향수</a></li>
								<li><a href="#">메이크업</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>

			<!-- 메인 패널 -->
			<div class="main-panel">
				<h2>식품</h2>
				<br>
				<h3>${categoryName}</h3>
				<div class="product-list">
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
				</div>
				<button>작품 더보기</button>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>
</html>
