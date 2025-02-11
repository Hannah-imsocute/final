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
			<form>
				<!-- 이벤트명 -->
				<div class="mb-3">
					<label for="subject" class="form-label">이벤트명</label> 
					<input type="text" class="form-control" id="subject" name="subject" placeholder="이벤트명을 입력하세요">
				</div>

				<!-- 이벤트 설명 -->
				<div class="mb-3">
					<label for="textcontent" class="form-label">이벤트 설명</label>
					<textarea class="form-control" id="textcontent" name="textcontent" rows="5" placeholder="이벤트 내용을 입력하세요"></textarea>
				</div>

				<!-- 이벤트 설정 -->
				<fieldset class="mb-3">
					<legend>이벤트 설정</legend>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType" id="coupon" value="coupon" checked>
						<label class="form-check-label" for="coupon">쿠폰 이벤트</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType" id="checkin" value="checkin">
						<label class="form-check-label" for="checkin">체크인 이벤트</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="eventType" id="comm" value="comm">
						<label class="form-check-label" for="comm">댓글 이벤트</label>
					</div>
				</fieldset>

				<div class="mb-3">
					<label for="thumbnail"> 썸네일 이미지를 설정해주세요 </label>
					<input type="file" class="form-control" id="thumbnail" name="thumbnail">
				</div>

				<!-- 제출 버튼 -->
				<div class="d-grid">
					<button type="submit" class="btn btn-primary btn-lg">등록하기</button>
				</div>
			</form>
		</div>

		<!-- 오른쪽: 쿠폰 및 이벤트 테이블 -->
		<div class="form-container form-small">
			<h2 class="text-center mb-4">이벤트 목록</h2>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="chkAll" name="chkAll">
							<label for="chkAll"> 전체 </label></th>
						<th>쿠폰 및 이벤트명</th>
						<th>진행기간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody> 
				
					<tr>
						<td><input type="checkbox" id="" name=""></td>
						<td>회원가입 이벤트</td>
						<td>2월 1일 - 2월 28일</td>
						<td>대기중</td>
					</tr>
				
				</tbody>
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
					console.log(data.state);
				}
			
				ajaxRequest(url, 'get', null, 'json', returnfn);
			}
		});
	});
});


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

	
</script>
</html>
