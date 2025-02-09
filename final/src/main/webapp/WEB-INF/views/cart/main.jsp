<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
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

        .cart-container {
            max-width: 1200px;
            margin: 20px auto;  /* 상단 여백 추가 */
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /* 장바구니 단계 표시 */
        .cart-steps {
            margin-bottom: 20px;
        }
        .cart-steps ol {
            list-style: none;
            display: flex;
            gap: 10px;
            padding: 0;
            margin: 0;
        }
        .cart-steps li { color: #ccc; }
        .cart-steps li.current { color: #333; font-weight: bold; }

        /* 좌우 2단 레이아웃 */
        .cart-content {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }
        .cart-left { flex: 3; }
        .cart-summary { flex: 1; }

        /* 테이블 스타일 – 상품 목록 */
        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-table th, .cart-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .cart-table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .cart-table td img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        /* 수량 조정 */
        .cart-item-qty {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        .cart-item-qty input[type="number"] {
            width: 50px;
            text-align: center;
        }

        /* 삭제 버튼 */
        .cart-item-delete button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .cart-item-delete button:hover {
            background-color: #cc0000;
        }

        /* 주문 금액 요약 – 오른쪽 영역 */
        .cart-summary {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            height: fit-content;
        }
        .cart-summary h3 {
            margin-top: 0;
            font-size: 18px;
            margin-bottom: 15px;
        }
        .cart-summary p { font-size: 15px; }
        .cart-summary .total-row {
            font-weight: bold;
            margin-top: 20px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }

        /* 주문하기 버튼 */
        .btn-order {
            width: 100%;
            padding: 12px 0;
            background-color: #ce7c2c;
            color: #fff;
            border: none;
            border-radius: 5px;
            margin-top: 15px;
            cursor: pointer;
            font-size: 15px;
        }
        .btn-order:hover { background-color: #b56a24; }

        .quantity-minus, .quantity-plus {
            background-color: #f7f7f7;
            border: 1px solid #ddd;
            padding: 4px 8px;
            font-size: 16px;
            cursor: pointer;
        }
        .quantity-minus:hover, .quantity-plus:hover {
            background-color: #eaeaea;
        }
        .quantity {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 4px;
            margin: 0 5px;
        }

    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="cart-container">
        <!-- 장바구니 단계 표시 -->
        <div class="cart-steps">
            <ol>
                <li class="current">01 장바구니</li>
                <li>02 주문 결제</li>
                <li>03 주문 완료</li>
            </ol>
        </div>

        <h2>장바구니</h2>

        <div class="cart-content">
            <!-- 왼쪽 영역: 상품 목록 (테이블 구조) -->
            <div class="cart-left">
                <c:if test="${empty list}">
                    <p>장바구니가 비어 있습니다.</p>
                </c:if>
                <c:if test="${not empty list}">
                    <table class="cart-table">
                        <thead>
                        <tr>
                            <th>상품 이미지</th>
                            <th>상품명</th>
                            <th>옵션</th>
                            <th>수량</th>
                            <th>단가</th>
                            <th>총 금액</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cart" items="${list}">
                            <tr>
                                <td>
                                        <%--                                    <img src="${cart.imageUrl != null ? cart.imageUrl : 'default-image.jpg'}" alt="상품 이미지">--%>
                                    <img src="#" alt="상품 이미지">
                                </td>
                                <td><c:out value="${cart.item}"/></td>
                                <td><c:out value="${cart.cartOption != null ? cart.cartOption : '없음'}"/></td>
<%--                                <td class="cart-item-qty"><c:out value="${cart.quantity}"/></td>--%>
                                <td class="cart-item-qty">
                                    <button type="button" class="quantity-minus">−</button>
                                    <input type="number" class="quantity" value="${cart.quantity}" min="1" readonly data-cartitemcode="${cart.cartItemCode}">
                                    <button type="button" class="quantity-plus">＋</button>
                                </td>
                                <td><c:out value="${cart.price}"/>원</td>
                                <td><c:out value="${cart.quantity * cart.price}"/>원</td>
                                <td class="cart-item-delete">
                                    <form action="${pageContext.request.contextPath}/cart/delete" method="post">
                                        <input type="hidden" name="cartItemCode" value="${cart.cartItemCode}">
                                        <button type="submit">삭제</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <!-- 오른쪽 영역: 주문 예상 금액 요약 -->
            <div class="cart-summary">
                <h3>주문 예상 금액</h3>
                <c:set var="totalPrice" value="0" scope="page"/>
                <c:forEach var="item" items="${list}">
                    <c:set var="lineTotal" value="${item.quantity * item.price}"/>
                    <c:set var="totalPrice" value="${totalPrice + lineTotal}" scope="page"/>
                </c:forEach>
                <p>총 작품금액: <span><c:out value="${totalPrice}"/>원</span></p>
                <p>배송비: <span>0원</span></p>
                <div class="total-row">
                    총 <c:out value="${fn:length(list)}"/>건 주문금액:
                    <span><c:out value="${totalPrice}"/>원</span>
                </div>
                <button type="button" class="btn-order">
                    <c:out value="${fn:length(list)}"/>건 주문하기
                </button>
            </div>
        </div>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
    function ajaxFun(url, method, formData, dataType, fn, file = false) {
        const settings = {
            type: method,
            data: formData,
            dataType:dataType,
            success:function(data) {
                fn(data);
            },
            beforeSend: function(jqXHR) {
            },
            complete: function () {
            },
            error: function(jqXHR) {
                console.log(jqXHR.responseText);
            }
        };

        if(file) {
            settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
            settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
        }

        $.ajax(url, settings);
    }

    $('.quantity-minus').click(function () {
        let $input = $(this).siblings('input.quantity');
        let currentQty = parseInt($input.val());
        if(currentQty > 1) {
            let diff = -1;
            // data-cartItemCode 속성으로 설정한 경우:
            let cartItemCode = $input.data('cartitemcode');
            let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
            let formData = {
                cartItemCode: cartItemCode,
                quantity: diff
            };

            const fn = function (data) {
                if(data.status === 'success') {
                    $input.val(currentQty + diff);
                } else {
                    alert('업데이트 실패: ' + data.message);
                }
            }
            ajaxFun(url, 'post', formData, 'json', fn);
        }
    });

    $('.quantity-plus').click(function () {
        let $input = $(this).siblings('input.quantity');
        let currentQty = parseInt($input.val());
            let diff = 1;
            // data-cartItemCode 속성으로 설정한 경우:
            let cartItemCode = $input.data('cartitemcode');
            let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
            let formData = {
                cartItemCode: cartItemCode,
                quantity: diff
            };

            const fn = function (data) {
                if(data.status === 'success') {
                    $input.val(currentQty + diff);
                } else {
                    alert('업데이트 실패: ' + data.message);
                }
            };
            ajaxFun(url, 'post', formData, 'json', fn);
        });
</script>
</body>
</html>
