<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>주문완료</title>

  <!-- 공통 CSS/JS 로드 -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <!-- 폰트 로드 -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />

  <style>
    header {
      position: relative !important; /* 기존 fixed 해제 */
    }

    /* 기본 리셋 */
    *, *::before, *::after {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f2f5;
      color: #333;
    }
    a {
      text-decoration: none;
      color: inherit;
    }

    /* 메인 컨테이너 */
    .complete-container {
      max-width: 500px;
      margin: 60px auto;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      padding: 30px;
      text-align: center;
    }

    .complete-container h2 {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 10px;
    }
    .complete-container p.desc {
      font-size: 14px;
      color: #666;
      margin-bottom: 30px;
    }

    /* 주문 정보 영역 */
    .order-info-box {
      text-align: left;
      margin-bottom: 30px;
      line-height: 1.6;
      border: 1px solid #eee;
      border-radius: 6px;
      padding: 20px;
      background-color: #fafafa;
    }
    .order-info-box .info-row {
      display: flex;
      justify-content: space-between;
      font-size: 14px;
      margin-bottom: 12px;
    }
    .order-info-box .label {
      color: #555;
    }
    .order-info-box .value {
      font-weight: 500;
    }
    .order-info-box .highlight {
      color: #0066cc;
      font-weight: 700;
    }

    /* 홈으로 버튼 */
    .btn-home {
      display: inline-block;
      width: 100%;
      padding: 15px 0;
      background-color: #0066cc;
      color: #fff;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .btn-home:hover {
      background-color: #005bb5;
    }

    @media (max-width: 576px) {
      .complete-container {
        margin: 30px 10px;
        padding: 20px;
      }
    }
  </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>

<main>
  <!-- 주문 완료 컨테이너 -->
  <div class="complete-container">
    <!-- 타이틀 -->
    <h2>주문완료</h2>
    <p class="desc">아래 계좌정보로 입금해 주시면 결제 완료처리가 됩니다.</p>

    <!-- 주문 정보 요약 박스 -->
    <div class="order-info-box">
      <!-- 입금 계좌 안내 -->
      <div class="info-row">
        <div class="label">입금계좌 안내</div>
        <div class="value highlight">
          <!-- 예: 기업은행 123-456-789012 (예금주 홍길동) -->
          <c:out value="${depositBank}" />
          <c:out value="${depositAccount}" />
          (<c:out value="${depositHolder}" />)
        </div>
      </div>

      <!-- 결제 금액 -->
      <div class="info-row">
        <div class="label">결제 금액</div>
        <div class="value highlight">
          <fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원
        </div>
      </div>

      <!-- 주문번호 -->
      <div class="info-row">
        <div class="label">주문번호</div>
        <div class="value">
          <c:out value="${orderNumber}" />
        </div>
      </div>

      <!-- 배송지 -->
      <div class="info-row">
        <div class="label">배송지</div>
        <div class="value">
          <c:out value="${receiverName}" /> / <c:out value="${receiverPhone}" /><br />
          <c:out value="${receiverAddress}" />
        </div>
      </div>

      <!-- 배송 방법 -->
      <div class="info-row">
        <div class="label">배송 방법</div>
        <div class="value">택배</div>
      </div>

      <!-- 배송 메모 -->
      <c:if test="${not empty shippingMemo}">
        <div class="info-row">
          <div class="label">배송 메모</div>
          <div class="value">
            <c:out value="${shippingMemo}" />
          </div>
        </div>
      </c:if>
    </div>

    <!-- 홈으로 버튼 -->
    <button class="btn-home" onclick="location.href='${pageContext.request.contextPath}/'">
      홈으로
    </button>
  </div>
</main>

<!-- 푸터 -->
<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>
</body>
</html>
