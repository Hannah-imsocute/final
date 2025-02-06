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
.content-around {
	margin-left: 200px;
}

.btn-cover {
	margin-top: 30px;
}

.eventList {
	margin-top: 30px;
}

.chk-cover {
	display: flex;
}

.form-check {
	margin-left: 10px;
}

.inputs-cover {
	margin-top: 15px;
}

.eachinput {
	margin-top: 10px;
}

/* 테이블 공통 스타일 */
table {
	width: 90%;
	border-collapse: collapse; /* 테두리 겹침 제거 */
	margin-bottom: 20px;
}

thead {
	background-color: #dbc2a6; /* 헤더 배경색 (샘플) */
	color: #fff; /* 헤더 글씨 색상 (샘플) */
}

thead th {
	padding: 10px;
	text-align: left;
	font-weight: bold;
}

tbody tr:nth-child(even) {
	background-color: #f9f9f9; /* 짝수 행 배경색 */
}

tbody td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

/* 상태나 수정 버튼 등에 스타일을 주고 싶다면 예시 추가 */
.status {
	font-weight: bold;
	color: #008000; /* 진행중일 때 초록색 예시 */
}

.edit-btn {
	background-color: #eee;
	border: none;
	padding: 6px 12px;
	cursor: pointer;
}

.edit-btn:hover {
	background-color: #ccc;
}

.se2_inputarea {
    width: 70% !important;
    height: 400px !important; /* 원하는 크기로 조정 */
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="content-around">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="#">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link active" href="#">종료된
						이벤트</a></li>
				<li class="nav-item"><a class="nav-link" href="#">당첨자발표</a></li>
			</ul>
			<div class="btn-cover">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#staticBackdrop">이벤트 등록</button>
			</div>
			<div class="eventList">
				<jsp:include page="/WEB-INF/views/admin/eventList.jsp" />
			</div>
		</div>
	</main>



	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">이벤트 등록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div class="chk-cover">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="chk" id="chk1"
								checked> <label class="form-check-label" for="chk1">
								쿠폰등록 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="chk" id="chk2">
							<label class="form-check-label" for="chk2"> 출석체크 이벤트 등록 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="chk" id="chk3">
							<label class="form-check-label" for="chk3"> 댓글 이벤트 등록 </label>
						</div>
					</div>
					<form action="">
						<div class="content1" style="display: none;">
							<jsp:include page="/WEB-INF/views/admin/eventcoupon.jsp" />
						</div>
						<div class="content2" style="display: none;">
							<jsp:include page="/WEB-INF/views/admin/eventclockin.jsp" />
						</div>
						<div class="content3">
							<jsp:include page="/WEB-INF/views/admin/eventcomm.jsp" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="submitContents(this.form)">등록</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js"
		charset="utf-8"></script>
	<script type="text/javascript">
	$('#staticBackdrop').on('shown.bs.modal', function () {
		var oEditors = [];
		nhn.husky.EZCreator
				.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : 'eventContent',
					sSkinURI : '${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html',
					fCreator : 'createSEditor2',
					fOnAppLoad : function() {
						oEditors.getById['eventContent'].setDefaultFont('돋움',
								12);
					},
				});
		console.log($('#eventContent'));
		function submitContents(elClickedObj) {
			oEditors.getById['eventContent'].exec('UPDATE_CONTENTS_FIELD', []);
			elClickedObj.submit();
		}
	})
	</script>
</body>
</html>