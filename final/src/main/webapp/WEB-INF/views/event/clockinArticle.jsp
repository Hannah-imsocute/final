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
	background: #f4f4f4;
	text-align: center;
	padding: 20px;
	color: #333;
}

header {
	margin-bottom: 30px;
}

main {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
	margin-top: 250px;
}

.post-container {
	width: 60%;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: left;
}

.post-title {
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 10px;
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
	overflow: hidden;
}

.post-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.post-content {
	font-size: 16px;
	line-height: 1.5;
	color: #333;
	margin-bottom: 20px;
}

.calendar-container {
	max-width: 400px;
	margin: 50px auto 20px;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 달력 상단 */
.calendar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.calendar-header .month-year {
	font-weight: 700;
	font-size: 1.4rem;
}

/* 요일 영역 */
.weekdays {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	text-align: center;
	color: #666;
	font-weight: 600;
	margin-bottom: 5px;
}

/* 날짜 영역 */
.days {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	row-gap: 10px;
	text-align: center;
	margin-bottom: 20px;
}

.day {
	cursor: pointer;
	padding: 8px 0;
	border-radius: 8px;
	transition: background-color 0.2s ease;
}

.day:hover {
	background-color: #f0f0f0;
}

.day.selected {
	background-color: #06c;
	color: #fff;
}

.weekend {
	color: #d95c5c;
}

/* 출석하기 버튼 */
.attendance-button {
	display: block;
	width: 150px;
	margin: 0 auto;
	padding: 10px 0;
	background-color: #ffca28;
	color: #333;
	border: none;
	border-radius: 25px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.attendance-button:hover {
	background-color: #ffc107;
	transform: translateY(-2px);
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

			<div class="calendar-container">
				<!-- 달력 상단 -->
				<div class="calendar-header">
					<div class="month-year">${year}년 ${month}월</div>
					<!-- 이전달/다음달 버튼 등 필요시 추가 -->
				</div>

				<!-- 요일 표시 -->
				<div class="weekdays">
					<div class="weekend">일</div>
					<div>월</div>
					<div>화</div>
					<div>수</div>
					<div>목</div>
					<div>금</div>
					<div class="weekend">토</div>
				</div>

				<!-- 날짜 영역 -->
				<div class="days">
				<c:set var="dayofweek" value="0"/>
				<c:when test="dayofweek < ${dayofweek - 1}">
					<div></div>
				</c:when>
					<div></div>
					<div></div>
					<div></div>
					<div class="day">1</div>
					<div class="day">2</div>
					<div class="day weekend">3</div>
					<div class="day weekend">4</div>
					<div class="day">5</div>
					<div class="day">6</div>
					<div class="day">7</div>
					<div class="day">8</div>
					<div class="day">9</div>
					<div class="day weekend">10</div>
					<div class="day weekend">11</div>
					<div class="day">12</div>
					<div class="day">13</div>
					<div class="day">14</div>
					<div class="day">15</div>
					<div class="day">16</div>
					<div class="day weekend">17</div>
					<div class="day weekend">18</div>
					<div class="day">19</div>
					<div class="day">20</div>
					<div class="day">21</div>
					<div class="day">22</div>
					<div class="day">23</div>
					<div class="day weekend">24</div>
					<div class="day weekend">25</div>
					<div class="day">26</div>
					<div class="day">27</div>
					<div class="day">28</div>
					<div class="day">29</div>
					<div class="day">30</div>
					<div class="day weekend">31</div>
				</div>

				<!-- 출석하기 버튼 -->
				<button type="button" class="attendance-button">출석하기</button>
			</div>

		</div>
	</main>

	<script type="text/javascript">
	/*
		const ajaxRequest = function(url, method, requestParams, responseType, callback, file = false, contentType = 'text') {
		
			const settings = {
					type: method, 
					data: requestParams,
					dataType: responseType,
					success:function(data) {
						callback(data);
					},
					beforeSend: function(jqXHR) {
					},
					complete: function () {
					},
					error: function(jqXHR) {
						console.log(jqXHR.responseText);
					}
			};
		
			if(file) {
				settings.processData = false;  
				settings.contentType = false; 
			}
		
			if(contentType.toLowerCase() === 'json') {
				settings.contentType = 'application/json; charset=utf-8';
			}
		
			$.ajax(url, settings);
		};
	*/
		$(function(){
			$('.attendance-button').click(function(){
				
				// 이미 출석했으면 우야노
				
				let date = new Date();
				let year = date.getFullYear();
				let month = date.getMonth()+1;
				let day = date.getDate();
				let num = ${dto.event.clockin_num};
				
				let url = '${pageContext.request.contextPath}/event/checked';
				let params = {year : year , month : month , day : day , num : num};
				
				const after = function (data){
					if(data.state == 'true'){
						alert('출석을 완료했습니다 !!');
					}
				}
				
				ajaxRequest(url, 'post', JSON.stringify(params), 'json', after, false, 'json');
				
			});
		});
	</script>
</body>
</html>