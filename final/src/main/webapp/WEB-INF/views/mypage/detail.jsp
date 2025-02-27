<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 내역 상세</title>

    <!-- 공통 CSS/JS 등 헤더 리소스 include -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Font Awesome (아이콘: 별점, 장바구니 등) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>

    <style>
        /************************************************************
         * 1) Global Reset & Base Style
         ************************************************************/
        header { position: relative !important; }
        * { box-sizing: border-box; }
        body, html {
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
            background-color: #fff;
            color: #333;
            line-height: 1.6;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            color: #fa7c00;
        }

        /************************************************************
         * 2) Main Container (사이드바 + 콘텐츠)
         ************************************************************/
        .main-container {
            margin-top: 10px; /* 헤더 높이 대비 */
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
            padding: 0 20px;
        }
        .content {
            flex: 1;
            background-color: #fff;
            margin-left: 20px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .content h2 {
            margin-top: 0;
            font-size: 1.4rem;
            margin-bottom: 30px;
            font-weight: 700;
            color: #333;
        }

        /************************************************************
         * 3) 주문 내역 상세 리스트 스타일
         ************************************************************/
        .list-box.detail-orders {
            border: none;
            margin-bottom: 20px;
        }
        .list-box.detail-orders ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .order-item-container {
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .order-header2 {
            display: flex;
            justify-content: space-between;
        }
        .order-date {
            font-size: 0.95rem;
            font-weight: 900;
            color: #666;
        }
        .order-code {
            font-size: 0.88rem;
            color: #100f0f;
            font-weight: 900;
        }
        .brand-name {
            font-size: 0.9rem;
            color: #fa7c00;
            font-weight: 900;
        }
        .order-body {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }
        .product-image {
            width: 100px;
            height: 100px;
            border-radius: 4px;
            object-fit: cover;
            margin-right: 16px;
            flex-shrink: 0;
        }
        .product-info {
            flex: 1; /* 가변 너비 */
            min-width: 0;
        }
        .product-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }
        .product-price {
            font-size: 1.1rem;
            font-weight: bold;
            color: #fa7c00;
            margin-bottom: 4px;
        }
        .shipping-fee {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 8px;
        }

        /************************************************************
         * 4) 버튼/아이콘 스타일
         ************************************************************/
        .product-actions {
            margin-top: 10px;
        }
        .product-actions button,
        .btn-inquiry {
            display: inline-block;
            margin-right: 6px;
            margin-bottom: 6px;
            padding: 6px 12px;
            font-size: 0.85rem;
            color: #555;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .product-actions button:hover,
        .btn-inquiry:hover {
            background-color: #f0f0f0;
            color: #fa7c00;
        }
        .cart-icon {
            margin-left: 16px;
            font-size: 24px;
            color: #fa7c00;
            cursor: pointer;
            transition: color 0.3s;
        }
        .cart-icon:hover {
            color: #e26d00;
        }
        .empty-msg {
            text-align: center;
            color: #999;
        }
        /* 주문상세 링크를 감싸는 영역 */
        .detail-button-wrap {
            text-align: right;
            margin-bottom: 5px;
            color: #e26d00;
        }

        /************************************************************
         * 5) 페이징 스타일 (화살표, 번호)
         ************************************************************/
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin: 2rem 0;
            padding: 0;
            list-style: none;
        }
        .pagination li a {
            display: inline-block;
            width: 2.5rem;
            height: 2.5rem;
            line-height: 2.5rem;
            text-align: center;
            font-size: 1rem;
            color: #555;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 50%;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.2s ease;
        }
        .pagination li a:hover {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            transform: scale(1.1);
        }
        .pagination li.active a {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            transform: scale(1.1);
        }
        .pagination li.disabled a {
            opacity: 0.5;
            pointer-events: none;
        }
        .pagination li.arrow a {
            font-size: 1.2rem;
        }

        .home-button {
            display: block;
            width: 130px;
            margin: 30px auto 0 auto;
            padding: 5px 0;
            text-align: center;
            font-size: 1rem;
            font-weight: 700;
            color: #fff;
            background-color: #fa7c00;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s, transform 0.2s;
            cursor: pointer;
        }

        /************************************************************
         * 6) 모달 디자인 (리뷰, 문의, 교환/반품)
         ************************************************************/
        /* 공통 모달 배경 */
        .modal {
            display: none; /* 기본 감춤 */
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            padding-top: 5%;
        }
        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 40px 30px;
            border-radius: 10px;
            width: 95%;
            max-width: 650px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.25);
            position: relative;
        }
        .modal-content .close {
            color: #aaa;
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-content .close:hover,
        .modal-content .close:focus {
            color: #000;
        }

        /* 리뷰 작성 모달 */
        #writeReviewModal { /* .modal 공통 사용 */ }
        #writeReviewModal .modal-content h3 {
            margin-top: 0;
            margin-bottom: 15px;
        }
        /* 상품 정보 영역 */
        #reviewProductInfo {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        #reviewProductInfo img {
            max-width: 120px;
            border-radius: 8px;
        }
        #reviewProductInfo span {
            font-weight: bold;
            font-size: 1.2rem;
        }
        /* 별점 */
        .star-rating {
            direction: rtl;
            font-size: 1.8rem;
            display: inline-block;
            padding: 10px 0;
        }
        .star-rating input[type="radio"] {
            display: none;
        }
        .star-rating label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input[type="radio"]:checked ~ label {
            color: #fa7c00;
        }
        /* textarea */
        textarea {
            width: 100%;
            height: 150px;
            padding: 12px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: none; /* 요청사항: resize 고정 */
            outline: none;
        }
        textarea:focus {
            border-color: #fa7c00;
        }
        /* 파일 미리보기 */
        .file-preview {
            margin-top: 10px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .file-preview img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        #selectFile {
            display: none;
        }
        .file-input-label {
            display: inline-block;
            padding: 8px 12px;
            font-size: 0.95rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
            cursor: pointer;
            margin-top: 15px;
        }
        #submitWriteReview {
            background-color: #fa7c00;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s;
            display: block;
        }
        #submitWriteReview:hover {
            background-color: #e26d00;
        }

        /* 상품 문의 모달 */
        #inquiryModal h3 {
            margin-top: 0;
            margin-bottom: 20px;
        }
        #inquiryForm label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
        }
        #inquiryForm input[type="text"],
        #inquiryForm textarea,
        #inquiryForm select {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        #inquiryForm textarea {
            resize: none; /* textarea resize 고정 */
            min-height: 100px;
        }
        /* 상품 문의 제출 버튼 디자인 */
        #submitInquiry {
            background-color: #fa7c00;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
            display: block; /* 원하는 경우 block으로 변경 */
        }
        #submitInquiry:hover {
            background-color: #e26d00;
        }

        /* 교환/반품 요청 모달 */
        #requestModal h3 {
            margin-top: 0;
            margin-bottom: 20px;
        }
        #requestForm select {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        #submitRequest {
            background-color: #fa7c00;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
        }

        .asktextArea {
            resize: none; /* 추가적으로 class로 잡힌 부분도 고정 */
        }

        /************************************************************
         * 7) 반응형 스타일 (미디어 쿼리)
         ************************************************************/
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                margin-top: 80px;
            }
            .content {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }
            .order-header,
            .order-body,
            .product-info {
                font-size: 0.9rem;
            }
            .pagination li a {
                width: 2rem;
                height: 2rem;
                line-height: 2rem;
                font-size: 0.9rem;
            }
        }
        @media (max-width: 480px) {
            .product-image { width: 80px; height: 80px; }
            .content { padding: 15px; }
        }
    </style>
