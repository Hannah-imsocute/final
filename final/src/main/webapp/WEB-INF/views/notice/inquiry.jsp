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
<style type="text/css">
body {
	background-color: #f8f9fa;
}

.contact-form {
	max-width: 600px;
	margin: 50px auto;
	background: #fff;
	border-radius: 8px;
	padding: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.contact-form h2 {
	margin-bottom: 20px;
	font-weight: 600;
}

.form-label {
	font-weight: 500;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main style="margin-top: 250px;">
		<div class="container">
			<div class="contact-form">
				<h2 class="text-center">문의하기</h2>
				<form name="inquiryForm" method="post">
					<!-- 제목 -->
					<div class="mb-3">
						<label for="subject" class="form-label">제목</label> <input
							type="text" class="form-control" id="subject" name="subject"
							placeholder="문의 제목을 입력하세요" required>
					</div>
					<!-- 카테고리 -->
					<div class="mb-3">
						<label for="category_num" class="form-label">카테고리</label> <select
							class="form-select" id="category_num" name="category_num" required>
							<option value="" selected >카테고리를 선택하세요</option>
							<option value="2">배송문의</option>
							<option value="3">주문문의</option>
							<option value="4">결제문의</option>
							<option value="5">회원문의</option>
						</select>
					</div>
					<!-- 내용 -->
					<div class="mb-3">
						<label for="textcontent" class="form-label">내용</label>
						<textarea class="form-control" id="textcontent" name="textcontent"
							rows="5" placeholder="문의 내용을 입력하세요" required></textarea>
					</div>
					<!-- 전송 버튼 -->
					<div class="d-grid">
						<button type="button" class="btn submit-btn" style="background-color: #FF7C00; border-color: #FF7C00; color: #fff;">문의 전송</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	
	<script type="text/javascript">
		$(function(){
			$('.submit-btn').click(function(){
				let $form = document.querySelector('form[name=inquiryForm]');
				let url = '${pageContext.request.contextPath}/notice/inquiries';
				
				$form.action = url;
				$form.submit();
			});
		});
	</script>
</body>
</html>