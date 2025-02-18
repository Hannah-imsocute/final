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

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
                	<c:forEach var="vo" items="${listFile}">
                		<div class="thumbnail">
                    		<img src="${pageContext.request.contextPath}/uploads/product/${vo.imageFileName}">
                        </div>
                    </c:forEach>
                    <c:if test="${empty listFile}">
                          <p>추가 이미지가 없습니다.</p>
                   </c:if>
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
           		<div class="product-report">
           		   <button class="btn-product-report">신고하기></button>
           		</div>
            </div>
        </section>


        <section class="tabs">
          <div class="product-info-tab">
            <button class="tab-button" data-target=".product-detail-info"  >작품정보</button>
            <div class="product-detail-info" style="display: none"> </div>
         </div>   
            
          <div class="product-review-tab">  
            <button class="tab-button" data-target=".product-review">후기</button>  
            <div class="product-review" style="display: none">
            	 <!-- 리뷰가 동적으로 들어갑니다 -->
            	 
            </div>
          </div>
       </section>
       
       
	<!-- 후기글 신고 모달 -->
	<div class="report-modal-dialog" style="display: none;">
	    <p>리뷰 번호 : <span id="modal-reviewNum"></span></p>
	
	    <!-- 신고 사유 선택 -->
	    <label for="report-reason">신고 사유:</label>
	    <select id="report-reason">
	        <option value="spam">스팸 또는 광고</option>
	        <option value="offensive">부적절한 콘텐츠</option>
	        <option value="copyright">저작권 침해</option>
	        <option value="other">기타</option>
	    </select>
	
	    <!-- 상세 설명 -->
	    <label for="report-description">상세 내용:</label>
	    <textarea id="report-description" placeholder="자세한 내용을 입력해주세요."></textarea>
	
	    <!-- 신고 버튼 -->
	    <div class="modal-buttons">
	        <button id="submit-report">신고하기</button>
	        <button id="close-report">닫기</button>
	    </div>
	</div>


	<!-- 작품 신고 모달 -->
	<div class="productReport-modal-dialog" style="display: none;">
	    <p>리뷰 번호 : <span id="modal-reviewNum"></span></p>
	
	    <!-- 신고 사유 선택 -->
	    <label for="productReport-reason">신고 사유:</label>
	    <select id="productReport-reason">
	        <option value="spam">스팸 또는 광고</option>
	        <option value="offensive">부적절한 콘텐츠</option>
	        <option value="copyright">저작권 침해</option>
	        <option value="other">기타</option>
	    </select>
	
	    <!-- 상세 설명 -->
	    <label for="productReport-description">상세 내용:</label>
	    <textarea id="productReport-description" placeholder="자세한 내용을 입력해주세요."></textarea>
	
	    <!-- 신고 버튼 -->
	    <div class="modal-buttons">
	        <button id="submit-productReport">신고하기</button>
	        <button id="close-productReport">닫기</button>
	    </div>
	</div>
        
        
    </main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>


<script type="text/javascript">

var contextPath = "${pageContext.request.contextPath}";

$(function(){
	$('.tab-button').click(function(){
		var targetClass = $(this).data('target');// data-target 값 가져오기
		var targetElement = $(targetClass); // 해당 div 찾기
		var tabsContainer = $(".tabs"); // tabs 전체 컨테이너 (동적으로 컨텐츠 영역 확장)
        var contextPath = "${pageContext.request.contextPath}";
        var productCode = "${dto.productCode}";
        
        //이미 보이는 상태라면 숨기기
        if(targetElement.is(":visible")){
        	targetElement.slideUp(function(){  //이미 보이는 상태라면 위로 올려서 숨기고
        	}); 
        	return;   //버튼 클릭 함수 종료
        }
        
        // 모든 탭 내용을 숨기고 tabs 높이 자동 조정
        // a 탭이 보여진 상태에서 b 탭을 눌렀을 때 내용 숨김 후 b탭을 표시하기 위함. 
        $('.product-detail-info, .product-review').slideUp();
        
        // 너비를 tabs와 동일하게 설정
        targetElement.css("width", tabsContainer.width() + "px");
        
        // 기존 내용 초기화 후 로딩 메시지 표시
        targetElement.slideDown(function () { // down될때 tabs 높이를 컨텐츠 영역의 높이만큼 자동 조절
            tabsContainer.css("height", targetElement.outerHeight() + 50 + "px");
        }); 
        
     // AJAX 요청 실행
        $.ajax({
        	url: contextPath + "/product/tabContent/" + productCode,
            type: "GET",
            data: { tab: targetClass, productCode: productCode}, // 어떤 탭인지 서버에 전달
            dataType: "json", // 응답 타입 설정 (HTML 또는 JSON)
            beforeSend: function() {
                $('.product-review').empty();  // AJAX 요청 전 기존 리스트 초기화
            },
            success: function (response) {
            	if(response.error){
            		targetElement.html("<p>" + response.error + "</p>");	
            	}
            	else if(targetClass ===".product-detail-info"){
            		targetElement.html("<p>" + response.dto.describe + "</p>" );
            	}
            	else if(targetClass ===".product-review"){
            		
            		var reviewContainer = $('.product-review');
                    
                    // 응답 데이터가 배열인지 확인 후 처리
                    if (response && Array.isArray(response.listReview)) {
                    	$.each(response.listReview, function(arrayIndex, arrayKey) {
                    		console.log(arrayKey.review_num);
                    		console.log(arrayKey.nickName);
                    		console.log(arrayKey.content);
                    		
		                    var emptyHtml = `
				                        	<div class="review-box"> 
				                        		<div class="review-report">
				                        		   <button class="btn-report">신고</button>
				                        		</div>
				                        		<ul>
				                        		    <li class = "review-num"></li>
				                        		    <li class = "review-author"></li>
				                        		    <div>
				                        		         <div class = "review-content"></div>
				                     	            </div>
				                     	        </ul>
				                     	    </div>`;
                    		var $productReviewBox = $(emptyHtml);
                    	
	                    	$productReviewBox.find('.btn-report').attr("data-review-num", arrayKey.review_num);
	                    	$productReviewBox.find('.review-num').text("댓글번호 :  " + arrayKey.review_num);
	                    	$productReviewBox.find('.review-author').text(" 작성자 :  " + arrayKey.nickName);
	                    	$productReviewBox.find('.review-content').text(arrayKey.content);
	                    	reviewContainer.append($productReviewBox);
	                    	
	                   		console.log("$productReviewBox :" + $productReviewBox);
                 	    });

                    } else {
                        console.warn('올바른 상품 데이터가 아닙니다.');
                    }
                    
            	}
            	
            	targetElement.css("width", tabsContainer.width() + "px");
                tabsContainer.css("height", targetElement.outerHeight() + 50 + "px");
            },
            error: function(){	
                targetElement.html("<p>데이터를 불러오던 중 오류가 발생했습니다 </p>"); // 응답 데이터를 해당 div에 삽입
            }
            
        });
    });
});



