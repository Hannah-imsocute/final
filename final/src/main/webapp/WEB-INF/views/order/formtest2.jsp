<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문결제</title>
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
  <!-- 폰트 & 다음 우편번호 API -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <style>
    /* 기본 폰트 */
    body {
      font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', sans-serif;
      background-color: #f0f2f5;
      color: #333;
      line-height: 1.6;
    }
    header { position: relative !important; }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    a { text-decoration: none; color: inherit; }
    a:hover { color: #555; }
    .order-page-container { max-width: 1200px; margin: 0 auto; padding: 40px 20px 40px; min-height: 80vh; }
    .order-header { display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; margin-bottom: 20px; }
    .order-header .order-title { margin: 0; font-size: 28px; font-weight: bold; }
    .cart-steps { font-size: 14px; color: #999; }
    .cart-steps ol { list-style: none; display: flex; gap: 15px; margin: 0; padding: 0; }
    .cart-steps li { padding: 4px 8px; border-radius: 4px; background: #eaeaea; }
    .cart-steps li.current { font-weight: bold; color: #333; }

    .order-content {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }
    /* 왼쪽(배송/할인/결제수단) */
    .order-left {
      flex: 1 1 0;
      min-width: 320px;
    }
    /* 오른쪽(주문 상품 목록) */
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
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .order-section h3 {
      margin-bottom: 10px;
      font-size: 18px;
      font-weight: 600;
      border-bottom: 1px solid #eee;
      padding-bottom: 8px;
    }

    /* 배송지 정보 */
    .shipping-box { position: relative; }
    .shipping-box .shipping-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
    }
    .shipping-box .recipient-info {
      display: flex;
      gap: 8px;
      align-items: center;
      font-size: 16px;
    }
    .recipient-name {
      font-weight: 600;
      color: #333;
    }
    .recipient-phone {
      color: #666;
      font-size: 14px;
    }
    .btn-addr-change {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 6px 12px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s;
      white-space: nowrap;
    }
    .btn-addr-change:hover {
      background: #f9f9f9;
    }
    .shipping-box .addr-text {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 6px;
      padding: 12px;
      margin-bottom: 10px;
      font-size: 16px;
      line-height: 1.5;
      min-height: 60px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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

    /* 쿠폰/포인트 사용 영역 */
    .coupon-discount-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }
    .coupon-discount-left {
      font-size: 15px;
    }
    .coupon-discount-left .couponDiscount {
      font-weight: bold;
      color: #f05;
    }
    .coupon-discount-right .coupon-btn {
      background: #fff;
      border: 1px solid #ddd;
      padding: 6px 12px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-size: 14px;
    }
    .coupon-discount-right .coupon-btn:hover {
      background: #f7f7f7;
    }
    .point-use-row {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-top: 10px;
      font-size: 14px;
    }
    .point-input-wrap {
      display: flex;
      align-items: center;
      gap: 6px;
    }
    .point-input-wrap input[type="text"] {
      width: 80px;
      text-align: right;
      padding: 5px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .point-btn {
      background: #fff;
      border: 1px solid #ddd;
      padding: 6px 10px;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .point-btn:hover {
      background: #f9f9f9;
    }

    /* 결제수단 예시 */
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

    /* 주문 상품 목록(오른쪽) - 카드형 스타일 */
    .order-summary-box {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .order-summary-box h3 {
      font-size: 18px;
      font-weight: 600;
      margin-top: 0;
      margin-bottom: 15px;
      border-bottom: 1px solid #eee;
      padding-bottom: 8px;
    }

    /* 개별 상품 카드 */
    .product-card {
      border-bottom: 1px solid #eee;
      padding-bottom: 15px;
      margin-bottom: 15px;
    }
    .product-card:last-child {
      border-bottom: none;
      margin-bottom: 0;
      padding-bottom: 0;
    }
    .store-name {
      font-size: 14px;
      color: #999;
      margin-bottom: 8px;
    }
    .product-card-body {
      display: flex;
      gap: 12px;
      align-items: center;
    }
    .product-image img {
      width: 70px;
      height: 70px;
      border-radius: 4px;
      object-fit: cover;
    }
    .product-info {
      display: flex;
      flex-direction: column;
      gap: 4px;
      font-size: 14px;
    }
    .product-title {
      font-size: 15px;
      font-weight: 600;
      color: #333;
    }
    .product-option {
      color: #666;
    }
    .product-price {
      color: #f05;
      font-weight: 500;
    }
    .product-shipfee {
      font-size: 12px;
      color: #999;
    }

    /* 금액 정보 */
    .price-info {
      margin-top: 20px;
      font-size: 14px;
      line-height: 1.6;
    }
    .price-row, .discount-row, .shipping-fee, .total-amount {
      display: flex; justify-content: space-between; margin-bottom: 5px;
    }
    .total-amount {
      margin-top: 10px;
      padding-top: 10px;
      border-top: 1px solid #eee;
      font-weight: bold;
    }
    .highlight {
      font-size: 18px;
      color: #333;
      font-weight: bold;
    }

    /* 버튼 */
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
      .order-right { width: 100%; order: -1; }
    }

    /* 모달창 */
    .modal-overlay {
      position: fixed; top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0,0,0,0.4);
      z-index: 9999;
      display: none;
      align-items: center;
      justify-content: center;
    }
    .modal {
      display: block !important;
      background-color: #fff;
      border-radius: 8px;
      width: 320px;
      max-width: 90%;
      padding: 15px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      position: relative;
      z-index: 10000;
      border: 1px solid #ccc;
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

    /* 배송지 목록 항목 */
    .address-item {
      border-bottom: 1px solid #eee;
      padding: 8px 0;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .address-info {
      font-size: 14px;
      line-height: 1.4;
    }
    .btn-select-address {
      padding: 4px 8px;
      border: 1px solid #ddd;
      background: #fff;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-size: 12px;
    }
    .btn-select-address:hover {
      background-color: #f9f9f9;
    }

    /* 쿠폰 모달 */
    #couponModalOverlay { display: none; }
    #couponModalOverlay .modal {
      width: 400px;
      max-width: 90%;
      border: none;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    #couponModalOverlay .modal-header {
      background: #ff8200;
      color: #fff;
      padding: 15px;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }
    #couponModalOverlay .modal-header h3 {
      margin: 0;
      font-size: 20px;
    }
    #couponModalOverlay .modal-body {
      max-height: 300px;
      overflow-y: auto;
      padding: 15px;
    }
    #couponModalOverlay .coupon-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    #couponModalOverlay .coupon-item {
      border: 1px solid #eee;
      border-radius: 6px;
      padding: 10px;
      margin-bottom: 10px;
      transition: background 0.3s;
      cursor: pointer;
    }
    #couponModalOverlay .coupon-item:hover {
      background: #f7f7f7;
    }
    #couponModalOverlay .modal-footer {
      padding: 15px;
      text-align: right;
      border-top: 1px solid #eee;
    }
    #couponModalOverlay .coupon-modal-apply {
      background: #ff8200;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 4px;
      cursor: pointer;
      transition: background 0.3s;
    }
    #couponModalOverlay .coupon-modal-apply:hover {
      background: #e66a00;
    }
    #couponModalOverlay .coupon-modal-cancel {
      background: #ccc;
      color: #333;
      border: none;
      padding: 10px 20px;
      border-radius: 4px;
      cursor: pointer;
      margin-right: 10px;
      transition: background 0.3s;
    }
    #couponModalOverlay .coupon-modal-cancel:hover {
      background: #b3b3b3;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>

  <script type="text/javascript">

    var IMP = window.IMP;
    IMP.init("imp86656532");

    function sendOk() {
      const f = document.orderSubmit;

      // 결제 API에서 응답 받을 파라미터
      let byMethod = ''; // 결제수단
      let provider = '';  // 카드사
      let confirmCode = ''; // 승인번호
      let confirmDate = ''; // YYYY-MM-DD HH:mm:ss
      let cardNumber = '';
      let itemCode = '${order.orderItem.itemCode}';
      let productCode ='${order.productCode}';
      let quantity = '${order.orderItem.quantity}'
      confirmDate = new Date().toISOString().replace('T', ' ').slice(0, -5); // YYYY-MM-DD HH:mm:ss

      let memberIdx = ${sessionScope.member.memberIdx};
      let merchant_uid = '${order.orderCode}';
      <%--let amount = '${overallNetPay}';--%>
      <%--let name = '${order.orderItem.item}'--%>
      // let name = '상품 테스트';
      <%--let name = '${cart.item}'--%>
      let amount = 10;
      let buyer_email = '${sessionScope.member.email}';
      let buyer_name = '${receiverName}';
      let buyer_tel = '${phone}';
      let buyer_addr = '${addTitle} - ${addDetail}';
      let buyer_postcode = '${postCode}';


      IMP.request_pay(
              {
                channelKey: "channel-key-eb37305c-955d-472e-98c1-f7d722cc1706",
                pay_method: provider,
                merchant_uid: merchant_uid, //상점에서 생성한 고유 주문번호
                name: '뚝딱뚝딱 상품',
                amount: amount,
                buyer_email: buyer_email,
                buyer_name: buyer_name,
                buyer_tel: buyer_tel, //필수 파라미터
                buyer_addr: buyer_addr,
                buyer_postcode: buyer_postcode,
              },function(resp) { // callback
                if(resp.success) {
                  alert('결제가 완료되었습니다!!');
                  console.log(resp) ;
                  byMethod = resp.card_name || '간편결제';
                  provider = resp.pay_method || '페이결제';
                  confirmCode = resp.paid_at;
                  cardNumber = resp.card_number;
                  // 승인번호 : 숫자
                  f.payment.value  = amount;          // 전체 결제 금액
                  f.byMethod.value = byMethod;
                  f.provider.value = provider;
                  f.confirmCode.value = confirmCode;
                  f.confirmDate.value = confirmDate;
                  f.cardNumber.value = cardNumber;
                  f.memberIdx.value = memberIdx;

                  f.action = '${pageContext.request.contextPath}/order/submit';
                  f.submit();
                } else {
                  alert('결제에 실패하셨습니다.');
                  console.log(resp);
                  return false;
                }
              })
    }
  </script>
