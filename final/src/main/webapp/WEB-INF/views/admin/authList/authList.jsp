<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>

<style type="text/css">
	.body-container {
		max-width: 950px;
	}
	
	.nav-tabs .nav-link {
		min-width: 170px;
		background: #f3f5f7;
		border-radius: 0;
		border-top: 1px solid #dbdddf;
		border-right: 1px solid #dbdddf;
		color: #333;
		font-weight: 600;
	}
	
	.nav-tabs .nav-item:first-child .nav-link {
		border-left: 1px solid #dbdddf;
	}
	
	.nav-tabs .nav-link.active {
		background: #3d3d4f;
		color: #fff;
	}
	
	.tab-pane {
		min-height: 300px;
	}
	
	.hover {
		cursor: pointer;
	}
	
	#chart-container {
		width: 476px;
		box-sizing: border-box;
		padding: 20px;
		height: 400px;
		border: 1px solid #ccc;
		text-align: center;
	}
</style>

	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/highcharts-3d.js"></script>


	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/dist/css/boot-board.css"
		type="text/css">

	<div id="main-content-authList-section">
		<main>
			<div class="wrapper">
				<div class="body-container">
					<div class="body-main">

						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="tab-1" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="1">
									<i class="bi bi-person-fill"></i> 전체
								</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-2" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="2">
									<i class="bi bi-mortarboard-fill"></i> 회원
								</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-3" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="3">
									<i class="bi bi-person-lines-fill"></i> 입점작가
								</button>
							</li>
						</ul>

						<div class="tab-content pt-3" id="nav-tabContent"></div>

						<form name="memberSearchForm">
							<input type="hidden" name="schType" value="userId"> <input
								type="hidden" name="kwd" value=""> <input type="hidden"
								name="role" value="1"> <input type="hidden" name="non"
								value="0"> <input type="hidden" name="enabled" value="">
						</form>

					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
$(function(){
	$('#tab-0').addClass('active');
	
    $('button[role="tab"]').on('click', function(e){
    	const tab = $(this).attr('data-tab');
    	
		if(tab !== '3') {
			// 회원, 강사, 직원 리스트
			resetList();
		} else {
			// 연령별 어낼러시스(분석)
			memberAnalysis();
		}
    });	
});

$(function(){
	listMember(1);
});

function listMember(page) {
	let url = '${pageContext.request.contextPath}/admin/memberManage/list';	
	let formData = $('form[name=memberSearchForm]').serialize();
	formData += '&page=' + page;
	
	const fn = function(data) {
		$('#nav-tabContent').html(data);		
	};
	
	ajaxRequest(url, 'get', formData, 'text', fn);
}

function resetList() {
	// 초기화
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');

	const f = document.memberSearchForm;
	
	f.schType.value = 'userId';
	f.kwd.value = '';
	f.role.value = role;
	f.non.value = 0;
	f.enabled.value = '';
	
	listMember(1);
}

function searchList() {
	// 검색
	const f = document.memberSearchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listMember(1);
}

$(function(){
	// 회원 리스트 상단 검색 checkbox
	$('#nav-tabContent').on('click', '.wrap-search-check input[type=checkbox]', function(){
		let enabled = '';
		let non = 0;
		
		if($('#enabledCheck1').is(':checked') && $('#enabledCheck2').is(':checked')) {
			enabled = '';
		} else if($('#enabledCheck1').is(':checked')) {
			enabled = '1';
		} else if($('#enabledCheck2').is(':checked')) {
			enabled = '0';
		}
		
		if($('#nonMemberCheckbox').is(':checked')){
			non = 1;
		}
		
		const f = document.memberSearchForm;
		f.non.value = non;
		f.enabled.value = enabled;
		
		listMember(1);
	});
});

