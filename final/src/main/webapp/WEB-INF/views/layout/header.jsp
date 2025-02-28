<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="bg-light py-1">
	<div class="container d-flex justify-content-end">
		<c:choose>
			<c:when test="${empty sessionScope.member}">
				<ul class="nav user-menu">
                   <li class="nav-item">
					<a href="${pageContext.request.contextPath}/member/login"
						title="로그인" class="nav-link"><i class="bi bi-lock"></i></a>
					</li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/member/register"
						title="회원가입"><i class="bi bi-person-plus"></i></a></li>
				</ul>
			</c:when>

			<c:otherwise>
				<ul class="nav user-menu">
					<li class="nav-item"><a href="#" class="nav-link">사용자님</a></li>
					<li class="nav-item"><a href="#" class="nav-link">알림</a></li>
					<li class="nav-item"><a href="#" class="nav-link">메시지</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/member/logout"
						title="로그아웃" class="nav-link"><i class="bi bi-unlock"></i></a></li>
					<c:if test="${sessionScope.member.userLevel==99}">
						<li class="p-2">
							<a href="${pageContext.request.contextPath}/admin" title="관리자"><i class="bi bi-gear"></i></a>
						</li>					
					</c:if>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div class="header-top">
	<!-- 로고 -->
	<div class="logo">
		<a href="${pageContext.request.contextPath}/"><img
			src="/dist/images/layout/top_logo.png" alt="로고"></a>
	</div>

	<!-- 전체 카테고리 아이콘 -->
	<div class="category-menu">
		<button class="category-btn">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
				fill="#000000" class="bi bi-list" viewBox="0 0 16 16">
        <path
					d="M2 3h12a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm0 4h12a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1zm0 4h12a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1z" />
      </svg>
			전체 카테고리
		</button>
	</div>
	<div class="category-dropdown">
		<a href="#">카테고리 1</a> <a href="#">카테고리 2</a> <a href="#">카테고리 3</a> <a
			href="#">카테고리 4</a> <a href="#">카테고리 5</a>
	</div>


	<div class="search-container">
		<div class="search-left">
			<form class="d-flex search-form">
				<div class="search-input-wrapper">
					<input type="text" class="form-control search-input"
						placeholder="검색어를 입력하세요" aria-label="Search">
					<button class="btn search-btn" type="submit">
						<!-- 검색 아이콘 -->
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
							fill="#000000" class="bi bi-search" viewBox="0 0 16 16">
              <path
								d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.867-3.867zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
            </svg>
					</button>
				</div>
			</form>
		</div>

		<div class="icon-group">
			<a href="#" class="icon-item"> <i class="bi bi-heart"></i> <span>찜</span>
			</a> <a href="${pageContext.request.contextPath}/mypage/home"
				class="icon-item"> <i class="bi bi-person-circle"></i> <span>내
					정보</span>
			</a> <a href="${pageContext.request.contextPath}/cart/list"
				class="icon-item"> <i class="bi bi-cart"></i> <span>장바구니</span>
			</a>
		</div>
	</div>
</div>

<!-- 네비게이션 메뉴 -->
<nav class="navbar navbar-expand-lg">
	<div class="container">
		<!-- 메뉴 항목들 -->
		<ul class="navbar-nav ms-auto">
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/product/category">전체 카테고리</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/product/recommend">추천 작품</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/product/popular">인기 작품</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/community/list">커뮤니티</a></li>
			<li class="nav-item"><a class="nav-link" href="#">이벤트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">공지사항</a></li>
		</ul>
	</div>
</nav>