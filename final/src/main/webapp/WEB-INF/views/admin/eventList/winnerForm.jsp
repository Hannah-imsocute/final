<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boooooot</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<style>
/* 기본 Reset (선택사항) */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
	background: #f2f2f2;
	color: #333;
	line-height: 1.4;
}

.popup-container {
	max-width: 600px;
	margin: 30px auto;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	padding: 20px 30px;
}

h1 {
	text-align: center;
	margin-bottom: 20px;
	color: #444;
}

form {
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: inline-block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #555;
}

input[type="text"], input[type="number"], textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
	outline: none;
}

input[type="text"]:focus, input[type="number"]:focus, textarea:focus {
	border-color: #4285f4;
}

textarea {
	resize: vertical; /* 필요에 따라 조절 */
}

.btn-wrap {
	text-align: center;
	margin-top: 20px;
}

.btn {
	display: inline-block;
	background: #4285f4;
	color: #fff;
	padding: 10px 20px;
	border-radius: 4px;
	text-decoration: none;
	cursor: pointer;
	font-size: 14px;
	border: none;
}

.btn:hover {
	background: #3367d6;
}

/* 당첨자 출력 영역 */
#winnerList {
	margin-top: 30px;
	padding: 15px;
	background: #f9f9f9;
	border: 1px solid #eee;
	border-radius: 4px;
	min-height: 100px;
}

#winnerList strong {
	color: #555;
}

.footer-text {
	text-align: center;
	font-size: 12px;
	color: #999;
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="popup-container">
		<h1>당첨자 뽑기</h1>
		<form action="#" method="post" id="winnerForm">
			<div class="form-group">
				<label for="eventName">이벤트명</label> <input type="text"
					id="eventName" name="eventName" value="${dto.subject}" readonly
					placeholder="이벤트명을 입력하세요" />
			</div>
			<div class="form-group">
				<label for="winnerCount">당첨자 수</label> <input type="number"
					id="winnerCount" name="winnerCount" min="1" value="1" />
			</div>
			<div class="form-group">
				<label for="postTitle">게시글 제목</label> <input type="text"
					id="postTitle" name="postTitle" placeholder="게시글 제목을 입력하세요" />
			</div>
			<div class="form-group">
				<label for="postContent">게시글 내용</label>
				<textarea id="postContent" name="postContent" rows="4"
					placeholder="게시글 내용을 입력하세요"></textarea>
			</div>
			<div class="btn-wrap">
				<input type="button" class="btn" value="게시글 등록" onclick="getWinners()" />
			</div>
		</form>

		<!-- 당첨자 표시 영역 -->
		<div id="winnerList">
			
		</div>
	</div>

	<div class="footer-text">&copy; 2025 Event Winner Popup</div>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/vendor/jquery/js/jquery.min.js"></script>
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
	
	function getWinners(){
		let url = "${pageContext.request.contextPath}/admin/event/getwinners";
		
		if(! $('#winnerCount').val()){
			alert('당첨자 수를 지정해주세요');
			return 
		}
		let size = $('#winnerCount').val();
		let params = {num : ${dto.event_article_num} , size : size};
		
		const fn = function (data){
			console.log(data);
		}
		
		ajaxRequest(url, 'get', params, 'json', fn);
	};
	</script>
</body>
</html>