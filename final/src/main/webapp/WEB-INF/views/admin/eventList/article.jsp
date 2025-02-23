<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />

<style type="text/css">
body {
	font-family: sans-serif;
	margin: 20px;
	background-color: #f5f5f5;
}

.event-view-container {
	max-width: 800px;
	margin: 0 auto;
	background-color: #ffffff;
	border: 1px solid #ccc;
	padding: 20px;
}

.event-view-container h2 {
	font-size: 1.4rem;
	margin-bottom: 10px;
	border-bottom: 2px solid #333;
	padding-bottom: 10px;
}

.event-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.event-table th, .event-table td {
	border: 1px solid #ccc;
	padding: 12px;
	vertical-align: middle;
}

.event-table th {
	background-color: #f2f2f2;
	text-align: left;
	font-weight: 600;
}

.event-table td {
	background-color: #fff;
	text-align: left;
}

.btn-area {
	text-align: right;
}

.btn-area button {
	padding: 8px 16px;
	background-color: #4285f4;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 4px;
	margin-left: 5px;
}

.btn-area button:hover {
	background-color: #3367d6;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main class="container mt-9">
		<div class="event-view-container">
			<h2>이벤트 상세 보기</h2>
			<table class="event-table">
				<!-- 4개의 열을 사용하므로 colgroup을 4개로 지정 (너비는 취향에 맞게 조정) -->
				<colgroup>
					<col style="width: 15%;">
					<col style="width: 35%;">
					<col style="width: 15%;">
					<col style="width: 35%;">
				</colgroup>
				<tbody>
					<!-- 이벤트명과 이벤트 작성일을 같은 행에 배치 -->
					<tr>
						<th>이벤트명</th>
						<td>${dto.subject}</td>
						<th>이벤트 작성일</th>
						<td>${dto.created}</td>
					</tr>

					<tr>
						<th>이벤트 시작일</th>
						<td>${dto.startdate}</td>
						<th>이벤트 종료일</th>
						<td>${dto.enddate}</td>
					</tr>
					<tr>
						<th>이벤트 타입</th>
						<td colspan="3"><label> <input type="radio"
								name="eventType" value="coupon"
								${dto.eventType=='coupon' ? 'checked disabled':'disabled'}>
								쿠폰
						</label> <label> <input type="radio" name="eventType"
								value="comment"
								${dto.eventType=='comment' ? 'checked disabled':'disabled'}>
								댓글
						</label> <label> <input type="radio" name="eventType"
								value="attendance"
								${dto.eventType=='clockin' ? 'checked disabled':'disabled'}>
								출석체크
						</label></td>
					</tr>
					<tr>
						<th>이벤트 타입 설명</th>
						<td colspan="3"><c:choose>
								<c:when test="${dto.eventType=='coupon'}">
            		쿠폰명 : ${dto.event.couponname} 쿠폰 코드 : ${dto.event.coupon_code} 
            		</c:when>
								<c:when test="${dto.eventType=='clockin'}">
            		일일포인트 : ${dto.event.daybyday} 주간 포인트 : ${dto.event.weekly} 월간 포인트 : ${dto.event.monthly}
            		</c:when>
								<c:otherwise>
            		댓글 개수 : ${dto.event.commcount}
            		</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th>이벤트 내용</th>
						<td colspan="3">${dto.textcontent}</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-area">
				<!-- 편집/삭제/목록 버튼 -->
				<c:if test="${dto.eventType == 'comment' }">
					<button type="button" onclick="pickWinners()">당첨자발표</button>
				</c:if>
				<button type="button" onclick="alert('편집 기능을 연결하세요.')">편집</button>
				<button type="button" onclick="alert('삭제 기능을 연결하세요.')">삭제</button>
				<button type="button" onclick="history.back()">목록으로 가기</button>
			</div>
		</div>
	</main>

	<script type="text/javascript">
		
		function pickWinners(){
			//window.open('${pageContext.request.contextPath}/admin/event/winners?num=${dto.event_article_num}','_blank', 'width=500, height=700, scrollbars=yes, resizable=no');
			
			let url = "${pageContext.request.contextPath}/admin/notice/write?category=event"+${dto.event_article_num};
			location.href = url;
		}
	</script>
</body>
</html>
