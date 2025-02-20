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
<style type="text/css">
/* 기본 스타일 */
body {
    background-color: #f5f6fa;
    font-family: 'Noto Sans KR', sans-serif;
}

/* main의 margin-top을 크게 조정 */
main {
    margin-top: 250px; /* 기존보다 더 여유 있는 여백 */
    padding-top: 20px; /* 추가적인 위쪽 여백 */
}

/* 카드 스타일 */
.event-card {
    max-width: 800px;
    background: #ffffff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
}

/* 제목 */
.event-title {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

/* 테이블 스타일 */
.event-table {
    width: 100%;
    background: #ffffff;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.event-table th, .event-table td {
    padding: 15px;
    border-bottom: 1px solid #ddd;
}

.event-table th {
    background-color: #f8f9fa;
    font-weight: bold;
    text-align: left;
    width: 30%;
}

.event-table td {
    text-align: left;
    color: #555;
}

/* 이벤트 타입 (라디오 버튼) */
.event-type {
    display: flex;
    gap: 15px;
    align-items: center;
}

.event-type label {
    font-size: 16px;
    color: #444;
}

.event-type input {
    margin-right: 5px;
}

/* 버튼 스타일 */
.btn-outline-primary {
    border: 2px solid #007bff;
    color: #007bff;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 6px;
    transition: all 0.3s ease-in-out;
}

.btn-outline-primary:hover {
    background-color: #007bff;
    color: white;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .event-card {
        padding: 20px;
    }
    .event-title {
        font-size: 24px;
    }
    .event-table th, .event-table td {
        padding: 12px;
        font-size: 14px;
    }
}
</style>

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>
	<main class="container mt-9">
		<div class="event-card shadow-lg p-4 mx-auto">
			<h2 class="event-title text-center">${event.subject}</h2>

			<!-- 이벤트 정보 테이블 -->
			<table class="table event-table">
				<tbody>
					<tr>
						<th>이벤트명</th>
						<td>${event.subject}</td>
					</tr>
					<tr>
						<th>이벤트 작성일</th>
						<td><fmt:formatDate value="${event.createdDate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
					<tr>
						<th>이벤트 시작일</th>
						<td><fmt:formatDate value="${event.startdate}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th>이벤트 종료일</th>
						<td><fmt:formatDate value="${event.enddate}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th>이벤트 컨텐츠</th>
						<td>${event.textcontent}</td>
					</tr>
					<tr>
						<th>이벤트 타입</th>
						<td>
							<div class="event-type">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="eventType" value="coupon"
									disabled
									<c:if test="${event.eventType == 'coupon'}">checked</c:if>>
									쿠폰
								</label> <label class="form-check-label"> <input type="radio"
									class="form-check-input" name="eventType" value="comment"
									disabled
									<c:if test="${event.eventType == 'comment'}">checked</c:if>>
									댓글
								</label> <label class="form-check-label"> <input type="radio"
									class="form-check-input" name="eventType" value="checkin"
									disabled
									<c:if test="${event.eventType == 'checkin'}">checked</c:if>>
									출석체크
								</label>
							</div>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="text-center mt-4">
				<a href="${pageContext.request.contextPath}/admin/event/list"
					class="btn btn-outline-primary">목록으로</a>
			</div>
		</div>
	</main>
</body>
</html>