<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="/dist/css/layout/main.css">
<style type="text/css">
/* 커스텀 부트스트랩 그리드 컬럼: 한 줄에 5개 배치 */
.col-5-custom {
	flex: 0 0 20%;
	max-width: 20%;
}

.carousel-container {
	display: flex;
	justify-content: center;
	align-items: center;
	max-width: 1200px;
	margin: 0 auto;
}

.side-banner {
    width: 33%; /* 캐러셀 대비 동일한 크기 */
    height: 100%; /* 캐러셀 높이에 맞추기 */
    flex-shrink: 0;
    opacity: 0.6;
    overflow: hidden;
    border-radius: 20px;
    display: flex;
}
/* ⭐️ 불투명도 추가 */
.side-banner img {
    width: 100%;
    height: 100%; /* 부모 높이 맞추기 */
    max-height: 350px; /* 캐러셀과 동일한 최대 높이 */
    object-fit: cover; /* 비율 유지하면서 꽉 채우기 */
    opacity: 0.6; /* 불투명도 적용 (0.0 = 완전 투명, 1.0 = 완전 불투명) */
    transition: opacity 0.3s ease-in-out; /* 부드러운 효과 */
}

.carousel-wrapper {
	flex-grow: 1;
	max-width: 800px; /* 캐러셀 크기에 맞춤 */
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main style="margin-top: 200px;">

		<div class="carousel-container">
			<!-- 왼쪽 이미지 -->
			<div class="side-banner left">
				<img
					src="${pageContext.request.contextPath}/uploads/product/necklace.jpg"
					alt="Left Image">
			</div>

			<!-- 캐러셀 -->
			<div class="carousel-wrapper">
				<div id="carouselExampleIndicators" class="carousel slide">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img
								src="${pageContext.request.contextPath}/uploads/event/check.jpg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img
								src="${pageContext.request.contextPath}/uploads/event/new.jpg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img
								src="${pageContext.request.contextPath}/uploads/product/necklace.jpg"
								class="d-block w-100" alt="...">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
					</button>
				</div>
			</div>

			<!-- 오른쪽 이미지 -->
			<div class="side-banner right">
				<img
					src="${pageContext.request.contextPath}/uploads/product/necklace.jpg"
					alt="Right Image">
			</div>
		</div>


		<section class="best-items-section">
			<h2>BEST ITEMS</h2>
			<!-- container와 row를 추가해서 부트스트랩 그리드 활용 -->
			<div class="container">
				<div class="row">
					<c:forEach var="dto" items="${list}">
						<div class="col-5-custom">
							<div class="best-item"
								onclick="location.href='${pageContext.request.contextPath}/product/${dto.productCode}'">
								<div class="best-item-img">
									<img
										src="${pageContext.request.contextPath}/uploads/product/${dto.thumbnail}"
										alt="${dto.item}">
								</div>
								<p class="best-item-desc">${dto.item}</p>
								<button class="heart-btn">
									<i
										class="bi ${dto.liked == 'unliked' ? 'bi-heart' : 'bi-heart-fill'}"></i>
								</button>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- 작품 더보기 버튼 -->
			<button type="button" class="more-btn"
				onclick="location.href='${pageContext.request.contextPath}/product/popular'">작품
				더보기</button>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script type="text/javascript">
		$(function() {
			$('.toggle-input')
					.change(
							function() {
								let state = $(this).is(':checked');

								if (state) {
									location.href = '${pageContext.request.contextPath}/artist/main/list';
								} else {
									location.href = '${pageContext.request.contextPath}/';
								}

							});
		});
	</script>
</body>
</html>
