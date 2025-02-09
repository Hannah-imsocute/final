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
                                <li data-categoryName="bakery"><a href="#">베이커리/전통간식</a></li>
								<li data-categoryName="beverage"><a href="#">음료/주류</a></li>
								<li data-categoryName="food"><a href="#">요리/간편식</a></li>
								<li data-categoryName="nongsusan"><a href="#">농수산품</a></li>
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
<!-- 			<div class="main-panel">
				<h5>카테고리별 메인페이지입니다</h5>
				<br>
				<div class="product-list">
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
					<div class="product-item">핸드메이드 케이스</div>
				</div>
				<button id="loadMore" >작품 더보기</button>
			</div>
 -->
	        <!-- 메인 패널 -->
	        <div class="main-panel">
	            <h5 class="main-top-name">카테고리별 메인페이지입니다</h5>
	            <br>
	            <div class="product-list" id="product-list">
	                <!-- 제품 항목들이 동적으로 로드됩니다 -->
	                
	            </div>
	            
	            <button id="loadMore">작품 더보기</button>
	        </div>
	        
	        
			
		</div>
	</main>
</body>

<script type="text/javascript">

$(document).ready(function() {
    $('.left-menu ul li').on('click', function(event) {
        event.stopPropagation(); // 부모 요소로 이벤트 전파 방지

        var $this = $(this);
        var categoryName = $this.attr('data-categoryName'); // 선택한 카테고리 가져오기
        var topName = $this.find('a').text().trim(); // 카테고리명 가져오기
        
        // .../product/category?categoryName=bakery
        $.ajax({
            url: '/product/category',  // Spring Boot 서버 엔드포인트
            method: 'GET',
            data: { categoryName: categoryName },  // 요청 데이터
            dataType: 'json',
            success: function(response) {
                var productList = $('#product-list');
                productList.empty();  // 기존 리스트 초기화

                // 메인 패널의 제목 변경
                $('.main-top-name').text(topName);

                // 응답 데이터가 배열인지 확인 후 처리
                if (response && Array.isArray(response.list)) {
                    $.each(response.list, function(arrayIndex, arrayKey) {
                    	alert("arrayKey.item : " + arrayKey.item );
                        productList.append('<div class="product-price">'     + arrayKey.price     + '</div>');
                        productList.append('<div class="product-discount">'  + arrayKey.discount  + '</div>');
                        productList.append('<div class="product-item">'      + arrayKey.item      + '</div>');
                        productList.append('<div class="product-salePrice">' + arrayKey.salePrice + '</div>');
                        productList.append('<div class="product-thumbnail">' + arrayKey.thumbnail + '</div>');
                    });
                } else {
                    console.warn('올바른 상품 데이터가 아닙니다.');
                }

                // 페이지네이션 정보 갱신
                //$('#pagination').html(response.paging || '');

                // 현재 페이지 및 카테고리 업데이트
                //window.currentPage = response.page || 1;
                //window.currentCategory = categoryName;
            },
            error: function(xhr, status, error) {
                alert('상품 정보를 불러오는 데 실패했습니다.');
                console.error(error, xhr.responseText);
            }
        });
    });
    
    /*
    $('#loadMore').on('click', function(event) {
    	alert("버튼 클릭 테스트");
        var productList = $('#product-list');
        productList.append('<div class="product-price">'     + "test"  + '</div>');
        productList.append('<div class="product-discount">'  + "test"  + '</div>');
        productList.append('<div class="product-item">'      + "test"  + '</div>');
        productList.append('<div class="product-salePrice">' + "test"  + '</div>');
        productList.append('<div class="product-thumbnail">' + "test"  + '</div>');
    	// ajax 호출
    });
    
    */
    $('#loadMore').on('click', function(event) {
        $('.left-menu ul li').on('click', function(event) {
            event.stopPropagation(); // 부모 요소로 이벤트 전파 방지

            var $this = $(this);
            var categoryName = $this.attr('data-categoryName'); // 선택한 카테고리 가져오기
            var page = "" ;
            
            $.ajax({
                url: '/product/category',  // Spring Boot 서버 엔드포인트
                method: 'GET',
                // 요청 데이터
                data: { categoryName: categoryName
                	  , page: page }, 
                dataType: 'json',
                success: function(response) {
                    var productList = $('#product-list');

                    // 응답 데이터가 배열인지 확인 후 처리
                    if (response && Array.isArray(response.list)) {
                        $.each(response.list, function(arrayIndex, arrayKey) {
                        	alert("arrayKey.item : " + arrayKey.item );
                            productList.append('<div class="product-price">'     + arrayKey.price     + '</div>');
                            productList.append('<div class="product-discount">'  + arrayKey.discount  + '</div>');
                            productList.append('<div class="product-item">'      + arrayKey.item      + '</div>');
                            productList.append('<div class="product-salePrice">' + arrayKey.salePrice + '</div>');
                            productList.append('<div class="product-thumbnail">' + arrayKey.thumbnail + '</div>');
                        });
                    } else {
                        console.warn('올바른 상품 데이터가 아닙니다.');
                    }

                    // 페이지네이션 정보 갱신
                    //$('#pagination').html(response.paging || '');

                    // 현재 페이지 및 카테고리 업데이트
                    //window.currentPage = response.page || 1;
                    //window.currentCategory = categoryName;
                },
                error: function(xhr, status, error) {
                    alert('상품 정보를 불러오는 데 실패했습니다.');
                    console.error(error, xhr.responseText);
                }
            });
        });
        
    });
    
    
});

</script>
</html>




