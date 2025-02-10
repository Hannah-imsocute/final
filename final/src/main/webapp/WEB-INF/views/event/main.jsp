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
			
				<!--  여기서부터 반복 -->
				
					<div class="event-card">
						<img src="event1.jpg" alt="새해 쿠폰 이벤트">
						<h3>새해 쿠폰 이벤트</h3>
						<p>역대급 혜택이얌</p>
						<span class="event-date">25.01.01 ~ 25.03.20</span>
					</div>
				<!--  여기까징  -->
			
			</div>
		</section>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>
</html>