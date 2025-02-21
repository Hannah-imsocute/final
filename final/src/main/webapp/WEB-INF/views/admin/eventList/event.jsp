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
.content-around {
	margin-left: 200px;
}

.btn-cover {
	margin-top: 30px;
}

.eventList {
	margin-top: 30px;
}

.chk-cover {
	display: flex;
}

.form-check {
	margin-left: 10px;
}

.inputs-cover {
	margin-top: 15px;
}

.eachinput {
	margin-top: 10px;
}

/* 테이블 공통 스타일 */
table {
	width: 90%;
	border-collapse: collapse; /* 테두리 겹침 제거 */
	margin-bottom: 20px;
}

thead {
	background-color: #dbc2a6; /* 헤더 배경색 (샘플) */
	color: #fff; /* 헤더 글씨 색상 (샘플) */
}

thead th {
	padding: 10px;
	text-align: left;
	font-weight: bold;
}

tbody tr:nth-child(even) {
	background-color: #f9f9f9; /* 짝수 행 배경색 */
}

tbody td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

/* 상태나 수정 버튼 등에 스타일을 주고 싶다면 예시 추가 */
.status {
	font-weight: bold;
	color: #008000; /* 진행중일 때 초록색 예시 */
}

.edit-btn {
	background-color: #eee;
	border: none;
	padding: 6px 12px;
	cursor: pointer;
}

.edit-btn:hover {
	background-color: #ccc;
}

.se2_inputarea {
	width: 70% !important;
	height: 400px !important; /* 원하는 크기로 조정 */
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="content-around">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active ongoingEvent"
					aria-current="page" href="#" data-mode="ongoingEvent" data-page="1">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link closedEvent" data-mode="closedEvent" data-page="1">종료된 이벤트</a></li>
				<li class="nav-item"><a class="nav-link winners" data-mode="winners" data-page="1">당첨자 발표</a></li>
				<li class="nav-item"><a class="nav-link couponsetting" data-mode="couponsetting" data-page="1">쿠폰 관리</a></li>
			</ul>
			<div class="btn-cover">
				<button type="button" class="btn btn-primary btn-upload-event">이벤트
					등록</button>
			</div>
			<div class="eventList">
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>이벤트명</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>진행상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td></td>
								<td><a href="${pageContext.request.contextPath}/admin/event/article/${dto.event_article_num}?type=${dto.eventType}" data-eventnum="${dto.event_article_num}">${dto.subject}</a></td>
								<td>${dto.startdate}</td>
								<td>${dto.enddate }</td>
								<td class="status">
								</td>
								<td>
									<button type="button" class="edit-btn btn">수정</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</main>
	<script type="text/javascript">
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
	
	$(function(){
		$('.btn-upload-event').click(function(){
			let url = "${pageContext.request.contextPath}/admin/event/write";
			location.href = url;
		});
	});
	
	$(function(){
		$('.nav-link').each(function(){
			$(this).click(function(){
				let mode = $(this).attr('data-mode');
				let page = $(this).attr('data-page');
				let url = '${pageContext.request.contextPath}/admin/event/rendering';
				let params = {mode : mode, page : page};
				
				$('.active').removeClass('active');
				$(this).addClass('active');
				
				const fn = function(data){
					console.log(data);
					
					if(data.mode == 'ongoingEvent'){
						ongoingEvent(data);
					}
				}
				$('tbody').html('');
				ajaxRequest(url, 'get', params, 'json' , fn);
			});
		});
	});
	
	function closedEvent(data){
		console.log(data.list);
		
		let out = '';
		for(el of data.list){
			let num = el.event_article_num;
			let subject = el.subject;
			let startdate = el.startdate;
			let enddate = el.enddate;
			let type = el.eventType;
			
			out += '<tr>';
			out += '	<td></td>';
			out += '	<td><a href="${pageContext.request.contextPath}/admin/event/article/'+num+'?type='+type+'" data-eventnum="'+num+'">'+subject+'</a></td>';
			out += '	<td>'+startdate+'</td>';
			out += '	<td>'+enddate+'</td>';
			out += '	<td class="staus">종료</td>';
			out += '	<td></td>';
		}
		
		$('tbody').html(out);
	};
	
	function ongoingEvent(data){
		console.log(data);
		
		let out = '';
		for(el of data.list){
			let num = el.event_article_num;
			let subject = el.subject;
			let startdate = el.startdate;
			let enddate = el.enddate;
			let type = el.eventType;
			
			out += '<tr>';
			out += '	<td></td>';
			out += '	<td><a href="${pageContext.request.contextPath}/admin/event/article/'+num+'?type='+type+'" data-eventnum="'+num+'">'+subject+'</a></td>';
			out += '	<td>'+startdate+'</td>';
			out += '	<td>'+enddate+'</td>';
			out += '	<td class="staus">진행중</td>';
			out += '	<td><button type="button" class="edit-btn btn">수정</button></td>';
		}
		
		$('tbody').html(out);
	};
	</script>
</body>
</html>