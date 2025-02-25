<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내 정보</title>
  <!-- 헤더 리소스 include -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <!-- Font Awesome 아이콘 (별, 장바구니 등) 사용 위해 CDN 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

  <style>
    /* ==================== Global Reset & Base Style ==================== */
    * { box-sizing: border-box; }
    header { position: relative !important; }
    body, html {
      margin: 0;
      padding: 0;
      font-family: "Noto Sans KR", sans-serif;
      background-color: #fff;
      color: #333;
    }
    a { text-decoration: none; color: inherit; }
    a:hover { text-decoration: none; color: #fa7c00; }

    /* ==================== Header (고정) ==================== */
    header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      z-index: 1000;
      background-color: #fff;
      border-bottom: 1px solid #e5e5e5;
    }

    /* ==================== Main Container ==================== */
    .main-container {
      margin-top: 10px;
      display: flex;
      max-width: 1200px;
      margin-left: auto;
      margin-right: auto;
      min-height: 80vh;
    }

    /* ==================== Sidebar & Content ==================== */
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
    }

    /* ==================== 포인트 & 쿠폰 영역 ==================== */
    .point-section {
      display: flex;
      border: 1px solid #eee;
      border-radius: 8px;
      overflow: hidden;
      margin-bottom: 20px;
    }
    .point-box {
      flex: 1;
      padding: 20px;
      background-color: #fafafa;
      text-align: center;
    }
    .point-box strong {
      display: block;
      margin-top: 8px;
      font-size: 1.2rem;
      color: #fa7c00;
    }

    /* ==================== 섹션 제목, "상세보기" 링크 ==================== */
    .section-title {
      font-size: 1rem;
      font-weight: 700;
      margin: 25px 0 15px 0;
      position: relative;
    }
    .section-more {
      position: absolute;
      right: 0;
      top: 0;
      font-size: 0.88rem;
      color: #fa7c00;
    }

    /* ==================== 최근 주문 내역 리스트 ==================== */
    .list-box.recent-orders {
      border: none;
      box-shadow: none;
      margin-bottom: 20px;
    }
    .list-box.recent-orders ul {
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
      list-style: none;
    }
    .order-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
    }
    .order-date {
      font-size: 0.95rem;
      font-weight: 900;
      color: #666;
    }
    .order-code {
      font-size: 0.88rem;
      color: #888;
      font-weight: 900;
    }
    .order-body {
      display: flex;
      align-items: center;
    }
    .product-image {
      width: 100px;
      height: 100px;
      border-radius: 4px;
      object-fit: cover;
      margin-right: 16px;
    }
    .product-info {
      flex: 1;
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
    .product-actions button {
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
    }
    .product-actions button:hover {
      background-color: #f0f0f0;
    }
    .cart-icon {
      margin-left: 16px;
      font-size: 24px;
      color: #fa7c00;
      cursor: pointer;
    }
    .cart-icon:hover {
      color: #e26d00;
    }
    .empty-msg { text-align: center; color: #999; }
    .detail-button-wrap {
      text-align: center;
      margin-top: 10px;
    }
    .detail-button {
      background-color: #fa7c00;
      color: #fff;
      border: none;
      border-radius: 4px;
      padding: 8px 16px;
      font-size: 0.9rem;
      cursor: pointer;
    }
    .detail-button:hover {
      background-color: #e26d00;
    }
    .notice-box, .coupon-box {
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 15px;
      font-size: 0.95rem;
      line-height: 1.4;
    }
    .notice-box {
      background-color: #fff9f5;
      border: 1px solid #ffd6c9;
      color: #555;
    }
    .coupon-box {
      background-color: #f2e9ff;
      border: 1px solid #e2d0ff;
      color: #333;
    }
    .coupon-box .highlight {
      font-weight: 700;
      color: #a050e3;
    }
    .banner-box {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      margin: 20px 0;
      font-size: 0.95rem;
      color: #666;
      background-color: #fdf9f4;
      text-align: center;
    }
    .explore-btn {
      margin-top: 10px;
      background-color: #fa7c00;
      color: #fff;
      border: none;
      border-radius: 4px;
      padding: 8px 16px;
      cursor: pointer;
      font-size: 0.9rem;
    }
    .explore-btn:hover { background-color: #e26d00; }
    footer {
      background-color: #f9f9f9;
      padding: 20px 0;
      margin-top: 20px;
      border-top: 1px solid #e5e5e5;
    }
    footer p { color: #666; font-size: 0.9rem; margin: 0; text-align: center; }
    @media (max-width: 992px) {
      .sidebar { width: 180px; }
    }
    @media (max-width: 768px) {
      .main-container { flex-direction: column; margin-top: 80px; }
      .sidebar { width: 100%; margin-bottom: 20px; }
      .content { margin-left: 0; width: 100%; padding: 20px; }
      .point-section { flex-direction: column; }
      .point-box { border-bottom: 1px solid #eee; }
      .point-box:last-child { border-bottom: none; }
    }

    /* ==================== 리뷰 작성 모달 (세련된 디자인) ==================== */
    #writeReviewModal {
      display: none;
      position: fixed;
      z-index: 2000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.6);
      padding-top: 5%;
    }
    #writeReviewModal .modal-content {
      background-color: #fff;
      margin: auto;
      padding: 40px 30px;
      border-radius: 10px;
      width: 95%;
      max-width: 650px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.25);
      position: relative;
    }
    #writeReviewModal .close {
      color: #aaa;
      position: absolute;
      right: 20px;
      top: 15px;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }
    #writeReviewModal .close:hover,
    #writeReviewModal .close:focus {
      color: #000;
    }
    /* ==================== 상품 정보 영역 (모달 상단) ==================== */
    #reviewProductInfo {
      display: flex;
      align-items: center;
      justify-content: left;
      gap: 15px;
      margin-bottom: 20px;
      border-bottom: 1px solid #eee;
      padding-bottom: 15px;
    }
    #reviewProductInfo img {
      margin-top: 10px;
      max-width: 120px;
      border-radius: 8px;
    }
    #reviewProductInfo span {
      font-weight: bold;
      font-size: 1.2rem;
    }
    /* ==================== 별점 디자인 ==================== */
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
    /* ==================== textarea 디자인 ==================== */
    textarea {
      width: 100%;
      height: 150px;
      padding: 12px;
      font-size: 1rem;
      border: 1px solid #ddd;
      border-radius: 4px;
      resize: none;
      outline: none;
    }
    textarea:focus {
      border-color: #fa7c00;
    }
    /* ==================== 파일 미리보기 ==================== */
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
    /* ==================== 파일 선택 & 작성완료 버튼 ==================== */
    /* 실제 file input 숨김 */
    #selectFile {
      display: none;
    }
    /* 커스텀 파일 선택 버튼 */
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
  </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 본문 컨테이너 -->
