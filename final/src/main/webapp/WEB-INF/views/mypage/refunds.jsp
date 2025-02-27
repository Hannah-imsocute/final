<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>교환/환불 신청 내역</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    <!-- 폰트어썸 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>

    <style>
        /* Reset & Base */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body, html {
            font-family: "Noto Sans KR", sans-serif;
            background-color: #f7f7f7;
            color: #444;
            line-height: 1.6;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            color: #fa7c00;
        }

        /* Header */
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
        }
        header { position: relative !important; }

        /* 메인 레이아웃 */
        .main-container {
            max-width: 1200px;
            margin: 15px auto 40px; /* 상단 여백 확보 (헤더 고정 고려) */
            padding: 0 20px;
            display: flex;
            gap: 20px;
        }
        .sidebar {
            flex: 0 0 250px;
        }
        .content {
            flex: 1;
            background: #fff;
            padding: 40px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .content h2 {
            font-size: 1.8rem;
            margin-bottom: 30px;
            font-weight: 700;
            border-bottom: 3px solid #fa7c00;
            padding-bottom: 10px;
            color: #333;
        }

        /* 테이블 스타일 */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            background-color: #fff;
        }
        .table thead {
            background-color: #fa7c00;
            color: #fff;
        }
        .table thead tr th {
            padding: 12px 10px;
            font-weight: 700;
            text-align: center;
        }
        .table tbody tr {
            border-bottom: 1px solid #ddd;
        }
        .table tbody tr:hover {
            background-color: #f9f9f9;
        }
        .table td {
            padding: 12px 10px;
            vertical-align: middle;
            text-align: center;
        }
        .table img {
            max-width: 80px;
            border-radius: 4px;
        }

        /* 상태 표시 */
        .state {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            color: #fff;
            font-weight: 700;
        }
        .state-0 {
            background-color: #3498db; /* 접수완료 */
        }
        .state-1 {
            background-color: #f39c12; /* 처리중 */
        }
        .state-default {
            background-color: #27ae60; /* 완료 */
        }

        /* 빈 데이터 메시지 */
        .empty-msg {
            text-align: center;
            color: #aaa;
            padding: 20px;
        }

        /* 페이징 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 30px;
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
            transition: background-color 0.3s, transform 0.2s;
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
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
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

        /* 반응형 */
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                margin: 80px auto 20px;
            }
            .sidebar {
                flex: none;
                width: 100%;
                margin-bottom: 20px;
            }
            .content {
                padding: 20px;
            }
            .content h2 {
                font-size: 1.6rem;
                margin-bottom: 20px;
            }
            .table thead tr th,
            .table td {
                font-size: 0.9rem;
                padding: 8px;
            }
        }
        @media (max-width: 480px) {
            .content {
                padding: 15px;
            }
            .pagination li a {
                width: 2rem;
                height: 2rem;
                line-height: 2rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- Main Container -->
<div class="main-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />
    </div>

    <!-- Content -->
    <div class="content">
        <h2>교환/환불 신청 내역</h2>

        <!-- 데이터가 있을 경우 테이블 출력 -->
        <c:if test="${not empty requestList}">
            <table class="table">
                <thead>
                <tr>
                    <th>날짜</th>
                    <th>상태</th>
                    <th>상품번호</th>
                    <th>요청내용</th>
                    <th>브랜드</th>
                    <th>주문번호</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="dto" items="${requestList}">
                    <tr>
                        <td>${fn:substring(dto.changeDate, 0, 10)} </td>
                        <td>
                            <span class="state
                                ${dto.changeState == 0 ? 'state-0' :
                                  (dto.changeState == 1 ? 'state-1' : 'state-default')}">
                                    ${dto.changeState == 0 ? '접수완료' :
                                            (dto.changeState == 1 ? '처리중' : '완료')}
                            </span>
                        </td>
                        <td>${dto.itemCode}</td>
                        <td>${dto.changeRequest}</td>
                        <td>${dto.brandName}</td>
                        <td>${dto.orderCode}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- 데이터가 없을 경우 메시지 출력 -->
        <c:if test="${empty requestList}">
            <p class="empty-msg">신청 내역이 없습니다.</p>
        </c:if>

        <!-- 페이징 -->
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
        <button class="home-button" onclick="location.href='${pageContext.request.contextPath}/mypage/home'">
            홈으로 가기
        </button>
    </div>
</div>

<!-- Footer -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
</body>
</html>
