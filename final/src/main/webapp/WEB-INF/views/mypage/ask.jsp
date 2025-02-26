<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 문의 내역</title>
    <!-- 공통 헤더 리소스 include -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        /* ========== Global Reset & Base Style ========== */
        * { box-sizing: border-box; }
        body, html {
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
            background-color: #fff;
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        a:hover { color: #fa7c00; }

        /* ========== Fixed Header ========== */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
        }

        /* ========== Main Container ========== */
        .main-container {
            margin-top: 70px; /* fixed header 공간 확보 */
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
            padding: 20px;
        }

        /* ========== Sidebar & Content ========== */
        .content {
            flex: 1;
            background-color: #fff;
            margin-left: 20px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        .content h2 {
            margin-top: 0;
            font-size: 1.4rem;
            margin-bottom: 30px;
            font-weight: 700;
        }

        /* ========== 문의 내역 리스트 ========== */
        .list-box.ask-list {
            border: none;
            margin-bottom: 20px;
        }
        .list-box.ask-list ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .ask-item-container {
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .ask-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .ask-date {
            font-size: 0.95rem;
            font-weight: 900;
            color: #666;
        }
        .ask-subject {
            font-size: 1rem;
            font-weight: bold;
            color: #fa7c00;
        }
        .ask-body {
            font-size: 0.95rem;
            line-height: 1.4;
            color: #333;
        }

        /* ========== 페이징 ========== */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin: 20px 0;
            padding: 0;
            list-style: none;
        }
        .pagination li a {
            display: inline-block;
            width: 2.5rem;
            height: 2.5rem;
            line-height: 2.5rem;
            text-align: center;
            font-size: 1rem;
            color: #555;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 50%;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.2s ease;
        }
        .pagination li a:hover {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            transform: scale(1.1);
        }
        .pagination li.active a {
            background-color: #fa7c00;
            border-color: #fa7c00;
            color: #fff;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            transform: scale(1.1);
        }
        .pagination li.disabled a {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 본문 컨테이너 -->
<div class="main-container">
    <!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

    <!-- 콘텐츠 영역 -->
    <div class="content">
        <h2>상품 문의 내역</h2>
        <div class="list-box ask-list">
            <c:choose>
                <c:when test="${not empty askList}">
                    <ul>
                        <c:forEach var="ask" items="${askList}">
                            <li class="ask-item-container">
                                <div class="ask-header">
                                        <span class="ask-date">
<%--                                            <fmt:formatDate value="${ask.regDate}" pattern="yyyy-MM-dd" />--%>
                                        </span>
                                    <span class="ask-subject">${ask.subject}</span>
                                </div>
                                <div class="ask-body">
                                        ${ask.content}
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <!-- 페이징 영역 -->
                    <ul class="pagination">
                            ${paging}
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="empty-msg">문의 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</body>
</html>