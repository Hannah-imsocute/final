<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ttshop</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/dist/vendor/bootstrap5/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/vendor/bootstrap5/icon/bootstrap-icons.css"
	type="text/css">
<style>
/* 전체 페이지 레이아웃 */
body {
	margin: 0;
	padding: 0;
	font-family: 'Roboto', sans-serif;
	background-color: #f1f3f4; /* 구글 폼 배경과 비슷한 색 */
}

/* 폼 컨테이너 */
.form-container {
	max-width: 600px;
	margin: 50px auto 100px; /* 상단 여백, 하단 여백 */
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	padding: 30px;
}

/* 상단 헤더 - 제목, 서브텍스트 */
.form-header {
	border-bottom: 1px solid #e0e0e0;
	padding-bottom: 20px;
	margin-bottom: 20px;
}

.form-header h1 {
	font-size: 24px;
	margin: 0 0 8px 0;
	color: #202124;
}

.form-header p {
	color: #5f6368;
	margin: 0;
}

/* 각 질문(카드 형태) */
.form-question {
	background-color: #fff;
	border-radius: 4px;
	margin-bottom: 24px;
	padding: 15px 0;
}

/* 라벨(질문 텍스트) */
.form-question label {
	display: block;
	font-weight: 500;
	font-size: 16px;
	margin-bottom: 8px;
	padding: 0 16px; /* 양옆 여백 */
	color: #202124;
}

/* 공통 input, select 스타일 */
.form-question input[type="text"], .form-question input[type="password"],
	.form-question input[type="date"], .form-question input[type="file"],
	.form-question select {
	width: 100%;
	max-width: 100%;
	font-size: 14px;
	border: 1px solid #dadce0;
	border-radius: 4px;
	box-sizing: border-box;
}

/* 아이디-확인버튼 감싸는 wrapper */
.form-id-wrapper {
	display: flex;
	align-items: center;
	margin: 0 16px;
}

.form-id-wrapper input {
	flex: 1;
	padding: 8px;
	margin-right: 8px;
}

.form-id-wrapper button {
	min-width: 100px;
	padding: 8px;
	background-color: #fff;
	color: #202124;
	border: 1px solid #dadce0;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.form-id-wrapper button:hover {
	background-color: #f1f3f4;
}

/* 그 외 input, select 기본 padding, margin */
.form-question input:not(.id-input), .form-question select {
	margin: 0 16px;
	padding: 8px;
}

/* 필수 표시 */
.required {
	color: #d93025;
	margin-left: 4px;
	font-size: 14px;
}

/* 아이디 확인 결과 메시지 */
.check-id-msg {
	margin: 8px 16px;
	font-size: 14px;
	color: #d93025; /* 기본은 빨간색. 필요 시 동적으로 색 변경 가능 */
}

/* 제출 버튼 */
.form-submit {
	text-align: right;
	margin-top: 30px;
}

.form-submit button {
	background-color: #4285f4;
	color: #fff;
	font-size: 14px;
	font-weight: 500;
	padding: 10px 24px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.form-submit button:hover {
	background-color: #357ae8;
}
</style>
</head>
<body>
	<div class="form-container">
		<!-- 상단 헤더 영역 -->
		<div class="form-header">
			<h1>회원 가입 폼</h1>
			<p>아래 정보를 입력해 주세요.</p>
		</div>

		<form name="sellerForm" method="post" enctype="multipart/form-data">
			<!-- 아이디 -->
			<div class="form-question">
				<label for="id"> 아이디 <span class="required">*</span>
				</label>
				<div class="form-id-wrapper">
					<input type="text" id="id" name="email" required class="id-input">
					<button type="button" class="check-btn">아이디 확인</button>
				</div>
				<!-- 아이디 중복확인 결과 메시지 표시 영역 -->
				<div class="check-id-msg" data-state=""></div>
			</div>

			<!-- 비밀번호 -->
			<div class="form-question">
				<label for="password"> 비밀번호 <span class="required">*</span>
				</label> <input type="password" id="password" name="password" required>
			</div>

			<!-- 닉네임 -->
			<div class="form-question">
				<label for="nickname"> 닉네임 <span class="required">*</span>
				</label> <input type="text" id="nickname" name="nickname" required>
			</div>

			<!-- 생년월일 -->
			<div class="form-question">
				<label for="birth"> 생년월일 <span class="required">*</span>
				</label> <input type="date" id="birth" name="birth" required>
			</div>

			<!-- 계좌번호 -->
			<div class="form-question">
				<label for="accountNumber"> 계좌번호 <span class="required">*</span>
				</label> <input type="text" id="accountNumber" name="accNumber"
					placeholder="예: 123-456-7890" required>
			</div>

			<!-- 은행명 -->
			<div class="form-question">
				<label for="bankName"> 은행명 <span class="required">*</span>
				</label> <select id="bankName" name="bank" required>
					<option value="">선택</option>
					<option value="kookmin">국민은행</option>
					<option value="shinhan">신한은행</option>
					<option value="woori">우리은행</option>
					<option value="hana">하나은행</option>
					<option value="nonghyup">농협</option>
				</select>
			</div>

			<!-- 통장 사본 이미지 -->
			<div class="form-question">
				<label for="bankStatement"> 통장사본 이미지 <span class="required">*</span>
				</label> <input type="file" id="bankStatement" name="bankStatement"
					accept="image/*" required>
			</div>

			<!-- 제출 버튼 -->
			<div class="form-submit">
				<button type="button" name="submit-btn" class="submit-btn">제출하기</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
	
	$('.check-btn').click(function(){
		let idvalue = $('.id-input').val();
		let url = '${pageContext.request.contextPath}/member/register/sellercheck';
		let params = {email : idvalue};
			
		const callback = function(data){
			let state = data.state;
			console.log(state);
			if( state == false){
				$('.check-id-msg').attr('data-state','false').css('color', 'red').text('유효한 이메일이 아닙니다.');
			}else if(state == true) {
				$('.check-id-msg').attr('data-state','true').css('color', 'blue').text('사용가능한 이메일입니다.');
			}
		};
			
		ajaxRequest(url, 'post', params, 'json', callback);
	});
	
	$(function(){
		$('.submit-btn').click(function(){
			let $form = document.querySelector('form[name=sellerForm]');
			let url = '${pageContext.request.contextPath}/member/register/seller';
		
			$form.action = url;
			$form.submit();
		});
	});
	</script>
</body>
</html>