</head>
<body>
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<%-- 장바구니에서 넘어온 값--%>
<c:set var="cartFinalPriceParam" value="${param.finalTotalPrice}" />
<c:if test="${not empty cartFinalPriceParam}">
  <!-- 장바구니 금액을 productTotal로 간주 -->
  <c:set var="productTotal" value="${cartFinalPriceParam}" scope="page"/>
  <c:choose>
    <c:when test="${productTotal lt 30000}">
      <c:set var="shippingFee" value="3000" scope="page"/>
    </c:when>
    <c:otherwise>
      <c:set var="shippingFee" value="0" scope="page"/>
    </c:otherwise>
  </c:choose>
  <c:set var="overallNetPay" value="${productTotal + shippingFee}" scope="page"/>
</c:if>

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

  <!-- 전체 폼 시작 -->
  <form action="${pageContext.request.contextPath}/order/submit" method="post" name="orderSubmit">
    <input type="hidden" name="payment" value="${overallNetPay}"><!-- 서버 기준 총금액 -->
    <input type="hidden" name="byMethod" value="">
    <input type="hidden" name="provider" value="">
    <input type="hidden" name="confirmCode" value="">
    <input type="hidden" name="confirmDate" value="">
    <input type="hidden" name="cardNumber" value="">
    <%--    <input type="hidden" name="orderCode" value="">--%>
    <%--    <input type="hidden" name="orderCode" value="">--%>
    <input type="hidden" name="itemCode" value="0">


    <!-- 카트 or 직접구매 분기 -->
    <c:choose>
      <c:when test="${mode eq 'direct'}">
        <c:if test="${not empty orderItems}">
          <c:forEach var="dto" items="${orderItems}" varStatus="status">
            <input type="hidden" name="productCode" value="${dto.productCode}" />
            <input type="hidden" name="quantity" value="${dto.quantity}" />
            <input type="hidden" name="itemCode" value="${dto.itemCode}" />
            <c:if test="${not empty dto.options}">
              <%--              <input type="hidden" name="options" value="${dto.options}" />--%>
              <%--              <input type="hidden" name="orderItems[${status.index}].options" value="${dto.options}" />--%>
              <c:forEach var="opt" items="${dto.options}" varStatus="optStatus">
                <input type="hidden" name="orderItems[${status.index}].options[${optStatus.index}]" value="${opt}" />
              </c:forEach>
            </c:if>

            <!-- 추가 필드 -->
            <input type="hidden" name="priceforeach" value="${dto.priceForeach}" />
            <input type="hidden" name="price" value="${dto.price}" />
            <input type="hidden" name="order_state" value="1" />
          </c:forEach>
        </c:if>
      </c:when>
      <c:otherwise>
        <!-- 장바구니 구매 -->
        <c:if test="${not empty cartItems}">
          <c:forEach var="cart" items="${cartItems}">
            <input type="hidden" name="selectedItems" value="${cart.cartItemCode}" />
          </c:forEach>
        </c:if>
      </c:otherwise>
    </c:choose>

    <input type="hidden" name="mode" value="${mode}" />

    <!-- 배송지 hidden -->
    <input type="hidden" id="hiddenMemberIdx" name="memberIdx" value="${sessionScope.member.memberIdx}" />
    <input type="hidden" id="hiddenAddrName" name="addName" value="${addName}" />
    <input type="hidden" id="hiddenReceiverName" name="receiverName" value="${receiverName}" />
    <input type="hidden" id="hiddenPostCode" name="postCode" value="${postCode}" />
    <input type="hidden" id="hiddenAddTitle" name="addTitle" value="${addTitle}" />
    <input type="hidden" id="hiddenAddDetail" name="addDetail" value="${addDetail}" />
    <input type="hidden" id="hiddenPhone" name="phone" value="${phone}" />
    <input type="hidden" id="hiddenPostCode" name="postCode" value="${postCode}" />

    <!-- 좌우 레이아웃 -->
    <div class="order-content">
      <!-- 왼쪽: 배송지, 쿠폰/포인트, 결제수단 -->
      <div class="order-left">
        <!-- 배송지 정보 -->
        <div class="order-section shipping-box">
          <h3>배송지 정보</h3>
          <div class="shipping-header">
            <div class="recipient-info">
              <strong class="recipient-name"><c:out value="${receiverName}" /></strong>
              <span class="recipient-phone"><c:out value="${phone}" /></span>
              <input type="hidden" name="postCode" value="${postCode}">
            </div>
            <button type="button" class="btn-addr-change">배송지 변경</button>
          </div>
          <div class="addr-text">
            <c:if test="${not empty addTitle}">
              <c:out value="${addTitle}" /> <c:out value="${addDetail}" /><br/>
            </c:if>
          </div>
          <select class="memo-input" name="require">
            <option value="요청사함 없음">배송시 요청사항을 선택해주세요.</option>
            <option value="배송 전 연락바랍니다">배송 전 연락바랍니다</option>
            <option value="부재 시 경비실에 맡겨주세요">부재 시 경비실에 맡겨주세요</option>
            <option value="부재 시 문앞에 놓아주세요">부재 시 문앞에 놓아주세요</option>
            <option value="부재 시 택배함에 놓아주세요">부재 시 택배함에 놓아주세요</option>
            <option value="other">기타 입력</option>
          </select>
          <div id="otherRequestDiv" style="display:none; margin-top:10px;">
            <input type="text" id="otherRequestInput" maxlength="50"
                   placeholder="최대 50자 입력이 가능합니다."
                   style="width:100%; padding:8px; font-size:14px; border:1px solid #ddd; border-radius:4px;" />
          </div>
        </div>

        <!-- 쿠폰 및 포인트 사용 -->
        <div class="order-section discount-box">
          <h3>쿠폰 및 포인트 사용</h3>
          <div class="coupon-discount-row">
            <div class="coupon-discount-left">
              <span>쿠폰할인&nbsp;</span>
              <strong class="couponDiscount">0원</strong>
            </div>
            <div class="coupon-discount-right">
              <button type="button" id="openCouponModal" class="coupon-btn">쿠폰 적용</button>
            </div>
          </div>
          <div class="point-use-row">
            <span>나의 포인트 <strong data-balance="${balance}">${balance}원</strong></span>
            <div class="point-input-wrap">
              <input type="text" name="spentPoint" placeholder="0"/>
              <button type="button" class="point-btn">전액사용</button>
            </div>
          </div>
        </div>

        <!-- 결제수단 예시 -->
        <div class="order-section payment-box">
          <h3>결제수단</h3>
          <div class="card-list">
            <div class="card-item">일반카드</div>
            <div class="card-item">네이버페이</div>
            <div class="card-item">카카오페이</div>
          </div>
        </div>
      </div>

      <!-- 오른쪽: 주문 상품 목록 카드형 + 합계 -->
      <div class="order-right">
        <div class="order-summary-box">
          <!-- 상품 개수 표시 (예: 주문 상품 1개) -->
          <h3>주문 상품 <c:out value="${fn:length(cartItems)}" />개</h3>

          <!-- 개별 상품 카드 -->
          <c:forEach var="cart" items="${cartItems}">
            <div class="product-card">
              <div class="store-name">${cart.brandName}</div>
              <div class="product-card-body">
                <div class="product-image">
                  <img src="${pageContext.request.contextPath}/uploads/product/${cart.thumbnail}" alt="상품 이미지"/>
                </div>
                <div class="product-info">
                  <div class="product-title">
                    <c:out value="${cart.item}" />
                  </div>
                  <div class="product-option">
                    <c:out value="${cart.cartOption != null ? cart.cartOption : '옵션없음'}" />
                  </div>
                  <div class="product-price">
                    <fmt:formatNumber value="${cart.price}" pattern="#,###" />원 /
                    <c:out value="${cart.quantity}" />개
                  </div>
                  <div class="product-shipfee">
                    배송비 3,000원 (30,000원 이상 구매시 무료)
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>


          <!-- 전체 가격 영역 -->
          <div class="price-info">
            <div class="price-row">
              <span>상품금액</span>
              <!-- 장바구니에서 넘어온 값 사용 가능 -->
              <span><fmt:formatNumber value="${productTotal}" pattern="#,###" />원</span>
            </div>
            <div class="discount-row">
              <span>할인금액</span>
              <span class="couponDiscount">-0원</span>
            </div>
            <div class="shipping-fee">
              <span>배송비</span>
              <span><fmt:formatNumber value="${shippingFee}" pattern="#,###" />원</span>
            </div>
            <div class="total-amount">
              <span>총 결제금액</span>
              <span class="highlight" id="finalNetPay">
                <!-- 장바구니 값이 있으면, 반영된 overallNetPay 출력 -->
                <fmt:formatNumber value="${overallNetPay}" pattern="#,###" />원
              </span>
            </div>
          </div>

          <!-- hidden 필드 (JS에서 변경 시 반영) -->
          <input type="hidden" name="coupon.couponCode" id="couponCode" value="" />
          <input type="hidden" name="couponValue" id="couponValue" value="0" />
          <input type="hidden" name="discountAmount" id="discountAmount" value="" />
          <input type="hidden" name="finalNetPay" id="finalNetPayInput" value="${overallNetPay}" />
          <input type="hidden" name="spentPoint" id="spentPoint" value="0" />

          <!-- 결제/취소 버튼 -->
          <button class="btn-submit-order" type="button" onclick="sendOk()">결제하기</button>
     <%--     <button type="button" class="btn btn-light btn-lg"
                  style="width: 250px; margin-top:10px;"
                  onclick="location.href='${pageContext.request.contextPath}/';">
            결제취소
          </button>--%>
        </div>
      </div>
    </div>

    <!-- 쿠폰 모달 -->
    <div id="couponModalOverlay" class="modal-overlay">
      <div class="modal">
        <div class="modal-header">
          <h3 style="margin:0; font-size:20px;">보유 쿠폰 선택</h3>
          <button type="button" class="modal-close coupon-modal-close"
                  style="border:none; background:transparent; font-size:24px; cursor:pointer;">&times;</button>
        </div>
        <div class="modal-body" style="padding:15px; max-height:300px; overflow-y:auto;">
          <ul class="coupon-list">
            <c:forEach var="coupon" items="${couponList}">
              <li class="coupon-item"
                  data-coupon-code="${coupon.couponCode}"
                  data-coupon-rate="${coupon.couponRate}"
                  style="border:1px solid #eee; border-radius:6px; padding:10px; margin-bottom:10px;">
                <div class="coupon-info">
                  <span class="coupon-code" style="font-weight:bold; color:#ff8200; font-size:16px;">
                      ${coupon.couponCode}
                  </span>
                  <span class="coupon-name" style="display:block; margin-top:5px;">
                      ${coupon.couponName}
                  </span>
                  <span class="coupon-rate" style="color:#555;">(${coupon.couponRate}% 할인)</span><br/>
                  <span class="coupon-expiration" style="font-size:12px; color:#999;">
                    ~ ${coupon.expireDate} 까지 사용 가능
                  </span>
                </div>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div class="modal-footer" style="padding:15px; text-align:right; border-top:1px solid #eee;">
          <button type="button" class="coupon-modal-cancel modal-close"
                  style="background:#ccc; color:#333; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; margin-right:10px;">
            취소
          </button>
          <button type="button" class="coupon-modal-apply"
                  style="background:#ff8200; color:#fff; border:none; padding:10px 20px; border-radius:4px; cursor:pointer;">
            쿠폰 적용
          </button>
        </div>
      </div>
    </div>
  </form>
