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


	<div id="main-content-applyList-section">
			<div class="wrapper">
				<div class="body-container">
					<div class="body-main">

						<div class="tab-content pt-1" id="nav-tabContent"></div>

						<form name="ApplySearchForm">
							<input type="hidden" name="schType" value="name"> 
							<input type="hidden" name="kwd" value=""> 
							<input type="hidden" name="role" value="1"> 
							<input type="hidden" name="non" value="0">
							<input type="hidden" name="agreed" value="">
						</form>

					</div>
				</div>
			</div>
	</div>
	<script type="text/javascript">
	
	$(function(){
	    // 페이지 로드 시, 기본적으로 리스트를 불러옴
	    listApply(1);
	});

	// 리스트 불러오기
	function listApply(page) {
	    let url = '${pageContext.request.contextPath}/admin/applyList/list';   

	    // 검색 조건 값 가져오기
	    let schType = $('#searchType').val();
	    let kwd = $('#keyword').val();

	    // 데이터를 폼 대신 직접 객체로 생성
	    let formData = {
	        page: page,
	        schType: schType,
	        kwd: kwd
	    };

	    $.ajax({
	        url: url,
	        type: 'GET',
	        data: formData, // formData를 객체로 보냄
	        dataType: 'text',
	        success: function(data) {
	            $('#nav-tabContent').html(data);        
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 요청 실패:', error);
	        }
	    });
	}

	// 초기화 함수
	function resetList() {
	    // 초기화
	    $('#searchType').val('name');
	    $('#keyword').val('');
	    $('#applyCheck1').prop('checked', true);
	    $('#applyCheck2').prop('checked', true);

	    listApply(1);
	}

	// 검색 함수
	function searchList() {
	    // 검색 후 리스트 불러오기
	    listApply(1);
	}

	function toggleCheckbox(id) {
	    if (id === 'applyCheck1') {
	        $('#applyCheck2').prop('checked', false); // 미승인 체크박스를 체크 해제
	    } else if (id === 'applyCheck2') {
	        $('#applyCheck1').prop('checked', false); // 승인 체크박스를 체크 해제
	    }
	    // 필터링된 값을 전송
	    filterData();
	}

	function filterData() {
	    let agreed = ''; // 빈 값으로 초기화

	    if ($('#applyCheck1').is(':checked')) {
	        agreed = '0'; // 승인 상태
	    } else if ($('#applyCheck2').is(':checked')) {
	        agreed = '1'; // 미승인 상태
	    }

	    // 폼 데이터에서 agreed 값을 설정
	    const f = document.ApplySearchForm;
	    f.agreed.value = agreed;  // 이제 agreed 값이 제대로 설정됩니다.

	    // 폼 데이터를 시리얼라이즈하여 AJAX로 전송
	    let formData = $(f).serialize();
	    formData += '&page=1';  // 페이지 번호를 추가

	    // AJAX 요청을 통해 필터링된 데이터를 서버로 전송
	    $.ajax({
	        url: '${pageContext.request.contextPath}/admin/applyList/list',  // 서버 URL 수정
	        type: 'GET',
	        data: formData,
	        dataType: 'text',
	        success: function(data) {
	            $('#nav-tabContent').html(data);
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 요청 실패:', error);
	        }
	    });
	  }

function apply(sellerApplyNum, page) {
    // 셀러 넘버와 페이지 정보를 서버로 보냄
    $.ajax({
        url: '/admin/applyList/getSellerDetails', // 서버의 해당 URL로 요청
        type: 'GET',
        data: { sellerApplyNum: sellerApplyNum, page: page }, // sellerApplyNum과 page 값을 보냄
        dataType: 'json', // 서버에서 JSON으로 응답을 받음
        success: function(response) {
            if (response) {
                // 서버에서 받은 데이터를 모달에 채워 넣음
                $('#sellerName').text(response.name);
                $('#sellerName2').text(response.name);
                $('#sellerEmail').text(response.email);
                $('#sellerPhone').text(response.phone);
                $('#sellerBrandName').text(response.brandName);
                $('#sellerBrandIntro').text(response.brandIntro);
                $('#sellerIntropeice').text(response.introPeice);
                $('#sellerForextra').text(response.forExtra);
                $('#sellerAgreed').text(response.agreed === 0 ? "미승인" : "승인");
                
             	// sellerApplyNum을 hidden input에 넣기
                $('#sellerApplyNum').val(response.sellerApplyNum);  
                
                // agreed 값을 hidden input에 저장
                $('#hiddenAgreed').val(response.agreed);
                
                // 모달을 보여줌
                $('#sellerStatusDetailesDialogModal').modal('show');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });
}

function updateStatusOk() {
    const sellerApplyNum = $('#sellerApplyNum').val(); // sellerApplyNum을 가져옴
    const agreed = 0; // 승인 버튼 클릭 시 `agreed` 값은 항상 0

    console.log("전송할 sellerApplyNum:", sellerApplyNum);
    console.log("전송할 agreed 값:", agreed);

    if (!confirm('상태 정보를 수정하시겠습니까?')) {
        return;
    }

    let url = '${pageContext.request.contextPath}/admin/applyList/updateApply';
    let formData = {
        sellerApplyNum: sellerApplyNum,  // sellerApplyNum만 전달
    };

    $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        success: function (data) {
            alert('처리가 완료되었습니다.');
            location.reload(); // 리스트 갱신
        },
        error: function (xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });

    $('#sellerStatusDetailesDialogModal').modal('hide');
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
