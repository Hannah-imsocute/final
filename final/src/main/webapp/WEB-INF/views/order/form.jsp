<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 폼</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        header { position: relative !important; }
    </style>

    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            padding: 0;
            background-color: #f2f4f7;
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
        }
        main { margin-top: 0; }

        .order-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 28px;
            color: #333;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .order-table th, .order-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .order-table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .order-table td img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        .order-summary {
            text-align: right;
            font-size: 16px;
            margin-top: 20px;
        }
        .order-summary span {
            font-weight: bold;
        }

        .order-form {
            margin-top: 30px;
        }
        .order-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .order-form input, .order-form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-submit-order {
            display: block;
            width: 100%;
            padding: 12px 0;
            background-color: #ce7c2c;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-submit-order:hover {
            background-color: #b56a24;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="order-container">
        <h1>주문서</h1>

        <table class="order-table">
            <thead>
            <tr>
                <th>상품 이미지</th>
                <th>상품명</th>
                <th>옵션</th>
                <th>수량</th>
                <th>총 금액</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cart" items="${cartItems}">
                <tr>
                    <td>
<%--                        <img src="${cart.imageUrl != null ? cart.imageUrl : 'default-image.jpg'}" alt="상품 이미지">--%>
                             <img src="#" alt="상품이미지">
                    </td>
                    <td><c:out value="${cart.item}"/></td>
                    <td><c:out value="${cart.cartOption != null ? cart.cartOption : '없음'}"/></td>
                    <td><c:out value="${cart.quantity}"/></td>
                    <td><c:out value="${cart.quantity * cart.price}"/>원</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 주문 요약 -->
        <div class="order-summary">
            <c:set var="totalPrice" value="0" scope="page"/>
            <c:forEach var="cart" items="${cartItems}">
                <c:set var="lineTotal" value="${cart.quantity * cart.price}"/>
                <c:set var="totalPrice" value="${totalPrice + lineTotal}" scope="page"/>
            </c:forEach>
            <p>총 주문금액: <span><c:out value="${totalPrice}"/>원</span></p>
        </div>

        <!-- 주문 폼: 배송정보 및 주문 요청사항 입력 -->
        <form class="order-form" action="${pageContext.request.contextPath}/order/submit" method="post">
            <label for="receiverName">수령인</label>
            <input type="text" id="receiverName" name="receiverName" required value="${receiverName}">

            <label for="address">배송주소</label>
<%--            <c:set var="address" value="${addTitle + addDetail}"/>--%>
<%--            <c:set var="address" value="${'' + addTitle + addDetail}"/>--%>
            <c:if test="${not empty addTitle}">
                <input type="email" id="address" name="address" value="${addTitle} ${addDetail}" >
            </c:if>
<%--            <input type="email" id="address" name="address" value="${addTitle} ${addDetail}" >--%>

            <label for="phone">연락처</label>
            <input type="text" id="phone" name="phone" required value="${phone}">

            <label for="orderMemo">주문 요청사항</label>
            <textarea id="orderMemo" name="orderMemo" rows="4" placeholder="추가 요청사항이 있으시면 입력하세요."></textarea>

            <!-- hidden 필드로 총 주문금액 전달 (서버에서 재검증 필요) -->
            <input type="hidden" name="totalPrice" value="${totalPrice}">

            <button type="submit" class="btn-submit-order">주문하기</button>
        </form>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
</body>
</html>
