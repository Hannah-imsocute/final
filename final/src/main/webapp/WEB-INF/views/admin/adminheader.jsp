<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!-- 상단 사용자 메뉴 -->
<div class="bg-light py-1">
	<div class="container d-flex justify-content-end">
		<ul class="nav user-menu">
			<li class="nav-item">
				<a href="#" class="nav-link">
					<span>${sessionScope.member.nickName} 관리자님</span>
				</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">알림</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">채팅</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">로그아웃</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">내 정보</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">찜</a>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link">고객센터</a>
			</li>
		</ul>
	</div>
</div>

<div class="navbar-container d-flex justify-content-between align-items-center">
	<!-- 로고 -->
	<div class="navbar-brand">
		<a href='${pageContext.request.contextPath}/'>
			<img src="/dist/images/layout/top_logo.png" alt="로고">
		</a>
	</div>
	<div class="icon-text-group-container d-flex align-items-center">
		<div class="icon-group">
			<a href="#" class="nav-link">
				<i class="bi bi-chat-left-text"></i>
				<p>채팅</p>
			</a>
		</div>
		<div class="icon-group">
			<a href="#" class="nav-link">
				<i class="bi bi-bell"></i>
				<p>알림</p>
			</a>
		</div>
		<div class="icon-group">
			<a href="#" class="nav-link">
				<i class="bi bi-heart"></i>
				<p>하트</p>
			</a>
		</div>
		<div class="icon-group">
			<a href="#" class="nav-link">
				<i class="bi bi-person-circle"></i>
				<p>내정보</p>
			</a>
		</div>
		<div class="icon-group">
			<a href="#" class="nav-link">
				<i class="bi bi-cart"></i>
				<p>장바구니</p>
			</a>
		</div>
	</div>
</div>