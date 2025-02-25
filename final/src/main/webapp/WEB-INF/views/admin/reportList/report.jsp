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
<link rel="stylesheet" href="/dist/css/admin/adminreport.css">
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="content-around">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page"
					href="${pageContext.request.contextPath}/admin/report/main">작품신고</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/admin/report/reviews">작품후기신고</a></li>
				<li class="nav-item"><a class="nav-link" href="#">댓글신고</a></li>
			</ul>
			<div class="options-cover">
				<select class="form-select category-select" aria-label="카테고리 선택">
					<option selected value="0">카테고리</option>
					<c:forEach var="dto" items="${categorylist}">
						<option value="${dto.category_num }">${dto.category_name}</option>
					</c:forEach>
				</select> <input type="text" class="form-control search-input"
					placeholder="검색어 입력">

				<button class="btn btn-primary search-btn">
					<i class="bi bi-search"></i>
				</button>
			</div>
			<div class="content-box">
				<div class="report-list">
					<table>
						<thead>
							<tr>
								<th>신고번호</th>
								<th>상품코드</th>
								<!--  신고종류에 따라 이름만 바꾸기 상품 | 댓글 | 후기  -->
								<th>신고자</th>
								<th>신고사유</th>
								<th>신고일자</th>
								<th>카테고리</th>
								<th>처리상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}" varStatus="status">
								<tr class="reportrows" data-num="${dto.sellerreport_num}">
									<td>${status.count}</td>
									<td>${dto.productcode }</td>
									<td>${dto.name}</td>
									<td>${dto.reason}</td>
									<td>${dto.report_date }</td>
									<td>${dto.category_name}</td>
									<td>${ empty dto.processdate ? '처리필요':'처리완료'}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div>${paging}</div>
			</div>
		</div>

		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">

					<div class="modal-header">
						<h5 class="modal-title fw-bold" id="reportModalLabel">🚨 신고
							상세 정보</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<table class="table table-bordered">
							<tbody class="detailsTable">
								<tr>
									<th class="bg-light">신고번호</th>
									<td id="reportId">12345</td>
								</tr>
								<tr>
									<th class="bg-light">상품코드</th>
									<td id="reviewId">67890</td>
								</tr>
								<tr>
									<th class="bg-light">신청인</th>
									<td id="applicant">홍길동</td>
								</tr>
								<tr>
									<th class="bg-light">신청일</th>
									<td id="applicationDate">2024-02-25</td>
								</tr>
								<tr>
									<th class="bg-light">카테고리</th>
									<td id="reportCategory">부적절한 리뷰 내용</td>
								</tr>
								<tr>
									<th class="bg-light">신고사유</th>
									<td id="reportReason">부적절한 리뷰 내용</td>
								</tr>
								<tr>
									<th class="bg-light">신고처리여부</th>
									<td id="reportStatus" class="fw-bold text-danger">미처리</td>
								</tr>
								<tr>
									<th class="bg-light">신고처리일</th>
									<td id="reportDate">-</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
							
					</div>
				</div>
			</div>
		</div>

	</main>
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
	</script>
	<script type="text/javascript">
		var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'));
		
		$(function(){
			$('#rejectBtn').click(function(){
				let reportNum = $('#reportId').text();
				let url = '${pageContext.request.contextPath}/admin/report/update';
				let params = {reportNum : reportNum, mode : 'seller', type : 'reject'};
				
				const fn = function(data){
					location.href='${pageContext.request.contextPath}/admin/report/main';
				};
				
				ajaxRequest(url, 'post', params, 'json', fn);
			});
			$('#processReportBtn').click(function (){
				let reportNum = $('#reportId').text();
				let url = '${pageContext.request.contextPath}/admin/report/update';
				let params = {reportNum : reportNum, mode : 'seller', type : 'blind'};
				
				const cb = function () {
					location.href='${pageContext.request.contextPath}/admin/report/main';
				};
				
				ajaxRequest(url, 'post', params, 'json', cb);
				
			});
		});
		
		$(function() {
			$('.search-btn')
					.click(
							function() {
								let keyword = $('.search-input').val();
								let category = $('.category-select').val();
								let url = '${pageContext.request.contextPath}/admin/report/main?keyword='
										+ encodeURIComponent(keyword, 'utf-8')
										+ '&category=' + category;

								location.href = url;
							});
			$('.reportrows').each(function() {
				$(this).click(function(){
					let num = $(this).attr('data-num');
					let url = '${pageContext.request.contextPath}/admin/report/details';
					let params = {num : num , mode : 'seller'};
					
					const callback = function(data){
						let out = '';
						console.log(data);
						let category_name = data.dto.category_name;
						let name = data.dto.name;
						let productcode = data.dto.productcode;
						let reason = data.dto.reason;
						let reportdate = data.dto.report_date;
						let sellerreport_num = data.dto.sellerreport_num;
						
						let processdate = data.dto.processdate ?  data.dto.processdate : '-';
						let process = data.dto.processdate ? '처리완료' : '미처리';
						let color = data.dto.processdate ? 'text-primary' : 'text-danger';
						
						out += '<tr>';
						out += '	<th class="bg-light">신고번호</th>';
						out += '	<td id="reportId">'+ sellerreport_num +'</td>';	
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">상품코드</th>'
						out += '	<td id="productCode">' + productcode + '</td>';
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">신청인</th>'
						out += '	<td id="applicant">'+ name +'</td>';
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">신청일</th>'
						out += '	<td id="applicationDate">'+ reportdate +'</td>';
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">카테고리</th>'
						out += '	<td id="reportCategory">'+ category_name +'</td>';
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">신고사유</th>'
						out += '	<td id="reportReason">'+ reason +'</td>';	
						out += '</tr>';
						
						out += '<tr>';
						out += '	<th class="bg-light">신고처리여부</th>'
						out += '	<td id="reportStatus" class="fw-bold '+ color +'">' + process + '</td>';
						out += '</tr>';

						out += '<tr>';
						out += '	<th class="bg-light">신고처리일</th>'
						out += '	<td id="reportDate">' + processdate + '</td>';
						out += '</tr>';
						
						// 아 개빡치네 이거 왜 반대로 나옴 
						console.log(data.dto.processdate)
						
						if(! data.dto.processdate ){
							btns += `<button type="button" class="btn btn-secondary" id="rejectBtn"
								data-bs-dismiss="modal">반려</button>
								<button type="button" class="btn btn-success"
									id="processReportBtn" data-bs-dismiss="modal">정지</button>`;
						}else {
							btns += `<button type="button" class="btn btn-success"
								data-bs-dismiss="modal">닫기</button>`;
						}
						
						
						$('.detailsTable').html('');
						$('.detailsTable').append(out);
						$('.modal-footer').html('');
						$('.modal-footer').html(btns);
						
						
						myModal.show();
					}
					
					ajaxRequest(url, 'post', params, 'json', callback);
				});
			});
		});
	</script>
</body>
</html>