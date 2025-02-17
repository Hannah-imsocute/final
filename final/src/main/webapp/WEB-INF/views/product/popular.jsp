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
						<li data-categoryName="food">식품 ▾
							<ul class="sub-menu">
								<li data-categoryName="bakery"><a href="#">베이커리/전통간식</a></li>
								<li data-categoryName="beverage"><a href="#">음료/주류</a></li>
								<li data-categoryName="dish"><a href="#">요리/간편식</a></li>
								<li data-categoryName="nongsusan"><a href="#">농수산품</a></li>
							</ul>
						</li>

						<li data-categoryName="fashion">패션 ▾
							<ul class="sub-menu">
								<li data-categoryName="clothing"><a href="#">의류</a></li>
								<li data-categoryName="jewelry"><a href="#">주얼리</a></li>
								<li data-categoryName="fashion-accessory"><a href="#">패션잡화</a></li>
							</ul>
						</li>
						
						<li data-categoryName="living">리빙 ▾
							<ul class="sub-menu">
								<li data-categoryName="camping"><a href="#">캠핑</a></li>
								<li data-categoryName="furniture"><a href="#">가구</a></li>
								<li data-categoryName="home-decor"><a href="#">홈데코</a></li>
								<li data-categoryName="kitchenware"><a href="#">주방용품</a></li>
								<li data-categoryName="bathroom"><a href="#">욕실용품</a></li>
							</ul>
						</li>
						
						<li data-categoryName="stationery">문구/기타용품 ▾
							<ul class="sub-menu">
								<li data-categoryName="case"><a href="#">케이스</a></li>
								<li data-categoryName="stationery"><a href="#">문구용품</a></li>
								<li data-categoryName="party-supplies"><a href="#">파티용품</a></li>
								<li data-categoryName="car-accessory"><a href="#">차량용품</a></li>
							</ul>
						</li>
						
						<li data-categoryName="beauty">뷰티 ▾
							<ul class="sub-menu">
								<li data-categoryName="skincare"><a href="#">스킨케어</a></li>
								<li data-categoryName="hair-body-cleansing"><a href="#">헤어/바디/클렌징</a></li>
								<li data-categoryName="perfume"><a href="#">향수</a></li>
								<li data-categoryName="makeup"><a href="#">메이크업</a></li>
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
	            <h5 class="main-top-name">인기작품별 메인페이지입니다</h5>
	            <div class="count">
	              <p class="dataCount">${dataCount}개<p>
	            </div>
	            <br>
	            <div class="product-list" id="product-list" data-page="0" data-totalPage="0" >
	                <!-- 제품 항목들이 동적으로 로드됩니다 -->
	                
	           </div>
	            <button id="loadMore" data-page ="${page}" >작품 더보기</button>
	        </div>
	
		</div>
	</main>
</body>

<script type="text/javascript">

