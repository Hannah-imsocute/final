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
							placeholder="제목을 입력하세요." required>
					</div>

					<!-- 내용(Textarea) -->
					<div class="mb-4">
						<label for="textcontent" class="form-label">내용</label>
						<textarea class="form-control" id="textcontent" name="textcontent"
							rows="6" placeholder="내용을 입력하세요." required></textarea>
					</div>

					<!-- FAQ 등록 여부(Radio 버튼) -->
					<div class="mb-4">
						<label class="form-label">FAQ로 등록</label>
						<div class="d-flex gap-4">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="fixed"
									id="faqYes" value="1"> <label class="form-check-label"
									for="faqYes">예</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="fixed"
									id="faqNo" value="0" checked> <label
									class="form-check-label" for="faqNo">아니오</label>
							</div>
						</div>
					</div>

					<!-- 카테고리 선택(Select) -->
					<div class="mb-4">
						<label for="category" class="form-label">카테고리</label> <select
							class="form-select" id="category" name="category_num" disabled>
							<option value="0">선택하세요</option>
							<option value="2">배송</option>
							<option value="3">주문</option>
							<option value="4">결제</option>
							<option value="5">회원</option>
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
					oEditors.getById['textcontent']
							.setDefaultFont('돋움', 12);
				},
			});	
	</script>
	
	<script type="text/javascript">
		$(function(){
			$('.form-check-input').click(function(){
				let value = $(this).attr('value');
				
				if(value == '0'){
					$('#category').prop('disabled', true);
				}else {
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