$.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
};

// 작품 후기글 신고하기
$(document).ready(function () {
    // 모달 생성
    const dlg = $(".report-modal-dialog").dialog({
        autoOpen: false,  
        modal: true,
        height: 450,
        width: 450,
        title: "작품 후기글 신고",
        close: function(event, ui) {
            // 모달이 닫힐 때 내용 초기화
            $("#report-reason").val("spam");
            $("#report-description").val("");
        }
    });

    // ✅ 신고 버튼 클릭 시 모달 열기
    $(".product-review").on('click', '.btn-report', function(event){
        event.stopPropagation();  // 이벤트 전파 방지

        console.log("reviewNum : " + $(this).attr("data-review-num"));
        $("#modal-reviewNum").text($(this).attr("data-review-num"));

        dlg.dialog("open");  // 모달 열기
    });

    // ✅ 닫기 버튼 기능
    $("#close-report").on("click", function () {
        dlg.dialog("close");
    });

    // ✅ 신고 버튼 기능 (데이터 처리 예시)
    $("#submit-report").on("click", function () {
        const reviewNum = $("#modal-reviewNum").text();
        const reason = $("#report-reason").val();
        const description = $("#report-description").val();

        console.log("신고 내용:", {
            reviewNum,
            reason,
            description
        });
        $.ajax({
	    	url: contextPath + "/product/reveiwReport",
	        type: "POST",
	        data: { 
	        	   reviewNum: reviewNum,    // 리뷰번호
	        	   categoryName: reason,     // 신고사유
	        	   content: description      // 상세내용
	        	   }, // 어떤 탭인지 서버에 전달
	     // dataType: "json", // 응답 타입 설정 (HTML 또는 JSON)
	        beforeSend: function(xhr, settings) {
	            
	        },
	        success: function(response) {
        		alert("신고가 접수되었습니다.");
	        },
            error: function(xhr, status, error) {
                alert('신고 접수를 실패했습니다.');
                console.error(error, xhr.responseText);
            }
	    });
        dlg.dialog("close");
    });
});


// 작품 신고하기
$(document).ready(function () {
    // 모달 생성
    const dlg = $(".productReport-modal-dialog").dialog({
        autoOpen: false,  
        modal: true,
        height: 450,
        width: 450,
        title: "작품신고",
        close: function(event, ui) {
            // 모달이 닫힐 때 내용 초기화
            $("#productReport-reason").val("spam");
            $("#productReport-description").val("");
        }
    });

    // ✅ 신고 버튼 클릭 시 모달 열기
    $(".product-report").on('click', '.btn-product-report', function(event){
        event.stopPropagation();  // 이벤트 전파 방지

        dlg.dialog("open");  // 모달 열기
    });

    // ✅ 닫기 버튼 기능
    $("#close-productReport").on("click", function () {
        dlg.dialog("close");
    });

    // ✅ 신고 버튼 기능 (데이터 처리 예시)
    $("#submit-productReport").on("click", function () {
    	const productCode = "${dto.productCode}";
        const reason = $("#productReport-reason").val();
        const description = $("#productReport-description").val();

        console.log("신고 내용:", {
        	productCode,
            reason,
            description
        });
        $.ajax({
	    	url: contextPath + "/product/productReport",
	        type: "POST",
	        data: {
	        	   productCode: productCode,    // 작품글번호
	        	   categoryName: reason,     // 신고사유
	        	   content: description      // 상세내용
	        	   }, 
	        // dataType: "json", // 응답 타입 설정 (HTML 또는 JSON)
	        beforeSend: function(xhr, settings) {
	            
	        },
	        success: function(response) {
        		alert("신고가 접수되었습니다.");
	        },
            error: function(xhr, status, error) {
                alert('신고 접수를 실패했습니다.');
                console.error(error, xhr.responseText);
            }
	    });
        dlg.dialog("close");
    });
});
	
	
</script>
</html>
