<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
  <!-- 상단 사용자 메뉴 -->
  <div class="bg-light py-1">
    <div class="container d-flex justify-content-end">
      <ul class="nav user-menu">
        <li class="nav-item">
          <a href="#" class="nav-link">사용자님</a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">알림</a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">메시지</a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>

  <!-- 메인 네비게이션 바 -->
  <nav class="navbar navbar-expand-lg position-relative">
    <div class="container">
      <!-- 로고 -->
      <div class="navbar-brand">
        <img src="/dist/images/layout/top_logo.png"  > <!-- 로고 이미지 추가 -->
      </div>


      <!-- 토글 버튼 (모바일용) -->
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarContent"
        aria-controls="navbarContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <!-- 검색창 -->
      <form
        class="d-flex search-form mx-auto my-2"
        style="max-width: 600px; position: relative;"
      >
        <input
          type="text"
          class="form-control search-input"
          placeholder="검색어를 입력하세요"
          aria-label="Search"
        />
        <button class="btn search-btn" type="submit">
          <!-- 검색 아이콘 -->
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            fill="#000000"
            class="bi bi-search"
            viewBox="0 0 16 16"
          >
            <path
              d="M11.742 10.344a6.5 6.5 0 1
                    0-1.397 1.398h-.001l3.85
                    3.85a1 1 0 0 0 1.415-1.414l-3.867-3.867zM12
                    6.5a5.5 5.5 0 1 1-11
                    0 5.5 5.5 0 0 1 11 0z"
            />
          </svg>
        </button>
      </form>
    </div>
  </nav>

  <!-- 메뉴 하단으로 이동 -->
  <!-- 서브 메뉴를 전체 너비로 확장 -->
  <div class="full-width-border sub-menu">
    <div class="container position-relative">
      <ul class="nav justify-content-center">
        <!-- 전체 카테고리 드롭다운 -->
        <li class="nav-item dropdown mx-3">
          <a class="nav-link" href="#" id="categoryMenu">
            전체 카테고리
          </a>
          <!-- 서브 메뉴 -->
          <ul class="dropdown-submenu nav flex-column">
            <li class="nav-item">
              <a href="#" class="nav-link">카테고리 A</a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">카테고리 B</a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">카테고리 C</a>
            </li>
            <li class="nav-item">
              <a href="#" class="nav-link">카테고리 D</a>
            </li>
          </ul>
        </li>
        <li class="nav-item mx-3">
          <a class="nav-link" href="#">추천 작품</a>
        </li>
        <li class="nav-item mx-3">
          <a class="nav-link" href="#">인기 작품</a>
        </li>
        <li class="nav-item mx-3">
          <a class="nav-link" href="#">커뮤니티</a>
        </li>
        <li class="nav-item mx-3">
          <a class="nav-link" href="#">이벤트</a>
        </li>
      </ul>
    </div>
  </div>