<div class="main-container">
  <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />
  <div class="content">
    <h2>내 정보</h2>
    <!-- 포인트 & 쿠폰 영역 -->
    <div class="point-section">
      <div class="point-box">
        포인트
        <strong>
          <c:choose>
            <c:when test="${not empty balance}">
              <fmt:formatNumber value="${balance}" pattern="#,###" />원
            </c:when>
            <c:otherwise>0원</c:otherwise>
          </c:choose>
        </strong>
      </div>
      <div class="point-box" id="couponBox" style="cursor:pointer;">
        쿠폰
        <strong>
          <c:choose>
            <c:when test="${not empty couponCount}">
              <fmt:formatNumber value="${couponCount}" pattern="#,###" />
            </c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </strong>
      </div>
    </div>

    <div class="notice-box">
      <p>한번만 구매하면 다음을 통한 혜택을 받을 수 있어요!</p>
    </div>
    <div class="coupon-box">
      <p>
        <span class="highlight">+1,200원</span>으로 매월 <span class="highlight">4천원 쿠폰</span>
        &nbsp;→ 최대 <span class="highlight">10%</span> 할인
      </p>
    </div>

    <!-- 최근 주문 내역 영역 -->
    <div class="section-title">
      최근 주문 내역
      <a href="${pageContext.request.contextPath}/mypage/detail" class="section-more">상세보기 &gt;</a>
    </div>
    <div class="list-box recent-orders">
      <c:choose>
        <c:when test="${not empty ordersHistory}">
          <ul>
            <c:forEach var="order" items="${ordersHistory}" varStatus="loopStatus" begin="0" end="1">
              <li class="order-item-container">
                <div class="order-header">
                  <span class="order-date">${order.orderDate}</span>
                  <span class="order-code">주문번호: ${order.orderCode}</span>
                </div>
                <div class="order-body">
                  <img src="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}" class="product-image" />
                  <div class="product-info">
                    <div class="product-title">${order.productName}</div>
                    <div class="product-price">
                      <fmt:formatNumber value="${order.netPay}" pattern="#,###" />원
                    </div>
                    <div class="shipping-fee">배송비: 무료</div>
                    <div class="product-actions">
                      <button>반품신청</button>
                      <button>교환신청</button>
                      <!-- 모달을 띄우는 버튼 -->
                      <button id="openWriteReviewBtn" class="btn-review"
                              data-product-code="${order.productCode}"
                              data-product-name="${order.productName}"
                              data-product-image="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}">
                        상품평 작성
                      </button>
                    </div>
                  </div>
                  <div class="cart-icon"
                       data-product-code="${order.productCode}"
                       data-product-name="${order.productName}"
                       data-price="${order.price}">
                    <i class="fas fa-shopping-cart"></i>
                  </div>
                </div>
              </li>
              <c:if test="${loopStatus.index == 1}">
                <div class="detail-button-wrap">
                  <button class="detail-button" onclick="location.href='${pageContext.request.contextPath}/mypage/detail'">주문내역 전체보기</button>
                </div>
              </c:if>
            </c:forEach>
          </ul>
        </c:when>
        <c:otherwise>
          <p class="empty-msg">구매 이력이 없습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="banner-box">
      졸업의 주인공을 찬란하고 빛나게 (배너 예시)
    </div>

    <div class="section-title">
      찜한 작품
      <a href="#" class="section-more">더보기 &gt;</a>
    </div>
    <div class="list-box">
      <p class="empty-msg">찜한 작품이 없습니다.</p>
    </div>

    <div class="section-title">
      팔로우하는 작가
      <a href="#" class="section-more">더보기 &gt;</a>
    </div>
    <div class="list-box">
      <p class="empty-msg">팔로우하는 작가가 없습니다.</p>
    </div>

    <div class="section-title">
      최근 본 작품
      <a href="#" class="section-more">더보기 &gt;</a>
    </div>
    <div class="list-box">
      <p class="empty-msg">최근 본 작품이 없습니다.</p>
      <button class="explore-btn">지금 구경하기</button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<!-- 쿠폰 모달 -->