</div>

<!-- 배송지 변경 모달 -->
<div id="modalOverlay" class="modal-overlay">
  <div class="modal">
    <div class="modal-header">
      <h3>배송지 변경</h3>
      <button type="button" class="modal-close">&times;</button>
    </div>
    <div class="modal-body">
      <div id="modalAddressList">
        <c:choose>
          <c:when test="${not empty shippingAddresses}">
            <ul style="list-style:none; padding-left:0;">
              <c:forEach var="addr" items="${shippingAddresses}">
                <li class="address-item"
                    data-receiverName="${addr.receiverName}"
                    data-addName="${addr.addName}"
                    data-addTitle="${addr.addTitle}"
                    data-addDetail="${addr.addDetail}"
                    data-phone="${addr.phone}"
                    data-postcode="${addr.postCode}">
                  <div class="address-info">
                    <strong>${addr.receiverName}</strong>
                    - ${addr.addTitle} ${addr.addDetail}
                    - ${addr.phone}
                    <c:if test="${addr.firstAdd == 1}">(기본 배송지)</c:if>
                  </div>
                  <button type="button" class="btn-select-address">선택</button>
                </li>
              </c:forEach>
            </ul>
          </c:when>
          <c:otherwise>
            <p>등록된 배송지가 없습니다.</p>
          </c:otherwise>
        </c:choose>
        <button type="button" id="btnAddNewAddress">배송지 추가하기</button>
      </div>
      <div id="modalAddressForm" style="display:none;">
        <label for="modalReceiverName">받는 분</label>
        <input type="text" name="receiverName" id="modalReceiverName" placeholder="수령인 예) 홍길동" />
        <input type="hidden" name="memberIdx" value="${sessionScope.member.memberIdx}">
        <label for="modalAddName">배송지명</label>
        <input type="text" name="addName" id="modalAddName" placeholder="배송지명 예) 집" />
        <label for="modalPostCode">우편번호</label>
        <div style="display:flex; gap:8px; margin-bottom:15px;">
          <input type="text" name="postCode" id="modalPostCode" placeholder="우편번호" style="flex:1;" readonly />
          <button type="button" id="btnSearchPostCode" style="padding:8px;">우편번호 찾기</button>
        </div>
        <label for="modalAddress">주소</label>
        <input type="text" name="addTitle" id="modalAddress" placeholder="기본주소 입력" />
        <label for="modalAddressDetail">상세주소</label>
        <input type="text" name="addDetail" id="modalAddressDetail" placeholder="상세주소 입력" />
        <label for="modalPhone">연락처</label>
        <input type="text" name="phone" id="modalPhone" placeholder="예) 010-1234-5678" />
        <label for="modalFirstAdd" style="display:block; margin-top:10px;">
          <input type="checkbox" name="firstAdd" id="modalFirstAdd" value="1">
          기본 배송지로 사용
        </label>
        <button type="button" id="btnShowAddressList">목록 보기</button>
      </div>
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

