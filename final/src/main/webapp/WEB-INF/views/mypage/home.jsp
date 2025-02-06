<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 정보</title>
    <!-- 공통 CSS/JS 로드 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

    <style>
        /* ========== 기본 리셋 및 전역 스타일 ========== */
        body {
            margin: 0;
            padding: 0;
            font-family: "Arial", sans-serif;
            background-color: #f5f5f5;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            text-decoration: none;
        }

        /* ========== 고정 헤더 (header.jsp로 include) ========== */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 10px; /* 헤더 하단 여백 */
        }

        /* 헤더와 본문 간격 확보 */
        .main-container {
            margin-top: 140px; /* 헤더 높이에 맞춰 여백 조정 */
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
        }

        /* ========== 사이드바 ========== */
        .sidebar {
            width: 220px;
            margin-top: 20px; /* 상단 헤더와 추가 간격 */
        }

        /* 프로필 박스 */
        .profile-box {
            background-color: #fff;
            border: 1px solid #fa7c00; /* 주황색 테두리 */
            border-radius: 4px;
            text-align: center;
            padding: 15px;
            margin-bottom: 10px;
        }
        /* 프로필 이미지 버튼 스타일 */
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
            background-color: #fff;
            display: block;
            margin: 0 auto;
        }
        .nickname {
            margin-top: 10px;
            font-size: 1rem;
            color: #333;
            font-weight: bold;
        }
        .realname {
            margin-top: 5px;
            font-size: 0.9rem;
            color: #666;
        }

        /* MY MENU 타이틀 바 */
        .menu-title {
            background-color: #fa7c00; /* 주황색 배경 */
            padding: 10px;
            border-radius: 4px;
            margin: 15px 0; /* 프로필 박스와 메뉴 사이 간격 */
            color: #fff;
            font-weight: bold;
            text-align: center;
        }

        /* 메뉴 목록 (각 항목별 구분) */
        .menu-list {
            background-color: #fff; /* 항목 부분 흰색 배경 */
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .menu-item {
            padding: 15px 10px;
            border-bottom: 1px solid #eee;
        }
        .menu-item:last-child {
            border-bottom: none;
        }
        .menu-item .main-text {
            font-weight: bold;
            font-size: 0.95rem;
            color: #333;
            margin-bottom: 5px;
        }
        .menu-item .sub-text {
            font-size: 0.85rem;
            color: #888;
        }
        /* 하위 메뉴 링크 스타일 */
        .menu-item .sub-text a {
            display: block;      /* 각 링크를 새 줄로 구분 */
            margin-bottom: 3px;  /* 하위 링크 간 간격 */
        }
        .menu-item .sub-text a:hover {
            color: #fa7c00; /* 호버 시 주황색 */
        }

        /* ========== 메인 콘텐츠 ========== */
        .content {
            flex: 1;
            background-color: #fff;
            margin-left: 20px; /* 사이드바와 간격 */
            padding: 30px;
        }
        .content h2 {
            margin-top: 0;
            font-size: 1.4rem;
            margin-bottom: 30px;
        }

        /* 포인트, 쿠폰, 기프트카드 등 요약 박스 */
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

        /* 안내 / 쿠폰 박스 */
        .notice-box {
            background-color: #fff9f5;
            border: 1px solid #ffd6c9;
            padding: 15px;
            border-radius: 8px;
            color: #555;
            font-size: 0.95rem;
            margin-bottom: 10px;
        }
        .coupon-box {
            background-color: #f2e9ff;
            border: 1px solid #e2d0ff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            color: #333;
            font-size: 0.95rem;
        }
        .coupon-box p {
            margin: 0;
        }
        .coupon-box .highlight {
            font-weight: bold;
            color: #a050e3;
        }

        /* 공통 섹션 타이틀 */
        .section-title {
            font-size: 1rem;
            font-weight: bold;
            margin: 25px 0 10px 0;
        }
        .section-more {
            float: right;
            font-size: 0.9rem;
            color: #fa7c00;
        }

        /* 리스트 박스 */
        .list-box {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            min-height: 60px;
            margin-bottom: 20px;
            position: relative;
            font-size: 0.95rem;
        }
        .list-box .empty-msg {
            color: #999;
        }
        .list-box .section-more {
            position: absolute;
            right: 15px;
            top: 15px;
        }

        /* 샘플 배너 박스 */
        .banner-box {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin: 15px 0;
            font-size: 0.95rem;
            color: #666;
            background-color: #fdf9f4;
        }

        /* 버튼 */
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

        /* 푸터 */
        footer {
            background-color: #f5f5f5;
            padding: 20px;
            margin-top: 20px;
        }
        footer p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        /* 반응형 설정 */
        @media (max-width: 992px) {
            .sidebar {
                width: 180px;
            }
        }
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
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
        <!-- 프로필 박스 -->
        <div class="profile-box">
            <!-- 숨겨진 파일 업로드 input -->
            <input
                    type="file"
                    id="profileFile"
                    name="profileFile"
                    accept="image/*"
                    style="display: none;"
                    onchange="previewProfileImage(event)"
            />
            <!-- 프로필 이미지 버튼: 클릭 시 숨겨진 input 호출 -->
            <button type="button" onclick="document.getElementById('profileFile').click()">
                <img
                        src="http://placehold.it/80x80"
                        alt="프로필"
                        class="profile-pic"
                        id="profilePreview"
                />
            </button>

            <!-- 닉네임 / 이름 -->
            <div class="realname">엄기은</div>
        </div>

        <!-- MY MENU 타이틀 -->
        <div class="menu-title">MY MENU</div>

        <!-- 메뉴 리스트 -->
        <div class="menu-list">
            <!-- 주문 배송 -->
            <div class="menu-item">
                <div class="main-text">
                    <a href="#">주문 배송</a>
                </div>
                <div class="sub-text">
                    <a href="#">주문/배송 내역</a>
                </div>
            </div>
            <!-- 알림 및 메시지 -->
            <div class="menu-item">
                <div class="main-text">
                    <a href="#">알림 및 메시지</a>
                </div>
                <div class="sub-text">
                    <a href="#">알림</a>
                    <a href="#">메시지</a>
                </div>
            </div>
            <!-- 선물함 -->
            <div class="menu-item">
                <div class="main-text">
                    <a href="#">선물함</a>
                </div>
                <div class="sub-text">
                    <a href="#">받은 선물함</a>
                    <a href="#">보낸 선물함</a>
                </div>
            </div>
            <!-- 기프트카드함 -->
            <div class="menu-item">
                <div class="main-text">
                    <a href="#">기프트카드함</a>
                </div>
                <div class="sub-text">
                    <a href="#">받은 카드함</a>
                    <a href="#">보낸 카드함</a>
                </div>
            </div>
            <!-- 나의 구매후기 -->
            <div class="menu-item">
                <div class="main-text">
                    <a href="#">나의 구매후기</a>
                </div>
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

        <!-- 상단 포인트 섹션 -->
        <div class="point-section">
            <div class="point-box">
                적립금
                <strong>0P</strong>
            </div>
            <div class="point-box">
                쿠폰
                <strong>0</strong>
            </div>
            <div class="point-box">
                기프트카드 포인트
                <strong>0P</strong>
            </div>
        </div>

        <!-- 안내 박스 -->
        <div class="notice-box">
            <p>한번만 구매하면 다음을 통한 혜택을 받을 수 있어요!</p>
        </div>
        <div class="coupon-box">
            <p>
                <span class="highlight">+1,200원</span>으로 매월 <span class="highlight">4천원 쿠폰</span>
                &nbsp;→ 최대 <span class="highlight">10%</span> 할인
            </p>
        </div>

        <!-- 최근 주문 내역 -->
        <div class="section-title">
            최근 주문 내역
            <a href="#" class="section-more">더보기 &gt;</a>
        </div>
        <div class="list-box">
            <p class="empty-msg">구매 이력이 없습니다.</p>
        </div>

        <!-- 샘플 배너 -->
        <div class="banner-box">
            졸업의 주인공을 찬란하고 빛나게 (배너 예시)
        </div>

        <!-- 찜한 작품 -->
        <div class="section-title">
            찜한 작품
            <a href="#" class="section-more">더보기 &gt;</a>
        </div>
        <div class="list-box">
            <p class="empty-msg">찜한 작품이 없습니다.</p>
        </div>

        <!-- 팔로우하는 작가 -->
        <div class="section-title">
            팔로우하는 작가
            <a href="#" class="section-more">더보기 &gt;</a>
        </div>
        <div class="list-box">
            <p class="empty-msg">팔로우하는 작가가 없습니다.</p>
        </div>

        <!-- 최근 본 작품 -->
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

<!-- 이미지 미리보기 스크립트 -->
<script>
    // 파일을 선택하면 미리보기 가능
    function previewProfileImage(event) {
        const file = event.target.files[0];
        if (!file) return; // 파일 선택 안 했으면 반환

        // 이미지만 허용 (예시)
        if (!file.type.startsWith("image/")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }

        // FileReader로 로컬 파일을 읽어 미리보기
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewImg = document.getElementById("profilePreview");
            previewImg.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
</script>

</body>
</html>
