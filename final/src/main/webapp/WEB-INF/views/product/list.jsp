<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Detail</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/product/product.css">

</head>
<body>
<div class="container product-detail-container">
  <div class="tabs">
    <a href="#" class="active">작품정보</a>
    <a href="#">후기 12</a>
  </div>

  <div class="row">
    <div class="col-md-6">
      <div class="product-image"></div>
      <div class="d-flex justify-content-start mt-3 product-thumbnails">
        <img src="https://via.placeholder.com/60" alt="Thumbnail" class="me-2">
        <img src="https://via.placeholder.com/60" alt="Thumbnail" class="me-2">
        <img src="https://via.placeholder.com/60" alt="Thumbnail">
      </div>
    </div>
    <div class="col-md-6">
      <div class="user-profile">
        <img src="https://via.placeholder.com/50" alt="User Profile">
        <span>엄기은님</span>
      </div>
      <div class="rating-info">
        <span>⭐ 4.8</span> | <span>리뷰 45개</span>
      </div>
      <h5>건강한 전역을 위한 아이템</h5>
      <div class="action-buttons">
        <button>찜하기</button>
        <button onclick="showReportModal()">신고</button>
      </div>
      <div class="d-flex align-items-center mb-2">
        <span class="badge bg-warning text-dark">18%</span>
        <span class="ms-3 discount">15,000원</span>
      </div>
      <div class="price mb-4">12,800원</div>

      <div class="additional-info mb-4">
        <p>적용 즉시 할인: -2,304원</p>
        <p>결제 혜택: 최대 5% 적립</p>
        <p>배송비: 2,500원 (30,000원 이상 구매 시 무료배송)</p>
      </div>

      <div class="mb-4">
        <label for="coupon" class="form-label">적용 가능 쿠폰</label>
        <select id="coupon" class="form-select">
          <option value="">선택하세요</option>
          <option value="1000">1000원 할인</option>
          <option value="2000">2000원 할인</option>
        </select>
      </div>

      <div class="d-flex align-items-center mb-4">
        <input type="number" class="form-control w-25" value="1" min="1">
        <span class="ms-2">건</span>
      </div>

      <div class="mb-4">
        <strong>총 상품 금액</strong>
        <span class="float-end price">12,800원</span>
      </div>

      <div class="d-flex">
        <button class="btn btn-orange me-3">장바구니</button>
        <button class="btn btn-orange">바로구매</button>
      </div>

      <div class="mt-3">
        <button class="btn btn-secondary">작품 문의</button>
        <span>작품 및 배송관련 문의는 작품 문의 버튼을 이용하여 주세요.</span>
      </div>
    </div>
  </div>

  <div class="review-header">
    <h6>후기 (12)</h6>
    <button class="btn btn-link text-decoration-none">후기 작성</button>
  </div>

  <div class="review-summary">
    <div class="d-flex align-items-center">
      <span class="fs-1">⭐</span>
      <span class="fs-2 ms-2">4.9</span>
    </div>
    <div class="photo-thumbnails">
      <img src="https://via.placeholder.com/80" alt="Photo Review">
      <img src="https://via.placeholder.com/80" alt="Photo Review">
      <img src="https://via.placeholder.com/80" alt="Photo Review">
      <img src="https://via.placeholder.com/80" alt="Photo Review">
      <span class="fs-6">+4 더보기</span>
    </div>
  </div>

  <div class="review">
    <strong>원숭이끼끼</strong>
    <span class="text-muted">2025년 1월 22일</span>
    <p>우와 너무 예쁘고 만족스러워요! 최고예요 ㅠㅠ 대박적!!</p>
    <div class="d-flex justify-content-between">
      <button class="btn btn-link">도움이 돼요 ❤️</button>
      <button class="btn btn-link text-danger">신고</button>
    </div>
  </div>
  <div class="review">
    <strong>지두래곤</strong>
    <span class="text-muted">2025년 1월 22일</span>
    <p>부자가 된다면 또 사겠습니다! 제가 로또 1등 되게 해주세요~</p>
    <div class="d-flex justify-content-between">
      <button class="btn btn-link">도움이 돼요 ❤️</button>
      <button class="btn btn-link text-danger">신고</button>
    </div>
  </div>
</div>

<div id="reportModal" class="report-modal">
  <div class="report-modal-header">⚠️ 작품 신고</div>
  <ul>
    <li>광고 표시가 너무 많습니다.</li>
    <li>유해한 이미지를 포함하고 있습니다.</li>
    <li>욕설 / 모욕적인 단어를 포함하고 있습니다.</li>
    <li>판매 금지 품목을 판매하고 있습니다.</li>
    <li>거래 분쟁이 있습니다.</li>
  </ul>
  <button class="btn btn-secondary mt-3" onclick="closeReportModal()">닫기</button>
</div>

<script>
  function showReportModal() {
    document.getElementById('reportModal').style.display = 'block';
  }

  function closeReportModal() {
    document.getElementById('reportModal').style.display = 'none';
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
