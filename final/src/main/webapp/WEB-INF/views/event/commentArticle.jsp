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
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #f8f8f8;
	text-align: center;
}

main {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
	margin-top: 200px;
}

.post-container {
	width: 60%;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: left;
}

.post-title {
	font-size: 22px;
	font-weight: bold;
}

.post-date {
	font-size: 14px;
	color: gray;
	margin-bottom: 15px;
}

.post-image {
	width: 100%;
	max-height: 800px; /* 기존보다 더 크게 설정 */
	overflow: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
}

.post-image img {
	max-width: 100%;
	max-height: 100%;
	height: auto;
	width: auto;
	object-fit: contain; /* 이미지 비율 유지하며 잘리지 않도록 설정 */
}

.post-content {
	font-size: 16px;
	line-height: 1.5;
	color: #333;
}

.post-actions {
	display: flex;
	gap: 5px;
	margin-top: 15px;
	align-items: center;
}

.action-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 5px;
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	background-color: white;
	transition: background 0.2s;
}

.action-btn:hover {
	background-color: #f0f0f0;
}

.comment-section {
	display: flex;
	gap: 10px;
	margin-top: 15px;
}

.comment-input {
	flex-grow: 1;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

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

.comment-list {
	margin-top: 15px;
	padding: 10px;
	background-color: #f9f9f9;
	border-radius: 5px;
}

.comment-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px;
	border-bottom: 1px solid #ddd;
}

.comment-info {
	display: flex;
	flex-direction: column;
}

.comment-nickname {
	font-weight: bold;
	font-size: 14px;
}

.comment-text {
	font-size: 14px;
	color: #333;
}

.comment-date {
	font-size: 12px;
	color: gray;
}

.delete-btn {
	background-color: #ff4d4d;
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 12px;
}

.delete-btn:hover {
	background-color: #d43f3f;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
		<div class="post-container">
			<h2 class="post-title">${dto.subject}</h2>
			<p class="post-date">${dto.startdate}~${dto.enddate }</p>
			<div class="post-image">
				<img alt="섬네일사진" src="/uploads/event/${dto.thumbnail}">
			</div>
			<p class="post-content">${dto.textcontent}</p>
			<div class="post-actions">
				<button class="action-btn">
					<i class="bi bi-balloon-heart"></i> 공감하기
				</button>
				<button class="action-btn">
					<i class="bi bi-chat-dots"></i> 댓글보기
				</button>
			</div>
			<div class="comment-section">
				<input type="text" class="comment-input"
					placeholder="댓글을 입력하여 주세요...">
				<button class="submit-btn">등록</button>
			</div>
			<div class="comment-list">
				<c:forEach var="com" items="${cmmList}">

					<div class="comment-item">
						<div class="comment-info">
							<span class="comment-nickname">${com.nickname}</span> <span
								class="comment-text">${com.content}</span> <span
								class="comment-date">2025-03-13</span>
						</div>
						<button class="delete-btn" data-num="${com.evtcmm_num}">삭제</button>
					</div>

				</c:forEach>

			</div>
		</div>
	</main>

	<script type="text/javascript">
		$('.submit-btn')
				.click(
						function() {
							let content = $('.comment-input').val();
							let num = "${dto.event_article_num}";
							
							let params = {
								content : content,
								evt_num : num
							};
							let url = '${pageContext.request.contextPath}/event/commentadd';

							const callback = function(data) {
								location.href = '${pagecontext.request.contextPath}/event/article/comment/${dto.event_article_num}';								
							}

							ajaxRequest(url, 'post', JSON.stringify(params),
									'json', callback, false, 'json');
						});
		$('.delete-btn').click(function(){
			let url = "${pageContext.request.contextPath}/event/commentdelete";
			let evtcmm_num = $(this).attr('data-num');
			if(confirm('댓글을 삭제 하시겠습니까 ?')){
				
				const cb = function(){
					location.href = "${pagecontext.request.contextPath}/event/article/comment/${dto.event_article_num}";
				};
				
				ajaxRequest(url,'post',{evtcmm_num : evtcmm_num},'json',cb);
			}
		});
	</script>
</body>
</html>