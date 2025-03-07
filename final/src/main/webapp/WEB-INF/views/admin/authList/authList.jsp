<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style type="text/css">
	.body-container {
		max-width: 1000px;
	}
	
	.nav-tabs .nav-link {
		min-width: 170px;
		background: #f3f5f7;
		border-radius: 0;
		border-top: 1px solid #dbdddf;
		border-right: 1px solid #dbdddf;
		color: #5D5D5D;
		font-weight: 600;
	}
	
	.nav-tabs .nav-item:first-child .nav-link {
		border-left: 1px solid #dbdddf;
	}
	
	.nav-tabs .nav-link.active {
		background: #ffc107;
		color: #333;
	}
	
	.tab-pane {
		min-height: 300px;
	}
	
	.hover {
		cursor: pointer;
	}
	
</style>


	<div id="main-content-authList-section">
			<div class="wrapper">
				<div class="body-container">
					<div class="body-main">

						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="tab-1" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="1">
									<i class="bi bi-person-fill"></i> 회원
								</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-2" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="2">
									<i class="bi bi-vector-pen"></i> 입점작가
								</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-3" data-bs-toggle="tab"
									data-bs-target="#nav-content" type="button" role="tab"
									aria-selected="true" data-tab="3">
									<i class="bi bi-person-lines-fill"></i> 관리자
								</button>
							</li>
						</ul>

						<div class="tab-content pt-1" id="nav-tabContent"></div>

						<form name="memberSearchForm">
							<input type="hidden" name="schType" value="nickname"> 
							<input type="hidden" name="kwd" value=""> 
							<input type="hidden" name="role" value="1"> 
							<input type="hidden" name="non" value="0">
							<input type="hidden" name="block" value="">
						</form>

					</div>
				</div>
			</div>
	</div>
	<script type="text/javascript">
$(function(){
	$('#tab-0').addClass('active');
	
    $('button[role="tab"]').on('click', function(e){
    	const tab = $(this).attr('data-tab');
    	
		if(tab !== '4') {
			resetList();
		} 
    });	
});

$(function(){
	listMember(1);
});

function listMember(page) {
    // URL 경로 수정: `list` 경로로 보내야 한다
    let url = '${pageContext.request.contextPath}/admin/authList/list';  // list 경로로 수정

    // 폼 데이터를 직렬화하고 페이지 번호를 추가
    let formData = $('form[name=memberSearchForm]').serialize();
    formData += '&page=' + page;

    // 페이지 번호를 쿼리 파라미터로 URL에 포함시켜서 보내기
    $.ajax({
        url: url + '?page=' + page,  // URL에 page 파라미터 포함
        type: 'GET',
        data: formData,  // 서버로 보내는 데이터
        dataType: 'text',
        success: function(data) {
            $('#nav-tabContent').html(data);        
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });
}




function resetList() {
	// 초기화
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');

	const f = document.memberSearchForm;
	
	f.schType.value = 'email';
	f.kwd.value = '';
	f.role.value = role;
	f.block.value = '';
	
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
		let block = '';
		let non = 0;
		
		if($('#blockCheck1').is(':checked') && $('#blockCheck2').is(':checked')) {
			block = '';
		} else if($('#blockCheck1').is(':checked')) {
			block = '0';
		} else if($('#blockCheck2').is(':checked')) {
			block = '1';
		}
		
		if($('#nonMemberCheckbox').is(':checked')){
			non = 1;
		}
		
		const f = document.memberSearchForm;
		f.non.value = non;
		f.block.value = block;
		
		listMember(1);
	});
});

function profile(memberIdx, page) {
    // 회원 상세 보기
    let url = '${pageContext.request.contextPath}/admin/authList/profile';
    let formData = 'memberIdx=' + memberIdx + '&page=' + page;

    $.ajax({
        url: url,
        type: 'GET',
        data: formData,
        dataType: 'text',
        success: function(data) {
            $('#nav-tabContent').html(data);  // 받아온 데이터를 해당 요소에 삽입
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);  // 에러 처리
        }
    });
}

function statusDetailesMember() {
	$('#memberStatusDetailesDialogModal').modal('show');	
}

function selectStatusChange() {
	const f = document.memberStatusDetailesForm;

	let code = f.reason.value;
	
	if(! code) {
		return;
	}

	if(code!=='0' && code!=='8') {
		f.reason.value = code;
	}
	
	f.reason.focus();
}

function updateMember() {
	$('#memberUpdateDialogModal').modal('show');
}

function updateMemberOk(page) {
    // 회원 정보 변경(권한, 이름, 생년월일)
    const f = document.memberUpdateForm;

    if (!f.email.value) {
        alert('이름을 입력 하세요.');
        f.email.focus();
        return;
    }

    if (f.authority.value === 'maybeUSer') {
        f.block.value = '1';    
    }

    if (!confirm('회원 정보를 수정하시겠습니까 ? ')) {
        return;
    }

    let url = '${pageContext.request.contextPath}/admin/authList/updateMember';
    let formData = $('#memberUpdateForm').serialize();

    $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function(data) {
            listMember(page);  // 회원 목록을 갱신
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);  // 에러 처리
        }
    });

    $('#memberUpdateDialogModal').modal('hide');
}


function deleteMember(memberIdx) {
	// 회원 삭제
	
}

function updateStatusOk(page) {
    // 회원 상태 변경
    const f = document.memberStatusDetailesForm;

    if (!f.reason.value) {
        alert('상태 코드를 선택하세요.');
        f.reason.focus();
        return;
    }

    if (!confirm('상태 정보를 수정하시겠습니까 ? ')) {
        return;
    }

    let url = '${pageContext.request.contextPath}/admin/authList/updateMemberStatus';
    let formData = $('#memberStatusDetailesForm').serialize();

    $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function(data) {
            listMember(page);  // 회원 목록 갱신
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);  // 에러 처리
        }
    });

    $('#memberStatusDetailesDialogModal').modal('hide');
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
