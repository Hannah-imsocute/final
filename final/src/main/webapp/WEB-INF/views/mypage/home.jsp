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
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
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

        /* ==================== Sidebar ==================== */
        .sidebar { width: 220px; margin-top: 20px; }
        .profile-box {
            background-color: #fff;
            border: 1px solid #fa7c00;
            border-radius: 8px;
            text-align: center;
            padding: 20px 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .profile-box button {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
        }
        .profile-pic {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto;
        }
        .realname { margin-top: 12px; font-size: 1rem; color: #333; font-weight: 700; }
        .menu-title {
            text-align: center;
            background-color: #fa7c00;
            color: #fff;
            padding: 12px 0;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .menu-list {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .menu-item { padding: 15px 20px; border-bottom: 1px solid #eee; }
        .menu-item:last-child { border-bottom: none; }
        .menu-item .main-text { font-weight: 700; font-size: 0.95rem; margin-bottom: 5px; }
        .menu-item .sub-text { font-size: 0.85rem; color: #888; }
        .menu-item .sub-text a { display: block; margin-bottom: 3px; }

        /* ==================== Content ==================== */
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

        /* 포인트 & 쿠폰 영역 */
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

        /* ==================== 최근 주문 내역 영역 ==================== */
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
        .list-box.recent-orders {
            padding: 20px;
            background-color: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        /* 개별 주문 카드 스타일 */
        .list-box.recent-orders ul {
            margin: 0;
            padding: 0;
        }
        .list-box.recent-orders li {
            list-style: none;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .recent-orders .order-header {
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        /* 이미지 사이즈 고정 및 커버 */
        .recent-orders .order-header .main-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
        }
        .recent-orders .order-code {
            font-weight: 600;
            color: #555;
        }
        .recent-orders .order-date {
            margin-left: auto; /* 오른쪽 정렬 */
            font-size: 0.9rem;
            color: #999;
        }
        .recent-orders .order-body {
            font-size: 1rem;
            margin-bottom: 10px;
        }
        .recent-orders .order-body p {
            margin: 5px 0;
        }
        .recent-orders .product-name {
            font-weight: 600;
            color: #333;
        }
        .recent-orders .order-state, .recent-orders .package-state {
            font-size: 0.9rem;
            color: #666;
        }
        .recent-orders .order-footer {
            text-align: right;
            font-size: 1.1rem;
            font-weight: bold;
            color: #fa7c00;
        }

        .empty-msg { text-align: center; color: #999; }

        /* ==================== 기타 콘텐츠 스타일 ==================== */
        .notice-box, .coupon-box {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            font-size: 0.95rem;
            line-height: 1.4;
        }
        .notice-box { background-color: #fff9f5; border: 1px solid #ffd6c9; color: #555; }
        .coupon-box { background-color: #f2e9ff; border: 1px solid #e2d0ff; color: #333; }
        .coupon-box .highlight { font-weight: 700; color: #a050e3; }
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
            .list-box.recent-orders li { width: 100%; }
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
    </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 본문 컨테이너 -->
<div class="main-container">
    <!-- 사이드바 -->
    <div class="sidebar">
        <div class="profile-box">
            <!-- 프로필 이미지 업로드 폼 (Ajax 전송) -->
            <input type="file" id="profileFile" name="profileFile" accept="image/*" style="display: none;">
            <button type="button" onclick="document.getElementById('profileFile').click()">
                <img src="<c:choose>
                            <c:when test='${not empty profileImageFile}'>
                                ${pageContext.request.contextPath}/uploads/mypage/${profileImageFile}
                            </c:when>
                            <c:otherwise>
                                http://placehold.it/80x80
                            </c:otherwise>
                        </c:choose>"
                     alt="프로필" class="profile-pic" id="profilePreview">
            </button>
            <div class="realname">${userProfile.nickName}</div>
        </div>
        <div class="menu-title">MY MENU</div>
        <div class="menu-list">
            <div class="menu-item">
                <div class="main-text"><a href="#">주문 배송</a></div>
                <div class="sub-text"><a href="#">주문/배송 내역</a></div>
            </div>
            <div class="menu-item">
                <div class="main-text"><a href="#">알림 및 메시지</a></div>
                <div class="sub-text">
                    <a href="#">알림</a>
                    <a href="#">메시지</a>
                </div>
            </div>
            <div class="menu-item">
                <div class="main-text"><a href="#">선물함</a></div>
                <div class="sub-text">
                    <a href="#">받은 선물함</a>
                    <a href="#">보낸 선물함</a>
                </div>
            </div>
            <div class="menu-item">
                <div class="main-text"><a href="#">기프트카드함</a></div>
                <div class="sub-text">
                    <a href="#">받은 카드함</a>
                    <a href="#">보낸 카드함</a>
                </div>
            </div>
            <div class="menu-item">
                <div class="main-text"><a href="#">나의 구매후기</a></div>
                <div class="sub-text">
                    <a href="#">작성 가능한 후기</a>
                    <a href="#">작성한 후기</a>
                </div>
            </div>
        </div>
    </div> <!-- .sidebar -->

    <!-- 메인 콘텐츠 -->
    <div class="content">
        <h2>내 정보</h2>
        <!-- 포인트 & 쿠폰 영역 (기프트카드 영역 제거) -->
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
            <a href="#" class="section-more">더보기 &gt;</a>
        </div>
        <div class="list-box recent-orders">
            <c:choose>
                <c:when test="${not empty ordersHistory}">
                    <ul>
                        <c:forEach var="order" items="${ordersHistory}">
                            <li>
                                <div class="order-header">
                                    <span class="order-code">주문번호: ${order.orderCode}</span>
                                    <span class="order-date">${order.orderDate}</span>
                                    <img src="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}" class="main-image">
                                </div>
                                <div class="order-body">
                                    <p class="product-name">상품명: ${order.productName}</p>
                                    <p class="order-state">주문상태: ${order.orderState}</p>
                                    <p class="package-state">배송상태: ${order.packageState}</p>
                                </div>
                                <div class="order-footer">
                                    <span class="net-pay"><fmt:formatNumber value="${order.netPay}" pattern="#,###" />원</span>
                                </div>
                            </li>
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

<!-- 이미지 미리보기 및 Ajax 업로드 스크립트 (jQuery 사용) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 이미지 미리보기 처리
    function previewProfileImage(event) {
        const file = event.target.files[0];
        if (!file) return;
        if (!file.type.startsWith("image/")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }
        const reader = new FileReader();
        reader.onload = function(e) {
            $("#profilePreview").attr("src", e.target.result);
        };
        reader.readAsDataURL(file);
    }

    $("#profileFile").on("change", function() {
        var file = this.files[0];
        if (!file) return;
        if (!file.type.startsWith("image/")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }
        // 미리보기 호출
        previewProfileImage({ target: { files: [file] } });
        var formData = new FormData();
        formData.append("profileFile", file);
        $.ajax({
            url: "${pageContext.request.contextPath}/mypage/image",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if(response.success) {
                    alert("프로필 이미지가 성공적으로 업로드되었습니다.");
                    $("#profilePreview").attr("src", "${pageContext.request.contextPath}/uploads/mypage/" + response.image);
                } else {
                    alert("프로필 이미지 업로드에 실패하였습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error during file upload:", error);
                alert("에러가 발생하였습니다.");
            }
        });
    });

    // 쿠폰 모달 처리
    $(document).ready(function(){
        var couponBox = document.getElementById('couponBox');
        var modal = document.getElementById('couponModal');
        var closeBtn = modal.querySelector('.close');
        couponBox.addEventListener('click', function() {
            modal.style.display = 'block';
        });
        closeBtn.addEventListener('click', function() {
            modal.style.display = 'none';
        });
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>
