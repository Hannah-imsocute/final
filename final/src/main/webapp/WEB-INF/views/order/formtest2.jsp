<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문결제</title>

  <!-- 공통 CSS/JS 로드 -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <!-- 폰트 로드 -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />

  <style>
    /* 기존 CSS 스타일 그대로 유지 */
    header {
      position: relative !important;
    }
    *, *::before, *::after {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f2f5;
      color: #333;
      line-height: 1.6;
    }
    a {
      text-decoration: none;
      color: inherit;
    }
    a:hover {
      color: #555;
    }
    .order-page-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px 40px;
      min-height: 80vh;
    }
    .order-header {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    .order-header .order-title {
      margin: 0;
      font-size: 28px;
      font-weight: bold;
    }
    .cart-steps {
      font-size: 14px;
      color: #999;
    }
    .cart-steps ol {
      list-style: none;
      display: flex;
      gap: 15px;
      margin: 0;
      padding: 0;
    }
    .cart-steps li {
      padding: 4px 8px;
      border-radius: 4px;
      background: #eaeaea;
    }
    .cart-steps li.current {
      font-weight: bold;
      color: #333;
    }
    .order-content {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }
    .order-left {
      flex: 1 1 0;
      min-width: 320px;
    }
    .order-right {
      width: 380px;
      flex-shrink: 0;
    }
    .order-section {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }
    .order-section h3 {
      margin-bottom: 10px;
      font-size: 18px;
      font-weight: 600;
      border-bottom: 1px solid #eee;
      padding-bottom: 8px;
    }
    .order-section .sub-info {
      font-size: 14px;
      color: #666;
      margin-bottom: 10px;
    }
    .order-section button {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 6px 12px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .order-section button:hover {
      background: #f9f9f9;
    }
    .shipping-box .addr-text {
      background-color: #fff;
      border: 1px solid #eee;
      border-radius: 4px;
      padding: 12px;
      margin-bottom: 10px;
      font-size: 14px;
      line-height: 1.4;
    }
    .memo-input {
      width: 100%;
      padding: 8px;
      margin-top: 10px;
      font-size: 14px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #fff;
    }
    .discount-box select {
      margin-left: 5px;
      padding: 5px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
      background-color: #fff;
    }
    .discount-box input[type="text"] {
      padding: 5px;
      font-size: 14px;
      text-align: center;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .payment-box .card-list {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }
    .payment-box .card-item {
      width: 120px;
      height: 60px;
      background-color: #f2f2f2;
      border-radius: 4px;
      border: 1px solid #eee;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 13px;
      color: #666;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .payment-box .card-item:hover {
      background-color: #ebebeb;
    }
    .payment-box .sub-info {
      margin-bottom: 10px;
    }
    .order-summary-box {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }
    .order-summary-box h3 {
      font-size: 18px;
      font-weight: 600;
      margin-top: 0;
      margin-bottom: 15px;
      border-bottom: 1px solid #eee;
      padding-bottom: 8px;
    }
    .product-list {
      margin-bottom: 20px;
    }
    .product-list-header,
    .product-list-item {
      display: flex;
      align-items: center;
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }
    .product-list-header {
      font-weight: bold;
      background-color: #f9f9f9;
    }
    .product-list-item:last-child {
      border-bottom: none;
    }
    .product-list .column {
      text-align: center;
      flex: 1;
    }
    .product-list .column.image {
      flex: 0 0 60px;
    }
    .product-list .column.image img {
      width: 50px;
      height: 50px;
      object-fit: cover;
      border-radius: 4px;
    }
    .sum-area {
      font-size: 14px;
      line-height: 1.6;
      text-align: right;
    }
    .sum-area .highlight {
      font-size: 16px;
      font-weight: bold;
      color: #333;
    }
    .order-form {
      margin-top: 15px;
      border-top: 1px solid #eee;
      padding-top: 15px;
    }
    .order-form label {
      display: block;
      margin-bottom: 5px;
      font-size: 14px;
      font-weight: bold;
    }
    .order-form input,
    .order-form textarea {
      width: 100%;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 8px;
      margin-bottom: 15px;
      font-size: 14px;
    }
    .btn-submit-order {
      display: block;
      width: 100%;
      padding: 14px 0;
      background-color: #ff8200;
      color: #fff;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 20px;
      transition: background-color 0.3s;
    }
    .btn-submit-order:hover {
      background-color: #ff8400;
    }

    @media (max-width: 768px) {
      .order-right {
        width: 100%;
        order: -1;
      }
    }

    /* 모달창 관련 추가 CSS */
    .modal-overlay {
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0,0,0,0.4);
      z-index: 9999;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .modal {
      background-color: #fff;
      border-radius: 8px;
      width: 400px;
      max-width: 90%;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      position: relative;
    }
    .modal-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 10px;
    }
    .modal-header h3 {
      margin: 0;
      font-size: 18px;
      font-weight: 600;
    }
    .modal-header .modal-close {
      border: none;
      background: transparent;
      font-size: 24px;
      line-height: 1;
      cursor: pointer;
    }
    .modal-body label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
      font-size: 14px;
    }
    .modal-body input {
      width: 100%;
      margin-bottom: 15px;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }
    .modal-footer {
      display: flex;
      justify-content: flex-end;
      gap: 8px;
    }
    .modal-footer button {
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }
    .modal-footer .modal-save {
      background-color: #ff8200;
      color: #fff;
    }
    .modal-footer .modal-cancel {
      background-color: #ccc;
    }
  </style>
</head>
<body>

<!-- 고정 헤더 (일반 헤더) -->
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<div class="order-page-container">
  <!-- 주문 헤더 -->
  <div class="order-header">
    <h2 class="order-title">주문결제</h2>
    <div class="cart-steps">
      <ol>
        <li>01 장바구니</li>
        <li class="current">02 주문 결제</li>
        <li>03 주문 완료</li>
      </ol>
    </div>
  </div>

  <!-- 좌우 2단 레이아웃 -->
  <div class="order-content">
    <!-- 왼쪽: 배송, 할인, 결제 정보 -->
    <div class="order-left">
      <!-- 배송지 정보 -->
      <div class="order-section shipping-box">
        <h3>배송지 정보</h3>
        <div class="sub-info">
          받는 분: <strong><c:out value="${receiverName}" /></strong>
          <button type="button" class="btn-addr-info">배송지 변경</button>
        </div>
        <div class="addr-text">
          <c:if test="${not empty addTitle}">
            <c:out value="${addTitle}" /> <c:out value="${addDetail}" /><br/>
          </c:if>
          <c:out value="${phone}" /> )
        </div>
        <select class="memo-input">
          <option value="">배송시 요청사항을 선택해주세요.</option>
          <option value="contact_before">배송 전 연락바랍니다</option>
          <option value="concierge">부재 시 경비실에 맡겨주세요</option>
          <option value="door">부재 시 문앞에 놓아주세요</option>
          <option value="parcel_box">부재 시 택배함에 놓아주세요</option>
          <option value="other">기타 입력</option>
        </select>
        <div id="otherRequestDiv" style="display:none; margin-top:10px;">
          <input type="text" maxlength="50" placeholder="최대 50자 입력이 가능합니다."
                 style="width:100%; padding:8px; font-size:14px; border:1px solid #ddd; border-radius:4px;">
        </div>
      </div>

      <!-- 할인 및 포인트 -->
      <div class="order-section discount-box">
        <h3>쿠폰 및 포인트 사용</h3>
        <div class="sub-info">
          쿠폰할인 <strong>0원</strong>
        </div>
        <label>
          쿠폰을 선택해 주세요:
          <select>
            <option>선택 없음</option>
            <option>쿠폰 적용</option>
            <option>카드 즉시 할인</option>
          </select>
        </label>
        <div style="margin-top:10px;">
          나의 포인트 0원
          <input type="text" value="0" size="5">
          <button type="button">전액사용</button>
        </div>
        <div style="margin-top: 15px; font-size:14px; color:#999;">
          제휴포인트도 스마일캐시로 전환하세요!<br>
          <small>(SSG MONEY / PAYCO / L.POINT 등)</small>
        </div>
      </div>

      <!-- 결제수단 -->
      <div class="order-section payment-box">
        <h3>결제수단</h3>
        <div class="sub-info">Pay 간편결제</div>
        <div class="card-list">
          <div class="card-item">BCcard</div>
          <div class="card-item">네이버페이</div>
          <div class="card-item">카카오페이</div>
        </div>
        <div style="margin-top: 15px; font-size:14px; color:#999;">
          다른 결제수단으로도 결제 가능합니다.
        </div>
      </div>
    </div> <!-- //order-left -->

    <!-- 오른쪽: 주문 상품 목록 및 합계 -->
    <div class="order-right">
      <div class="order-summary-box">
        <h3>주문 상품 목록</h3>

        <!-- 상품 목록 -->
        <div class="product-list">
          <div class="product-list-header">
            <div class="column image">이미지</div>
            <div class="column name">상품명</div>
            <div class="column option">옵션</div>
            <div class="column quantity">수량</div>
            <div class="column price">금액</div>
          </div>
          <c:forEach var="cart" items="${cartItems}">
            <div class="product-list-item">
              <div class="column image">
                <img src="${pageContext.request.contextPath}/dist/img/우산.jpg" alt="상품 이미지"/>
              </div>
              <div class="column name">
                <c:out value="${cart.item}" />
              </div>
              <div class="column option">
                <c:out value="${cart.cartOption != null ? cart.cartOption : '없음'}" />
              </div>
              <div class="column quantity">
                <c:out value="${cart.quantity}" />
              </div>
              <div class="column price">
                <fmt:formatNumber value="${cart.quantity * cart.price}" pattern="#,###" />원
              </div>
            </div>
          </c:forEach>
        </div>

        <!-- 합계 영역 -->
        <div class="sum-area">
          상품금액: <span>
            <fmt:formatNumber value="${overallNetPay}" pattern="#,###" />원
          </span><br/>
          할인금액: <span style="color:#f05;">-0원</span><br/>
          배송비: 0원<br/><br/>
          총 결제금액:
          <span class="highlight">
            <fmt:formatNumber value="${overallNetPay}" pattern="#,###" />원
          </span>
        </div>

        <!-- 결제하기 버튼 -->
        <button class="btn-submit-order">결제하기</button>
      </div>
    </div> <!-- //order-right -->
  </div> <!-- //order-content -->
