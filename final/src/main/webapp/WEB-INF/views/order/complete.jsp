<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문완료</title>

  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
      color: #333;
      margin: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }

    .complete-container {
      max-width: 500px;
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .complete-container h2 {
      font-size: 26px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #007aff;
    }

    .complete-container p.desc {
      font-size: 16px;
      color: #666;
      margin-bottom: 20px;
    }

    .order-info-box {
      background: #f1f3f5;
      padding: 20px;
      border-radius: 8px;
      text-align: left;
      font-size: 14px;
      line-height: 1.6;
    }

    .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
    }

    .label {
      color: #555;
    }

    .value {
      font-weight: 600;
      color: #222;
    }

    .highlight {
      color: #e63946;
      font-size: 18px;
      font-weight: bold;
    }

    .btn-home {
      width: 100%;
      padding: 12px;
      background: #007aff;
      color: white;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.3s;
    }

    .btn-home:hover {
      background: #005bb5;
    }
  </style>
</head>
<body>
<div class="complete-container">
  <h2>주문 완료</h2>
  <p class="desc">구매해주셔서 감사합니다.</p>
  <div class="order-info-box">
    <div class="info-row">
      <div class="label">결제 금액</div>
      <div class="value highlight">
        <fmt:formatNumber value="${order.netPay}" pattern="#,###"/>원
      </div>
    </div>
    <div class="info-row">
      <div class="label">주문번호</div>
      <div class="value">${order.orderCode}</div>
    </div>
    <div class="info-row">
      <div class="label">배송지</div>
      <div class="value">
        <c:out value="${receiverName}" /> / <c:out value="${phone}" /><br />
        <c:out value="${addrTitle}" />
      </div>
    </div>
    <c:if test="${not empty shippingMemo}">
      <div class="info-row">
        <div class="label">배송 메모</div>
        <div class="value"><c:out value="${shippingMemo}" /></div>
      </div>
    </c:if>
  </div>
  <button class="btn-home" onclick="location.href='${pageContext.request.contextPath}/'">
    홈으로
  </button>
</div>
</body>
</html>
