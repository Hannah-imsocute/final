<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 구매후기</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Font Awesome (별 아이콘 사용) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        /* 기본 Reset 및 Base 스타일 */
        header { position: relative !important; }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body, html {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #444;
            line-height: 1.6;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            color: #fa7c00;
        }
        /* 헤더 */
        header {
            width: 100%;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
            padding: 10px 20px;
        }
        /* 메인 컨테이너 */
        .main-container {
            max-width: 1200px;
            margin: 10px auto 40px;
            display: flex;
            gap: 20px;
            padding: 0 20px;
        }
        .sidebar {
            flex: 0 0 250px;
        }
        .content {
            flex: 1;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .content h2 {
            font-size: 1.8rem;
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 3px solid #fa7c00;
            color: #333;
        }
        /* 리뷰 컨테이너 */
        .review-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .review-card {
            border: 1px solid #ddd;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .review-card-header {
            background-color: #f8f8f8;
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .review-card-header .star-rating {
            color: #fa7c00;
            font-size: 1.2rem;
        }
        .review-card-body {
            display: flex;
            padding: 15px;
        }
        .review-card-body .product-image {
            width: 100px;
            height: 100px;
            border-radius: 4px;
            object-fit: cover;
            margin-right: 16px;
        }
        .review-card-body .review-content {
            flex: 1;
        }
        .review-card-body .review-content h5 {
            margin-bottom: 10px;
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
        }
        .review-card-body .review-content p {
            margin-bottom: 10px;
            color: #555;
        }
        .review-card-body .review-content .review-img {
            max-width: 150px;
            max-height: 150px;
            border-radius: 4px;
            object-fit: cover;
            margin-top: 10px;
        }
        .review-card-body .review-actions {
            margin-top: 10px;
        }
        .review-card-body .review-actions button {
            padding: 6px 12px;
            margin-right: 5px;
            border: 1px solid #fa7c00;
            border-radius: 4px;
            background-color: #fff;
            color: #fa7c00;
            font-size: 0.9rem;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }
        .review-card-body .review-actions button:hover {
            background-color: #fa7c00;
            color: #fff;
        }
        /* 페이지네이션 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 30px;
            list-style: none;
        }
        .pagination li a {
            display: inline-block;
            width: 2.5rem;
            height: 2.5rem;
            line-height: 2.5rem;
            text-align: center;
            font-size: 1rem;
            color: #555;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 50%;
            transition: background-color 0.3s, transform 0.2s;
        }
        .pagination li a:hover {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            transform: scale(1.1);
        }
        .pagination li.active a {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
            transform: scale(1.1);
        }
        .pagination li.disabled a {
            opacity: 0.5;
            pointer-events: none;
        }
        /* 모달 스타일 (리뷰 수정) */
        #editReviewModal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            padding-top: 5%;
        }
        #editReviewModal .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 40px 30px;
            border-radius: 10px;
            width: 95%;
            max-width: 650px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.25);
            position: relative;
        }
        #editReviewModal .close {
            color: #aaa;
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        /* 폼 내부 요소 */
        .review-form textarea {
            width: 100%;
            height: 150px;
            padding: 12px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: none;
            outline: none;
            margin-top: 15px;
        }
        .review-form textarea:focus {
            border-color: #fa7c00;
        }
        .file-input-label {
            display: inline-block;
            padding: 8px 12px;
            font-size: 0.95rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
            cursor: pointer;
            margin-top: 15px;
        }
        .btn-submit {
            background-color: #fa7c00;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s;
            display: block;
        }
        .btn-submit:hover {
            background-color: #e26d00;
        }
        .file-preview {
            margin-top: 10px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .file-preview img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        /* 별점 디자인 */
        .star-rating {
            direction: rtl;
            font-size: 1.8rem;
            display: inline-block;
            padding: 10px 0;
        }
        .star-rating input[type="radio"] {
            display: none;
        }
        .star-rating label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input[type="radio"]:checked ~ label {
            color: #fa7c00;
        }
        /* 홈으로 가기 버튼 */
        .home-button {
            display: block;
            width: 130px;
            margin: 30px auto 0 auto;
            padding: 5px 0;
            text-align: center;
            font-size: 1rem;
            font-weight: 700;
            color: #fff;
            background-color: #fa7c00;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s, transform 0.2s;
            cursor: pointer;
        }
        .home-button:hover {
            background-color: #e26d00;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
<!-- 헤더 -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 메인 컨테이너 -->
<div class="main-container">
    <!-- 사이드바 -->
    <div class="sidebar">
        <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />
    </div>
    <!-- 콘텐츠 -->
    <div class="content">
        <h2>내 구매후기</h2>
        <c:if test="${fn:length(reviewList) == 0}">
            <div class="empty-msg">등록된 상품평이 없습니다.</div>
        </c:if>

        <!-- 리뷰 카드 목록 -->
        <div class="review-container">
            <c:forEach var="review" items="${reviewList}">
                <div class="review-card">
                    <div class="review-card-header">
                        <div class="star-rating">
                            ★ <c:out value="${review.starRate}" /> / 5
                        </div>
                    </div>
                    <div class="review-card-body">
                        <img src="${pageContext.request.contextPath}/uploads/product/${review.thumbnail}"
                             alt="상품 이미지" class="product-image">
                        <div class="review-content">
                            <h5>${review.productName}</h5>
                            <p><c:out value="${review.content}" /></p>
                            <c:if test="${not empty review.selectFile}">
                                <img src="${pageContext.request.contextPath}/uploads/review/${review.image}"
                                     alt="리뷰 이미지" class="review-img">
                            </c:if>
                            <div class="review-actions">
                                <button type="button"
                                        class="btn-edit"
                                        data-review-num="${review.reviewNum}"
                                        data-content="${review.content}"
                                        data-starRate="${review.starRate}"
                                        data-image="${pageContext.request.contextPath}/uploads/product/${review.thumbnail}"
                                        data-product-name="${review.productName}"
                                        data-review-image="${pageContext.request.contextPath}/uploads/review/${review.image}"
                                        onclick="editReview(this);">
                                    수정
                                </button>
                                <button type="button"
                                        class="btn-delete"
                                        data-review-num="${review.reviewNum}"
                                        onclick="deleteReview(this);">
                                    삭제
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 페이징 -->
        <ul class="pagination">
            <li class="arrow ${page == 1 ? 'disabled' : ''}">
                <a href="?page=${page - 1}">&lt;</a>
            </li>
            <c:forEach var="i" begin="1" end="${total_page}">
                <li class="${i == page ? 'active' : ''}">
                    <a href="?page=${i}">${i}</a>
                </li>
            </c:forEach>
            <li class="arrow ${page == total_page ? 'disabled' : ''}">
                <a href="?page=${page + 1}">&gt;</a>
            </li>
        </ul>
        <!-- 홈으로 가기 버튼 -->
        <button class="home-button" onclick="location.href='${pageContext.request.contextPath}/mypage/home'">
            홈으로 가기
        </button>
    </div>
</div>

<!-- 푸터 -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- 리뷰 수정 모달 (AJAX PUT 처리) -->
<div id="editReviewModal">
    <div class="modal-content">
        <span class="close" id="closeEditReviewBtn">&times;</span>
        <h3>리뷰 수정</h3>
        <form id="editReviewForm" action="#" method="post" class="review-form" enctype="multipart/form-data">
            <!-- 수정할 리뷰 번호 (숨김) -->
            <input type="hidden" id="editReviewNum" name="reviewNum" value="">
            <!-- 모달 상단 상품 정보 -->
            <div id="editReviewProductInfo" class="modal-product-info">
                <img id="editReviewProductImage" src="" alt="상품 이미지">
                <span id="editReviewProductName"></span>
            </div>
            <!-- 별점 입력 -->
            <label>별점</label>
            <div class="star-rating">
                <input type="radio" id="editStar5" name="starRate" value="5" />
                <label for="editStar5" title="5 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="editStar4" name="starRate" value="4" />
                <label for="editStar4" title="4 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="editStar3" name="starRate" value="3" />
                <label for="editStar3" title="3 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="editStar2" name="starRate" value="2" />
                <label for="editStar2" title="2 stars"><i class="fas fa-star"></i></label>
                <input type="radio" id="editStar1" name="starRate" value="1" />
                <label for="editStar1" title="1 star"><i class="fas fa-star"></i></label>
            </div>
            <textarea id="editReviewContent" name="content" placeholder="최소 10자를 입력하세요."></textarea>

            <!-- 파일 업로드 -->
            <label for="editSelectFile" class="file-input-label">📁 파일 선택</label>
            <input type="file" id="editSelectFile" name="selectFile" multiple accept="image/*" />

            <!-- 기존 리뷰 이미지 미리보기 -->
            <div id="editFilePreview" class="file-preview"></div>

            <!-- 수정 완료 버튼 -->
            <button type="button" id="submitEditReview" class="btn-submit">수정완료</button>
        </form>
    </div>
</div>

<script>
    function editReview(btn) {
        var reviewNum = $(btn).data('review-num');
        var productImage = $(btn).data('image');
        var productName = $(btn).data('product-name');
        var existingReviewImage = $(btn).data('review-image');

        $.ajax({
            url: '${pageContext.request.contextPath}/review/detail/' + reviewNum,
            method: 'GET',
            data: { reviewNum: reviewNum },
            dataType: 'json',
            success: function(response) {
                response.productImage = productImage;
                response.productName = productName;
                response.existingReviewImage = existingReviewImage;
                showEditReviewModal(response);
            },
            error: function(xhr, status, error) {
                alert('수정 요청 실패: ' + error);
            }
        });
    }

    function showEditReviewModal(reviewData) {
        $('#editReviewNum').val(reviewData.reviewNum);
        $('#editReviewContent').val(reviewData.content);
        $('#editReviewForm input[name="starRate"]').prop('checked', false);
        if (reviewData.starRate) {
            $('#editStar' + reviewData.starRate).prop('checked', true);
        }
        $('#editReviewProductImage').attr('src', reviewData.productImage || '');
        $('#editReviewProductName').text(reviewData.productName || '');
        $('#editFilePreview').empty();
        if (reviewData.existingReviewImage) {
            $('#editFilePreview').append(
                '<img src="' + reviewData.existingReviewImage + '" alt="기존 리뷰 이미지">'
            );
        }
        $('#editReviewModal').show();
    }

    function closeModal(modalSelector) {
        $(modalSelector).hide();
    }

    $(document).ready(function(){
        $('#closeEditReviewBtn').click(function(){
            closeModal('#editReviewModal');
        });
        $(window).click(function(event) {
            if ($(event.target).is('#editReviewModal')) {
                closeModal('#editReviewModal');
            }
        });
        $('#submitEditReview').on('click', function(e) {
            e.preventDefault();
            var reviewNum = $('#editReviewNum').val();
            var formData = new FormData($('#editReviewForm')[0]);
            $.ajax({
                url: '${pageContext.request.contextPath}/review/edit/' + reviewNum,
                type: 'PUT',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert("작성하신 후기가 수정되었습니다.: " + response);
                    closeModal('#editReviewModal');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert("리뷰 수정에 실패했습니다. 에러: " + error);
                }
            });
        });
    });

    function deleteReview(btn) {
        var reviewNum = $(btn).data('review-num');
        if(confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: '${pageContext.request.contextPath}/review/' + reviewNum,
                method: 'DELETE',
                success: function(response) {
                    alert('작성하신 후기가 삭제되었습니다.');
                    $(btn).closest('.review-card').fadeOut();
                },
                error: function(xhr, status, error) {
                    alert('삭제 요청 실패: ' + error);
                }
            });
        }
    }
</script>
</body>
</html>