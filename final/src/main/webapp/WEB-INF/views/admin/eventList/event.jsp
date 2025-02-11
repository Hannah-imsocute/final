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
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="#">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link active" href="#">종료된
						이벤트</a></li>
				<li class="nav-item"><a class="nav-link" href="#">당첨자발표</a></li>
			</ul>
			<div class="btn-cover">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#staticBackdrop">이벤트 등록</button>
				<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/adminevent/posting'">이벤트 게시글 등록</button>
			</div>
			<div class="eventList">
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>이벤트명</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${couponlist}" varStatus="status">
							<tr>
								<td>${status.index}</td>
								<td><a href="#" data-couponCode="${dto.coupon_code}">${dto.couponName}</a></td>
								<td>${dto.start}</td>
								<td>${dto.end}</td>
								<td class="status">진행중</td>
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



	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">이벤트 등록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="chk-cover">
						<div class="form-check">
							<input class="form-check-input first" type="radio" name="chk"
								id="chk1" checked> <label class="form-check-label"
								for="chk1"> 쿠폰등록 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="chk" id="chk2">
							<label class="form-check-label" for="chk2"> 출석체크 이벤트 등록 </label>
						</div>
					</div>
					<form action="" name="chkForm">
						<div class="content1" style="display: none;">
							<jsp:include page="/WEB-INF/views/admin/eventList/eventcoupon.jsp" />
						</div>
						<div class="content2" style="display: none;">
							<jsp:include page="/WEB-INF/views/admin/eventList/eventclockin.jsp" />
						</div>
						<div class="content3" style="display: none;">
							<jsp:include page="/WEB-INF/views/admin/eventList/eventcomm.jsp" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary modalClosebtn"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary submit"
						onclick="submitContents()" data-chk="chk1">등록</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js"
		charset="utf-8"></script>
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
			$('input.first').trigger('click');
	});
		
	$('input[name=chk]').each(function() {
		$(this).on('click',function(){
				$('.content1').hide();
				$('.content2').hide();
				$('.content3').hide();
				if($(this).attr('id')==='chk1') {
					$('.content1').show();
					$('button.submit').attr('data-chk', "chk1");
				}else if ($(this).attr('id')==='chk2'){
					$('.content2').show();
					$('button.submit').attr('data-chk', "chk2");
				}else if ($(this).attr('id')==='chk3'){
					$('.content3').show();
					$('button.submit').attr('data-chk', "chk3");
				}
				
			});
		});
		
		
		function submitContents(){
			let chk = $('button.submit').attr('data-chk');
			
			if(chk === 'chk1'){
				if(checkCouponValid()){
				
					let name = $('input[name="couponName"]').val();
					let rate = $('input[name="couponRate"]').val();
					let start = $('input[name="couponStart"]').val();
					let end = $('input[name="couponEnd"]').val();
					let valid = $('input[name="couponValid"]').val();
					
					let url = '${pageContext.request.contextPath}/adminevent/coupon';
					let param = {name : name , rate : rate ,start : start , end : end,valid : valid};
				
					const returnfn = function (resp) {
						$('.modalClosebtn').trigger('click');
						//$('.modalClosebtn').modal('hide');
						console.log(resp.state);
					}
				
					ajaxRequest(url,'post',param,'json', returnfn)
				}

			}else if(chk === 'chk2'){
				
				if( checkClockEvent()){
					
					let eventName = $('input[name="eventName"]').val();
					let daypoint = $('input[name="daypoint"]').val();
					let weeklypoint = $('input[name="weeklypoint"]').val();
					let monthlypoint = $('input[name="monthlypoint"]').val();
					let eventStart = $('input[name="eventStart"]').val();
					let eventEnd = $('input[name="eventEnd"]').val();
					
					let url = '${pageContext.request.contextPath}/adminevent/clockin';
					let param = {eventName : eventName ,  daypoint : daypoint, weeklypoint : weeklypoint, monthlypoint : monthlypoint, eventstart : eventStart , eventend : eventEnd };
				
					const eventCallback = function (data) {
						$('.modalClosebtn').trigger('click');
						//$('.modalClosebtn').modal('hide');
						console.log(data.state);
					}
					
					ajaxRequest(url, 'post', param, 'json', eventCallback);
				}
			}
			
		};
		
			function checkCouponValid() {
				let name = $('input[name="couponName"]').val();
				let rate = $('input[name="couponRate"]').val();
				let start = $('input[name="couponStart"]').val();
				let end = $('input[name="couponEnd"]').val();
				let valid = $('input[name="couponValid"]').val();

				let startdate = new Date(start);
				let enddate = new Date(end);
				
				if(! name){
					alert('쿠폰명을 입력해주세요');
					$('input[name="couponName"]').focus();
					return false;
				}
				if(! rate){
					alert('할인율을 입력해주세요');
					$('input[name="couponRate"]').focus();
					return false;
				}else if( ! /^\d+(\.\d)?$/.test(rate)){
					alert('할인율은 소수점 한자리까지만 지정가능합니다.');
				}
				if(! start){
					alert('시작일을 지정해주세요');
					$('input[name="couponStart"]').focus();
					return false;
					
				}else if(startdate > enddate) {
					alert('시작일이 종료일보다 클 수 없습니다.');
					return false;
				}
				
				if(! end){
					alert('종료일을 지정해주세요');
					$('input[name="couponEnd"]').focus();
					return false;
				}
				
				if(! valid){
					alert('유효기간을 입력해주세요');
					$('input[name="couponValid"]').focus();
					return false;
				}
				return true;
			}
			
			function checkClockEvent() {
				let eventName = $('input[name="eventName"]').val();
				let daypoint = $('input[name="daypoint"]').val();
				let weeklypoint = $('input[name="weeklypoint"]').val();
				let monthlypoint = $('input[name="monthlypoint"]').val();
				let eventStart = $('input[name="eventStart"]').val();
				let eventEnd = $('input[name="eventEnd"]').val();
				
				if(! eventName){
					alert('이벤트 명을 입력해주세요.');
					$('input[name="eventName"]').focus();
					return false;
				}
				if(! daypoint){
					alert('일일 적립포인트를 입력해주세요.');
					$('input[name="daypoint"]').focus();
					return false;
				}
				if(! weeklypoint){
					alert('주간 적립 포인트를 입력해주세요.');
					$('input[name="weeklypoint"]').focus();
					return false;
				}
				if(! monthlypoint){
					alert('월간 적립 포인트를 입력해주세요.');
					$('input[name="monthlypoint"]').focus();
					return false;
				}
				if(! eventStart){
					alert('시작일을  지정해주세요.');
					$('input[name="eventStart"]').focus();
					return false;
				}
				if(! eventEnd){
					alert('종료일을 지정해주세요.');
					$('input[name="eventEnd"]').focus();
					return false;
				}
				
				return true;
			}
		
	</script>

</body>
</html>