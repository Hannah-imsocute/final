<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>주문 상세보기</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 간단한 스타일 추가 -->
    <style>
        /* 기본 설정 */
        * {
            box-sizing: border-box;
        }
        body, html {
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
            background-color: #fff;
            color: #333;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            color: #fa7c00;
        }
        header {
            position: relative !important;
        }

        /* 메인 컨테이너 */
        .main-container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            min-height: 80vh;
            padding: 20px;
        }
        .content {
            flex: 1;
            background-color: #fff;
            margin-left: 20px;
        }

        /* 주문 상세 타이틀 */
        .order-detail-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .order-detail-title h2 {
            margin: 0;
            font-size: 1.4rem;
            font-weight: 700;
        }
        .order-detail-title .order-date {
            font-size: 0.95rem;
            color: #666;
        }

        /* 카드 공통 스타일 */
        .card {
            background-color: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .card h3 {
            margin-top: 0;
            margin-bottom: 1em;
            font-size: 1.2rem;
            font-weight: bold;
            color: #fa7c00;
        }
        .card p {
            margin: 6px 0;
            line-height: 1.4;
            font-size: 0.95rem;
        }
        .card .label {
            font-weight: 600;
            margin-right: 5px;
        }

        /* 주문 정보가 없을 때 */
        .no-order-msg {
            color: #999;
            font-size: 1.1rem;
            margin-top: 40px;
            text-align: center;
        }

        /* 주문 상품 정보 영역 */
        .order-items {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        .order-items img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .order-items .item-info {
            flex: 1;
        }
        .order-items .item-info p {
            margin: 4px 0;
        }
        .order-items .price-info {
            text-align: right;
            margin-left: 15px;
        }

        /* 배송 정보와 결제 정보 2단 레이아웃 */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }
            .content {
                margin-left: 0;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<div class="main-container">
    <!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

    <div class="content">

        <!-- 주문 상세 제목 + 날짜 -->
        <div class="order-detail-title">
            <h2>주문 상세보기</h2>
            <c:if test="${not empty orderDetail}">
                <span class="order-date">
                    ${orderDetail.orderDate}
                </span>
            </c:if>
        </div>

        <!-- 주문 정보가 없는 경우 -->
        <c:if test="${empty orderDetail}">
            <p class="no-order-msg">주문 정보를 찾을 수 없습니다.</p>
        </c:if>

        <!-- 주문 정보가 있는 경우 -->
        <c:if test="${not empty orderDetail}">

            <!-- 주문 상품 정보 -->
            <div class="card">
                <h3>주문정보</h3>
                <div class="order-items">
                        <%-- 할인금액 계산: (총 상품금액 × (할인율 / 100)) --%>
                    <c:set var="discountPrice" value="${orderDetail.price * orderDetail.quantity * (orderDetail.discount / 100.0)}" />
                    <img src="${pageContext.request.contextPath}/uploads/product/${orderDetail.thumbnail}"
                         alt="상품이미지" />
                    <div class="item-info">
                        <p class="product-name">
                            <strong>${orderDetail.productName}</strong>
                        </p>
                        <p> 주문번호:
                            <stront>${orderDetail.orderCode}</stront>
                        </p>
                        <p>상품가격:
                            <fmt:formatNumber value="${orderDetail.priceforeach}" pattern="#,###"/>원
                        </p>
                        <p>상품수량:
                            ${orderDetail.quantity}개
                        </p>
                        <p>할인금액:
                            <fmt:formatNumber value="${discountPrice}" pattern="#,###"/>원
                        </p>
                        <p>배송비:
                            <fmt:formatNumber value="${orderDetail.shipping}" pattern="#,###"/>원
<%--                        <div class="shipping-fee">${orderDetail.shipping == 0 ? '배송비:무료' : orderDetail.shipping}</div>--%>
                        </p>
                    </div>
                    <div class="price-info">
                        <p>최종 결제금액</p>
                        <p style="font-size:1.1rem; font-weight:700; color:#fa7c00;">
                            <fmt:formatNumber value="${orderDetail.netPay}" pattern="#,###"/>원
                        </p>
                    </div>
                </div>
            </div>

            <!-- 배송 정보 & 결제 정보 -->
            <div class="info-grid">
                <!-- 배송 정보 -->
                <div class="card">
                    <h3>배송정보</h3>
                    <p>
                        <span class="label">배송지:</span>
                            ${orderDetail.addrTitle} / ${orderDetail.addrDetail}
                    </p>
                    <p>
                        <span class="label">연락처:</span>
                            ${orderDetail.phone}
                    </p>
                </div>

                <!-- 결제 정보 -->
                <div class="card">
                    <h3>결제정보</h3>
                    <p class="label">카드사 : ${orderDetail.bymethod}</p>
                    <fmt:formatNumber value="${orderDetail.cardNumber}" pattern="0" var="cardStr" />
                    <c:if test="${fn:length(cardStr) > 6}">
                        <p class="label">카드 번호: ${fn:substring(cardStr, 0, 6)}*****${fn:substring(cardStr, 6, 12)}</p>
                    </c:if>
                    <p class="label">승인 번호: ${orderDetail.confirmCode}</p>
                    <p class="label">승인 날짜: ${orderDetail.confirmDate}</p>
                    <p>
                        <span class="label">결제금액:</span>
                        <fmt:formatNumber value="${orderDetail.netPay}" pattern="#,###"/>원
                    </p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
</body>
</html>