</div> <!-- //order-page-container -->

<!-- 모달창 (배송지 변경) -->
<div id="modalOverlay" class="modal-overlay" style="display: none;">
  <div class="modal">
    <div class="modal-header">
      <h3>배송지 변경</h3>
      <!-- 닫기 버튼 -->
      <button type="button" class="modal-close">&times;</button>
    </div>
    <div class="modal-body">
      <label for="modalReceiverName">받는 분</label>
      <input type="text" id="modalReceiverName" value="<c:out value='${receiverName}'/>" />

      <label for="modalPostCode">우편번호</label>
      <div style="display: flex; gap: 8px; margin-bottom: 15px;">
        <input type="text" id="modalPostCode" placeholder="우편번호" style="flex:1;" readonly />
        <button type="button" id="btnSearchPostCode" style="padding: 8px;">우편번호 찾기</button>
      </div>

      <label for="modalAddress">주소</label>
      <input type="text" id="modalAddress" placeholder="주소를 입력하세요" />

      <label for="modalAddressDetail">상세주소</label>
      <input type="text" id="modalAddressDetail" placeholder="상세주소를 입력하세요" />

      <label for="modalPhone">연락처</label>
      <input type="text" id="modalPhone" value="<c:out value='${phone}'/>" placeholder="연락처" />
    </div>
    <div class="modal-footer">
      <button type="button" class="modal-save">저장</button>
      <button type="button" class="modal-cancel modal-close">취소</button>
    </div>
  </div>
