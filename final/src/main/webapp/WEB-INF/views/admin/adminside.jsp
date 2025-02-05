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
