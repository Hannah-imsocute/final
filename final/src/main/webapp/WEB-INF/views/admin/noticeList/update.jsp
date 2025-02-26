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
	background-color: #f8f9fa;
}

.custom-container {
	min-width: 1000px;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background: #fff;
}

.form-label {
	font-weight: 600;
}

.btn-primary {
	width: 100%;
	font-size: 1.1rem;
	padding: 10px;
	border-radius: 8px;
}

.form-control, .form-select {
	border-radius: 8px;
	padding: 10px;
}

.form-check-label {
	font-weight: 500;
}
</style>

</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main style="width: 80%; margin-top: 200px; margin-left: 300px;">
		<div
			class="container d-flex justify-content-center align-items-center vh-100">
			<div class="custom-container">
				<h1 class="text-center mb-4">📢 공지 등록</h1>

				<!-- 글 작성 폼 -->
				<form method="post" name="writeForm">
					<!-- 제목 -->
					<div class="mb-4">
						<label for="subject" class="form-label">제목</label> <input
							type="text" class="form-control" id="subject" name="subject"
							value="${dto.subject}"
							placeholder="제목을 입력하세요." required>
					</div>

					<!-- 내용(Textarea) -->
					<div class="mb-4">
						<label for="textcontent" class="form-label">내용</label>
						<textarea class="form-control" id="textcontent" name="textcontent"
							rows="6" placeholder="내용을 입력하세요." required></textarea>
					</div>

					<!-- FAQ 등록 여부(Radio 버튼) + 당첨자 추첨하기 버튼 -->
					<div class="mb-4">
						<label class="form-label">FAQ로 등록</label>
						<!-- d-flex 로 묶고 gap(간격) 또는 margin 등을 활용해 버튼과 라디오 사이 간격 넉넉히 -->
						<div class="d-flex align-items-center" style="gap: 40px;">
							<div class="d-flex gap-4">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="fixed"
										id="faqYes" value="1" ${dto.fixed == 1 ? 'checked' : ''}>
									<label class="form-check-label" for="faqYes">예</label>
								</div>
								<div class="form-check">
									<input class="form-check-input defaultfaq" type="radio" name="fixed"
										id="faqNo" value="0" ${dto.fixed == 0 ? 'checked' : ''}	>
										 <label class="form-check-label" for="faqNo">아니오</label>
								</div>
							</div>
							
						</div>
					</div>

					<!-- 카테고리 선택(Select) -->
					<div class="mb-4">
						<label for="category" class="form-label">카테고리</label> <select
							class="form-select" id="category" name="category_num">
							<option value="0" ${dto.category_num == 0 ? 'selected':'' }>선택하세요</option>
							<option value="2" ${dto.category_num == 2 ? 'selected':'' }>배송</option>
							<option value="3" ${dto.category_num == 3 ? 'selected':'' }>주문</option>
							<option value="4" ${dto.category_num == 4 ? 'selected':'' }>결제</option>
							<option value="5" ${dto.category_num == 5 ? 'selected':'' }>회원</option>
							<option value="6" ${dto.category_num == 6 ? 'selected':'' }>이벤트당첨</option>
						</select>
					</div>

					<!-- 등록 버튼 -->
					<button type="submit" class="btn btn-primary" onclick="Submit()">등록</button>
				</form>
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
						oEditors.getById['textcontent'].setDefaultFont('돋움', 12);
						let content = '<c:out value="${dto.textcontent}" />';
						oEditors.getById['textcontent'].setIR(content);
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
		
		$(function() {
			$('.form-check-input').click(function() {
				let value = $(this).attr('value');

				if (value == '0') {
					$('#category').prop('disabled', true);
				} else {
					$('#category').prop('disabled', false);
				}
			});
			
		});

		function Submit() {
			let url = "${pageContext.request.contextPath}/admin/notice/save";
			let $form = document.querySelector('form');

			// textarea 처리
			oEditors.getById["textcontent"].exec("UPDATE_CONTENTS_FIELD", []);

			$form.action = url;
			$form.submit();
		}
		
		
	</script>
</body>
</html>