</head>
<body>
<!-- header (고정) -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- main container -->
<div class="main-container">
    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

    <!-- Content -->
    <div class="content">
        <h2>주문 내역 상세</h2>

        <!-- 주문 내역 리스트 -->
        <div class="list-box detail-orders">
            <c:choose>
                <c:when test="${not empty ordersHistory}">
                    <ul>
                        <c:forEach var="order" items="${ordersHistory}">
                            <!-- 주문상세 이동 텍스트 링크 -->
                            <div class="detail-button-wrap">
                                <a href="${pageContext.request.contextPath}/mypage/orderDetail?orderCode=${order.orderCode}">
                                    주문상세 >
                                </a>
                            </div>

                            <li class="order-item-container">
                                <div class="order-header">
                                    <div class="order-header2">
                                        <span class="order-code">주문번호: ${order.orderCode}</span>
                                    </div>
                                    <span class="brand-name">${order.brandName}</span>
                                </div>
                                <div class="order-body">
                                    <img src="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}"
                                         class="product-image" />
                                    <div class="product-info">
                                        <div class="product-title">${order.productName}</div>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${order.netPay}" pattern="#,###" />원
                                        </div>
                                        <div class="shipping-fee">배송비 무료</div>
                                        <div class="product-actions">
                                            <!-- 반품 신청 버튼 -->
                                            <button class="btn-request" data-request-type="return"
                                                    data-item-code="${order.itemCode}" data-order-code="${order.orderCode}">
                                                반품신청
                                            </button>
                                            <!-- 교환 신청 버튼 -->
                                            <button class="btn-request" data-request-type="exchange"
                                                    data-item-code="${order.itemCode}" data-order-code="${order.orderCode}">
                                                교환신청
                                            </button>
                                            <!-- 리뷰 작성 (조건: reviewCount가 0이면) -->
                                            <c:if test="${order.reviewCount == 0}">
                                                <button class="btn-review"
                                                        data-product-code="${order.productCode}"
                                                        data-product-name="${order.productName}"
                                                        data-product-image="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}"
                                                        data-product-order="${order.orderCode}">
                                                    상품평 작성
                                                </button>
                                            </c:if>
                                            <!-- 신규: 상품 문의 버튼 -->
                                            <button type="button" class="btn-inquiry"
                                                    data-product-code="${order.productCode}">
                                                상품 문의
                                            </button>
                                        </div>
                                    </div>
                                    <!-- 장바구니 아이콘 -->
                                    <div class="cart-icon"
                                         data-product-code="${order.productCode}"
                                         data-price="${order.price}">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- 페이징 영역 -->
                    <ul class="pagination">
                        <li class="arrow ${page == 1 ? 'disabled' : ''}">
                            <a href="?page=${page - 1}">&lt;</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${total_page}">
                            <li class="${i == page ? 'active' : ''}">
                                <a href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="arrow ${page == total_page ? 'disabled' : ''}">
                            <a href="?page=${page + 1}">&gt;</a>
                        </li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="empty-msg">주문 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <button class="home-button" onclick="location.href='${pageContext.request.contextPath}/mypage/home'">
            홈으로 가기
        </button>
    </div>
