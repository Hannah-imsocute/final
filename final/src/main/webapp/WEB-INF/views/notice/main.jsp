<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ttshop 고객센터</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f8f8;
}

.customer-center {
	text-align: center;
	background-color: white;
	margin: 40px auto;
	padding: 60px 30px;
	max-width: 1000px;
	border-radius: 12px;
	margin-top: 250px;
}

.title {
	font-size: 36px;
	font-weight: bold;
	margin-bottom: 10px;
}

.subtitle {
	font-size: 20px;
	color: #666;
	margin-bottom: 30px;
}

.divider {
	border-bottom: 2px solid #ddd;
	margin: 30px 0;
}

/* 탭 버튼 스타일 */
.tab-menu {
	display: flex;
	justify-content: space-around;
	margin-bottom: 20px;
}

.tab-menu .nav-link {
	font-size: 20px;
	padding: 20px 50px;
	font-weight: bold;
	color: #555;
	width: 100%;
	text-align: center;
}

.tab-menu .nav-link.active {
	background-color: #333;
	color: white;
}

/* 검색창 스타일 */
.search-box .input-group {
	max-width: 500px;
	margin: 0 auto;
}

.search-box .btn {
	background-color: #333;
	color: white;
}

/* 키워드 스타일 */
.keyword-box {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	justify-content: center;
	margin-top: 15px;
}

.keyword-box span {
	background: #eee;
	padding: 10px 15px;
	border-radius: 20px;
	font-size: 16px;
	font-weight: bold;
	color: #555;
}

/* FAQ 스타일 */
.accordion-item {
	border: none;
	border-bottom: 1px solid #ddd;
}

.accordion-button {
	font-size: 18px;
	font-weight: bold;
	color: #333;
	background-color: #fff;
}

.accordion-button:not(.collapsed) {
	background-color: #f8f8f8;
	color: #333;
}

.notice-table-wrapper {
	margin: 20px auto;
	max-width: 1000px;
	background-color: #fff;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.notice-table {
	width: 100%;
	border-collapse: collapse;
}

.notice-table thead {
	background-color: #333;
	color: #fff;
}

.notice-table th, .notice-table td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #ddd;
	font-size: 16px;
}

.notice-table tr:hover {
	background-color: #f8f8f8;
}

.status-label {
	display: inline-block;
	padding: 5px 10px;
	border-radius: 5px;
	color: #fff;
	background-color: #ff6600; /* 원하는 색상으로 변경 가능 */
	font-size: 14px;
}
.go-inquiry {
  font-size: 14px;      /* 더 작게 보이도록 */
  color: #999;          /* 회색 톤 */
  margin-left: 10px;    /* 왼쪽 여백 */
  text-decoration: underline; /* 밑줄(선택사항) */
}

.go-inquiry:hover {
  color: #666;          /* 마우스 오버 시 약간 어둡게 */
}

</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="customer-center">
		<h2 class="title">고객센터</h2>
		<p class="subtitle">
			무엇을 도와드릴까요? 
			<a onclick="openInquiryform()"
				class="go-inquiry">1:1문의 남기러가기</a>
		</p>


		<div class="divider"></div>

		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs tab-menu" id="customerTab" role="tablist">
			<li class="nav-item">
				<button class="nav-link active" id="faq-tab" data-bs-toggle="tab"
					data-bs-target="#faq" type="button" role="tab">FAQ</button>
			</li>
			<li class="nav-item">
				<button class="nav-link" id="inquiry-tab" data-bs-toggle="tab"
					data-bs-target="#inquiry" type="button" role="tab">1:1문의</button>
			</li>
			<li class="nav-item">
				<button class="nav-link" id="notice-tab" data-bs-toggle="tab"
					data-bs-target="#notice" type="button" role="tab">공지사항</button>
			</li>
		</ul>

		<div class="divider"></div>

		<!-- 검색 박스 -->
		<div class="search-box">
			<div class="input-group">
				<input type="text" name="keyword" class="form-control"
					placeholder="질문 키워드를 입력해주세요.">
				<button class="btn">검색</button>
			</div>
		</div>

		<!-- 키워드 태그 -->
		<div class="keyword-box">
			<c:forEach var="string" items="${tags}">
				<span>#${string}</span>
			</c:forEach>
		</div>

		<div class="divider"></div>

		<!-- 탭 컨텐츠 -->
		<div class="tab-content" id="customerTabContent">
			<!-- FAQ 섹션 -->
			<div class="tab-pane fade show active" id="faq" role="tabpanel">
				<div class="accordion" id="faqAccordion">
					<c:forEach var="dto" items="${list}">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button" data-bs-toggle="collapse"
									data-bs-target="#faq${dto.evt_not_num}">${dto.subject}</button>
							</h2>
							<div id="faq${dto.evt_not_num}"
								class="accordion-collapse collapse">
								<div class="accordion-body">${dto.textcontent}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- 1:1문의 섹션 -->
			<div class="tab-pane fade" id="inquiry" role="tabpanel" data-page="0"
				data-total="1">

				<div class="notice-table-wrapper">
					<table class="notice-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>상태</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>


			<!-- 공지사항 섹션 -->
			<div class="tab-pane fade" id="notice" role="tabpanel" data-page="0"
				data-total="1">
				<div class="notice-table-wrapper">
					<table class="notice-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>상태</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>


	<script type="text/javascript">
		$(function() {
			$('#notice-tab').click(function() {
				let url = "${pageContext.request.contextPath}/notice/notlist";

				let page = $('#notice').attr('data-page');
				let total = $('#notice').attr('data-total');

				const callback = function(data) {
					$('#notice').attr('data-page', data.page);
					$('#notice').attr('data-total', data.total);
					
					addMoreContent(data);
				}
				ajaxRequest(url, 'get', null, 'json', callback);
			});
			
			$('#inquiry-tab').click(function(){
				let url = '${pageContext.request.contextPath}/notice/inquire';
				
				let page = $('#inquiry').attr('data-page');
				let total = $('#inquiry').attr('data-total');
				
				const callback = function (data){
					$('#inquiry').attr('data-page', data-page);
					$('#inquiry').attr('data-total', data-total);
					
					addInquireContent(data);		
				}
				ajaxRequest(url,'get',null,'json',callback);
			});
			
		});

		function addMoreContent(data) {
			console.log(data);
			let tbody = $('.notice-table').find('tbody');
			
			let result = '';
			for(let el of data.list){
				let num	 = el.evt_not_num;
				let subject = el.subject;
				let create_date = el.create_date;
				
				result += '<tr>';
				result += '	<td></td>';
				result += '	<td><span class="status-label">공지</span></td>';
				result += '	<td><a href="${pageContext.request.contextPath}/notice/article/'+num+'">'+ subject + '</a></td>';
				result += '	<td>'+create_date+'</td>';
			}
			tbody.html(result);
		}
		
		function addInquireContent(data){
			console.log(data);
		}
		
		
		function openInquiryform(){
			window.open();
		}
	</script>

</body>
</html>
