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

    <!-- 예시로 구글 폰트 사용 (선택 사항) -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

    <style>
        /* ==================== Global Reset & Base Style ==================== */
        * {
            box-sizing: border-box;
        }
        header { position: relative !important; }
        body, html {
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
            background-color: #fff; /* 흰색 배경 */
            color: #333;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            text-decoration: none;
            color: #fa7c00; /* 브랜드 컬러(주황)로 hover 시 변경 */
        }

        /* ==================== Header (고정) ==================== */
        header {
            position: fixed; /* 고정 헤더 */
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
        }
        header .header-inner {
            /* 필요 시 여백 조정 */
        }

        /* 헤더와 본문 사이 간격 확보 (.main-container의 margin-top 조정) */
        .main-container {
            margin-top: 10px; /* 헤더 높이에 맞게 조정 */
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
        }

        /* ==================== Sidebar ==================== */
        .sidebar {
            width: 220px;
            margin-top: 20px; /* 사이드바 상단 여백 */
        }
        .profile-box {
            background-color: #fff;
            border: 1px solid #fa7c00;
            border-radius: 8px;
            text-align: center;
            padding: 20px 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
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
        .realname {
            margin-top: 12px;
            font-size: 1rem;
            color: #333;
            font-weight: 700;
        }
        .menu-title {
            text-align: center;
            background-color: #fa7c00;
            color: #fff;
            padding: 12px 0;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 10px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }
        .menu-list {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }
        .menu-item {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }
        .menu-item:last-child {
            border-bottom: none;
        }
        .menu-item .main-text {
            font-weight: 700;
            font-size: 0.95rem;
            margin-bottom: 5px;
        }
        .menu-item .sub-text {
            font-size: 0.85rem;
            color: #888;
        }
        .menu-item .sub-text a {
            display: block;
            margin-bottom: 3px;
        }

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
        .point-box:not(:last-child) {
            border-right: 1px solid #eee;
        }
        .point-box strong {
            display: block;
            margin-top: 8px;
            font-size: 1.2rem;
            color: #fa7c00;
        }
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
        .list-box {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            min-height: 60px;
            margin-bottom: 20px;
            position: relative;
            background-color: #fff;
        }
        .list-box .empty-msg {
            color: #999;
            margin-bottom: 0;
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
        .explore-btn:hover {
            background-color: #e26d00;
        }

        /* ==================== Footer ==================== */
        footer {
            background-color: #f9f9f9;
            padding: 20px 0;
            margin-top: 20px;
            border-top: 1px solid #e5e5e5;
        }
        footer p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
            text-align: center;
        }

        /* ==================== Responsive ==================== */
        @media (max-width: 992px) {
            .sidebar {
                width: 180px;
            }
        }
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                margin-top: 80px; /* 모바일에서도 헤더 높이에 맞게 여백 동일 적용 */
            }
            .sidebar {
                width: 100%;
                margin-bottom: 20px;
            }
            .content {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }
            .point-section {
                flex-direction: column;
            }
            .point-box:not(:last-child) {
                border-right: none;
                border-bottom: 1px solid #eee;
            }
        }

        /* ==================== Modal (쿠폰 모달) ==================== */
        .modal {
            display: none; /* 기본 숨김 */
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5); /* 반투명 배경 */
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
        .modal-content h3 {
            margin-top: 0;
            font-size: 1.4rem;
        }
        .modal-content ul {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
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
        .modal-content li:last-child {
            margin-bottom: 0;
        }
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
        .close:hover,
        .close:focus {
            color: #000;
        }
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
            <input type="file" id="profileFile" name="profileFile" accept="image/*" style="display: none;" onchange="previewProfileImage(event)">
            <button type="button" onclick="document.getElementById('profileFile').click()">
                <img src="http://placehold.it/80x80" alt="프로필" class="profile-pic" id="profilePreview">
            </button>
            <div class="realname">엄기은</div>
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
        <div class="point-section">
            <div class="point-box">
                포인트
                <strong><fmt:formatNumber value="${userPoint.balance}" pattern="#,###" />원</strong>
            </div>
            <!-- 쿠폰 영역: 클릭 시 모달 오픈 -->
            <div class="point-box" id="couponBox" style="cursor:pointer;">
                쿠폰
                <strong><c:out value="${couponCount}"/></strong>
            </div>
            <div class="point-box">
                기프트카드 포인트
                <strong>0P</strong>
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

        <div class="section-title">
            최근 주문 내역
            <c:forEach var="dto" items="${orderList}">
<%--                ${orderList.}--%>
            </c:forEach>
            <a href="#" class="section-more">더보기 &gt;</a>
        </div>
        <div class="list-box">
            <p class="empty-msg">구매 이력이 없습니다.</p>
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
    </div>
</div>

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

<!-- 이미지 미리보기 스크립트 -->
<script>
    function previewProfileImage(event) {
        const file = event.target.files[0];
        if (!file) return; // 파일 없으면 중단
        if (!file.type.startsWith("image/")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById("profilePreview").src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    // 쿠폰 모달 스크립트
    document.addEventListener('DOMContentLoaded', function() {
        var couponBox = document.getElementById('couponBox');
        var modal = document.getElementById('couponModal');
        var closeBtn = modal.querySelector('.close');

        // 쿠폰 박스 클릭 시 모달 열기
        couponBox.addEventListener('click', function() {
            modal.style.display = 'block';
        });

        // 닫기 버튼 클릭 시 모달 닫기
        closeBtn.addEventListener('click', function() {
            modal.style.display = 'none';
        });

        // 모달 외부 클릭 시 모달 닫기
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>