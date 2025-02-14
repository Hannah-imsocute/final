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
        /* 기본 리셋 및 글로벌 스타일 */
        header {
            position: relative !important; /* 기존 fixed 해제 */
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

        /* 메인 컨테이너 - 상단 패딩을 줄여 헤더와 가까이 배치 */
        .order-page-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px 40px; /* 상단 패딩 40px로 줄임 */
            min-height: 80vh;
        }

        /* 주문 헤더 영역 (제목과 장바구니 단계를 한 행에 배치) */
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

        /* 좌우 2단 레이아웃 */
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

        /* 공통 박스 스타일 */
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

        /* 배송지 박스 */
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

        /* 할인/스마일캐시 박스 */
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

        /* 결제수단 박스 */
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

        /* 우측 영역 - 주문 상품 요약 */
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

        /* 상품 목록 - DIV 기반 리스트 (테이블 대신) */
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

        /* 금액 합계 영역 */
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

        /* 주문 폼 영역 */
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

        /* 주문(결제) 버튼 */
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

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .order-right {
                width: 100%;
                order: -1;
            }
        }
    </style>
</head>
<body>

<!-- 고정 헤더 (이제 fixed가 아닌 일반 헤더) -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<div class="order-page-container">
    <!-- 주문 헤더: 페이지 제목과 장바구니 단계 -->
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
        <!-- 왼쪽: 배송/할인/결제/주문정보 -->
        <div class="order-left">
            <!-- 배송지 정보 -->
            <div class="order-section shipping-box">
                <h3>배송지 정보</h3>
                <div class="sub-info">
                    받는 분: <strong><c:out value="${receiverName}" /></strong>
                    <button type="button">배송지 변경</button>
                </div>
                <div class="addr-text">
                    <!-- 주소 정보 -->
                    <c:if test="${not empty addTitle}">
                        <c:out value="${addTitle}" /> <c:out value="${addDetail}" /><br/>
                    </c:if>
                    ( <c:out value="${phone}" /> )
                </div>
                <!-- 배송 요청사항 select -->
                <select class="memo-input">
                    <option value="">배송시 요청사항을 선택해주세요.</option>
                    <option value="contact_before">배송 전 연락바랍니다</option>
                    <option value="concierge">부재 시 경비실에 맡겨주세요</option>
                    <option value="door">부재 시 문앞에 놓아주세요</option>
                    <option value="parcel_box">부재 시 택배함에 놓아주세요</option>
                    <option value="other">기타 입력</option>
                </select>
                <!-- 기타 입력 텍스트 필드 (최대 50자, placeholder 적용) -->
                <div id="otherRequestDiv" style="display:none; margin-top:10px;">
                    <input type="text" maxlength="50" placeholder="최대 50자 입력이 가능합니다." style="width:100%; padding:8px; font-size:14px; border:1px solid #ddd; border-radius:4px;">
                </div>
            </div>

            <!-- 할인 & 스마일캐시 -->
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

        <!-- 오른쪽: 상품 목록 / 합계 -->
        <div class="order-right">
            <div class="order-summary-box">
                <h3>주문 상품 목록</h3>

                <!-- 상품 목록 (DIV 기반 리스트) -->
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

                <!-- 합계 계산 -->
                <c:set var="totalPrice" value="0" scope="page" />
                <c:forEach var="cart" items="${cartItems}">
                    <c:set var="lineTotal" value="${cart.quantity * cart.price}" />
                    <c:set var="totalPrice" value="${totalPrice + lineTotal}" scope="page" />
                </c:forEach>

                <div class="sum-area">
                    상품금액: <span>
                            <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                        </span><br/>
                    할인금액: <span style="color:#f05;">-0원</span><br/>
                    배송비: 0원<br/><br/>
                    총 결제금액:
                    <span class="highlight">
                            <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                        </span>
                </div>

                <!-- 결제하기 버튼 추가 -->
                <form action="${pageContext.request.contextPath}/order/submit">
                    <button class="btn-submit-order">결제하기</button>
                </form>
            </div>
        </div> <!-- //order-right -->
    </div> <!-- //order-content -->
</div> <!-- //order-page-container -->

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<!-- JS -->
<script>
    window.addEventListener('DOMContentLoaded', function() {
        const totalPrice = "<c:out value='${totalPrice}'/>";
        const hiddenField = document.getElementById('hiddenTotalPrice');
        if (hiddenField) {
            hiddenField.value = totalPrice;
        }

        // 배송 요청사항 select change event 처리
        const shippingSelect = document.querySelector('.shipping-box .memo-input');
        const otherRequestDiv = document.getElementById('otherRequestDiv');
        if (shippingSelect && otherRequestDiv) {
            shippingSelect.addEventListener('change', function() {
                if (this.value === 'other') {
                    otherRequestDiv.style.display = 'block';
                } else {
                    otherRequestDiv.style.display = 'none';
                }
            });
        }
    });
</script>
</body>
</html>
