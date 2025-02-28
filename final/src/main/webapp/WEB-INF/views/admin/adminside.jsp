<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="sidebar">
    <!-- 프로필 및 포인트 영역 -->
    <div class="profile-container">
        <!-- 프로필 이미지 -->
        <div class="profile-img-container">
            <!--<img src="img/profile.jpg" alt="Profile Picture" class="profile-img">-->
        </div>
        <p class="user-name">
        	<span>${sessionScope.member.nickName}<br>관리자님</span>
        </p>
    </div>

    <!-- 사이드바 메뉴 -->
	<div class="sidebar-menu">
	    <ul>
	        <li><a class="menu-item" href="<c:url value='/admin/authList' />">권한관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/applyList' />">입점 신청 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/settlementManage' />">결제 및 정산 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/productList' />">상품 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/event/main' />">이벤트 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/membershipList' />">광고 상품 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/notice/main' />">공지 및 문의 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/report/main' />">신고 관리</a></li>
	        <li><a class="menu-item" href="<c:url value='/admin/statsList' />">통계 및 보고</a></li>
	    </ul>
	</div>

</div>

<script src="<c:url value='/dist/js/layout/adminSidebar.js' />"></script>
