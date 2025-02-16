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

.event-section {
	padding: 40px 20px;
	background-color: #fff;
}

h2 {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: left;
	padding-left: 10%;
}

.event-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 20px;
	max-width: 1100px;
	margin: 0 auto;
}

.event-card {
	background-color: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding-bottom: 15px;
	transition: transform 0.3s ease-in-out;
}

.event-card:hover {
	transform: scale(1.05);
}

.event-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.event-card h3 {
	font-size: 18px;
	margin: 10px 0;
	font-weight: bold;
}

.event-card p {
	font-size: 14px;
	color: #666;
}

.event-date {
	font-size: 14px;
	color: #333;
	font-weight: bold;
	display: block;
	margin-top: 5px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<section class="event-section">
		<h2>이벤트</h2>
		<div class="event-container">

			<c:forEach var="dto" items="${list}">

				<div class="event-card" data-eventNum="${dto.event_article_num}" data-eventType="${dto.eventType}">
					<img src="${pageContext.request.contextPath}/uploads/event/${dto.thumbnail}" alt="새해 쿠폰 이벤트">
					<h3>${dto.subject}</h3>
					<p>${dto.eventType}</p>
					<span class="event-date">${dto.startdate} ~ ${dto.enddate}</span>
				</div>

			</c:forEach>
		</div>
	</section>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	
	<script type="text/javascript">
		$(function(){
			$('.event-card').each(function(){
				$(this).click(function (){
					
					let articleNumber = $(this).attr('data-eventNum');
					let Type = $(this).attr('data-eventType');
					
					let url = "${pageContext.request.contextPath}/event/article/"+Type + "/" +articleNumber;
					
					location.href = url;
				});
			});
		});
	</script>
</body>
</html>