</div>

<!-- footer -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- =============== [모달] 리뷰 작성 =============== -->
<div id="writeReviewModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeWriteReviewBtn">&times;</span>
        <h3>상품평 작성</h3>
        <form id="writeReviewForm"
              action="${pageContext.request.contextPath}/review/write"
              method="post"
              class="review-form"
              enctype="multipart/form-data">
            <!-- 상품 정보 영역 -->
            <div id="reviewProductInfo">
                <img id="reviewProductImage" src="" alt="상품 이미지">
                <span id="reviewProductName"></span>
            </div>
            <!-- 별점 입력 -->
            <label>별점</label>
            <div class="star-rating">
                <input type="radio" id="star5" name="starRate" value="5" />
                <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="star4" name="starRate" value="4" />
                <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="star3" name="starRate" value="3" />
                <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="star2" name="starRate" value="2" />
                <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="star1" name="starRate" value="1" />
                <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
            </div>
            <!-- 리뷰 내용 입력 -->
            <label for="reviewContent" style="display:none;">리뷰내용</label>
            <textarea id="reviewContent" name="content" placeholder="최소 10자를 입력하세요."></textarea>
            <!-- 파일 업로드 & 미리보기 -->
            <label for="selectFile" class="file-input-label">📁 파일 선택</label>
            <input type="file" id="selectFile" name="selectFile" multiple accept="image/*" />
            <div id="filePreview" class="file-preview"></div>
            <!-- hidden 필드 -->
            <input type="hidden" name="memberIdx" value="${sessionScope.member.memberIdx}">
            <input type="hidden" id="productCode" name="productCode" value="">
            <input type="hidden" id="productName" name="productName" value="">
            <input type="hidden" id="orderCode" name="orderCode" value="">
            <!-- 작성 버튼 -->
            <button type="button" id="submitWriteReview">작성완료</button>
        </form>
    </div>
