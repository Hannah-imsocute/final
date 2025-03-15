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
	max-height: 550px; /* 기존보다 더 크게 설정 */
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
	margin-bottom: 20px;
}

.download-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 5px;
	padding: 10px 15px;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: #ff9800;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.2s;
}

.download-btn:hover {
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
			<h2 class="post-title">${dto.subject}</h2>
			<p class="post-date">${dto.startdate}~${dto.enddate}</p>
			<div class="post-image">
				<img alt="썸네일"
					src="${pageContext.request.contextPath}/uploads/event/${dto.thumbnail}">
			</div>
			<p class="post-content">${dto.textcontent}</p>
			<button class="download-btn">
				<i class="bi bi-download"></i> 쿠폰 다운로드
			</button>
		</div>
	</main>

	<script type="text/javascript">
		$(function() {
			$('.download-btn').click(function() {
				let valid = "${valid}";
				if (valid == 'true') {
						alert('이미 발급된 쿠폰입니다.');
						return false;
				}
				let num = "${dto.event_article_num}";
					let code = '${dto.event.coupon_code}';
					let url = '${pageContext.request.contextPath}/event/getCoupon';
					let params = {couponcode : code,eventNum : num};
					const fn = function(data) {
						if(data.state == 'true'){
							alert('쿠폰이 발급되었습니다');
						}else{
							alert('꺄악 오류발생');
						}
					};

				ajaxRequest(url, 'post',JSON.stringify(params), 'json', fn,	false, 'json');
			});
		});
	</script>
</body>
</html>