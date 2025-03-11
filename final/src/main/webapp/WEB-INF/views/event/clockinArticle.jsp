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
	max-height: 700px; /* 기존보다 더 크게 설정 */
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

/* 테이블 전체 스타일 */
.table {
	width: 60%; /* 적절한 너비 */
	margin: 20px auto; /* 가운데 정렬 */
	border-collapse: collapse; /* 셀 간격 제거 (한 줄로 보이도록) */
	background-color: #fff; /* 배경 흰색 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 살짝 그림자 */
	border-radius: 8px; /* 모서리를 둥글게 */
	overflow: hidden; /* 테이블 모서리가 둥글게 잘리도록 */
}

/* 테이블 헤더(요일) 스타일 */
.table thead td {
	background-color: #333; /* 짙은색 배경 */
	color: #fff; /* 글자는 흰색 */
	font-weight: bold;
	padding: 10px;
	text-transform: uppercase; /* 대문자 (선택사항) */
	text-align: center;
	font-size: 14px;
}

/* 본문 셀 스타일 */
.table tbody td {
	border: 1px solid #e5e5e5; /* 옅은 테두리 */
	padding: 12px;
	text-align: center;
	font-size: 14px;
	cursor: pointer; /* 마우스 포인터 표시 */
	transition: background-color 0.2s ease;
}

/* Hover 시 배경색 변화 */
.table tbody td:hover {
	background-color: #f5f5f5;
}

/* 오늘 날짜 .today 강조 */
.today {
	background-color: #2979ff;
	color: #fff;
	font-weight: bold;
	border-radius: 4px; /* 셀 내부에서 약간 둥글림 */
}

/* 달력에 표시하지 않는 빈 칸(.gray) */
.gray {
	background-color: #fafafa;
	color: #ccc;
}

/* 그 외 일반 날짜(.other) */
.other {
	background-color: #fff;
	color: #333;
}

/* 하트 */
.heart-icon-wrap {
	position: relative;
	display: inline-block;
	/* 하트(아이콘)와 숫자의 크기를 조절합니다. */
	font-size: 32px; /* 좀 크게 설정: 24px, 32px 등 */
	width: 32px;
	height: 32px;
}

/* 아이콘 스타일 */
.heart-icon-wrap i {
	color: red; /* 테두리만 있는 하트이므로 빨간색 outline */
	line-height: 32px; /* 세로 정렬 보정 */
}

/* 하트 중앙에 숫자를 겹쳐 표시 */
.heart-number {
	position: absolute;
	top: 60%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 16px; /* 숫자 크기 */
	font-weight: bold;
	color: red; /* 숫자 색상 (하트와 같은 색이면 테두리와 어울림) */
	pointer-events: none; /* 마우스로 클릭 시 숫자 때문에 이벤트가 가로막히지 않도록 (선택) */
}

.day-number {
	font-size: 16px;
	color: #333;
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
			<p class="post-date">${dto.startdate }~${dto.enddate }</p>
			<div class="post-image">
				<img alt="썸네일"
					src="${pageContext.request.contextPath}/uploads/event/${dto.thumbnail}">
			</div>
			<p class="post-content">${dto.textcontent }</p>

			<table class="table">
				<thead>
					<tr>
						<td>일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td>토</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="i" begin="1" end="${week-1}">
							<td class='gray'></td>
						</c:forEach>
						<c:forEach var="chk" items="${checked}">

							<c:forEach var="i" begin="1" end="${lastDate}">
								<c:set var="cls" value="${i==td ? 'today':'other' }" />
								<td class="${cls}">
									<div class="heart-icon-wrap">
										<c:choose>
											<c:when test="${chk == i }">
												<i class="bi bi-heart"></i>
												<span class="heart-number" data-number="${i}">${i}</span>
											</c:when>
											<c:otherwise>
												<span class="heart-number" data-number="${i}">${i}</span>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
								<c:set var="week" value="${week+1}" />
								<c:if test="${lastDate!=i && week%7==1 }">
									<c:out value="</tr><tr>" escapeXml="false" />
								</c:if>
							</c:forEach>

						</c:forEach>
						<c:if test="${week%7!=1}">
							<c:set var="w" value="${week%7==0?7:week%7}" />
							<c:forEach var="i" begin="${w}" end="7">
								<td class='gray'></td>
							</c:forEach>
						</c:if>
					</tr>
				</tbody>

			</table>

			<!-- 출석하기 버튼 -->
			<button type="button" class="attendance-button">출석하기</button>

		</div>
	</main>

	<script type="text/javascript">
	$(function(){
		$('.attendance-button').click(function(){
			let url = '${pageContext.request.contextPath}/event/checked';
			let params = {num : ${dto.event_article_num} };
			
			const callback = function(data){
				alert('출석체크가 완료되었습니다 ! ');
				$('.attendance-button').prop('disabled', true);
				
			};
			
			ajaxRequest(url, 'post', params, 'json', callback);
		});
	});	
	</script>
</body>
</html>