</div>

<!-- =============== [모달] 상품 문의 =============== -->
<div id="inquiryModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeInquiryModalBtn">&times;</span>
        <h3>상품 문의</h3>
        <form id="inquiryForm"
              action="${pageContext.request.contextPath}/ask/submit"
              method="post"
              class="inquiry-form">
            <label for="subject">제목</label>
            <input type="text" id="subject" name="subject"
                   placeholder="문의 제목을 입력하세요." required />
            <label for="inquiryCategory">카테고리</label>
            <select id="inquiryCategory" name="category" required>
                <option value=0>카테고리 선택</option>
                <option value=1>제품정보</option>
                <option value=2>배송문의</option>
                <option value=3>교환/반품</option>
                <option value=4>기타</option>
            </select>
            <label for="inquiryContent">내용</label>
            <textarea id="inquiryContent" name="content" class="asktextArea"
                      placeholder="문의 내용을 입력하세요." required></textarea>
            <input type="hidden" name="memberIdx" value="${sessionScope.member.memberIdx}" >
            <input type="hidden" name="productCode" id="AskproductCode" value="" >
            <!-- 문의 제출 버튼 -->
            <button type="submit" id="submitInquiry">문의 제출</button>
        </form>
    </div>
</div>

<!-- =============== [모달] 교환/반품 요청 =============== -->
<div id="requestModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeRequestModalBtn">&times;</span>
        <h3 id="modalTitle">요청사항 선택</h3>
        <form id="requestForm">
            <select id="requestSelect"></select>
            <!-- 필요 시 추가 폼 항목 -->
            <input type="hidden" id="itemCode" name="itemCode" value="">
            <input type="hidden" id="orderCode" name="orderCode" value="">
            <button type="button" id="submitRequest">신청하기</button>
        </form>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){

        /* ====== 장바구니 아이콘 클릭 이벤트 ====== */
        $('.cart-icon').click(function (e) {
            e.preventDefault();
            var productCode = $(this).data('product-code');
            var price = $(this).data('price');
            let params = { productCode: productCode, quantity: 1, price: price };
            let url = "${pageContext.request.contextPath}/cart/add";
            $.ajax({
                url: url,
                type: "POST",
                data: params,
                dataType: "text",
                success: function(data){
                    alert('상품을 장바구니에 담았습니다.');
                },
                error: function(jqXHR) {
                    console.log(jqXHR.responseText);
                }
            });
        });

        /* ====== 리뷰 작성 모달 열기 ====== */
        $('.btn-review').click(function(){
            var productCode = $(this).data('product-code');
            var productName = $(this).data('product-name');
            var productImage = $(this).data('product-image');
            var orderCode = $(this).data('product-order');
            // 폼 hidden에 값 세팅
            $('#productCode').val(productCode);
            $('#productName').val(productName);
            $('#orderCode').val(orderCode);
            // 이미지, 제목
            $('#reviewProductImage').attr('src', productImage);
            $('#reviewProductName').text(productName);

            $('#writeReviewModal').show();
        });

        /* ====== 리뷰 모달 닫기 ====== */
        $('#closeWriteReviewBtn').click(function(){
            $('#writeReviewModal').hide();
        });
        // 모달 영역 바깥 클릭 시 닫기
        $(window).click(function(event) {
            if ($(event.target).is('#writeReviewModal')) {
                $('#writeReviewModal').hide();
            }
        });

        /* ====== 리뷰 작성 Ajax ====== */
        $('#submitWriteReview').click(function(){
            var content = $('#reviewContent').val().trim();
            if(content.length < 10) {
                alert("리뷰 내용은 최소 10자 이상 입력해야 합니다.");
                $('#reviewContent').focus();
                return;
            }
            var formData = new FormData($('#writeReviewForm')[0]);
            $.ajax({
                url: $('#writeReviewForm').attr('action'),
                type: $('#writeReviewForm').attr('method'),
                data: formData,
                dataType: 'json',
                contentType: false,
                processData: false,
                success: function(response) {
                    if(response.success) {
                        alert(response.message);
                        $('#writeReviewModal').hide();
                        $('#writeReviewForm')[0].reset();
                        $('#filePreview').empty();
                    } else {
                        alert("리뷰 등록 실패: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert("리뷰 등록 실패: " + error);
                }
            });
        });

        /* ====== 파일 미리보기 ====== */
        $('#selectFile').on('change', function(){
            $('#filePreview').empty();
            var files = this.files;
            if(files){
                $.each(files, function(index, file){
                    var reader = new FileReader();
                    reader.onload = function(e){
                        var img = $('<img>').attr('src', e.target.result);
                        $('#filePreview').append(img);
                    };
                    reader.readAsDataURL(file);
                });
            }
        });

        /* ====== 상품 문의 모달 열기 ====== */
        $('.btn-inquiry').click(function(){
            var productCode = $(this).data('product-code');
            $('#AskproductCode').val(productCode);
            $('#inquiryModal').show();
        });
        $('#closeInquiryModalBtn').click(function(){
            $('#inquiryModal').hide();
        });
        $(window).click(function(event) {
            if ($(event.target).is('#inquiryModal')) {
                $('#inquiryModal').hide();
            }
        });

        /* ====== 교환/반품 모달 ====== */
        var returnOptions = '<option value="">요청사항 선택</option>'
            + '<option value="불량">상품 불량</option>'
            + '<option value="변심">단순 변심</option>'
            + '<option value="분실">배송된 장소에 박스가 분실됨</option>'
            + '<option value="오배송">오배송</option>';
        var exchangeOptions = '<option value="">요청사항 선택</option>'
            + '<option value="사이즈">사이즈 교환</option>'
            + '<option value="색상">색상 교환</option>'
            + '<option value="모델">다른 모델 교환</option>';

        $('.btn-request').click(function(e){
            e.preventDefault();
            var requestType = $(this).data('request-type');
            var orderCode = $(this).data('order-code');
            var itemCode = $(this).data('item-code');
            $('#itemCode').val(itemCode);
            $('#orderCode').val(orderCode);
            if(requestType === 'return'){
                $('#modalTitle').text('반품 요청사항 선택');
                $('#requestSelect').html(returnOptions);
            } else if(requestType === 'exchange'){
                $('#modalTitle').text('교환 요청사항 선택');
                $('#requestSelect').html(exchangeOptions);
            }
            $('#requestModal').show();
        });
        $('#closeRequestModalBtn').click(function(){
            $('#requestModal').hide();
        });
        $(window).click(function(event) {
            if ($(event.target).is('#requestModal')) {
                $('#requestModal').hide();
            }
        });

        /* ====== 교환/반품 요청 Ajax 예시 ====== */
        $('#submitRequest').click(function(){
            var selectedOption = $('#requestSelect').val();
            if(!selectedOption){
                alert("요청사항을 선택해주세요.");
                return;
            }
            alert("요청이 접수되었습니다: " + selectedOption);
            $('#requestModal').hide();
        });

        /* ====== 상품 문의 제출 시 알림 (테스트용) ====== */
        $('#submitInquiry').click(function () {
            alert('상품 문의가 등록되었습니다.');
        });
    });
</script>
</body>
</html>