function profile(memberIdx, page) {
	// 회원 상세 보기
	let url = '${pageContext.request.contextPath}/admin/memberManage/profile';
	let formData = 'memberIdx=' + memberIdx + '&page=' + page;
	
	const fn = function(data){
		$('#nav-tabContent').html(data);
	};

	ajaxRequest(url, 'get', formData, 'text', fn);
}

function statusDetailesMember() {
	$('#memberStatusDetailesDialogModal').modal('show');	
}

function selectStatusChange() {
	const f = document.memberStatusDetailesForm;

	let code = f.statusCode.value;
	let memo = f.statusCode.options[f.statusCode.selectedIndex].text;
	
	f.memo.value = '';	
	if(! code) {
		return;
	}

	if(code!=='0' && code!=='8') {
		f.memo.value = memo;
	}
	
	f.memo.focus();
}

function updateMember() {
	$('#memberUpdateDialogModal').modal('show');
}

function updateMemberOk(page) {
	// 회원 정보 변경(권한, 이름, 생년월일)
	const f = document.memberUpdateForm;

	if( ! f.userName.value ) {
		alert('이름을 입력 하세요.');
		f.userName.focus();
		return;
	}
	
	if(f.authority.value === 'INACTIVE' || f.authority.value === 'EX_EMP') {
		f.enabled.value = '0';	
	}
	
	if( ! confirm('회원 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/memberManage/updateMember';
	let formData = $('#memberUpdateForm').serialize();

	const fn = function(data){
		listMember(page);
	};
	ajaxRequest(url, 'post', formData, 'json', fn);
	
	$('#memberUpdateDialogModal').modal('hide');
}

function deleteMember(memberIdx) {
	// 회원 삭제
	
}

function updateStatusOk(page) {
	// 회원 상태 변경
	const f = document.memberStatusDetailesForm;

	if( ! f.statusCode.value ) {
		alert('상태 코드를 선택하세요.');
		f.statusCode.focus();
		return;
	}
	if( ! f.memo.value.trim() ) {
		alert('상태 메모를 입력하세요.');
		f.memo.focus();
		return;
	}
	
	if( ! confirm('상태 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/memberManage/updateMemberStatus';
	let formData = $('#memberStatusDetailesForm').serialize();

	const fn = function(data){
		listMember(page);
	};
	ajaxRequest(url, 'post', formData, 'json', fn);
	
	$('#memberStatusDetailesDialogModal').modal('hide');
}

function memberAnalysis() {
	// 연령별 어낼러시스(분석)
	$('#nav-tabContent').empty();
	$('#nav-tabContent').html('<div id="chart-container" class="m-1"></div>');	

	let url = '${pageContext.request.contextPath}/admin/memberManage/memberAgeSection';
	$.getJSON(url, function(data){
		let titles = [];
		let values = [];
		
		/*
		for(let i=0; i<data.list.length; i++) {
			titles.push(data.list[i].SECTION);
			values.push(data.list[i].COUNT);
		}
		*/
		for(let item of data.list) {
			titles.push(item.SECTION);
			values.push(item.COUNT);
		}

		Highcharts.chart('chart-container', {
			title:{
				text : '연령대별 회원수'
			},
			xAxis : {
				categories:titles
			},
			yAxis : {
				title:{
					text:'인원(명)'
				}
			},
			series:[{
		        type: 'column',
		        colorByPoint: true,
		        name: '인원수',
		        data: values,
		        showInLegend: false
		    }]
		});
	});
}

$(function(){
	// 모달창이 닫힐때 aria-hidden="true"와 포커스 충돌로 발생하는 에러 해결
	$('#nav-tabContent').on('hide.bs.modal', '#memberUpdateDialogModal', function () {
		$('button, input, select, textarea').each(function () {
	        $(this).blur();
	    });
	});
	$('#nav-tabContent').on('hide.bs.modal', '#memberStatusDetailesDialogModal', function () {
		$('button, input, select, textarea').each(function () {
	        $(this).blur();
	    });
	});	
});
</script>
</body>
</html>