<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="sidebar">
	<!-- 프로필 및 포인트 영역 -->
	<div class="profile-container">
		<!-- 프로필 이미지 -->
		<div class="profile-img-container">
			<!-- <img src="img/profile.jpg" alt="Profile Picture" class="profile-img"> -->
		</div>
		<p class="user-name">관리자님</p>

	</div>
	<!--  사이드바 메뉴-->
		<ul class="sidebar-menu">
		    <li><a href="#" class="menu-item" data-page="authList">권한관리</a></li>
		    <li><a href="#" class="menu-item" data-page="applyList">입점신청관리</a></li>
		    <li><a href="#" class="menu-item" data-page="membershipList">멤버십관리</a></li>
		    <li><a href="#" class="menu-item" data-page="paymentList">결제 및 정산관리</a></li>
		    <li><a href="#" class="menu-item" data-page="productList">상품관리</a></li>
		    <li><a href="#" class="menu-item" data-page="eventList">이벤트관리</a></li>
		    <li><a href="#" class="menu-item" data-page="noticeList">공지사항관리</a></li>
		    <li><a href="#" class="menu-item" data-page="inquiryList">문의사항관리</a></li>
		    <li><a href="#" class="menu-item" data-page="reportList">신고관리</a></li>
		    <li><a href="#" class="menu-item" data-page="statsList">통계 및 보고</a></li>
		</ul>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".menu-item").forEach(item => {
        item.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 링크 동작 방지

            let page = this.getAttribute("data-page"); // 클릭한 메뉴의 data-page 값 가져오기

            fetch("/WEB-INF/views/admin/" + page + ".jsp")  // JSP 파일 로드
                .then(response => response.text())
                .then(data => {
                    document.getElementById("main-content").innerHTML = data; // 내용 변경
                })
                .catch(error => console.error("Error loading page:", error));
        });
    });
});
</script>

<script src="/dist/js/layout/app.js"></script>
