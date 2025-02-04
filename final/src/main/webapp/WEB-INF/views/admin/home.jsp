<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin page</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    overflow-y: auto;  /* 세로 스크롤 생성 */
	    overflow-x: hidden; /* 가로 스크롤 방지 */
	}
	
</style>
</head>
<body>

<div class="container vh-100 overflow-auto">
    <jsp:include page="/WEB-INF/views/admin/adminimported.jsp"/>

    <header>
        <jsp:include page="/WEB-INF/views/admin/adminheader.jsp"/>
    </header>

    <nav>
        <div class="sidebar">
		<div class="profile-container">
			<!-- 프로필 이미지 -->
			<div class="profile-img-container">
				<!-- <img src="img/profile.jpg" alt="Profile Picture" class="profile-img"> -->
			</div>
			<p class="user-name">관리자님</p>
	
		</div>
		<!--  사이드바 메뉴-->
<ul class="sidebar-menu">
    <li><a href='${pageContext.request.contextPath}/admin/auth' class="accordion-button"> 권한관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/apply' class="accordion-button"> 입점신청관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/membership' class="accordion-button"> 멤버십관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/payment' class="accordion-button"> 결제 및 정산관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/product' class="accordion-button"> 상품관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/event' class="accordion-button"> 이벤트관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/notice' class="accordion-button"> 공지사항관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/inquiry' class="accordion-button"> 문의사항관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/report' class="accordion-button"> 신고관리 </a></li>
    <li><a href='${pageContext.request.contextPath}/admin/stats' class="accordion-button"> 통계 및 보고 </a></li>
</ul>
		</div>
	<script src="/dist/js/layout/app.js"></script>
    </nav>

    <main>
        ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
    </main>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('.sidebar-menu').on('click', 'a.accordion-button', function(event) {
		event.preventDefault(); // 기본 이동 방지
		
		let url = $(this).attr('href');
		if (url === "javascript:void(0)") return; // 이동할 주소가 없으면
		
		$.ajax({
			url: url,
			type: 'GET',
			dataType: 'html',
			success: function(response) {
				$('main').html(response); 
				history.pushState(null, null, url); // 주소 변경
			},
			error: function() {
				alert('페이지를 불러오는데 실패했습니다.');
			}
		});
	});
	
	// 브라우저 "뒤로가기" 클릭 시, 변경된 URL에 맞는 페이지 로드
    window.onpopstate = function() {
        $.ajax({
            url: window.location.pathname, // 현재 URL을 가져와 요청
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                $('main').html(response);
            }
        });
    };
});

</script>

</body>
</html>