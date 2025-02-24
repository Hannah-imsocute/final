<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 내역 상세</title>
    <!-- 헤더 리소스 include (CSS/JS 등 공통 자원) -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- Font Awesome (장바구니 아이콘 등) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>

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
        a:hover { text-decoration: none; color: #fa7c00; }

        /* ========== Header (고정) ========== */
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

        /* ========== Main Container ========== */
        .main-container {
            margin-top: 10px;
            display: flex;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            min-height: 80vh;
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

        /* ========== 주문 내역 리스트 (상세) ========== */
        .list-box.detail-orders {
            border: none;
            box-shadow: none;
            margin-bottom: 20px;
        }
        .list-box.detail-orders ul {
            margin: 0;
            padding: 0;
        }

        /* 주문정보 전체 컨테이너 */
        .order-item-container {
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            list-style: none;
        }

        /* 주문 헤더 (날짜, 주문번호) */
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .order-date {
            font-size: 0.95rem;
            font-weight: 900;
            color: #666;

        }
        .order-code {
            font-size: 0.88rem;
            color: #888;
            font-weight: 900;
        }

        /* 주문 바디 (이미지 + 상품정보 + 장바구니) */
        .order-body {
            display: flex;
            align-items: center;
        }
        .product-image {
            width: 100px;
            height: 100px;
            border-radius: 4px;
            object-fit: cover;
            margin-right: 16px;
        }
        .product-info {
            flex: 1;
        }
        .product-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }
        .product-price {
            font-size: 1.1rem;
            font-weight: bold;
            color: #fa7c00;
            margin-bottom: 4px;
        }
        .shipping-fee {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 8px;
        }

        /* 버튼들 */
        .product-actions button {
            display: inline-block;
            margin-right: 6px;
            margin-bottom: 6px;
            padding: 6px 12px;
            font-size: 0.85rem;
            color: #555;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
        }
        .product-actions button:hover {
            background-color: #f0f0f0;
        }

        /* 장바구니 아이콘에 data 속성 활용 */
        .cart-icon {
            margin-left: 16px;
            font-size: 24px;
            color: #fa7c00;
            cursor: pointer;
        }
        .cart-icon:hover {
            color: #e26d00;
        }

        /* ========== 빈 메시지 ========== */
        .empty-msg {
            text-align: center;
            color: #999;
        }

        /* ========== Responsive ========== */
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                margin-top: 80px;
            }
            .content {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }
            .order-body {
                flex-direction: column;
                align-items: flex-start;
            }
            .product-image {
                margin-bottom: 10px;
            }
            .cart-icon {
                margin: 10px 0 0 0;
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
    <!-- 사이드바 include -->
    <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

    <!-- 메인 콘텐츠 -->
    <div class="content">
        <h2>주문 내역 상세</h2>

        <!-- 전체 주문 내역 -->
        <div class="list-box detail-orders">
            <c:choose>
                <c:when test="${not empty ordersHistory}">
                    <ul>
                        <!-- 모든 주문을 순회하여 표시 -->
                        <c:forEach var="order" items="${ordersHistory}">
                            <li class="order-item-container">
                                <div class="order-header">
                                    <span class="order-date">${order.orderDate}</span>
                                    <span class="order-code">주문번호: ${order.orderCode}</span>
                                </div>

                                <div class="order-body">
                                    <!-- 상품 이미지 -->
                                    <img src="${pageContext.request.contextPath}/uploads/product/${order.thumbnail}"
                                         class="product-image" />

                                    <!-- 상품 정보 -->
                                    <div class="product-info">
                                        <div class="product-title">${order.productName}</div>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${order.netPay}" pattern="#,###" />원
                                        </div>
                                        <div class="shipping-fee">배송비: 무료</div>
                                        <div class="product-actions">
                                            <button>반품신청</button>
                                            <button>교환신청</button>
                                            <button>일반 상품평</button>
                                        </div>
                                    </div>

                                    <!-- 장바구니 아이콘: data-product-code와 data-price 속성 추가 -->
                                    <div class="cart-icon"
                                         data-product-code="${order.productCode}"
                                         data-price="${order.price}">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="empty-msg">주문 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function ajaxFun(url, method, formData, dataType, fn, file = false) {
        const settings = {
            type: method,
            data: formData,
            dataType: dataType,
            success: function(data) {
                fn(data);
            },
            error: function(jqXHR) {
                console.log(jqXHR.responseText);
            }
        };
        if(file){
            settings.processData = false;
            settings.contentType = false;
        }
        $.ajax(url, settings);
    }

    $(function (){
        $('.cart-icon').click(function (e) {
            e.preventDefault();
            var productCode = $(this).data('product-code');
            var price = $(this).data('price');
            var quantity = 1;

            let params = { productCode: productCode, quantity: quantity, price: price };
            let url = "${pageContext.request.contextPath}/cart/add";

            const fn = function(data){
                alert('상품을 장바구니에 담았습니다.');
            };

            ajaxFun(url, "POST", params, "text", fn);
        });
    });
</script>
</body>
</html>
