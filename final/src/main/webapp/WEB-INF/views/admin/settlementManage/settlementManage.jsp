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

                <!-- 메인 탭 -->
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="tab-1" data-bs-toggle="tab"
                            data-bs-target="#tab-1-content" type="button" role="tab"
                            aria-selected="true" data-tab="1">
                            <i class="bi bi-person-fill"></i> 일 정산 내역
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="tab-2" data-bs-toggle="tab"
                            data-bs-target="#tab-2-content" type="button" role="tab"
                            aria-selected="false" data-tab="2">
                            <i class="bi bi-vector-pen"></i> 작가 정산 내역
                        </button>
                    </li>
                </ul>

                <!-- 메인 탭의 내용 -->
                <div class="tab-content pt-1">
                    <div class="tab-pane fade show active" id="tab-1-content">
                        <!-- 소분류 탭 -->
                        <ul class="nav nav-pills" id="subTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="sub-tab-1" data-bs-toggle="pill" 
                                        data-bs-target="#sub-content-1" type="button" role="tab" 
                                        aria-selected="true" data-sub-tab="1">포인트 정산</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="sub-tab-2" data-bs-toggle="pill" 
                                        data-bs-target="#sub-content-2" type="button" role="tab" 
                                        aria-selected="false" data-sub-tab="2">현금 정산</button>
                            </li>
                        </ul>

                        <!-- 소분류 탭의 내용 -->
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="sub-content-1">
                                <!-- 소분류 1에 해당하는 데이터 표시 -->
                                <div id="subTabContent1"></div>
                            </div>
                            <div class="tab-pane fade" id="sub-content-2">
                                <!-- 소분류 2에 해당하는 데이터 표시 -->
                                <div id="subTabContent2"></div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="tab-2-content">
                        <!-- 다른 메인 탭의 소분류 내용 -->
                    </div>
                </div>

                <form name="memberSearchForm">
                    <input type="hidden" name="schType" value="email"> 
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

function loadProfile(settlement_num, page) {
    let url = '${pageContext.request.contextPath}/admin/settlementManage/profile';  // 요청 URL
    let formData = 'settlement_num=' + settlement_num + '&page=' + page;

    $.ajax({
        url: url,
        type: 'GET',
        data: formData,
        dataType: 'html',  // HTML로 응답을 처리
        success: function(data) {
            $('#tab-content').html(data);  // 받아온 데이터를 해당 요소에 삽입
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);  // 에러 처리
        }
    });
}



$(function(){
    // 기본적으로 메인탭 1번과 서브탭 1번을 활성화
    $('#tab-1').addClass('active');
    $('#sub-tab-1').addClass('active');
    loadSubTabContent(1, 1); // 메인탭 1번, 서브탭 1번 로드

    // 메인탭 클릭 이벤트
    $('#myTab button[role="tab"]').on('click', function(e){
        const mainTab = $(this).attr('data-tab');
        switchMainTab(mainTab);
    });

    // 서브탭 클릭 이벤트
    $('#subTab button[data-sub-tab]').on('click', function(e){
        const subTab = $(this).attr('data-sub-tab');
        const mainTab = $('#myTab .active').attr('data-tab'); // 현재 활성화된 메인탭 찾기
        
        // 기존 서브탭에서 active 제거하고 새로 클릭한 서브탭에 추가
        $('#subTab .active').removeClass('active');
        $(this).addClass('active');

        loadSubTabContent(mainTab, subTab);
    });
});

function switchMainTab(mainTab) {
    // 기존 메인탭 비활성화
    $('#myTab .active').removeClass('active');
    // 새 메인탭 활성화
    $('#tab-' + mainTab).addClass('active');

    // 서브탭 초기화 (기본적으로 서브탭 1번 활성화)
    $('#subTab .active').removeClass('active');
    $('#sub-tab-1').addClass('active');

    // 서브탭 1번 콘텐츠 로드
    loadSubTabContent(mainTab, 1);
}

function loadSubTabContent(mainTab, subTab) {
    const url = '/admin/settlementManage/list'; // 서버에서 데이터를 받아오는 URL
    const params = {
        mainTab: mainTab, // 메인탭 번호
        subTab: subTab,   // 서브탭 번호
    };

    $.ajax({
        url: url,
        type: 'GET',
        data: params,
        success: function(response) {
            $('#subTabContent1').html(''); // 기존 콘텐츠 초기화
            if (subTab == "1") {
                $('#subTabContent1').html(response).show();
                $('#subTabContent2').hide();
            } else {
                $('#subTabContent2').html(response).show();
                $('#subTabContent1').hide();
            }
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

</script>