// 전역변수 설정
var total_page_count = 0;
var contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
	/* 1. 왼쪽 메뉴바 클릭 이벤트 */

    $('.left-menu ul li').on('click', function(event) {
        event.stopPropagation(); // 부모 요소로 이벤트 전파 방지
        $('#loadMore').prop("disabled", false).text("작품 더보기"); // 작품더보기 버튼 초기화
        
        var $this = $(this);
        var categoryName = $this.attr('data-categoryName'); // 선택한 카테고리 가져오기
        
        var topName = $this.find('a').text().trim(); // 카테고리명 가져오기
        var page = parseInt($this.attr('data-page'), 10); // 페이지 가져오기

        if(isNaN(page)){
        	page = 1;
        	$this.attr('data-page', page)
        }



        $.ajax({
            url: '/product/byPopularWorks',  // Spring Boot 서버 엔드포인트
            method: 'GET',
            data: { categoryName: categoryName, page:page },  // 요청 데이터
            dataType: 'json',
            beforeSend: function() {
                $('#product-list').empty();  // AJAX 요청 전 기존 리스트 초기화
            },
            success: function(response) {
                var productList = $('#product-list');
             
                 // 메인 패널의 제목 변경
                $('.main-top-name').text(topName);
                $('.dataCount').text(response.dataCount+"개");
                
                // 응답 데이터가 배열인지 확인 후 처리	
                if (response && Array.isArray(response.popularList)) {
                	$.each(response.popularList, function(arrayIndex, arrayKey) {
                	    console.log("Processing arrayKey:", arrayKey);
                	  
                	    // 빈 HTML을 먼저 추가
                	    var emptyHtml = `
                	        <div class="border rounded product-box">
                	            <div class="product-info">
                	                <div class="product-thumbnail">
                	                	<img class="thumbnail-img">
                	                <div>
                	                <div class="product-brandName"></div>
                	                <div class="product-item"></div>
                	                <div class="product-price"></div>
                	                <div class="product-discount"></div>
                	                <div class="product-salePrice"></div>
                	                <div class="product-productCode"></div>
                	            </div>
                	        </div>`;
                	    var $productBox = $(emptyHtml);  // jQuery 객체로 변환
                	    
                	    // 데이터를 추가
                	    $productBox.find('.thumbnail-img').attr("src",contextPath + "/uploads/product/" + arrayKey.thumbnail);
                	    $productBox.find('.product-brandName').text(arrayKey.brandName);
                	    $productBox.find('.product-item').text(arrayKey.item);
                	    $productBox.find('.product-price').text(arrayKey.price.toLocaleString() + " 원");
                	    $productBox.find('.product-discount').text(arrayKey.discount + "%");
                	    $productBox.find('.product-salePrice').text(arrayKey.salePrice.toLocaleString() + " 원");
                	    $productBox.find('.product-productCode').attr("data-productCode", arrayKey.productCode);

                	    // 최종적으로 productList에 추가
                	    productList.append($productBox);
                	    
                	    page_total_count = arrayKey.total_page; // 전역변수에 전체페이지갯수 담아두기 
                	    
                	})
                } else {
                    console.warn('올바른 상품 데이터가 아닙니다.');
                }

            },
            error: function(xhr, status, error) {
                alert('상품 정보를 불러오는 데 실패했습니다.');
                console.error(error, xhr.responseText);
            }
        });
    });

    /* 2. 컨텐츠 하단 작품 더보기 클릭 이벤트 */
    $('#loadMore').on('click', function(event) {
       event.stopPropagation(); // 부모 요소로 이벤트 전파 방지
            var $this = $(this);
            var categoryName = $this.attr('data-categoryName'); // 선택한 카테고리 가져오기
         
            if (!categoryName || categoryName.trim() === "") {
                categoryName = "bakery"; // 기본값 설정 (필요에 따라 변경)
                $this.attr('data-categoryName', categoryName); // 버튼 속성 업데이트
            }      
          
            var page = parseInt($this.attr('data-page'), 10);
            	if(isNaN(page)){
            	page = 2;
            	$this.attr('data-page', page)
            }

            $.ajax({
                url: '/product/byPopularWorks/',  // Spring Boot 서버 엔드포인트
                method: 'GET',
                /* 요청 데이터 셋팅 */
                data: { categoryName: categoryName
                	  , page: page }, 
                dataType: 'json',
				/* api 호출전 데이터 체크로직 */
                beforeSend: function (xhr, settings){
                	if(page >= total_page_count){ 
                		 alert("마지막 페이지입니다."); // 마지막 페이지 알림
                         $this.prop("disabled", true).text("마지막 페이지"); // 버튼 비활성화
                         return false;
                	}
                },
                success: function(response) {
                    var productList = $('#product-list');

                    // 응답 데이터가 배열인지 확인 후 처리
                    if (response && Array.isArray(response.popularList)) {
                        $.each(response.popularList, function(arrayIndex, arrayKey) {
                        	var emptyHtml = `
                     	       <div class="border rounded product-box">
                     	           <div class="product-info">
                     	               <div class="product-thumbnail">
              	                	     <img class="thumbnail-img">
              	                       <div>
                     	               <div class="product-brandName"></div>
                     	               <div class="product-item"></div>
                     	               <div class="product-price"></div>
                     	               <div class="product-discount"></div>
                     	               <div class="product-salePrice"></div>
                     	               <div class="product-productCode"></div>
                     	           </div>
                     	       </div>`;
                     		var $productBox = $(emptyHtml);  // jQuery 객체로 변환
                     	    $productBox.find('.thumbnail-img').attr("src",contextPath + "/uploads/product/" + arrayKey.thumbnail);
                     		$productBox.find('.product-brandName').text(arrayKey.brandName);
                     		$productBox.find('.product-item').text(arrayKey.item);
                     		$productBox.find('.product-price').text(arrayKey.price.toLocaleString() + " 원");
                     		$productBox.find('.product-discount').text(arrayKey.discount + "%");
                     		$productBox.find('.product-salePrice').text(arrayKey.salePrice.toLocaleString() + " 원");
                     		$productBox.find('.product-productCode').attr("data-productCode", arrayKey.productCode);
                     		productList.append($productBox);
                 	    });
                        
	                    total_page_count = response.total_page; // DB 기준 갱신된 전체페이지 갯수를 전역변수에 갱신
	                    
	                    $this.attr('data-page', page + 1); // 페이지 갯수 증가
	                    
                    } else {
                        console.warn('올바른 상품 데이터가 아닙니다.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('상품 정보를 불러오는 데 실패했습니다.');
                    console.error(error, xhr.responseText);
                }
       
      		 });
       });
});


/* 3. 컨텐츠 클릭 시 상세보기 이벤트 */
$(document).ready(function() {
	$('.product-list').on('click', '.product-box', function(){
		let productCode = $(this).find('.product-productCode').attr('data-productCode');
		 alert(productCode)
		 if (!productCode) {
		        console.warn("상품 코드가 없습니다.", $(this).attr('data-productCode'));
		        alert("상품 코드가 없습니다.");
		        return;
		 }
		 // 페이지 이동 (쿼리스트링 방식으로 productCode 전달)
		
		 let url = '${pageContext.request.contextPath}/product/'+productCode;
		 location.href = url;

	});
});


</script>
</html>




