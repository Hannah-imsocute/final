<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

header {
	position: relative !important; /* 기존 fixed 해제 */
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #f8f8f8;
	text-align: center;
}
/* 메인 컨테이너 */
main {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

/* 게시글 전체 스타일 */
.post-container {
    width: 60%;
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: left;
}

/* 제목 */
.post-title {
    font-size: 22px;
    font-weight: bold;
}

/* 날짜 */
.post-date {
    font-size: 14px;
    color: gray;
    margin-bottom: 15px;
}

/* 게시글 이미지 (대체) */
.post-image {
    width: 100%;
    height: 300px;
    background-color: #ddd;
    border-radius: 5px;
    margin-bottom: 15px;
}

/* 본문 */
.post-content {
    font-size: 16px;
    line-height: 1.5;
    color: #333;
}

/* 버튼 그룹 */
.post-actions {
    display: flex;
    gap: 10px;
    margin-top: 15px;
}

/* 버튼 공통 */
.like-btn, .comment-btn {
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: background 0.2s;
}

/* 공감 버튼 */
.like-btn {
    background-color: #ff9800;
    color: white;
}

.like-btn:hover {
    background-color: #e68900;
}

/* 댓글 버튼 */
.comment-btn {
    background-color: #ddd;
    color: black;
}

.comment-btn:hover {
    background-color: #ccc;
}

/* 댓글 입력 영역 */
.comment-section {
    display: flex;
    gap: 10px;
    margin-top: 15px;
}

/* 댓글 입력창 */
.comment-input {
    flex-grow: 1;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* 댓글 등록 버튼 */
.submit-btn {
    background-color: #ff9800;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #e68900;
}

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
    <div class="post-container">
        <h2 class="post-title">새해 쿠폰 이벤트</h2>
        <p class="post-date">25.01.01 ~ 25.03.20</p>
        <div class="post-image"></div> 
        <p class="post-content">${dto.textcontent}</p>
        
        <div class="post-actions">
            <button class="like-btn">😊 공감하기</button>
            <button class="comment-btn">💬 댓글쓰기</button>
        </div>

        <div class="comment-section">
            <input type="text" class="comment-input" placeholder="댓글을 입력하여 주세요...">
            <button class="submit-btn">등록</button>
        </div>
    </div>
</main>

</body>
</html>