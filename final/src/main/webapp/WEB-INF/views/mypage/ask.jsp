<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 문의 내역</title>
    <!-- 공통 헤더 리소스 include -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Font Awesome (아이콘: 별점, 장바구니 등) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        /************************************************
         * 1) Global Reset & Base Style
         ************************************************/
        header { position: relative !important; }
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

        /************************************************
         * 2) Main Container (사이드바 + 콘텐츠)
         ************************************************/
        .main-container {
            /* 상단 고정 헤더가 있다면, 적절히 margin-top 조정 */
            margin-top: 10px; /* 예: 헤더 높이가 70px 정도일 때 */
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
            padding: 20px;
        }
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

        /************************************************
         * 3) 문의 내역 테이블 스타일 (반응형 포함)
         ************************************************/
        .table-responsive {
            width: 100%;
            overflow-x: auto; /* 좁은 화면에서 가로 스크롤 허용 */
            -webkit-overflow-scrolling: touch; /* 모바일 부드러운 스크롤 */
        }
        .ask-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            min-width: 600px; /* 테이블이 너무 작게 접히지 않도록 최소 너비 지정 */
        }
        .ask-table thead th {
            background-color: #fafafa;
            border-bottom: 1px solid #e5e5e5;
            font-weight: 700;
            padding: 14px;
            text-align: left;
            white-space: nowrap; /* 헤더가 여러 줄로 줄바꿈되지 않도록 */
        }
        .ask-table tbody tr {
            border-bottom: 1px solid #eee;
        }
        .ask-table td {
            padding: 14px;
            vertical-align: middle;
            font-size: 0.95rem;
        }
        /* 답변 상태 색상 강조 */
        .answer-complete {
            color: #28a745;  /* 초록색 */
            font-weight: bold;
        }
        .answer-pending {
            color: #fa7c00; /* 오렌지색 */
            font-weight: bold;
        }

        /************************************************
         * 4) 페이징 스타일 (화살표, 번호)
         ************************************************/
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

        .home-button {
            display: block;
            width: 130px;
            margin: 30px auto 0 auto;
            padding: 5px 0;
            text-align: center;
            font-size: 1rem;
            font-weight: 700;
            color: #fff;
            background-color: #fa7c00;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s, transform 0.2s;
            cursor: pointer;
        }

        /************************************************
         * 5) 추가 반응형 (폰트 크기, 패딩 축소 등)
         ************************************************/
        @media (max-width: 768px) {
            .ask-table thead th,
            .ask-table td {
                padding: 10px;
                font-size: 0.9rem;
            }
        }
        @media (max-width: 480px) {
            .ask-table thead th,
            .ask-table td {
                padding: 8px;
                font-size: 0.85rem;
            }
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

        <!-- 테이블을 가로 스크롤 가능한 컨테이너로 감싸기 -->
        <c:choose>
            <c:when test="${not empty askList}">
                <div class="table-responsive">
                    <table class="ask-table">
                        <thead>
                        <tr>
                            <th style="width: 15%;">답변상태</th>
                            <th style="width: 30%;">문의내용</th>
                            <th style="width: 15%;">문의종류</th>
                            <th style="width: 20%;">상품</th>
                            <th style="width: 20%;">작성일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="ask" items="${askList}">
                            <tr>
                                <!-- 답변 상태 -->
                                <td>
                                    <c:choose>
                                        <c:when test="${ask.answerState == 1}">
                                            <span class="answer-complete">답변완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="answer-pending">미답변</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <!-- 문의 내용 -->
                                <td>
                                        ${ask.content}
                                </td>
                                <!-- 문의 종류 -->
                                <td>
                                    <c:choose>
                                        <c:when test="${ask.category == 1}">제품정보</c:when>
                                        <c:when test="${ask.category == 2}">배송문의</c:when>
                                        <c:when test="${ask.category == 3}">교환/반품</c:when>
                                        <c:when test="${ask.category == 4}">기타</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <!-- 상품 (브랜드명 / 상품명) -->
                                <td>
                                        ${ask.brandName} / ${ask.productName}
                                </td>
                                <!-- 작성일 -->
                                <td>
                                    <c:out value="${fn:substring(ask.askDate, 0, 10)}"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 페이징 영역 -->
                <ul class="pagination">
                    <li class="arrow ${page == 1 ? 'disabled' : ''}">
                        <a href="?page=${page - 1}">&lt;</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${total_page}">
                        <li class="${i == page ? 'active' : ''}">
                            <a href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="arrow ${page == total_page ? 'disabled' : ''}">
                        <a href="?page=${page + 1}">&gt;</a>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <p class="empty-msg">문의 내역이 없습니다.</p>
            </c:otherwise>
        </c:choose>
        <!-- 홈으로 가기 버튼 -->
        <button class="home-button" onclick="location.href='${pageContext.request.contextPath}/mypage/home'">
            홈으로 가기
        </button>
    </div>
</div>

<!-- 푸터 -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
</body>
</html>