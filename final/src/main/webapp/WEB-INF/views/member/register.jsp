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
<link rel="stylesheet" href="/dist/css/layout/register.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>

		<div class="join-container">
			<!-- 상단 로고/타이틀 -->
			<div class="join-header">
				<!-- 실제 로고 이미지를 사용하려면 <img>로 교체 -->
				<h1>뚝딱뚝딱</h1>
				<p>정말 간단한 회원가입하기</p>
			</div>
			<div class="divider"></div>

			<!-- 단계 표시 (예시로 2단계 중 2단계 활성) -->
			<div class="step-indicator">
				<div class="step-circle active">1</div>
				<div class="step-line"></div>
				<div class="step-circle">2</div>
			</div>
			<div class="step-title">가입 정보 입력하기</div>

			<!-- 폼 시작 -->
			<form>
				<!-- 이메일 -->
				<div class="form-group">
					<label>이메일 <span class="required">*</span></label>
					<div class="email-wrap">
						<!-- 아이디(@앞) -->
						<input type="text" class="email-user" name="email" placeholder="예) abc123"
							required />
						<!-- @ 기호 표시 -->
						<div class="at-symbol">@</div>
						<!-- 도메인 직접입력 -->
						<input type="text" class="email-domain" name="domain" placeholder="예) naver.com"
							required />
						<!-- 도메인 select (원하는 도메인 추가 가능) -->
						<select class="domain-select" name="domain">
							<option value="" selected>직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
						<!-- 중복확인 버튼 -->
						<button type="button" class="dup-check-btn">중복확인</button>
					</div>
				</div>

				<!-- 이름 -->
				<div class="form-group">
					<label>이름 <span class="required">*</span></label> <input name="name"
						type="text" placeholder="이름을 입력해주세요." required >
				</div>

				<!-- 닉네임 -->
				<div class="form-group">
					<label>닉네임 <span class="required">*</span></label> <input name="nickname"
						type="text" placeholder="닉네임을 입력해주세요." required>
				</div>

				<!-- 비밀번호 -->
				<div class="form-group">
					<label>비밀번호 <span class="required">*</span></label> <input name="password"
						type="password" placeholder="영문+숫자+특수문자 포함 8자 이상" required>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<input type="password" placeholder="비밀번호 확인" required>
				</div>

				<!-- 전화번호 -->
				<div class="form-group">
					<label>전화번호 <span class="required">*</span></label> <input	name="phone"
						type="text" placeholder="- 를 제외한 번호만 입력해주세요." required pattern="/^[0-9]{9,11}$/">
				</div>

				<!-- 생년월일 -->
				<div class="form-group">
					<label>생년월일 <span class="required">*</span></label> <input name="birth"
						type="date" required>
				</div>

				<!-- 동의 체크박스 영역 (필요한 만큼 추가) -->
				<div class="checkbox-group">
					<div class="checkbox-item">
						<label> <input type="checkbox"> 모두 동의합니다.
						</label>
					</div>
					<div class="checkbox-item">
						<label> <input type="checkbox"> [필수] 만 14세 이상입니다.
						</label>
					</div>
					<div class="checkbox-item">
						<label> <input type="checkbox"> [필수] 이용약관 동의
						</label> <span class="option-link">보기</span>
					</div>
					<div class="checkbox-item">
						<label> <input type="checkbox"> [필수] 개인정보 수집 및 이용
							동의
						</label> <span class="option-link">보기</span>
					</div>
					<div class="checkbox-item">
						<label> <input type="checkbox"> [선택] 개인정보 수집 및 이용
							동의
						</label> <span class="option-link">보기</span>
					</div>
					<div class="checkbox-item">
						<label> <input type="checkbox"> [선택] 할인쿠폰/이벤트/뉴스레터
							수신 동의
						</label> <span class="option-link">보기</span>
					</div>
				</div>

				<!-- 가입 버튼 -->
				<button type="submit" class="submit-btn">회원가입하기</button>
			</form>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>
</html>