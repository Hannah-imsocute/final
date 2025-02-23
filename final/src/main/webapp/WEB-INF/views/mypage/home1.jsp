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

  <!-- Font Awesome 아이콘 (장바구니 등) 사용 위해 CDN 추가 -->
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

    /* ==================== 최근 주문 내역 리스트(새 디자인) ==================== */
    .list-box.recent-orders {
      border: none;
      box-shadow: none;
      margin-bottom: 20px;
    }
    .list-box.recent-orders ul {
      margin: 0;
      padding: 0;
    }

    /* 주문정보 전체 컨테이너 */
    .order-item-container {
      border: 1px solid #e5e5e5;
      border-radius: 8px;
      padding: 16px;
      margin-bottom: 20px;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.08);
      list-style: none;
    }

    /* 주문 헤더 (날짜, 주문번호) */
    .order-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
    }
    .order-date {
      font-size: 0.95rem;
      font-weight: 600;
      color: #666;
    }
    .order-code {
      font-size: 0.88rem;
      color: #888;
    }

    /* 주문 바디 (이미지 + 상품정보 + 장바구니) */
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
      flex: 1; /* 이미지 제외 나머지 공간 채우기 */
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

    /* 버튼들 */
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

    /* 장바구니 아이콘 */
    .cart-icon {
      margin-left: 16px;
      font-size: 24px;
      color: #fa7c00;
      cursor: pointer;
    }
    .cart-icon:hover {
      color: #e26d00;
    }

    /* ==================== 빈 메시지, 상세보기 버튼 ==================== */
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

    /* ==================== 기타 콘텐츠 스타일 ==================== */
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

    /* ==================== Footer ==================== */
    footer {
      background-color: #f9f9f9;
      padding: 20px 0;
      margin-top: 20px;
      border-top: 1px solid #e5e5e5;
    }
    footer p { color: #666; font-size: 0.9rem; margin: 0; text-align: center; }

    /* ==================== Responsive ==================== */
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

    /* ==================== Modal (쿠폰 모달) ==================== */
    .modal {
      display: none;
      position: fixed;
      z-index: 2000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.5);
    }
    .modal-content {
      background-color: #fff;
      margin: 10% auto;
      padding: 20px;
      border: 1px solid #888;
      border-radius: 8px;
      width: 80%;
      max-width: 500px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    }
    .modal-content h3 { margin-top: 0; font-size: 1.4rem; }
    .modal-content ul { list-style: none; padding: 0; margin: 20px 0; }
    .modal-content li {
      padding: 12px;
      margin-bottom: 10px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      border-radius: 6px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .modal-content li:last-child { margin-bottom: 0; }
    .modal-content p {
      text-align: center;
      font-weight: bold;
      color: #888;
      margin: 20px 0;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }
    .close:hover, .close:focus { color: #000; }

    /* ==================== 리뷰 작성 모달 전용 스타일 ==================== */
    .btn-review {
      margin: 20px;
      padding: 10px 20px;
      background-color: #fa7c00;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 0.9rem;
    }
    .btn-review:hover { background-color: #e26d00; }
    .review-form label {
      display: block;
      font-weight: 600;
      margin-bottom: 6px;
    }
    .review-form textarea {
      width: 100%;
      min-height: 120px;
      padding: 8px;
      font-size: 0.95rem;
      border: 1px solid #ddd;
      border-radius: 4px;
      resize: vertical;
      margin-bottom: 12px;
    }
    .btn-submit {
      background-color: #fa7c00;
      color: #fff;
      border: none;
      border-radius: 4px;
      padding: 8px 16px;
      font-size: 0.9rem;
      cursor: pointer;
      width: 100%;
    }
    .btn-submit:hover { background-color: #e26d00; }
  </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 본문 컨테이너 -->
<div class="main-container">
  <!-- 사이드바 include -->
  <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

  <!-- 메인 콘텐츠 -->
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
            <!-- 2건만 보여주기 위해 begin="0" end="1" 지정 -->
            <c:forEach var="order" items="${ordersHistory}" varStatus="loopStatus" begin="0" end="1">
              <li class="order-item-container">
                <!-- 주문 헤더 -->
                <div class="order-header">
                  <span class="order-date">${order.orderDate}</span>
                  <span class="order-code">주문번호: ${order.orderCode}</span>
                </div>
                <!-- 주문 바디 -->
                <div class="order-body">
                  <!-- 상품 이미지 -->
                  <img src="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}"
                       class="product-image" />
                  <!-- 상품 정보 -->
                  <div class="product-info">
                    <div class="product-title">${order.productName}</div>
                    <div class="product-price">
                      <fmt:formatNumber value="${order.netPay}" pattern="#,###" />원
                    </div>
                    <div class="shipping-fee">배송비: 무료</div>
                    <!-- 버튼들 -->
                    <div class="product-actions">
                      <button>반품신청</button>
                      <button>교환신청</button>
                      <!-- 새 창을 중앙에 작게 띄우는 함수 사용 -->
                      <button onclick="openCenteredReviewForm();">
                        일반 상품평
                      </button>
                    </div>
                  </div>
                  <!-- 장바구니 아이콘 -->
                  <div class="cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                  </div>
                </div>
              </li>
              <c:if test="${loopStatus.index == 1}">
                <div class="detail-button-wrap">
                  <button class="detail-button"
                          onclick="location.href='${pageContext.request.contextPath}/mypage/detail'">
                    주문내역 전체보기
                  </button>
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

    <!-- 일반 상품평 모달 열기 버튼 -->
    <button id="openReviewModal" class="btn-review">일반 상품평</button>
  </div> <!-- .content -->
</div> <!-- .main-container -->

<!-- 푸터 -->
<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- 쿠폰 모달 (모달 오버레이 및 콘텐츠) -->
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

<!-- 리뷰 작성 모달 (폼 포함) -->
<div id="reviewModal" class="modal">
  <div class="modal-content">
    <span class="close" id="closeReviewModal">&times;</span>
    <h3>일반 상품평 작성</h3>
    <!-- 리뷰 작성 폼 (POST 전송: /mypag/review/write) -->
    <form action="${pageContext.request.contextPath}/mypag/review/write" method="post" class="review-form">
      <label for="reviewContent">리뷰 내용</label>
      <textarea id="reviewContent" name="reviewContent" placeholder="내용을 입력하세요"></textarea>
      <button type="submit" class="btn-submit">작성완료</button>
    </form>
  </div>
</div>

<!-- 이미지 미리보기 및 Ajax 업로드 스크립트 (jQuery 사용) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // 새 창을 중앙에 작게 열기 위한 함수
  function openCenteredReviewForm() {
    var width = 500;
    var height = 500;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    window.open('${pageContext.request.contextPath}/mypage/review/form', 'reviewWindow', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top + ',resizable=yes');
  }

  // 쿠폰 모달 처리
  $(document).ready(function(){
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

  // 리뷰 작성 모달 처리
  document.getElementById('openReviewModal').addEventListener('click', function() {
    document.getElementById('reviewModal').style.display = 'block';
  });
  document.getElementById('closeReviewModal').addEventListener('click', function() {
    document.getElementById('reviewModal').style.display = 'none';
  });
  window.addEventListener('click', function(event) {
    if (event.target === document.getElementById('reviewModal')) {
      document.getElementById('reviewModal').style.display = 'none';
    }
  });
</script>
</body>
</html>
