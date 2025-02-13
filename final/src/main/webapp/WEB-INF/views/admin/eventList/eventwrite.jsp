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
<style>
* {
	box-sizing: border-box;
}

.container {
	display: flex;
	gap: 20px; /* 두 개의 form-container 간격 조정 */
}

.form-container {
	padding: 20px;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	min-width: 400px; /* 너무 작아지는 것 방지 */
	margin-top: 150px;
}

.form-container.form-large {
	flex: 6; /* 큰 크기 */
	min-width: 500px;
}

/* 이벤트 목록 테이블을 30% 크기로 */
.form-container.form-small {
	flex: 4; /* 작은 크기 */
	min-width: 300px;
}

header {
	position: relative !important;
}

legend {
	font-size: 1.2rem;
	font-weight: bold;
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background: #f8f9fa;
	font-weight: bold;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main class="container mt-5">
		<!-- 왼쪽: 이벤트 등록 폼 -->
		<div class="form-container form-large">
			<h2 class="text-center mb-4">이벤트 등록</h2>
			<form name="eventForm" method="post">
				<!-- 이벤트명 -->
				<div class="mb-3">
					<label for="subject" class="form-label">이벤트명</label> <input
						type="text" class="form-control" id="subject" name="subject"
						placeholder="이벤트명을 입력하세요">
				</div>

				<!-- 이벤트 설명 -->
				<div class="mb-3">
					<label for="textcontent" class="form-label">이벤트 설명</label>
					<textarea class="form-control" id="textcontent" name="textcontent"
						rows="5" placeholder="이벤트 내용을 입력하세요"></textarea>
				</div>

				<!-- 이벤트 설정 -->
				<fieldset class="mb-3">
					<legend>이벤트 설정</legend>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType"
							id="coupon" value="coupon" checked> <label
							class="form-check-label" for="coupon">쿠폰 이벤트</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType"
							id="checkin" value="checkin"> <label
							class="form-check-label" for="checkin">체크인 이벤트</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType"
							id="comm" value="comm"> <label class="form-check-label"
							for="comm">댓글 이벤트</label>
					</div>
				</fieldset>

				<div class="mb-3">
					<label for="thumbnail"> 썸네일 이미지를 설정해주세요 </label> <input type="file"
						class="form-control" id="thumbnail" name="thumbnail">
				</div>

				<!-- 제출 버튼 -->
				<div class="d-grid">
					<button type="button" class="btn btn-primary btn-lg"
						onclick="uploadEvent();">등록하기</button>
				</div>
				<input type="hidden" name="coupon_code" value="default"> <input
					type="hidden" name="clockin_num" value="0">
			</form>
		</div>

		<!-- 오른쪽: 쿠폰 및 이벤트 테이블 -->
		<div class="form-container form-small">
			<h2 class="text-center mb-4">이벤트 목록</h2>
			<table class="listTable">
			</table>
		</div>
	</main>
</body>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : 'textcontent',
		sSkinURI : '${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html',
		fCreator : 'createSEditor2',
		fOnAppLoad : function() {
			// 로딩 완료 후
			oEditors.getById['textcontent'].setDefaultFont('돋움', 12);
		},
	});
</script>
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

$(function (){
	$('input[name="eventType"]').each(function () {
		
		$(this).click(function () {
			
			if($(this).prop('checked')){
				let url = "${pageContext.request.contextPath}/adminevent/eventlist/"+$(this).val();
			
				const returnfn = function (data) {
					let type = data.type;
					
					if(type === 'coupon'){
						CouponLoading(data);
					}else if(type === 'checkin') {
						checkinLoading(data);
					}
				}
			
				ajaxRequest(url, 'get', null, 'json', returnfn);
			}
		});
	});
	
	$('input#coupon').trigger('click');
	
});

function CouponLoading(data){
		let out = '';
						
		out += `<thead>`;
		out += `	<tr>`;
		out += `		<th></th>`;
		out += `		<th>쿠폰명</th>`;
		out += `		<th>진행기간</th>`;
		out += `		<th>할인율</th>`;
		out += `		<th>상태</th>`;
		out += `	</tr>`;
		out += `</thead>`;
					
		if(! data.list){
			out += `<tbody>`;
			out += `	<tr>`;
			out += `		<td colspan="5">등록된 쿠폰이 없습니다</td>`;
			out += `	</tr>`;
			out += `</tbody>`;
			$('.listTable').empty();
			$('.listTable').append(out);
			return false;
		}
		
		let count = 0;
		for(let dto of data.list){
				
			let coupon_code = dto.coupon_code;
			let couponName = dto.couponName;
			let rate = dto.rate;
			let start = dto.start;
			let end = dto.end;
			let valid = dto.valid;
			
			out += '<tbody>';
			out += '	<tr>';
			out += '		<td><input type="radio" id="coupon'+coupon_code+'" name="selectdetail" data-code=' + coupon_code;
			if(count == 0){
				out += ' checked ></td>';
			}else {
				out += ' ></td>';
			}
			out += '		<td>' + couponName + '</td>';
			out += '		<td> ' + start + ' - ' + end + '</td>';
			out += '		<td> ' + rate  + '% </td>';
			out += ' <td>' + valid + ' </td>';
			out += '</tr>';
			out += '</tbody>';
			
			count++;
		}
		$('.listTable').empty();
		$('.listTable').append(out);
}


