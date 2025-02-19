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
		<li><a href="javascript:void(0)"  class="accordion-button"> 작품 등록 관리
				<img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		    </a>
			<ul class="sub-menu">
				<li><a href="<c:url value='/artist/productManage/list' />" >작품 리스트</a></li>
				<li><a href="<c:url value='/artist/productManage/write' />" >작품 등록</a></li>
			</ul>
		</li>
		<li><a href="javascript:void(0)" class="accordion-button"> 주문 내역 관리
				<img src="/dist/images/layout/down_∨.png" class="toggle-icon" alt="Toggle Icon">
		</a>
			<ul class="sub-menu">
				<li><a href="<c:url value='/artist/orderManage/100' />"  >주문 통합 검색</a></li>
				<li><a href="<c:url value='/artist/orderManage/110' />">미 결제 확인</a></li>
				<li><a href="<c:url value='/artist/orderManage/120' />">발주(주문)확인/발송관리</a></li>
				<li><a href="<c:url value='/artist/orderManage/130' />">배송 현황 내역</a></li>
				<li><a href="<c:url value='/artist/orderManage/140' />">구매확정 내역</a></li>
				<li><a href="<c:url value='/artist/orderManage/150' />">주문 취소 관리</a></li>
				<li><a href="">반품 관리</a></li>
				<li><a href="#">교환 관리</a></li>

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
