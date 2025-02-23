<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 폼</title>
    <!-- 기존 headerResources.jsp (CSS/JS 공통 리소스) 포함 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    <!-- Font Awesome (아이콘) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        /* ========== Global Reset & Base Style ========== */
        * { box-sizing: border-box; }
        body, html {
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
            background-color: #fff;
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        a:hover { color: #fa7c00; }

        /* ========== Modal (리뷰 작성 폼 오버레이) ========== */
        .modal {
            display: block; /* form.jsp에서는 바로 폼이 보이도록 */
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            padding-top: 5%; /* 상단 여백 */
        }
        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 8px;
            width: 90%;
            max-width: 400px; /* 작은 창 */
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            position: relative;
        }
        /* 닫기 버튼 제거 */

        /* ========== 별점 영역 ========== */
        .star-rating {
            display: flex;
            flex-direction: row; /* 왼→오른쪽 순서 */
            gap: 5px;
            margin-bottom: 12px;
        }
        .star-rating input {
            display: none; /* 라디오 버튼 숨기기 */
        }
        .star-rating label {
            font-size: 1.4rem;
            color: #ddd;
            cursor: pointer;
        }
        /* hover 시 해당 별과 왼쪽 별까지 색상 변경 */
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #fa7c00;
        }
        /* 선택된 별점(=라디오 체크)부터 왼쪽 별까지 색상 변경 */
        .star-rating input:checked ~ label {
            color: #fa7c00;
        }

        /* ========== 리뷰 작성 폼 스타일 ========== */
        .review-form label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
        }
        .review-form textarea {
            width: 100%;
            min-height: 120px;
            padding: 8px;
            font-size: 0.95rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: none; /* 오른쪽 모서리 리사이즈 아이콘 제거 */
            margin-bottom: 12px;
        }
        .btn-submit {
            background-color: #fa7c00;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 0.9rem;
            cursor: pointer;
            width: 100%;
        }
        .btn-submit:hover { background-color: #e26d00; }

        /* ========== 반응형 ========== */
        @media (max-width: 480px) {
            .modal-content {
                padding: 15px;
            }
            .btn-submit {
                padding: 8px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
<!-- 리뷰 작성 폼 모달 오버레이 (항상 표시됨) -->
<div id="reviewModal" class="modal">
    <div class="modal-content">
        <h2>상품평 작성</h2>
        <!-- 리뷰 작성 폼 (POST 전송: /mypag/review/write) -->
        <form action="${pageContext.request.contextPath}/mypag/review/write" method="post" class="review-form">

            <!-- 별점 입력: name="starRate" -> ReviewDto의 starRate와 매핑 -->
            <label>별점</label>
            <div class="star-rating">
                <!-- 왼쪽부터 1~5 순서 -->
                <input type="radio" id="star1" name="starRate" value="1" />
                <label for="star1"><i class="fas fa-star"></i></label>

                <input type="radio" id="star2" name="starRate" value="2" />
                <label for="star2"><i class="fas fa-star"></i></label>

                <input type="radio" id="star3" name="starRate" value="3" />
                <label for="star3"><i class="fas fa-star"></i></label>

                <input type="radio" id="star4" name="starRate" value="4" />
                <label for="star4"><i class="fas fa-star"></i></label>

                <input type="radio" id="star5" name="starRate" value="5" />
                <label for="star5"><i class="fas fa-star"></i></label>
            </div>

            <label for="reviewContent">리뷰 내용</label>
            <textarea id="reviewContent" name="reviewContent" placeholder="최대 10자를 입력하세요"></textarea>
<%--            <input type="hidden" name="" value="${}">--%>
            <button type="submit" class="btn-submit">작성완료</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function () {
        $('.review-form').on('submit', function (e){
            var reviewContent = $('#reviewContent').val().trim();

            if(reviewContent.length === 0) {
                alert('내용을 입력해주세요');
                $('#reviewContent').focus();
                e.preventDefault();
                return false;
            }

            if(reviewContent.length < 10){
                alert('10자 이상 입력해주세요.');
                $('#reviewContent').focus();
                e.preventDefault();
                return false;
            }
        });
    });
</script>
</body>
</html>
