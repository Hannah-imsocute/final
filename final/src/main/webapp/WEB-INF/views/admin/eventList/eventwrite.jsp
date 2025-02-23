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
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main class="container mt-9">
		<div class="card shadow-lg p-4 mx-auto ms-9"
			style="min-height: 800px; max-width: 900px;">
			<h3 class="mb-4 text-center">이벤트 등록</h3>
			<form name="articleForm" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="subject" class="form-label">이벤트 제목</label> <input
						type="text" class="form-control" id="subject" name="subject"
						placeholder="이벤트 제목을 입력하세요">
				</div>

				<div class="mb-3">
					<label for="textcontent" class="form-label">이벤트 내용</label>
					<textarea class="form-control" id="textcontent" name="textcontent"
						rows="10" placeholder="이벤트 내용을 입력하세요"></textarea>
				</div>

				<div class="mb-3">
					<label for="thumbnail" class="form-label">썸네일 이미지</label> <input
						type="file" class="form-control" id="thumbnail" name="file">
				</div>

				<div class="row g-3 mb-3">
					<div class="col-md-6">
						<label for="startdate" class="form-label">시작 날짜</label> <input
							type="date" class="form-control" id="startdate" name="startdate">
					</div>
					<div class="col-md-6">
						<label for="enddate" class="form-label">종료 날짜</label> <input
							type="date" class="form-control" id="enddate" name="enddate">
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label">이벤트 유형</label>
					<div class="d-flex gap-3">
						<div class="form-check">
							<input class="form-check-input couponchk" type="radio"
								name="eventType" id="eventType1" value="coupon"> <label
								class="form-check-label" for="eventType1">쿠폰</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="eventType"
								id="eventType2" value="checkin"> <label
								class="form-check-label" for="eventType2">출석체크</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="eventType"
								id="eventType3" value="comment"> <label
								class="form-check-label" for="eventType3">댓글</label>
						</div>
						<div class="form-check">
							<button type="button" class="btn btn-primary px-4 upload"
								data-bs-toggle="modal" data-bs-target="#staticBackdrop">coupon</button>
						</div>
					</div>
				</div>
				<div>
					<input type="text" class="form-control" name="eventdetail"
						data-status="false" readonly>
				</div>
				<div class="text-center">
					<button type="button" class="btn submitbtn">이벤트 게시</button>
				</div>
			</form>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">쿠폰 및 스케줄러 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body text-center">
						<form name="typeForm" enctype="multipart/form-data"></form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary btnupload"
							data-type="coupon">등록</button>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js"
		charset="utf-8"></script>
	<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : 'textcontent',
					sSkinURI : '${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html',
					fCreator : 'createSEditor2',
					fOnAppLoad : function() {
						// 로딩 완료 후
						oEditors.getById['textcontent']
								.setDefaultFont('돋움', 12);
					},
				});
		
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

	</script>

	<script type="text/javascript">
	
			// radio 버튼에 따라서 모달 내용을 바꾸는 ajax
			$(function() {
				$('.form-check-input').click(function(){
					let value = $(this).attr('value');
					if(value == 'comment'){
						$('.upload').prop('disabled',true);	
					}else if(value == 'coupon') {
						$('.upload').prop('disabled',false);
						let url = "${pageContext.request.contextPath}/admin/event/bringform";
						let param = {type : 'coupon'};
						ajaxRequest(url, 'get', param, 'text', inputform);
						
					}else if( value == 'checkin'){
						$('.upload').prop('disabled',false);
						let url = "${pageContext.request.contextPath}/admin/event/bringform";
						let param = {type : 'checkin'};
						
						ajaxRequest(url, 'get', param, 'text', inputform);
					}
					
					$('.upload').text(value);
				});
				$('.couponchk').trigger('click');
			});
			
			// 모달 내용 삽입 
			function inputform( data ) {
				$('.modal-body form').html(data);
			}
			
			
			
			// 쿠폰 및 스케줄러 등록 
			$(function (){
				$('.btnupload').click(function (){
					let url = "${pageContext.request.contextPath}/admin/event/typefixed";
					
					let form = document.querySelector('form[name=typeForm]');
					
					let formdata = new FormData(form);
					
					ajaxRequest(url, 'post', formdata, 'json',handleTypeSubmit, true );
				});
			});
			
			// 타입지정 ajax 처리
			function handleTypeSubmit (data){
				$('input[name=eventdetail]').val("");
				
				let state = data.state;
				
				if(state != 'success'){
					alert("등록에 실패했습니다.");
					return;
				}
				
				let dto = data.dto;
				
				let string = '';
				if(dto.eventType == 'coupon'){
					string += '쿠폰코드 : ' + dto.coupon_code + ', 쿠폰명 : ' + dto.couponname ;
				}else if( dto.eventType == 'checkin'){
					string += '일일포인트 :' + dto.daybyday + ', 주간포인트 : ' + dto.weekly + ', 월간포인트 :' + dto.monthly;
				}
				
				$('input[name=eventdetail]').val(string);
				$('input[name=eventdetail]').attr('data-status', "true");
			}
			
			
			// 유효성 검사 ajax type 
			
			
			// 게시글 유효성검사
			function articleCheck( form ){
				return true;
			}
			
			
			// submit 
			$(function (){
				
				
				$('.submitbtn').click(function (){
					let url = "${pageContext.request.contextPath}/admin/event/write";
					
					let $form = document.querySelector('form[name=articleForm]');
					
					if( ! articleCheck($form) ){
						return false;
					}
					// 스마트에디터 내용 textarea 에 담기					
					oEditors.getById["textcontent"].exec("UPDATE_CONTENTS_FIELD", []);

					$form.action = url;
					$form.submit();
				});
		
				
				
			});
			
	</script>
</body>
</html>