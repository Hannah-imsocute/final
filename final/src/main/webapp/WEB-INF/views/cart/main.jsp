<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <!-- 기존 headerResources.jsp 등에 포함된 CSS/JS 링크들 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 폰트 (예시) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet" />

    <style>
        /* 전역 기본 */
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            background: #f3f3f3;
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
        }
        header {
            position: relative !important; /* 기존 fixed 해제 */
        }
        main {
            margin-top: 0;
        }

        /* 컨테이너 */
        .cart-page {
            max-width: 1200px;
            margin: 20px auto 60px;
            padding: 0 20px;
        }

        /* 오른쪽 정렬 - 단계 표시 */
        .cart-steps {
            margin-bottom: 20px;
            font-size: 14px;
            color: #999;
            text-align: right;
        }
        .cart-steps ol {
            list-style: none;
            display: inline-flex;
            gap: 10px;
            padding: 0;
            margin: 0;
        }
        .cart-steps li.current {
            font-weight: bold;
            color: #333;
        }

        .cart-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* 전체선택, 선택삭제 */
        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            color: #666;
            font-size: 14px;
        }
        .cart-actions .left-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .cart-actions input[type="checkbox"] {
            transform: scale(1.2);
        }
        .cart-actions .right-actions button {
            background: none;
            border: 1px solid #ddd;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        .cart-actions .right-actions button:hover {
            background: #f7f7f7;
        }

        /* 레이아웃 (좌: 상품목록, 우: 결제요약) */
        .cart-content {
            display: flex;
            gap: 20px;
        }
        .cart-left {
            flex: 3;
        }
        .cart-right {
            flex: 1;
        }

        /* 카드 스타일 (좌측 상품 영역) */
        .cart-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }

        /* 상품 컨테이너 (item + footer) */
        .cart-item-block {
            border-top: 1px solid #eee;
            padding-top: 15px;
            margin-top: 15px;
        }
        .cart-item-block:first-child {
            border-top: none;
            padding-top: 0;
            margin-top: 0;
        }

        /* 스토어명 및 아이콘 컨테이너 */
        .store-info {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 5px;
        }
        .store-name {
            font-size: 14px;
            font-weight: bold;
            color: #666; /* 살짝 연한 색상 */
        }

        /* 상품 정보 (이미지/수량/옵션/쿠폰/가격 + 삭제버튼) */
        .cart-item-row {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .cart-item-check input[type="checkbox"] {
            transform: scale(1.2);
        }
        .cart-item-image img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        .cart-item-details {
            flex: 1;
        }
        .item-title {
            font-size: 15px;
            font-weight: bold;
            margin-bottom: 4px;
        }
        .item-option {
            font-size: 13px;
            color: #888;
        }

        /* 수량, 가격, 삭제버튼 영역 */
        .cart-item-right {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .item-quantity {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .btn-qty {
            width: 32px;
            height: 32px;
            border: 1px solid #ddd;
            background: #fff;
            cursor: pointer;
            font-size: 16px;
        }
        .input-qty {
            width: 50px;
            height: 32px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
        }

        .coupon-btn {
            background: #ff8200;
            color: #fff;
            font-size: 12px;
            border: none;
            border-radius: 4px;
            padding: 4px 6px;
            cursor: pointer;
        }
        .coupon-btn:hover {
            background: #ff8400;
        }

        /* 가격 및 삭제 버튼 (X아이콘) */
        .price-and-delete {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .item-price {
            font-size: 16px;
            font-weight: bold;
        }
        .item-delete button {
            width: 20px;
            height: 20px;
            background: url('https://cdn-icons-png.flaticon.com/512/458/458595.png') no-repeat center center;
            background-size: contain;
            border: none;
            cursor: pointer;
        }
        .item-delete button:hover {
            opacity: 0.7;
        }

        /* 상품별 footer (상품금액, 할인금액, 배송비, 주문금액) */
        .cart-card-footer {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            flex-wrap: wrap;
        }
        .cart-card-footer .label {
            color: #999;
        }
        .cart-card-footer .value {
            font-weight: bold;
        }
        .cart-card-footer .divider {
            margin: 0 10px;
            color: #ccc;
        }
        .cart-card-footer .shipping {
            color: #ff8200;
        }

        /* 가격 텍스트 */
        .price-text {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            letter-spacing: -0.5px;
        }

        /* 우측 결제정보 박스 */
        .order-summary {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 20px;
        }
        .order-summary h3 {
            margin-top: 0;
            font-size: 18px;
            margin-bottom: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        .summary-item .label {
            color: #666;
        }
        .summary-item .value {
            font-weight: bold;
            font-size: 15px;
        }
        .discount-info {
            color: #f05;
            font-size: 14px;
        }
        .summary-total {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }

        /* 구매하기 버튼 */
        .btn-checkout {
            display: block;
            width: 100%;
            margin-top: 15px;
            padding: 14px 0;
            background: #ff8200;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }
        .btn-checkout:hover {
            background: #ff6600;
        }

        /* 쿠폰 모달 오버레이 */
        .coupon-modal {
            display: none; /* 기본 숨김 처리 */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        /* 모달 창 */
        .coupon-modal-content {
            background: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            position: relative;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.3s ease;
        }

        /* 모달 헤더 */
        .coupon-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .coupon-modal-header h3 {
            margin: 0;
            font-size: 20px;
        }
        .coupon-modal-close {
            font-size: 24px;
            cursor: pointer;
            color: #999;
        }
        .coupon-modal-close:hover {
            color: #ff8200;
        }

        /* 모달 본문 */
        .coupon-modal-body {
            margin: 15px 0;
            max-height: 300px;
            overflow-y: auto;
        }
        .coupon-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .coupon-item {
            padding: 10px;
            border: 1px solid #f0f0f0;
            border-radius: 5px;
            margin-bottom: 10px;
            transition: background 0.3s;
            cursor: pointer;
        }
        .coupon-item:hover {
            background: #f9f9f9;
        }
        .coupon-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .coupon-code {
            font-weight: bold;
            color: #ff8200;
            font-size: 16px;
        }
        .coupon-description {
            font-size: 14px;
            color: #555;
        }
        .coupon-expiration {
            font-size: 12px;
            color: #999;
        }
        .coupon-modal-footer {
            text-align: right;
            border-top: 1px solid #eee;
            padding-top: 10px;
        }
        .coupon-modal-apply {
            background: #ff8200;
            border: none;
            color: #fff;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .coupon-modal-apply:hover {
            background: #ff6600;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Responsive 스타일 */
        @media (max-width: 768px) {
            .cart-page {
                padding: 0 10px;
            }
            .cart-content {
                flex-direction: column;
            }
            .cart-right {
                order: -1;
                margin-bottom: 20px;
            }
            .cart-item-row, .cart-item-right, .cart-card-footer {
                flex-direction: column;
                align-items: flex-start;
            }
            .item-quantity {
                margin-bottom: 10px;
            }
            .price-and-delete {
                justify-content: space-between;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="cart-page">
    <!-- 장바구니 단계 (오른쪽 정렬) -->
    <div class="cart-steps">
        <ol>
            <li class="current">01 장바구니</li>
            <li>02 주문 결제</li>
            <li>03 주문 완료</li>
        </ol>
    </div>

    <h2 class="cart-title">장바구니</h2>

    <!-- 전체선택 / 선택삭제 -->
    <div class="cart-actions">
        <div class="left-actions">
            <label>
                <input type="checkbox" class="selectAll" checked/> 전체선택 ( <c:out value="${fn:length(list)}"/> / <c:out value="${fn:length(list)}"/> 개 )
            </label>
        </div>
        <div class="right-actions">
            <form name="btnForm" action="${pageContext.request.contextPath}/cart/delete" method="post">
                <input type="hidden" name="cartItemCode" value="${cartItemCode}">
                <button type="button" class="btnSelectRemove">선택삭제</button>
            </form>
        </div>
    </div>

    <!-- 본문: 좌측(상품), 우측(결제) -->
    <div class="cart-content">
        <div class="cart-left">
            <!-- 장바구니 비어있을때 -->
            <c:if test="${empty list}">
                <div class="cart-card" style="text-align:center;">
                    <p>장바구니가 비어 있습니다.</p>
                </div>
            </c:if>

            <!-- 장바구니 있을때 -->
            <c:if test="${not empty list}">
                <div class="cart-card">
                    <c:forEach var="cart" items="${list}">
                        <!-- 상품+푸터 묶음을 감싸는 블록 -->
                        <div class="cart-item-block">
                            <!-- 스토어명과 아이콘을 같은 영역에 배치 -->
                            <div class="store-info">
                                <span class="store-name">기은샵</span>
                                <svg data-v-6d2bd019="" data-v-ec764313=""
                                     width="24" height="24" viewBox="0 0 24 24"
                                     xmlns="http://www.w3.org/2000/svg" class="BaseIcon"
                                     style="width: 24px; height: 24px; opacity: 1; fill: currentcolor; --BaseIcon-color: #333333;">
                                    <g clip-path="url(#clip0_124_2947)">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M9.53039 5.46973L15.5304 11.4697C15.7967 11.736 15.8209 12.1527 15.603 12.4463L15.5304 12.5304L9.53039 18.5304L8.46973 17.4697L13.9391 12.0001L8.46973 6.53039L9.53039 5.46973Z"></path>
                                    </g>
                                    <defs>
                                        <clipPath id="clip0_124_2947">
                                            <rect width="24" height="24"></rect>
                                        </clipPath>
                                    </defs>
                                </svg>
                            </div>
                            <!-- 상품 정보 (한 줄) -->
                            <div class="cart-item-row">
                                <div class="cart-item-check">
                                    <input type="checkbox" checked value="${cart.cartItemCode}"/>
                                </div>
                                <div class="cart-item-image">
                                    <!-- 이미지 (실제 경로로 교체) -->
                                    <img src="${pageContext.request.contextPath}/dist/img/우산.jpg" alt="상품 이미지"/>
                                </div>
                                <div class="cart-item-details">
                                    <div class="item-title">
                                        <c:out value="${cart.item}"/>
                                    </div>
                                    <div class="item-option">
                                        <c:out value="${cart.cartOption != null ? cart.cartOption : '옵션없음'}"/>
                                    </div>
                                </div>

                                <div class="cart-item-right">
                                    <!-- 수량 조절 -->
                                    <div class="item-quantity">
                                        <button type="button" class="btn-qty quantity-minus">-</button>
                                        <input type="number" class="input-qty" value="${cart.quantity}" min="1" readonly data-cartitemcode="${cart.cartItemCode}" data-oldprice="${cart.price}" />
                                        <button type="button" class="btn-qty quantity-plus">+</button>
                                    </div>
                                    <!-- 쿠폰 버튼 -->
                                    <button class="coupon-btn">쿠폰적용</button>

                                    <!-- 쿠폰 목록 모달 (기본 숨김) -->
                                    <div class="coupon-modal" id="couponModal">
                                        <div class="coupon-modal-content">
                                            <div class="coupon-modal-header">
                                                <h3>보유 쿠폰 목록</h3>
                                                <span class="coupon-modal-close">&times;</span>
                                            </div>
                                            <div class="coupon-modal-body">
                                                <ul class="coupon-list">
                                                    <li class="coupon-item">
                                                        <div class="coupon-info">
                                                            <span class="coupon-code">ABC123</span>
                                                            <span class="coupon-description">10% 할인 쿠폰</span>
                                                            <span class="coupon-expiration">2025-12-31 까지 사용 가능</span>
                                                        </div>
                                                    </li>
                                                    <li class="coupon-item">
                                                        <div class="coupon-info">
                                                            <span class="coupon-code">XYZ789</span>
                                                            <span class="coupon-description">5,000원 할인 쿠폰</span>
                                                            <span class="coupon-expiration">2025-06-30 까지 사용 가능</span>
                                                        </div>
                                                    </li>
                                                    <!-- 필요한 경우 추가 coupon-item -->
                                                </ul>
                                            </div>
                                            <div class="coupon-modal-footer">
                                                <button type="button" class="coupon-modal-apply">쿠폰 적용</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 가격 및 삭제 버튼 -->
                                    <div class="price-and-delete">
                                        <div class="item-price price-text" data-oldprice="${cart.price}">
                                            <c:out value="${cart.quantity * cart.price}"/>원
                                        </div>
                                        <div class="item-delete">
                                            <form action="${pageContext.request.contextPath}/cart/delete" method="post">
                                                <input type="hidden" name="cartItemCode" value="${cart.cartItemCode}">
                                                <button type="submit"></button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- //cart-item-row -->

                            <!-- 상품별 footer -->
                            <div class="cart-card-footer">
                                <div>
                                    <span class="label">상품금액</span>
                                    <span class="value price-text">
                                        <fmt:formatNumber value="${cart.quantity * cart.price}" pattern="#,###" />원
                                    </span>
                                </div>
                                <span class="divider">|</span>
                                <div>
                                    <span class="label">할인금액</span>
                                    <span class="value price-text" style="color:#f05;">
                                        7,000원
                                    </span>
                                </div>
                                <span class="divider">|</span>
                                <div>
                                    <span class="label">배송비</span>
                                    <span class="value shipping price-text">무료배송</span>
                                </div>
                                <span class="divider">=</span>
                                <div>
                                    <span class="label">주문금액</span>
                                    <span class="value price-text">
<%--                                        <c:out value="${(cart.quantity * cart.price) - 7000}"/>원--%>
                                        <fmt:formatNumber value="${(cart.quantity * cart.price) - 7000}" pattern="#,###" />원

                                    </span>
                                </div>
                            </div>
                        </div> <!-- //cart-item-block -->
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- 우측 결제정보 요약 -->
        <div class="cart-right">
            <div class="order-summary">
                <h3>결제정보</h3>
                <!-- 전체 totalPrice 계산 -->
                <c:set var="totalPrice" value="0" scope="page"/>
                <c:forEach var="citem" items="${list}">
                    <c:set var="lineTotal" value="${citem.quantity * citem.price}"/>
                    <c:set var="totalPrice" value="${totalPrice + lineTotal}" scope="page"/>
                </c:forEach>

                <div class="summary-item">
                    <span class="label">상품수</span>
                    <span class="value"><c:out value="${fn:length(list)}"/>개</span>
                </div>
                <div class="summary-item">
                    <span class="label">상품금액</span>
                    <span class="value price-text">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                    </span>
                </div>
                <div class="summary-item">
                    <span class="label">할인금액</span>
                    <span class="value discount-info">-7,000원</span>
                </div>
                <div class="summary-item">
                    <span class="label">배송비</span>
                    <span class="value">0원</span>
                </div>
                <div class="summary-total">
                    총 결제금액:
                    <span style="float:right;" class="price-text">
                        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                    </span>
                </div>

                <button type="button" class="btn-checkout" onclick="location.href='${pageContext.request.contextPath}/order/form'">
                    구매하기
                </button>
            </div>
        </div>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
    /* 기존 Ajax 함수 */
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

    // 수량 감소
    $('.quantity-minus').click(function () {
        let $input = $(this).siblings('.input-qty');
        let currentQty = parseInt($input.val());
        if(currentQty > 1) {
            let diff = -1;
            let cartItemCode = $input.data('cartitemcode');

            let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
            let formData = {
                cartItemCode: cartItemCode,
                quantity: diff
            };
            ajaxFun(url, 'post', formData, 'json', function(data){
                if(data.status === 'success'){
                    let newCurrentQty = currentQty + diff;

                    $input.val(newCurrentQty);

                    let oldPrice = parseInt($input.data('oldprice'));

                    let newPrice = newCurrentQty * oldPrice;

                    let $price = $('.input-qty').closest('.cart-item-right').find('.item-price');

                    $price.text(newPrice + '원');

                } else {
                    alert('업데이트 실패: ' + data.message);
                }
            });
        }
    });

    // 수량 증가
    $('.quantity-plus').click(function () {
        let $input = $(this).siblings('.input-qty');
        let currentQty = parseInt($input.val());
        let diff = 1;
        let cartItemCode = $input.data('cartitemcode');
        let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
        let formData = {
            cartItemCode: cartItemCode,
            quantity: diff
        };

        ajaxFun(url, 'post', formData, 'json', function(data){
            if(data.status === 'success'){
                let newCurrentQty = currentQty + diff;
                 $input.val(newCurrentQty);

                let oldPrice = parseInt($input.data('oldprice'));
                let newPrice = oldPrice * newCurrentQty;
                // 가격 표시 업데이트
                let $price = $input.closest('.cart-item-right').find('.item-price');
                $price.text(newPrice + '원');
            } else {
                alert('업데이트 실패: ' + data.message);
            }
        });
    });

    $(function () {
        $('.btnSelectRemove').click(function () {
            let selectedItems = [];
            let $form = $('form[name="btnForm"]');

            $('.cart-item-check input:checked').each(function(){
                selectedItems.push($(this).val());
            });

            if(selectedItems.length === 0) {
                alert('선택된 상품이 없습니다.');
                return;
            }

            if(! confirm('선택된 상품을 삭제하시겠습니까?')){
                return;
            }
            $form.submit();
        });
    });

    $(function () {
        $('.selectAll').click(function () {
            let isChecked = $(this).prop('checked');
            $('.cart-item-check input[type="checkbox"]').prop('checked', isChecked);
        });

        $('.cart-item-check input[type=checkbox]').click(function (){
            let length = $('.cart-item-check input[type=checkbox]').length;
            let total = $('.cart-item-check input[type=checkbox]:checked').length;
            $('.selectAll').prop('checked', length === total);
        });
    });

    $(function () {
        $('.coupon-btn').click(function () {
            $("#couponModal").css("display", "block");
        });
        $('.coupon-modal-close').click(function (){
            $('#couponModal').css("display", "none");
        });
        $('.coupon-modal-apply').click(function () {
            let url = '${pageContext.request.contextPath}/coupon/use';
            // 쿠폰 적용 로직 추가
        });
    });

    $(function () {
        $('.BaseIcon').click(function () {
            location.href = '${pageContext.request.contextPath}/mypage/home';
        });
    });
</script>


</body>
</html>