</div>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<!-- JS -->
<script>
  window.addEventListener('DOMContentLoaded', function() {
    const shippingSelect = document.querySelector('.shipping-box .memo-input');
    const otherRequestDiv = document.getElementById('otherRequestDiv');
    if (shippingSelect && otherRequestDiv) {
      shippingSelect.addEventListener('change', function() {
        otherRequestDiv.style.display = this.value === 'other' ? 'block' : 'none';
      });
    }
  });

  // 모달창 열고 닫기 스크립트
  document.addEventListener("DOMContentLoaded", function() {
    const modalOverlay = document.getElementById('modalOverlay');
    const btnAddrChange = document.querySelector('.btn-addr-info');
    const closeButtons = document.querySelectorAll('.modal-close');
    const btnSave = document.querySelector('.modal-save');

    // 1) 모달 열기
    btnAddrChange.addEventListener('click', function() {
      modalOverlay.style.display = 'flex';
    });

    // 2) 모달 닫기 ( × 버튼, 취소 버튼 )
    closeButtons.forEach(function(btn) {
      btn.addEventListener('click', function() {
        modalOverlay.style.display = 'none';
      });
    });

    // 3) 저장 버튼 클릭 시 (Ajax 예시)
    btnSave.addEventListener('click', function() {
      // 필요한 값들
      const receiverName = document.getElementById('modalReceiverName').value;
      const postCode = document.getElementById('modalPostCode').value;
      const address = document.getElementById('modalAddress').value;
      const addressDetail = document.getElementById('modalAddressDetail').value;
      const phone = document.getElementById('modalPhone').value;

      // TODO: 실제로 서버에 보낼 AJAX 구현
      // 예) $.ajax({
      //   url: '/updateAddress',
      //   type: 'POST',
      //   data: {
      //     receiverName,
      //     postCode,
      //     address,
      //     addressDetail,
      //     phone
      //   },
      //   success: function(res) {
      //     // 성공 시 처리
      //   }
      // });

      // 모달 닫기
      modalOverlay.style.display = 'none';
    });
  });
</script>

</body>
</html>