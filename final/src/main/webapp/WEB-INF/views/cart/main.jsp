<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        * { box-sizing: border-box; }
        body {
            margin: 0;
            background: #f3f3f3;
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
        }
        header { position: relative !important; }
        main { margin-top: 0; }
        /* 컨테이너 */
        .cart-page {
            max-width: 1200px;
            margin: 20px auto 60px;
            padding: 0 20px;
        }
        /* 단계 표시 */
        .cart-steps {
            margin-bottom: 20px;
            font-size: 14px;
            color: #999;
            text-align: right;
        }
        .cart-steps ol { list-style: none; display: inline-flex; gap: 10px; padding: 0; margin: 0; }
        .cart-steps li.current { font-weight: bold; color: #333; }
        .cart-title { font-size: 28px; font-weight: bold; margin-bottom: 5px; }
        /* 전체선택, 선택삭제 */
        .cart-actions {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 10px; color: #666; font-size: 14px;
        }
        .cart-actions .left-actions { display: flex; align-items: center; gap: 10px; }
        .cart-actions input[type="checkbox"] { transform: scale(1.2); }
        .cart-actions .right-actions button {
            background: none; border: 1px solid #ddd; padding: 6px 12px;
            border-radius: 5px; cursor: pointer;
        }
        .cart-actions .right-actions button:hover { background: #f7f7f7; }
        /* 레이아웃 (좌: 상품목록, 우: 결제요약) */
        .cart-content { display: flex; gap: 20px; }
        .cart-left { flex: 3; }
        .cart-right { flex: 1; }
        /* 카드 스타일 */
        .cart-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 20px; margin-bottom: 20px;
        }
        /* 상품 컨테이너 */
        .cart-item-block {
            border-top: 1px solid #eee;
            padding-top: 15px; margin-top: 15px;
        }
        .cart-item-block:first-child { border-top: none; padding-top: 0; margin-top: 0; }
        /* 스토어명 및 아이콘 */
        .store-info { display: inline-flex; align-items: center; gap: 5px; margin-bottom: 5px; }
        .store-name { font-size: 14px; font-weight: bold; color: #666; }
        /* 상품 정보 */
        .cart-item-row {
            display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
        }
        .cart-item-check input[type="checkbox"] { transform: scale(1.2); }
        .cart-item-image img {
            width: 80px; height: 80px; object-fit: cover; border-radius: 5px;
        }
        .cart-item-details { flex: 1; }
        .item-title { font-size: 15px; font-weight: bold; margin-bottom: 4px; }
        .item-option { font-size: 13px; color: #888; }
        /* 수량, 가격, 삭제버튼 */
        .cart-item-right {
            display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
        }
        .item-quantity {
            display: flex; align-items: center; gap: 5px;
        }
        .btn-qty {
            width: 32px; height: 32px;
            border: 1px solid #ddd; background: #fff;
            cursor: pointer; font-size: 16px;
        }
        .input-qty {
            width: 50px; height: 32px;
            text-align: center; border: 1px solid #ddd;
            border-radius: 4px; font-size: 15px;
        }
        /* 가격 및 삭제 버튼 */
        .price-and-delete { display: flex; align-items: center; gap: 8px; }
        .item-price { font-size: 16px; font-weight: bold; }
        .item-delete button {
            width: 20px; height: 20px;
            background: url('https://cdn-icons-png.flaticon.com/512/458/458595.png') no-repeat center center;
            background-size: contain; border: none; cursor: pointer;
        }
        .item-delete button:hover { opacity: 0.7; }
        /* 상품별 footer (동적 업데이트 대상) */
        .cart-card-footer {
            margin-top: 10px; padding-top: 10px;
            border-top: 1px solid #eee;
            display: flex; align-items: center; gap: 20px; font-size: 14px; flex-wrap: wrap;
        }
        .cart-card-footer .label { color: #999; }
        .cart-card-footer .value { font-weight: bold; }
        .cart-card-footer .divider { margin: 0 10px; color: #ccc; }
        .cart-card-footer .shipping { color: #ff8200; }
        /* footer 내 개별 금액 업데이트를 위해 클래스 추가 */
        .footer-product-amount { }
        .discount-amount { }
        .footer-order-amount { }
        .price-text {
            font-size: 18px; font-weight: bold; color: #333; letter-spacing: -0.5px;
        }
        /* 우측 결제정보 박스 */
        .order-summary {
            background-color: #fff; border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 20px;
        }
        .order-summary h3 { margin-top: 0; font-size: 18px; margin-bottom: 20px; }
        .summary-item {
            display: flex; justify-content: space-between; margin-bottom: 8px;
        }
        .summary-item .label { color: #666; }
        .summary-item .value { font-weight: bold; font-size: 15px; }
        .discount-info { color: #f05; font-size: 14px; }
        .summary-total {
            font-size: 18px; font-weight: bold; margin-top: 20px;
            border-top: 1px solid #eee; padding-top: 15px;
        }
        /* 구매하기 버튼 */
        .btn-checkout {
            display: block; width: 100%; margin-top: 15px; padding: 14px 0;
            background: #ff8200; color: #fff; border: none; border-radius: 6px;
            font-size: 16px; cursor: pointer; text-align: center;
        }
        .btn-checkout:hover { background: #ff6600; }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .cart-page { padding: 0 10px; }
            .cart-content { flex-direction: column; }
            .cart-right { order: -1; margin-bottom: 20px; }
            .cart-item-row, .cart-item-right, .cart-card-footer {
                flex-direction: column; align-items: flex-start;
            }
            .item-quantity { margin-bottom: 10px; }
            .price-and-delete {
                justify-content: space-between; width: 100%;
            }
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<!-- 전체 장바구니 목록을 하나의 폼으로 감싸기 -->
<form name="cartForm" action="${pageContext.request.contextPath}/order/form" method="post">
    <!-- 폼 제출 시 최종 금액을 함께 넘기기 위해 히든필드 추가 -->
    <input type="hidden" name="finalTotalPrice" id="finalTotalPrice" value="0" />

    <main class="cart-page">
        <!-- 장바구니 단계 -->
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
                    <input type="checkbox" class="selectAll" checked/> 전체선택 (
                    <c:out value="${fn:length(cartList)}"/> / <c:out value="${fn:length(cartList)}"/> 개 )
                </label>
            </div>
            <div class="right-actions">
                <button type="button" class="btnSelectRemove">선택삭제</button>
            </div>
        </div>

        <!-- 장바구니 목록 -->
        <div class="cart-content">
            <div class="cart-left">
                <c:if test="${empty cartList}">
                    <div class="cart-card" style="text-align:center;">
                        <p>장바구니가 비어 있습니다.</p>
                    </div>
                </c:if>

                <c:if test="${not empty cartList}">
                    <div class="cart-card">
                        <c:forEach var="cart" items="${cartList}">
                            <!-- 서버에서 초기 계산 (화면 표시용) -->
                            <c:set var="lineTotal" value="${cart.quantity * cart.price}"/>
                            <c:set var="discountRate" value="${cart.discount != null ? cart.discount : 0}" />
                            <c:set var="discountAmount" value="${(lineTotal * discountRate) / 100}" />
                            <c:set var="finalPrice" value="${lineTotal - discountAmount}" />

                            <div class="cart-item-block">
                                <!-- 상품 정보 -->
                                <div class="store-info">
                                    <span class="store-name">${cart.brandName}</span>
                                    <svg data-v-6d2bd019="" data-v-ec764313=""
                                         width="24" height="24" viewBox="0 0 24 24"
                                         xmlns="http://www.w3.org/2000/svg" class="BaseIcon"
                                         style="width: 24px; height: 24px; opacity: 1; fill: currentcolor;">
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
                                <div class="cart-item-row">
                                    <div class="cart-item-check">
                                        <input type="checkbox" name="cartItemCode" value="${cart.cartItemCode}" checked/>
                                    </div>
                                    <div class="cart-item-image">
                                        <img src="#" alt="상품이미지">
                                    </div>
                                    <div class="cart-item-details">
                                        <div class="item-title">
                                            <c:out value="${cart.item}"/>
                                        </div>
                                        <div class="item-option">
                                            <c:out value="${cart.optionName != null ? cart.optionName : '옵션없음'}"/>
                                        </div>
                                    </div>
                                    <div class="cart-item-right">
                                        <!-- 수량 조절 -->
                                        <div class="item-quantity">
                                            <button type="button" class="btn-qty quantity-minus">-</button>
                                            <!-- 여기서 할인율을 JS로 넘기기 위해 data-discountrate 추가 -->
                                            <input type="number" class="input-qty"
                                                   value="${cart.quantity}"
                                                   min="1"
                                                   readonly
                                                   data-cartitemcode="${cart.cartItemCode}"
                                                   data-oldprice="${cart.price}"
                                                   data-discountrate="${discountRate}" />
                                            <button type="button" class="btn-qty quantity-plus">+</button>
                                        </div>
                                        <!-- 가격 및 삭제 (서버 계산값으로 초기 표시) -->
                                        <div class="price-and-delete">
                                            <!-- 상품금액(수량x단가)의 표기. (할인 전 금액) -->
                                            <div class="item-price price-text">
                                                <fmt:formatNumber value="${lineTotal}" pattern="#,###" />원
                                            </div>
                                            <div class="item-delete">
                                                <button type="button" onclick="deleteCartItem(${cart.cartItemCode})"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 상품별 footer (동적 업데이트 대상) -->
                                <div class="cart-card-footer">
                                    <div>
                                        <span class="label">상품금액</span>
                                        <span class="value footer-product-amount price-text">
                                            <fmt:formatNumber value="${lineTotal}" pattern="#,###" />원
                                        </span>
                                    </div>
                                    <span class="divider">|</span>
                                    <div>
                                        <span class="label">할인금액</span>
                                        <span class="value price-text discount-amount" style="color:#f05;">
                                            <fmt:formatNumber value="${discountAmount}" pattern="#,###" />원
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
                                        <span class="value footer-order-amount final-price price-text">
                                            <fmt:formatNumber value="${finalPrice}" pattern="#,###" />원
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="productCode" value="${cart.productCode}">
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <!-- 우측 결제정보 요약 (서버에서 기본 합계, JS에서 변경 시 동적 업데이트) -->
            <div class="cart-right">
                <div class="order-summary">
                    <h3>결제정보</h3>
                    <!-- 초기값: JSP에서 간단 계산 (할인 없이) -->
                    <c:set var="sumLineTotal" value="0" scope="page"/>
                    <c:set var="sumDiscount" value="0" scope="page"/>
                    <c:forEach var="citem" items="${cartList}">
                        <c:set var="lineTotal" value="${citem.quantity * citem.price}" />
                        <c:set var="discountRate" value="${citem.discount != null ? citem.discount : 0}" />
                        <c:set var="lineDiscount" value="${(lineTotal * discountRate) / 100}" />
                        <c:set var="sumLineTotal" value="${sumLineTotal + lineTotal}" scope="page" />
                        <c:set var="sumDiscount" value="${sumDiscount + lineDiscount}" scope="page" />
                    </c:forEach>
                    <c:set var="initFinalSum" value="${sumLineTotal - sumDiscount}" />

                    <div class="summary-item">
                        <span class="label">상품수</span>
                        <span class="value">
                            <c:out value="${fn:length(cartList)}"/>개
                        </span>
                    </div>
                    <div class="summary-item">
                        <span class="label">상품금액</span>
                        <span class="value price-text" id="summaryLineTotal">
                            <fmt:formatNumber value="${sumLineTotal}" pattern="#,###" />원
                        </span>
                    </div>
                    <div class="summary-item">
                        <span class="label">할인금액</span>
                        <span class="value discount-info" id="summaryDiscount">
                            <fmt:formatNumber value="${sumDiscount}" pattern="#,###" />원
                        </span>
                    </div>
                    <div class="summary-item">
                        <span class="label">배송비</span>
                        <span class="value">0원</span>
                    </div>
                    <div class="summary-total">
                        총 결제금액:
                        <span style="float:right;" class="price-text" id="summaryFinalPrice">
                            <fmt:formatNumber value="${initFinalSum}" pattern="#,###" />원
                        </span>
                    </div>
                    <!-- 구매하기 버튼: 폼의 submit 버튼 -->
                    <button type="submit" class="btn-checkout">구매하기</button>
                </div>
            </div>
        </div>
    </main>
</form>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<script>
    /* Ajax 함수 (공용) */
    function ajaxFun(url, method, formData, dataType, fn, file = false) {
        const settings = {
            type: method,
            data: formData,
            dataType: dataType,
            success: function(data) { fn(data); },
            error: function(jqXHR) { console.log(jqXHR.responseText); }
        };
        if(file){
            settings.processData = false;
            settings.contentType = false;
        }
        $.ajax(url, settings);
    }

    /**
     * 장바구니 전체 합계/할인을 다시 계산하여 우측 요약영역, 히든필드에 반영
     */
    function updateTotalPrice() {
        let sumLineTotal = 0;   // 전체 상품금액 (할인 전)
        let sumDiscount = 0;    // 전체 할인
        let sumFinal = 0;       // 최종결제금액(=합계-할인)

        // 각 상품블록을 순회하면서 할인 계산
        $('.cart-item-block').each(function () {
            let $input = $(this).find('.input-qty');
            let quantity = parseInt($input.val());
            let oldPrice = parseInt($input.data('oldprice'));
            let discountRate = parseInt($input.data('discountrate')) || 0;

            let lineTotal = quantity * oldPrice;
            let discountAmount = Math.floor(lineTotal * (discountRate / 100));
            let finalPrice = lineTotal - discountAmount;

            sumLineTotal += lineTotal;
            sumDiscount += discountAmount;
            sumFinal += finalPrice;
        });

        // 우측 영역 갱신
        $('#summaryLineTotal').text(sumLineTotal.toLocaleString() + '원');
        $('#summaryDiscount').text(sumDiscount.toLocaleString() + '원');
        $('#summaryFinalPrice').text(sumFinal.toLocaleString() + '원');

        // form 전송 시 넘기기 위해 히든필드에도 저장
        $('#finalTotalPrice').val(sumFinal);
    }

    /**
     * 개별 항목의 수량이 바뀌었을 때(서버 update 후) 해당 블록의 표시값 & 전체요약을 다시 계산/갱신
     */
    function updateItemLineUI($cartItemBlock, newQty) {
        let $input = $cartItemBlock.find('.input-qty');
        $input.val(newQty);

        let oldPrice = parseInt($input.data('oldprice'));
        let discountRate = parseInt($input.data('discountrate')) || 0;

        let lineTotal = newQty * oldPrice;
        let discountAmount = Math.floor(lineTotal * (discountRate / 100));
        let finalPrice = lineTotal - discountAmount;

        // 1) 상품 블록 내의 금액들 표시
        $cartItemBlock.find('.item-price').text(lineTotal.toLocaleString() + '원');          // (상단) 상품금액
        $cartItemBlock.find('.footer-product-amount').text(lineTotal.toLocaleString() + '원'); // (footer) 상품금액
        $cartItemBlock.find('.discount-amount').text(discountAmount.toLocaleString() + '원');  // (footer) 할인금액
        $cartItemBlock.find('.final-price').text(finalPrice.toLocaleString() + '원');         // (footer) 최종금액

        // 2) 우측 요약 영역 & 히든필드도 재계산
        updateTotalPrice();
    }

    // 수량 감소 버튼
    $('.quantity-minus').click(function () {
        let $input = $(this).siblings('.input-qty');
        let currentQty = parseInt($input.val());
        if(currentQty > 1) {
            let newQty = currentQty - 1;
            let cartItemCode = $input.data('cartitemcode');

            // Ajax로 서버에 업데이트
            let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
            let formData = { cartItemCode: cartItemCode, quantity: newQty };
            ajaxFun(url, 'post', formData, 'json', function(data){
                if(data.status === 'success'){
                    // 화면에 표시값 갱신
                    let $block = $input.closest('.cart-item-block');
                    updateItemLineUI($block, newQty);
                } else {
                    alert('업데이트 실패: ' + data.message);
                }
            });
        }
    });

    // 수량 증가 버튼
    $('.quantity-plus').click(function () {
        let $input = $(this).siblings('.input-qty');
        let currentQty = parseInt($input.val());
        let newQty = currentQty + 1;
        let cartItemCode = $input.data('cartitemcode');

        // Ajax로 서버에 업데이트
        let url = '${pageContext.request.contextPath}/cart/updateQuantity1';
        let formData = { cartItemCode: cartItemCode, quantity: newQty };
        ajaxFun(url, 'post', formData, 'json', function(data){
            if(data.status === 'success'){
                // 화면 갱신
                let $block = $input.closest('.cart-item-block');
                updateItemLineUI($block, newQty);
            } else {
                alert('업데이트 실패: ' + data.message);
            }
        });
    });

    // 선택삭제 버튼
    $(function () {
        $('.btnSelectRemove').click(function () {
            let selectedItems = [];
            // 주의: 버튼이 submit이 아니라 type=button이므로 별도 폼이 필요하면 만들어주세요.
            // 여기서는 예시이므로 "btnForm" 폼 등이 있다고 가정하셨던 부분.
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

    // 전체선택/해제
    $(function () {
        $('.selectAll').click(function () {
            let isChecked = $(this).prop("checked");
            $('.cart-item-check input[type="checkbox"]').prop("checked", isChecked);
        });
        $('.cart-item-check input[type=checkbox]').click(function (){
            let length = $('.cart-item-check input[type="checkbox"]').length;
            let total = $('.cart-item-check input[type="checkbox"]:checked').length;
            $('.selectAll').prop("checked", length === total);
        });
    });

    // 로고 아이콘 클릭 -> 페이지 이동 예시
    $(function () {
        $('.BaseIcon').click(function () {
            location.href = '${pageContext.request.contextPath}/mypage/home';
        });

        // 폼 submit 시 체크된 cartItemCode가 하나라도 있는지 검사
        $("form[name='cartForm']").on("submit", function(e) {
            if ($("input[name='cartItemCode']:checked").length === 0) {
                e.preventDefault();
                alert("선택된 상품이 없습니다.");
                return false;
            }
        });
    });

    // 개별 삭제 (1개)
    function deleteCartItem(cartItemCode){
        if(! confirm('상품을 삭제하시겠습니까?')) {
            return false;
        }
        let url = '${pageContext.request.contextPath}/cart/delete';
        let params = { cartItemCode: cartItemCode };
        const fn = function (data) {
            if(data.status === 'success') {
                alert('상품이 삭제되었습니다.');
                // DOM에서 해당 block 제거
                $('input[name="cartItemCode"][value="' + cartItemCode + '"]')
                    .closest('.cart-item-block')
                    .remove();
                // 합계 재계산
                updateTotalPrice();
            } else {
                alert('삭제에 실패하였습니다: ' + data.message);
            }
        }
        ajaxFun(url, 'post', params, 'json', fn);
    }

    // 페이지 로딩완료 시, JS로 최종합계 한 번 세팅(수정/삭제 후 재접속 등 대비)
    $(document).ready(function(){
        updateTotalPrice();
    });
</script>
</body>
</html>