<div id="couponModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h3>쿠폰 리스트</h3>
    <c:choose>
      <c:when test="${not empty couponList}">
        <ul>
          <c:forEach var="coupon" items="${couponList}">
            <li>
              <span class="coupon-code">${coupon.couponCode}</span>
              <span class="coupon-expire">만료일: ${coupon.expireDate}</span>
            </li>
          </c:forEach>
        </ul>
      </c:when>
      <c:otherwise>
        <p>쿠폰이 없습니다.</p>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- 리뷰 작성 모달 (세련된 디자인 적용) -->
<div id="writeReviewModal">
  <div class="modal-content">
    <span class="close" id="closeWriteReviewBtn">&times;</span>
    <h3>상품평 작성</h3>
    <form id="writeReviewForm" action="${pageContext.request.contextPath}/review/write" method="post" class="review-form" enctype="multipart/form-data">
      <!-- 모달 상단 상품 정보 영역 -->
      <div id="reviewProductInfo">
        <img id="reviewProductImage" src="" alt="상품 이미지">
        <span id="reviewProductName"></span>
      </div>
      <!-- 별점 입력 -->
      <label>별점</label>
      <div class="star-rating">
        <input type="radio" id="star5" name="starRate" value="5" /><label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
        <input type="radio" id="star4" name="starRate" value="4" /><label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
        <input type="radio" id="star3" name="starRate" value="3" /><label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
        <input type="radio" id="star2" name="starRate" value="2" /><label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
        <input type="radio" id="star1" name="starRate" value="1" /><label for="star1" title="1 star"><i class="fas fa-star"></i></label>
      </div>
      <!-- 내용 입력 영역 -->
      <label for="reviewContent"></label>
      <textarea id="reviewContent" name="content" placeholder="최소 10자를 입력하세요."></textarea>
      <!-- 파일 업로드 & 미리보기 영역 -->
      <label for="selectFile" class="file-input-label">📁 파일 선택</label>
      <input type="file" id="selectFile" name="selectFile" multiple accept="image/*" />
      <div id="filePreview" class="file-preview"></div>
      <!-- hidden 필드 -->
      <input type="hidden" name="memberIdx" value="${sessionScope.member.memberIdx}">
      <input type="hidden" id="productCode" name="productCode" value="">
      <input type="hidden" id="productName" name="productName" value="">
      <!-- 작성완료 버튼 -->
      <button type="button" id="submitWriteReview" class="btn-submit">작성완료</button>
    </form>
  </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function(){
    // 상품평 작성 버튼 클릭 시 (모달에 상품 정보 세팅)
    $('.btn-review').click(function(){
      var productCode = $(this).data('product-code');
      var productName = $(this).data('product-name');
      var productImage = $(this).data('product-image');

      $('#productCode').val(productCode);
      $('#productName').val(productName);

      $('#reviewProductImage').attr('src', productImage);
      $('#reviewProductName').text(productName);
      // 모달 열기
      $('#writeReviewModal').show();
    });

    $('#closeWriteReviewBtn').click(function(){
      $('#writeReviewModal').hide();
    });
    $(window).click(function(event) {
      if ($(event.target).is('#writeReviewModal')) {
        $('#writeReviewModal').hide();
      }
    });

    // 리뷰 작성 Ajax 처리
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

    // 파일 선택 시 미리보기 구현
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

    $(".cart-icon").click(function(event){
      event.preventDefault();
      var productCode = $(this).data('product-code');
      var price = $(this).data('price');
      var quantity = 1;
      let params = { productCode: productCode, quantity: quantity, price: price };
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

    // 쿠폰 모달 처리
    var couponBox = document.getElementById('couponBox');
    var couponModal = document.getElementById('couponModal');
    var couponClose = couponModal.querySelector('.close');
    couponBox.addEventListener('click', function() {
      couponModal.style.display = 'block';
    });
    couponClose.addEventListener('click', function() {
      couponModal.style.display = 'none';
    });
    window.addEventListener('click', function(event) {
      if (event.target === couponModal) {
        couponModal.style.display = 'none';
      }
    });
  });
</script>
</body>
</html>
