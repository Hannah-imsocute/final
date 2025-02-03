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
		<p class="user-name">사용자 이름</p>
		<div class="point-container">
			<p class="point-text">
				포인트: <span class="point-value">0</span>P
			</p>
		</div>
		<!-- 버튼으로 만든 이미지 -->
		<div>
			<button class="image-button">
				<img src="/dist/images/layout/bank.png" alt="Bank Image">
			</button>
		</div>
	</div>
	<!--  사이드바 메뉴-->
	<ul class="sidebar-menu">
		<li><a href="javascript:void(0)" class="accordion-button"> 주문
				<img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="#">서브 항목 1</a></li>
				<li><a href="#">서브 항목 2</a></li>
			</ul></li>
		<li><a href="javascript:void(0)" class="accordion-button"> 작품
				<img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="#">서브 항목 1</a></li>
				<li><a href="#">서브 항목 2</a></li>
			</ul></li>
		<li><a href="javascript:void(0)" class="accordion-button"> 활동
				<img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="#">서브 항목 1</a></li>
				<li><a href="#">서브 항목 2</a></li>
			</ul></li>
		<li><a href="javascript:void(0)" class="accordion-button"> 작품
				올리기 <img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="#">서브 항목 1</a></li>
				<li><a href="#">서브 항목 2</a></li>
			</ul></li>
		<li><a href="javascript:void(0)" class="accordion-button"> 동체
				및 정산 <img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="#">서브 항목 1</a></li>
				<li><a href="#">서브 항목 2</a></li>
			</ul></li>
	</ul>
</div>
<script src="/dist/js/layout/app.js"></script>