function checkinLoading(data) {
	let out = '';
	
	out += `<thead>`;
	out += `	<tr>`;
	out += `		<th></th>`;
	out += `		<th>이벤트명</th>`;
	out += `		<th>진행기간</th>`;
	out += `		<th>일일적립포인트</th>`;
	out += `		<th>주간적립포인트</th>`;
	out += `		<th>월간적립포인트</th>`;
	out += `		<th>상태</th>`;
	out += `	</tr>`;
	out += `</thead>`;
	
	if(! data.list){
		out += `<tbody>`;
		out += `	<tr>`;
		out += `		<td colspan="7">등록된 출석체크일정이 없습니다</td>`;
		out += `	</tr>`;
		out += `</tbody>`;
		$('.listTable').empty();
		$('.listTable').append(out);
		return false;
	}
	
	let count = 0;
	for(let dto of data.list){
		
		let clockin_num = dto.clockin_num;
		let event_title = dto.event_title;
		let start_date = dto.start_date;
		let expire_date = dto.expire_date;
		let daybyday = dto.daybyday;
		let weekly = dto.weekly;
		let monthly = dto.monthly;
		let selected = dto.selected;
		
		out += '<tbody>';
		out += '	<tr>';
		out += '		<td><input type="radio" id="clockin'+clockin_num+'" name="selectdetail" data-code=' + clockin_num;
		if(count == 0){
		out += ' checked ></td>';
		}else {
		out += ' ></td>';
		}
		out += '		<td>' + event_title + '</td>';
		out += '		<td> ' + start_date + ' - ' + expire_date + '</td>';
		out += '		<td> ' + daybyday +'p</td>';
		out += '		<td> ' + weekly  +'p</td>';
		out += '		<td> ' + monthly +'p</td>';
		out += ' <td>' + selected + ' </td>';
		out += '</tr>';
		out += '</tbody>';
		
		count++;
	}
	$('.listTable').empty();
	$('.listTable').append(out);
	
}

function checkValid() {
	
	let eventName = $('#subject').val();
	let eventContent = $('#textcontent').val();
	let eventType = $('input[name="eventType"]').val();
	let thumbNail = $('#thumbnail').val();
	
	
	if(! eventName){
		return false;
	}
	
	if(! eventContent){
		return false;
	}
	
	if(eventType === 'coupon'){
		
	}else if(eventType === 'checkin'){
		
	}
	
	if(! thumbNail){
		return false;
	}
	
}


function uploadEvent() {
	
	let form = $('form[name=eventForm]');
	let $form = document.querySelector('form[name=eventForm]');
	
	let subject = form.find('[name=subject]').val();
	let content = oEditors.getById["textcontent"].getIR();
	oEditors.getById["textcontent"].exec("UPDATE_CONTENTS_FIELD", []);

	
	let type = form.find('[name=eventType]').val();
	let thumbnail = form.find('[name=thumbnail]').val();
	
	let selectdetail = $('input[name=selectdetail]').attr('data-code');
	console.log(selectdetail);
	if(type == 'coupon'){
		$('input[name=coupon_code]').val(selectdetail);
	}else if(type == 'clockin'){
		$('input[name=clockin_num]').val(selectdetail);
	}
	
	
	if(! subject){
		alert('이벤트 제목을 등록해주세요');
		return false;
	}
	
	if(! content){
		alert('컨텐츠를 작성해주세요');
		return false;
	}
	
	if(! type){
		alert('게시글의 타입을 지정해주세요');
		return false;
	}
	
	if(! thumbnail){
		alert('썸네일 이미지를 지정해주세요');
		return false;
	}
	if(! selectdetail && type !='comm'){
		alert('하나의 이벤트를 선택해야합니다');
		return false;
	}
	
	$form.action = "${pageContext.request.contextPath}/adminevent/writeform";
	$form.submit();
	
}

	
</script>
</html>