<script>
  function sample6_execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
        $("#modalPostCode").val(data.zonecode);
        $("#modalAddress").val(addr);
        $("#modalAddressDetail").focus();
      }
    }).open();
  }

  $(document).ready(function() {
    // 배송시 요청사항 처리
    const $deliverySelect = $('.shipping-box .memo-input');
    const $otherRequestDiv = $('#otherRequestDiv');
    const $otherInput = $('#otherRequestInput');

    $deliverySelect.change(function() {
      if ($(this).val() === 'other') {
        $otherRequestDiv.show();
      } else {
        $otherRequestDiv.hide();
      }
    });

    $('form[name=orderSubmit]').submit(function () {
      if ($deliverySelect.val() === 'other') {
        const otherVal = $otherInput.val().trim();
        if (otherVal) {
          $deliverySelect.removeAttr('name');
          $(this).append('<input type="hidden" name="require" value="'+otherVal+'">');
        }
      }
    });

    // (B) 배송지 변경 모달
    const $modalOverlay = $('#modalOverlay');
    const $closeButtons = $('.modal-close');

    $('.btn-addr-change').click(function() {
      $('#modalAddressList').show();
      $('#modalAddressForm').hide();
      $modalOverlay.css('display','flex');
    });
    $closeButtons.click(function() {
      $modalOverlay.hide();
      $('#couponModalOverlay').hide();
    });
    $('#btnAddNewAddress').click(function() {
      $('#modalAddressList').hide();
      $('#modalAddressForm').show();
      $('#modalReceiverName, #modalAddName, #modalPostCode, #modalAddress, #modalAddressDetail, #modalPhone').val('');
      $('#modalFirstAdd').prop('checked', false);
    });
    $('#btnShowAddressList').click(function() {
      $('#modalAddressForm').hide();
      $('#modalAddressList').show();
    });
    $('#btnSearchPostCode').click(function() {
      sample6_execDaumPostcode();
    });

    // 배송지 선택
    $(document).on('click', '.btn-select-address', function() {
      const $li = $(this).closest('.address-item');
      const receiverName = $li.data('receivername');
      const addTitle = $li.data('addtitle');
      const addDetail = $li.data('adddetail');
      const phone = $li.data('phone');
      const postCode = $li.data('postcode');
      const addName = $li.data('addname'); // 서버에 저장 시 필요하다면 사용

      $('.recipient-name').text(receiverName);
      $('.recipient-phone').text(phone);
      let newAddrHtml = addTitle;
      if(addDetail) newAddrHtml += ' ' + addDetail;
      $('.addr-text').html(newAddrHtml);

      // 서버에 선택된 주소 업데이트 (예시 Ajax)
      $.ajax({
        url: '${pageContext.request.contextPath}/order/selectAddress',
        type: 'post',
        data: { receiverName, addTitle, addDetail, phone, postCode },
        success: function(response) {
          if(response.status === "success") {
            $modalOverlay.hide();
            $("#hiddenAddrName").val(addName);
            $("#hiddenPostCode").val(postCode);
            $("#hiddenAddTitle").val(addTitle);
            $("#hiddenAddDetail").val(addDetail);
            $("#hiddenPhone").val(phone);
            $("#hiddenReceiverName").val(receiverName);
          } else {
            alert("배송지 선택에 실패했습니다: " + response.message);
          }
        },
        error: function(xhr) {
          console.log(xhr.responseText);
        }
      });
    });

    // 신규 배송지 등록
    $('.modal-save').click(function() {
      if ($('#modalAddressForm').is(':visible')) {
        const receiverName  = $('#modalReceiverName').val();
        const addName       = $('#modalAddName').val();
        const postCode      = $('#modalPostCode').val();
        const addTitle      = $('#modalAddress').val();
        const addDetail     = $('#modalAddressDetail').val();
        const phone         = $('#modalPhone').val();
        const firstAdd      = $('#modalFirstAdd').is(':checked') ? 1 : 0;

        if(!receiverName) { alert('받는 분을 입력하세요.'); return; }
        if(!addTitle) { alert('주소를 입력하세요.'); return; }
        if(!phone) { alert('연락처를 입력하세요.'); return; }

        $.ajax({
          url: '${pageContext.request.contextPath}/order/insertAddress',
          type: 'post',
          data: { receiverName, addName, postCode, addTitle, addDetail, phone, firstAdd },
          dataType: 'json',
          success: function(data) {
            if(data.status === 'success') {
              alert('배송지 등록 성공');
              // 화면 반영
              $('.recipient-name').text(receiverName);
              $('.recipient-phone').text(phone);
              let newAddrHtml = addTitle + (addDetail ? ' ' + addDetail : '');
              $('.addr-text').html(newAddrHtml);

              // hidden 값들도 업데이트
              $modalOverlay.hide();
              $("#hiddenAddrName").val(receiverName);
              $("#hiddenPostCode").val(postCode);
              $("#hiddenAddTitle").val(addTitle);
              $("#hiddenAddDetail").val(addDetail);
              $("#hiddenPhone").val(phone);
              $("#hiddenReceiverName").val(receiverName);
            } else {
              alert('등록 실패: ' + (data.message || '알 수 없는 오류'));
            }
          },
          error: function(xhr) {
            console.log(xhr.responseText);
          }
        });
      } else {
        $modalOverlay.hide();
      }
    });

    // (C) 포인트 처리
    $('.point-btn').click(function() {
      const fullPoint = parseInt("${balance}", 10) || 0;
      $("input[name=spentPoint]").val(fullPoint);
      updateFinalPriceByPoint();
    });
    $("input[name=spentPoint]").on("input", function(){
      updateFinalPriceByPoint();
    });
    function updateFinalPriceByPoint() {
      // originalTotal: 서버에서 계산한 overallNetPay (배송비 포함)
      let originalTotal = parseInt("${overallNetPay}", 10) || 0;
      let discountAmt = parseInt($('#discountAmount').val(), 10) || 0;
      let usedPoint = parseInt($("input[name=spentPoint]").val(), 10) || 0;

      // 쿠폰 적용 후
      let afterCoupon = originalTotal - discountAmt;
      if(afterCoupon < 0) afterCoupon = 0;

      // 포인트가 쿠폰적용금액보다 많으면 제한
      if(usedPoint > afterCoupon) {
        usedPoint = afterCoupon;
        $("input[name=spentPoint]").val(usedPoint);
      }

      let finalTotal = afterCoupon - usedPoint;
      if(finalTotal < 0) finalTotal = 0;

      // 화면 갱신
      $("#finalNetPay").text(finalTotal.toLocaleString() + "원");
      $("#finalNetPayInput").val(finalTotal);
    }

    // (D) 쿠폰 모달
    $('#openCouponModal').click(function(){
      $('#couponModalOverlay').css('display','flex');
    });
    $('.coupon-modal-close').click(function(){
      $('#couponModalOverlay').hide();
    });

    // 쿠폰 선택 표시
    $(document).on('click', '.coupon-item', function(){
      $('.coupon-item').removeClass('selected').css('background', '');
      $(this).addClass('selected').css('background', '#f7f7f7');
    });

    // 쿠폰 적용 버튼
    $('.coupon-modal-apply').click(function(){
      const selected = $('.coupon-item.selected');
      if(selected.length === 0){
        alert("쿠폰을 선택해주세요.");
        return;
      }
      const couponCode = selected.data('coupon-code');
      const couponRate = parseInt(selected.data('coupon-rate'), 10) || 0;

      // 장바구니(또는 서버) 기준 총액
      let originalTotal = parseInt("${overallNetPay}", 10) || 0;
      // 할인금액 계산
      let discountAmount = Math.floor(originalTotal * couponRate / 100);
      if(discountAmount < 0) discountAmount = 0;

      // 화면 & hidden 세팅
      $("#couponCode").val(couponCode);
      $("#couponValue").val(discountAmount);
      $('#discountAmount').val(discountAmount);
      $(".couponDiscount").text("-" + discountAmount.toLocaleString() + "원");

      // 포인트 재적용 로직
      let usedPoint = parseInt($("input[name=spentPoint]").val(), 10) || 0;
      let afterCoupon = originalTotal - discountAmount;
      if(afterCoupon < 0) afterCoupon = 0;
      if(usedPoint > afterCoupon) {
        usedPoint = afterCoupon;
        $("input[name=spentPoint]").val(usedPoint);
      }
      let finalTotal = afterCoupon - usedPoint;
      if(finalTotal < 0) finalTotal = 0;
      $("#finalNetPay").text(finalTotal.toLocaleString() + "원");
      $("#finalNetPayInput").val(finalTotal);

      alert("쿠폰 " + couponCode + " (" + couponRate + "% 할인)이 적용되었습니다.");
      $('#couponModalOverlay').hide();
    });
  });
</script>
</body>
</html>
