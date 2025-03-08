<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />


<style type="text/css">
    /* 기본 스타일 */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7fa;
        margin: 0;
        padding: 0;
    }



    /* 콘텐츠 박스 스타일 */
    .container {
        max-width: 900px;
        margin : 0 auto;
        padding: 20px;
    }

    .community-form {
        background-color: #ffffff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        padding: 30px;
        margin-bottom: 40px;
    }

    .community_num {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .brandName {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        padding-bottom: 10px;
        border-bottom: 2px solid #e0e0e0;
    }

    .content {
        font-size: 16px;
        color: #555;
        line-height: 1.6;
        padding-top: 15px;
    }

    .community-review {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        display: block;
    }

    .review-header {
        font-size: 20px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
    }

    .review-item {
        padding: 10px;
        border-bottom: 1px solid #eee;
        margin-bottom: 10px;
    }

    .review-item:last-child {
        border-bottom: none;
    }


    /* 모바일 대응 */
    @media (max-width: 768px) {
        .container {
            padding: 15px;
        }

        .community-form {
            padding: 20px;
        }
    }
    .button-container {
        display: flex;
        justify-content: flex-end;
        padding-right: 20px;
        width: auto;
    }
    .button-container button {
        background-color: #ff6b6b;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .button-container button:hover {
        background-color: #ff4f4f;
    }
</style>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	
	
	<main class="container">
        <div class="community-form">
				<div class="community_num" data-community_num="${dto.community_num}">
					<div class="p-2 px-4">
						<div class="brandName">
							${dto.brandName}
						 </div>
						 <div class="content">
							${dto.content}
				 	     </div>
					 </div>
				</div>

      	 </div>
 <!-- 리뷰 영역 -->
        <div class="community-review" style="display: none">
            <div class="review-header">
                리뷰
            </div>
            <!-- 리뷰 아이템들이 동적으로 들어감 -->
            <div class="review-item">
                <strong>작성자 이름</strong> - 2025-03-08
                <p>이곳에 리뷰 내용이 들어갑니다.</p>
            </div>
            <div class="review-item">
                <strong>작성자 이름</strong> - 2025-03-07
                <p>이곳에 리뷰 내용이 들어갑니다.</p>
            </div>
        </div>

        <!-- 리뷰 작성 버튼 -->
        <div class="button-container"  style="text-align: center;">
            <button class="btn" onclick="window.location.href='/writeReview'">리뷰 작성</button>
        </div>
    </main>

</body>
</html>