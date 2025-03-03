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
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main style="margin-top: 200px;">
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
					<img src="" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
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
		$(function(){
			$('.toggle-input').change(function(){
				let state = $(this).is(':checked');
				
				if(state){
					location.href='${pageContext.request.contextPath}/artist/main/list';
				}else {
					location.href= '${pageContext.request.contextPath}/';
				}
				
			});
		});
	</script>
</body>
</html>
