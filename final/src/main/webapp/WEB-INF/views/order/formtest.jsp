<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문결제</title>
  <!-- 공통 CSS/JS 로드 (jQuery 포함 여부 확인) -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
  <!-- 만약 jQuery가 없다면 아래 주석을 해제 -->
  <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
  <!-- 폰트 로드 -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />
  <!-- 다음 우편번호 API -->
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
    .order-content { display: flex; gap: 20px; flex-wrap: wrap; }
    .order-left { flex: 1 1 0; min-width: 320px; }
    .order-right { width: 380px; flex-shrink: 0; }
    .order-section { background-color: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
    .order-section h3 { margin-bottom: 10px; font-size: 18px; font-weight: 600; border-bottom: 1px solid #eee; padding-bottom: 8px; }

    /* 배송지 영역(개선) */
    .shipping-box { position: relative; }
    /* 상단: 받는 분 + 연락처 왼쪽, 배송지 변경 버튼 오른쪽 */
    .shipping-box .shipping-header {
      display: flex;
      justify-content: space-between;
      align-items: center; /* 세로 중앙 정렬 */
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
    /* 주소 영역 */
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

    /* 쿠폰/포인트 사용 영역(개선) */
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
    .point-guide {
      margin-top: 15px;
      font-size: 14px;
      color: #999;
    }

    /* 결제수단 */
    .payment-box .card-list { display: flex; gap: 10px; flex-wrap: wrap; }
    .payment-box .card-item {
      width: 120px; height: 60px; background-color: #f2f2f2; border-radius: 4px; border: 1px solid #eee;
      display: flex; align-items: center; justify-content: center; font-size: 13px; color: #666;
      cursor: pointer; transition: background-color 0.3s;
    }
    .payment-box .card-item:hover { background-color: #ebebeb; }

    /* 주문 요약 */
    .order-summary-box { background-color: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
    .order-summary-box h3 { font-size: 18px; font-weight: 600; margin-top: 0; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 8px; }
    .product-list { margin-bottom: 20px; }
    .product-list-header, .product-list-item { display: flex; align-items: center; padding: 10px 0; border-bottom: 1px solid #eee; }
    .product-list-header { font-weight: bold; background-color: #f9f9f9; }
    .product-list-item:last-child { border-bottom: none; }
    .product-list .column { text-align: center; flex: 1; }
    .product-list .column.image { flex: 0 0 60px; }
    .product-list .column.image img { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; }
    .sum-area { font-size: 14px; line-height: 1.6; text-align: right; }
    .sum-area .highlight { font-size: 16px; font-weight: bold; color: #333; }
    .btn-submit-order {
      display: block; width: 100%; padding: 14px 0; background-color: #ff8200; color: #fff;
      border: none; border-radius: 6px; font-size: 16px; cursor: pointer; margin-top: 20px;
      transition: background-color 0.3s;
    }
    .btn-submit-order:hover { background-color: #ff8400; }
    @media (max-width: 768px) {
      .order-right { width: 100%; order: -1; }
    }

    /* 모달창 */
    .modal-overlay {
      position: fixed; top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0,0,0,0.4); z-index: 9999;
      display: none; align-items: center; justify-content: center;
    }
    .modal {
      display: block !important; background-color: #fff; border-radius: 8px; width: 320px; max-width: 90%;
      padding: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.2); position: relative; z-index: 10000; border: 1px solid #ccc;
    }
    .modal-header {
      display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px;
    }
    .modal-header h3 { margin: 0; font-size: 18px; font-weight: 600; }
    .modal-header .modal-close {
      border: none; background: transparent; font-size: 24px; line-height: 1; cursor: pointer;
    }
    .modal-body label {
      display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px;
    }
    .modal-body input {
      width: 100%; margin-bottom: 15px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;
    }
    .modal-footer {
      display: flex; justify-content: flex-end; gap: 8px;
    }
    .modal-footer button {
      padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;
    }
    .modal-footer .modal-save { background-color: #ff8200; color: #fff; }
    .modal-footer .modal-cancel { background-color: #ccc; }

    /* 배송지 목록 항목 */
    .address-item {
      border-bottom: 1px solid #eee; padding: 8px 0; display: flex; align-items: center; justify-content: space-between;
    }
    .address-info { font-size: 14px; line-height: 1.4; }
    .btn-select-address {
      padding: 4px 8px; border: 1px solid #ddd; background: #fff; border-radius: 4px; cursor: pointer;
      transition: background-color 0.3s; font-size: 12px;
    }
    .btn-select-address:hover { background-color: #f9f9f9; }

    /* ★ 쿠폰 모달 */
    #couponModalOverlay { display: none; }
    #couponModalOverlay .modal {
      width: 400px; max-width: 90%; border: none; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }
    #couponModalOverlay .modal-header {
      background: #ff8200; color: #fff; padding: 15px; border-top-left-radius: 8px; border-top-right-radius: 8px;
    }
    #couponModalOverlay .modal-header h3 {
      margin: 0; font-size: 20px;
    }
    #couponModalOverlay .modal-body {
      max-height: 300px; overflow-y: auto; padding: 15px;
    }
    #couponModalOverlay .coupon-list { list-style: none; padding: 0; margin: 0; }
    #couponModalOverlay .coupon-item {
      border: 1px solid #eee; border-radius: 6px; padding: 10px; margin-bottom: 10px; transition: background 0.3s; cursor: pointer;
    }
    #couponModalOverlay .coupon-item:hover { background: #f7f7f7; }
    #couponModalOverlay .modal-footer {
      padding: 15px; text-align: right; border-top: 1px solid #eee;
    }
    #couponModalOverlay .coupon-modal-apply {
      background: #ff8200; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; transition: background 0.3s;
    }
    #couponModalOverlay .coupon-modal-apply:hover { background: #e66a00; }
    #couponModalOverlay .coupon-modal-cancel {
      background: #ccc; color: #333; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; margin-right: 10px; transition: background 0.3s;
    }
    #couponModalOverlay .coupon-modal-cancel:hover { background: #b3b3b3; }
  </style>
</head>
<body>
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
      <!-- 배송지 정보 (개선된 구조) -->
      <div class="order-section shipping-box">
        <h3>배송지 정보</h3>
        <!-- 받는 분 + 연락처, 배송지 변경 버튼 한 줄 -->
        <div class="shipping-header">
          <div class="recipient-info">
            <strong class="recipient-name"><c:out value="${receiverName}" /></strong>
            <span class="recipient-phone"><c:out value="${phone}" /></span>
          </div>
          <button type="button" class="btn-addr-change">배송지 변경</button>
        </div>
        <!-- 주소 표시 박스 -->
        <div class="addr-text">
          <c:if test="${not empty addTitle}">
            <c:out value="${addTitle}" /> <c:out value="${addDetail}" /><br/>
          </c:if>
        </div>

        <!-- 배송시 요청사항(메모) -->
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
                 style="width:100%; padding:8px; font-size:14px; border:1px solid #ddd; border-radius:4px;" />
        </div>
      </div>

      <!-- 할인 및 포인트 (개선된 구조) -->
      <div class="order-section discount-box">
        <h3>쿠폰 및 포인트 사용</h3>
        <!-- 쿠폰 할인 / 버튼을 가로로 배치 -->
        <div class="coupon-discount-row">
          <div class="coupon-discount-left">
            <span>쿠폰할인&nbsp;</span>
            <strong class="couponDiscount">0원</strong>
          </div>
          <div class="coupon-discount-right">
            <button type="button" id="openCouponModal" class="coupon-btn">쿠폰 적용</button>
          </div>
        </div>

        <!-- 포인트 사용 영역 -->
        <div class="point-use-row">
          <span>나의 포인트 <strong>${memberPoint.balance}원</strong></span>
          <div class="point-input-wrap">
            <input type="text" name="balance" placeholder="0" />
            <button type="button" class="point-btn">전액사용</button>
          </div>
        </div>
        <div class="point-guide">
          제휴포인트도 스마일캐시로 전환하세요!<br/>
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
                <img src="#" alt="상품 이미지"/>
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
          상품금액:
          <span>
            <fmt:formatNumber value="${productTotal}" pattern="#,###" />원
          </span><br/>
          할인금액: <span style="color:#f05;" class="couponDiscount">-0원</span><br/>
          배송비:
          <span>
            <fmt:formatNumber value="${shippingFee}" pattern="#,###" />원
          </span><br/><br/>
          총 결제금액:
          <span class="highlight" id="finalNetPay">
            <fmt:formatNumber value="${overallNetPay}" pattern="#,###" />원
          </span>
        </div>
        <!-- 결제하기 버튼 -->
        <form action="${pageContext.request.contextPath}/order/submit" name="orderSubmit" method="post">
          <!-- 필요 시 hidden 필드 추가 -->
          <button class="btn-submit-order" type="submit">결제하기</button>
          <input type="hidden" name="discountAmount" id="discountAmount" value="" />
          <input type="hidden" name="finalNetPay" id="finalNetPayInput" value="" />
        </form>
      </div>
    </div> <!-- //order-right -->
  </div> <!-- //order-content -->
</div> <!-- //order-page-container -->

<!-- 배송지 변경 모달 (기존 유지) -->
<div id="modalOverlay" class="modal-overlay">
  <div class="modal">
    <div class="modal-header">
      <h3>배송지 변경</h3>
      <!-- 닫기 버튼 -->
      <button type="button" class="modal-close">&times;</button>
    </div>
    <div class="modal-body">
      <!-- 주소 목록 영역 (초기에는 목록 모드) -->
      <div id="modalAddressList">
        <c:choose>
          <c:when test="${not empty shippingAddresses}">
            <ul style="list-style:none; padding-left:0;">
              <c:forEach var="addr" items="${shippingAddresses}">
                <li class="address-item"
                    data-receiverName="${addr.receiverName}"
                    data-addTitle="${addr.addTitle}"
                    data-addDetail="${addr.addDetail}"
                    data-phone="${addr.phone}">
                  <div class="address-info">
                    <strong>${addr.receiverName}</strong> - ${addr.addTitle} ${addr.addDetail} - ${addr.phone}
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
      <!-- 새 배송지 등록 폼 (초기에는 숨김) -->
      <div id="modalAddressForm" style="display: none;">
        <label for="modalReceiverName">받는 분</label>
        <input type="text" name="receiverName" id="modalReceiverName" placeholder="수령인 예) 홍길동" />
        <input type="hidden" name="memberIdx" value="${sessionScope.member.memberIdx}">

        <label for="modalAddName">배송지명</label>
        <input type="text" name="addName" id="modalAddName" placeholder="배송지명 예) 집" />

        <label for="modalPostCode">우편번호</label>
        <div style="display: flex; gap: 8px; margin-bottom: 15px;">
          <input type="text" name="postCode" id="modalPostCode" placeholder="우편번호" style="flex:1;" readonly />
          <button type="button" id="btnSearchPostCode" style="padding: 8px;">우편번호 찾기</button>
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

<!-- ★ 쿠폰 모달 -->
<div id="couponModalOverlay" class="modal-overlay">
  <div class="modal" style="width:400px; max-width:90%; border:none; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
    <div class="modal-header" style="background: #ff8200; color: #fff; padding: 15px; border-top-left-radius: 8px; border-top-right-radius: 8px;">
      <h3 style="margin:0; font-size:20px;">보유 쿠폰 선택</h3>
      <button type="button" class="modal-close coupon-modal-close" style="border:none; background:transparent; font-size:24px; cursor:pointer; color:#fff;">&times;</button>
    </div>
    <div class="modal-body" style="padding:15px; max-height:300px; overflow-y:auto;">
      <ul class="coupon-list" style="list-style:none; padding:0; margin:0;">
        <c:forEach var="coupon" items="${couponList}">
          <li class="coupon-item" data-coupon-code="${coupon.couponCode}" data-coupon-rate="${coupon.couponRate}"
              style="border: 1px solid #eee; border-radius: 6px; padding: 10px; margin-bottom: 10px; transition: background 0.3s; cursor: pointer;">
            <div class="coupon-info">
              <span class="coupon-code" style="font-weight:bold; color:#ff8200; font-size:16px;">${coupon.couponCode}</span>
              <span class="coupon-name" style="display:block; margin-top:5px;">${coupon.couponName}</span>
              <span class="coupon-rate" style="color:#555;">(${coupon.couponRate}% 할인)</span><br/>
              <span class="coupon-expiration" style="font-size:12px; color:#999;">~ ${coupon.expireDate} 까지 사용 가능</span>
            </div>
          </li>
        </c:forEach>
      </ul>
    </div>
    <div class="modal-footer" style="padding:15px; text-align:right; border-top:1px solid #eee;">
      <button type="button" class="coupon-modal-cancel modal-close" style="background:#ccc; color:#333; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; margin-right:10px; transition: background 0.3s;">취소</button>
      <button type="button" class="coupon-modal-apply" style="background:#ff8200; color:#fff; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; transition: background 0.3s;">쿠폰 적용</button>
    </div>
  </div>
</div>
<!-- ★ 쿠폰 모달 끝 -->

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<script>
  // AJAX 유틸 함수
  function ajaxFun(url, method, formData, dataType, fn, file = false) {
    const settings = {
      type: method,
      data: formData,
      dataType: dataType,
      success: function(data) { fn(data); },
      error: function(jqXHR) { console.log(jqXHR.responseText); }
    };
    if(file){
      settings.processData = false;
      settings.contentType = false;
    }
    $.ajax(url, settings);
  }

  // 다음 우편번호 API를 모달 input 필드에 적용
  function sample6_execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        var addr = '';
        var extraAddr = '';

        if (data.userSelectedType === 'R') {
          addr = data.roadAddress;
        } else {
          addr = data.jibunAddress;
        }

        if (data.userSelectedType === 'R') {
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
          }
          if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          if(extraAddr !== ''){
            extraAddr = ' (' + extraAddr + ')';
          }
        } else {
          extraAddr = '';
        }

        document.getElementById("modalPostCode").value = data.zonecode;
        document.getElementById("modalAddress").value = addr;
        document.getElementById("modalAddressDetail").focus();
      }
    }).open();
  }

  $(document).ready(function() {
    const $shippingSelect = $('.shipping-box .memo-input');
    const $otherRequestDiv = $('#otherRequestDiv');
    $shippingSelect.change(function() {
      if ($(this).val() === 'other') {
        $otherRequestDiv.show();
      } else {
        $otherRequestDiv.hide();
      }
    });

    // 모달 관련 (배송지 변경)
    const $modalOverlay = $('#modalOverlay');
    // 변경: 클래스명을 btn-addr-info -> btn-addr-change 로 바꿨으므로 아래도 맞춤
    const $btnAddrChange = $('.btn-addr-change');
    const $closeButtons = $('.modal-close');
    const $btnSave = $('.modal-save');

    // 배송지 변경 버튼 클릭시 목록 열기
    $btnAddrChange.click(function() {
      $('#modalAddressList').show();
      $('#modalAddressForm').hide();
      $modalOverlay.css('display','flex');
    });

    // 배송지 추가하기 버튼 클릭시 등록 폼
    $('#btnAddNewAddress').click(function() {
      $('#modalAddressList').hide();
      $('#modalAddressForm').show();
      // 폼 내부 값 초기화
      $('#modalReceiverName').val('');
      $('#modalAddName').val('');
      $('#modalPostCode').val('');
      $('#modalAddress').val('');
      $('#modalAddressDetail').val('');
      $('#modalFirstAdd').prop('checked', false);
      $('#modalPhone').val('');
    });

    // 목록 보기 버튼 클릭 -> 주소 목록으로 전환
    $('#btnShowAddressList').click(function() {
      $('#modalAddressForm').hide();
      $('#modalAddressList').show();
    });

    // 모달 닫기 버튼
    $closeButtons.click(function() {
      $modalOverlay.hide();
      $('#couponModalOverlay').hide();
    });

    // 우편번호 찾기 -> 다음 우편번호 API 호출
    $('#btnSearchPostCode').click(function() {
      sample6_execDaumPostcode();
    });

    // 배송지 선택 버튼 클릭 이벤트
    $(document).on('click', '.btn-select-address', function() {
      const $li = $(this).closest('.address-item');
      const receiverName = $li.data('receivername');
      const addTitle = $li.data('addtitle');
      const addDetail = $li.data('adddetail');
      const phone = $li.data('phone');

      // 화면의 배송 정보 업데이트
      $('.recipient-name').text(receiverName);
      $('.recipient-phone').text(phone);

      let newAddrHtml = addTitle;
      if(addDetail) { newAddrHtml += ' ' + addDetail; }
      $('.addr-text').html(newAddrHtml);

      // 배송지 선택 AJAX 호출 (실제로 서버에 저장 필요하면 사용)
      $.ajax({
        url: '${pageContext.request.contextPath}/order/selectAddress',
        type: 'post',
        data: {
          receiverName: receiverName,
          addTitle: addTitle,
          addDetail: addDetail,
          phone: phone
        },
        success: function(response) {
          if(response.status === "success") {
            $modalOverlay.hide();
          } else {
            alert("배송지 선택에 실패했습니다: " + response.message);
          }
        },
        error: function(xhr) {
          console.log(xhr.responseText);
        }
      });
    });

    // 포인트 전액사용 버튼
    $('.point-btn').click(function (){
      const fullPoint = parseInt("${memberPoint.balance}", 10);
      $("input[name=balance]").val(fullPoint);
      updateFinalPrice();
    });

    // 포인트 사용 입력 필드 변경 시 최종 결제금액 업데이트
    $("input[name=balance]").on("input", function(){
      updateFinalPrice();
    });

    function updateFinalPrice() {
      let originalTotal = parseInt("${overallNetPay}", 10);
      let usedPoint = parseInt($("input[name=balance]").val(), 10) || 0;
      // 사용포인트가 결제금액보다 많으면 결제금액은 0으로 처리
      if(usedPoint > originalTotal) {
        usedPoint = originalTotal;
        $("input[name=balance]").val(usedPoint);
      }
      let finalTotal = originalTotal - usedPoint;
      $("#finalNetPay").html(finalTotal.toLocaleString() + "원");
    }

    // 주소 저장 버튼 (새 배송지 등록)
    $btnSave.click(function() {
      if ($('#modalAddressForm').is(':visible')) {
        const receiverName  = $('#modalReceiverName').val();
        const addName       = $('#modalAddName').val();
        const postCode      = $('#modalPostCode').val();
        const addTitle      = $('#modalAddress').val();
        const addDetail     = $('#modalAddressDetail').val();
        const phone         = $('#modalPhone').val();
        const firstAdd      = $('#modalFirstAdd').is(':checked') ? 1 : 0;

        if (!receiverName) {
          alert('받는 분(수령인)을 입력하세요.');
          return;
        }
        if (!addTitle) {
          alert('주소를 입력하세요.');
          return;
        }
        if (!phone) {
          alert('연락처를 입력하세요.');
          return;
        }

        let formData = {
          receiverName: receiverName,
          addName: addName,
          postCode: postCode,
          addTitle: addTitle,
          addDetail: addDetail,
          phone: phone,
          firstAdd: firstAdd
        };

        // 신규 배송지 등록 AJAX
        $.ajax({
          url: '${pageContext.request.contextPath}/order/insertAddress',
          type: 'post',
          data: formData,
          dataType: 'json',
          success: function(data) {
            if(data.status === 'success') {
              alert('배송지 등록 성공');

              // 화면 표시 갱신
              $('.recipient-name').text(receiverName);
              $('.recipient-phone').text(phone);

              let newAddrHtml = addTitle;
              if(addDetail) { newAddrHtml += ' ' + addDetail; }
              $('.addr-text').html(newAddrHtml);

              $modalOverlay.hide();
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

    // 결제하기 버튼
    $('.btn-submit-order').click(function () {
      alert('구매하기 버튼 클릭');
    });

    // 쿠폰 모달 열기
    $('#openCouponModal').click(function(){
      $('#couponModalOverlay').css('display','flex');
    });
    // 쿠폰 모달 닫기
    $('.coupon-modal-close').click(function(){
      $('#couponModalOverlay').hide();
    });
    // 쿠폰 목록에서 선택
    $(document).on('click', '.coupon-item', function(){
      $('.coupon-item').removeClass('selected').css('background', '');
      $(this).addClass('selected').css('background', '#f7f7f7');
    });
    // 쿠폰 적용
    $('.coupon-modal-apply').click(function(){
      var selected = $('.coupon-item.selected');
      if(selected.length === 0){
        alert("쿠폰을 선택해주세요.");
        return;
      }
      var couponCode = selected.data('coupon-code');
      var couponRate = selected.data('coupon-rate');

      // overallNetPay -> 최종 결제 금액
      let overallNetPayStr = "${overallNetPay}";
      let originalTotal = parseInt(overallNetPayStr.replace(/,/g, ''), 10) || 0;

      // 할인 금액 = 최종 결제 금액 * 할인율 / 100
      let discountAmount = Math.floor(originalTotal * couponRate / 100);
      let finalTotal = originalTotal - discountAmount;

      $(".couponDiscount").text("-" + discountAmount.toLocaleString() + "원");
      $("#finalNetPay").text(finalTotal.toLocaleString() + "원");

      $('#discountAmount').val(discountAmount);
      $('#finalNetPayInput').val(finalTotal);
      alert("쿠폰 " + couponCode + " (" + couponRate + "% 할인) 이(가) 적용되었습니다.");
      $('#couponModalOverlay').hide();
    });
  });
</script>
</body>
</html>