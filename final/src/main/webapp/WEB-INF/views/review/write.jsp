<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 폼</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
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
            display: block;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            padding-top: 5%;
        }
        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            position: relative;
        }
        /* ========== 별점 영역 ========== */
        .star-rating {
            display: flex;
            flex-direction: row;
            gap: 5px;
            margin-bottom: 12px;
        }
        .star-rating input { display: none; }
        .star-rating label {
            font-size: 1.4rem;
            color: #ddd;
            cursor: pointer;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label { color: #fa7c00; }
        .star-rating input:checked ~ label { color: #fa7c00; }
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
            resize: none;
            margin-bottom: 12px;
        }
        .review-form input[type="file"] {
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
            .modal-content { padding: 15px; }
            .btn-submit { padding: 8px; font-size: 0.85rem; }
        }
    </style>
</head>
<body>
<div id="reviewModal" class="modal">
    <div class="modal-content">
        <h2>상품평 작성</h2>
        <!-- 컨트롤러의 URL에 맞춰 action 속성을 지정합니다. -->
        <form id="reviewForm"
              method="post"
              class="review-form"
              enctype="multipart/form-data">
            <!-- 별점 입력 -->
            <label>별점</label>
            <div class="star-rating">
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
            <!-- 상품 정보 표시 및 전달 -->
            <div>
                <span>상품번호: ${productCode}</span>
                <span>상품명: ${productName}</span>
            </div>
            <input type="hidden" name="productCode" value="${productCode}" />
            <input type="hidden" name="memberIdx" value="${memberIdx}" />
            <!-- 리뷰 내용 -->
            <label for="content">리뷰 내용</label>
            <textarea id="content" name="content" placeholder="최소 10자를 입력하세요"></textarea>
            <!-- 리뷰 이미지 파일 업로드 -->
            <label for="selectFile">리뷰 이미지 (여러 파일 선택 가능)</label>
            <input type="file" id="selectFile" name="selectFile" multiple accept="image/*" />
            <button type="button" id="submitReview" class="btn-submit">작성완료</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function ajaxFun(url, method, formData, dataType, fn, file = false) {
        const settings = {
            type: method,
            data: formData,
            dataType: dataType,
            success: function(data) {
                fn(data);
            },
            error: function(jqXHR) {
                console.log(jqXHR.responseText);
            }
        };
        if(file) {
            settings.processData = false;
            settings.contentType = false;
        }
        $.ajax(url, settings);
    }

    $(function (){
        $('#submitReview').click(function(){
            var content = $('#content').val().trim();
            if(content.length < 10) {
                alert("리뷰 내용은 최소 10자 이상 입력해야 합니다.");
                $('#content').focus();
                return;
            }
            let url = '${pageContext.request.contextPath}/review/write'
            // 파일 입력이 있는지 확인
            var fileCount = $('#selectFile')[0].files.length;
            if(fileCount > 0) {
                // 파일이 있는 경우 FormData 사용
                var formData = new FormData($('#reviewForm')[0]);
                ajaxFun(url, 'POST', formData, 'json', function(response) {
                    if(response.success) {
                        alert(response.message);
                        // 성공 시 모달 닫기 및 폼 초기화 등 추가 처리
                    } else {
                        alert("리뷰 등록 실패: " + response.message);
                    }
                }, true);
            } else {
                // 파일이 없는 경우 serialize() 사용
                var formData = $('#reviewForm').serialize();
                ajaxFun(url, 'POST', formData, 'json', function(response) {
                    if(response.success) {
                        alert(response.message);
                        // 성공 시 추가 처리 (모달 닫기, 폼 초기화 등)
                    } else {
                        alert("리뷰 등록 실패: " + response.message);
                    }
                });
            }
        });
    });
</script>
</body>
</html>