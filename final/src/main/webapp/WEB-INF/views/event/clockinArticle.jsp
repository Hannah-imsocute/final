<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/ko.js"></script>
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
	background: #f4f4f4;
	text-align: center;
	padding: 20px;
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
	height: 300px;
	background-color: #ddd;
	border-radius: 5px;
	margin-bottom: 15px;
}

.post-content {
	font-size: 16px;
	line-height: 1.5;
	color: #333;
	margin-bottom: 20px;
}

#calendar-container {
	max-width: 400px;
	margin: auto;
	background: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
	position: relative;
	border-top: 10px solid #444;
}

.attendance-mark {
	width: 25px;
	height: 25px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.attendance-btn {
	background: #444;
	color: white;
	border: none;
	padding: 12px 20px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 25px;
	margin-top: 15px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	transition: background 0.3s;
}

.attendance-btn:hover {
	background: #222;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
		<div class="post-container">
			<h2 class="post-title">${dto.subject }</h2>
			<p class="post-date">${dto.startdate }~${dto.enddate }</p>
			<div class="post-image">
				<img alt="썸네일" src="/uploads/event/${dto.thumbnail}">
			</div>
			<p class="post-content">${dto.textcontent}</p>

			<div id="calendar-container">
				<div class="header">📌 1월 출석체크</div>
				<img
					src="https://upload.wikimedia.org/wikipedia/commons/e/ec/Pushpin_icon.svg"
					class="pin">
				<div id="calendar"></div>
				<button class="attendance-btn" id="check-in-btn">✅ 출석체크하기</button>
			</div>
		</div>
	</main>

	<script type="text/javascript">
		var calendar = null;
		document.addEventListener('DOMContentLoaded', function() {
			const calendarEl = document.getElementById('calendar');

			calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar: {
					left: '',
					center: 'title',
					right: ''
				},
				initialView: 'dayGridMonth',
				locale: 'ko'
			});
			
			
			calendar.render();
		});
	</script>
</body>
</html>