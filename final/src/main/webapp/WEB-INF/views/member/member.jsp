﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch(e) {
		return false;
	}
}

function memberOk() {
	const f = document.memberForm;
	let str;

	str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert('아이디를 다시 입력 하세요. ');
		f.userId.focus();
		return;
	}


	str = f.userPwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert('패스워드를 다시 입력 하세요. ');
		f.userPwd.focus();
		return;
	}

	if( str !== f.userPwd2.value ) {
        alert('패스워드가 일치하지 않습니다. ');
        f.userPwd.focus();
        return;
	}
	
    str = f.userName.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert('이름을 다시 입력하세요. ');
        f.userName.focus();
        return;
    }

    str = f.birth.value;
    if( !isValidDateString(str) ) {
        alert('생년월일를 입력하세요. ');
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
    if( !str ) {
        alert('전화번호를 입력하세요. ');
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
    if( !/^\d{3,4}$/.test(str) ) {
        alert('숫자만 가능합니다. ');
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
    if( !/^\d{4}$/.test(str) ) {
    	alert('숫자만 가능합니다. ');
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value.trim();
    if( !str ) {
        alert('이메일을 입력하세요. ');
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( !str ) {
        alert('이메일을 입력하세요. ');
        f.email2.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/';
    f.submit();
}

function changeEmail() {
    const f = document.memberForm;
	    
    let str = f.selectEmail.value;
    if( str !== 'direct' ) {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = '';
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	// 아이디 중복 검사

}

/*
window.addEventListener('DOMContentLoaded', () => {
	const dateELS = document.querySelectorAll('form input[type=date]');
	dateELS.forEach( inputEL => inputEL.addEventListener('keydown', e => e.preventDefault()) );
	
	const timeELS = document.querySelectorAll('form input[type=time]');
	timeELS.forEach( inputEL => inputEL.addEventListener('keydown', e => e.preventDefault()) );
});	
*/
</script>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-person-square"></i> ${mode=="account"?"회원가입":"정보수정"} </h3>
			</div>
			
		    <div class="alert alert-info" role="alert">
		        <i class="bi bi-person-check-fill"></i> SPRING의 회원이 되시면 회원님만의 유익한 정보를 만날수 있습니다.
		    </div>
	    			
			<div class="body-main">

				<form name="memberForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userId">아이디</label>
						<div class="col-sm-10 wrap-userId">
							<div class="row">
								<div class="col-6 pe-1">
									<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}" 
											${mode=="update" ? "readonly ":""}
											placeholder="아이디">
								</div>
								<div class="col-3 ps-1">
									<c:if test="${mode=='account'}">
										<button type="button" class="btn btn-light" onclick="userIdCheck();">아이디중복검사</button>
									</c:if>
								</div>
							</div>
							<c:if test="${mode=='account'}">
								<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
							</c:if>
						</div>
					</div>
				 
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
						<div class="col-sm-10">
				        	<div class="row">
				        		<div class="col-6">
				            		<input type="password" name="userPwd" id="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
				        		</div>
				        	</div>
				            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
				        <div class="col-sm-10">
				        	<div class="row">
				        		<div class="col-6">
				            		<input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
				        		</div>
				        	</div>
				            <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userName">이름</label>
				        <div class="col-sm-10">
				        	<div class="row">
				        		<div class="col-6">
				            		<input type="text" name="userName" id="userName" class="form-control" value="${dto.userName}" 
				            			${mode=="update" ? "readonly ":""}
				            			placeholder="이름">
				        		</div>
				        	</div>
				        </div>
				    </div>
				 
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
				        <div class="col-sm-10">
				        	<div class="row">
				        		<div class="col-6">
				            		<input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}"
				            			${mode=="update" ? "readonly ":""}
				            			placeholder="생년월일">
				        		</div>
				        	</div>
				            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
				        </div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com" ${dto.email2=="naver.com" ? "selected" : ""}>네이버 메일</option>
									<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected" : ""}>지 메일</option>
									<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected" : ""}>한 메일</option>
									<option value="outlook.com" ${dto.email2=="outlook.com" ? "selected" : ""}>마이크로소프트</option>
									<option value="icloud.com" ${dto.email2=="icloud.com" ? "selected" : ""}>애플</option>
									<option value="direct">직접입력</option>
								</select>
							</div>
							
							<div class="col input-group">
								<input type="text" name="email1" class="form-control" maxlength="30" value="${dto.email1}" >
							    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
								<input type="text" name="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly>
							</div>		
					        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label">메일 수신</label>
				        <div class="col-sm-10">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="receiveEmail" id="receiveEmail" 
									value="1" ${empty dto || dto.receiveEmail == 1 ? "checked":""}>
								<label class="form-check-label" for="receiveEmail">동의</label>
							</div>			        
				        </div>
				    </div>
	
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-1">
								<input type="text" name="tel1" id="tel1" class="form-control" value="${dto.tel1}" maxlength="3">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="tel2" id="tel2" class="form-control" value="${dto.tel2}" maxlength="4">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="tel3" id="tel3" class="form-control" value="${dto.tel3}" maxlength="4">
							</div>
				        </div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
				        <div class="col-sm-5">
				       		<div class="input-group">
				           		<input type="text" name="zip" id="zip" class="form-control" placeholder="우편번호" value="${dto.zip}" readonly>
			           			<button class="btn btn-light" type="button" style="margin-left: 3px;" onclick="daumPostcode();">우편번호 검색</button>
				           	</div>
						</div>
				    </div>
			
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
				        <div class="col-sm-10">
				       		<div>
				           		<input type="text" name="addr1" id="addr1" class="form-control" placeholder="기본 주소" value="${dto.addr1}" readonly>
				           	</div>
				       		<div style="margin-top: 5px;">
				       			<input type="text" name="addr2" id="addr2" class="form-control" placeholder="상세 주소" value="${dto.addr2}">
							</div>
						</div>
				    </div>
			
					<c:if test="${mode=='account'}">
					    <div class="row mb-3">
					        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
							<div class="col-sm-8" style="padding-top: 5px;">
								<input type="checkbox" id="agree" name="agree"
									class="form-check-input"
									checked
									style="margin-left: 0;"
									onchange="form.sendButton.disabled = !checked">
								<label class="form-check-label">
									<a href="#" class="text-decoration-none">이용약관</a>에 동의합니다.
								</label>
							</div>
					    </div>
				    </c:if>
				     
				    <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> ${mode=="account"?"회원가입":"정보수정"} <i class="bi bi-check2"></i></button>
				            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="account"?"가입취소":"수정취소"} <i class="bi bi-x"></i></button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
				        </div>
				    </div>
				
				    <div class="row">
						<p class="form-control-plaintext text-center">${message}</p>
				    </div>
				</form>

			</div>
		</div>
	</div>
</main>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<%--<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>--%>
</body>
</html>