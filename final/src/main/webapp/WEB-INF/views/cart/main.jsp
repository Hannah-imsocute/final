<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <!-- 예: Bootstrap, jQuery 등 공통 리소스 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <!-- Google Fonts 예시 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* 전역 기본 스타일 */
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 0;
            background-color: #f2f4f7;
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
        }
        main {
            margin-top: 140px; /* 고정 헤더 높이만큼 여백 */
        }
        /* 브레드크럼 스타일 */
        .breadcrumb-area {
            font-size: 14px;
            color: #777;
            margin-bottom: 16px;
            display: flex;
            gap: 8px;
        }
        .breadcrumb-area span {
            position: relative;
            padding-right: 10px;
        }
        .breadcrumb-area span::after {
            content: ">";
            position: absolute;
            right: 0;
            color: #ccc;
        }
        .breadcrumb-area span:last-child::after {
            content: "";
        }
        .breadcrumb-area .current {
            font-weight: 700;
            color: #222;
        }
        /* 장바구니 페이지 헤더 */
        .cart-page-header {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .cart-page-header h2 {
            margin: 0;
            font-size: 26px;
        }
        .cart-page-header .select-info {
            font-size: 14px;
            color: #666;
            margin-top: 4px;
            display: block;
        }
        .btn-delete-selected {
            background-color: transparent;
            border: 1px solid #ddd;
            padding: 8px 14px;
            border-radius: 6px;
            color: #555;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-delete-selected:hover {
            background-color: #f8f8f8;
            border-color: #ccc;
        }
        /* 장바구니 컨테이너 */
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .d-flex {
            display: flex;
        }
        /* 왼쪽 상품 리스트 영역 */
        .cart-items {
            flex-grow: 1;
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        /* 개별 상품 박스 */
        .cart-item-box {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: box-shadow 0.2s;
        }
        .cart-item-box:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .cart-item-top {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }
        .cart-item-top input[type="checkbox"] {
            margin-right: 10px;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        .cart-item-top strong {
            color: #fa7c00;
            font-size: 15px;
        }
        hr {
            border: none;
            border-top: 1px solid #f0f0f0;
            margin: 12px 0;
        }
        .cart-item-info {
            display: flex;
            gap: 16px;
        }
        .cart-item-thumb {
            width: 100px;
            height: 100px;
            border-radius: 6px;
            object-fit: cover;
            flex-shrink: 0;
        }
        .cart-item-info > div {
            flex-grow: 1;
        }
        .cart-item-title {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 4px;
        }
        .cart-item-discount {
            font-size: 14px;
            color: #e74c3c;
            margin-left: 6px;
        }
        .cart-item-extra {
            font-size: 13px;
            color: #777;
            line-height: 1.4;
            margin-top: 4px;
        }
        /* 옵션, 수량, 가격 영역 */
        .cart-item-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 12px;
            flex-wrap: wrap;
        }
        .option-btn {
            border: 1px solid #ddd;
            background-color: #fff;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .option-btn:hover {
            background-color: #f7f7f7;
        }
        .quantity-area {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        .quantity-area button {
            width: 32px;
            height: 32px;
            border: none;
            background-color: #f7f7f7;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s;
        }
        .quantity-area button:hover {
            background-color: #eaeaea;
        }
        .quantity-area input[type="number"] {
            width: 48px;
            border: none;
            text-align: center;
            font-size: 15px;
        }
        .price-text {
            font-size: 16px;
            font-weight: 600;
            color: #e67e22;
        }
        .remove-item-btn {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .remove-item-btn:hover {
            background-color: #cf3c2b;
        }
        /* 주문 요청사항 */
        .cart-item-request {
            margin-top: 12px;
        }
        .cart-item-request textarea {
            width: 100%;
            height: 70px;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
            resize: vertical;
        }
        /* 하단 금액 요약 */
        .cart-item-summary {
            display: flex;
            justify-content: space-between;
            margin-top: 16px;
            font-size: 15px;
            font-weight: 500;
        }
        .cart-item-summary .price {
            color: #e67e22;
        }
        .more-items-link {
            text-align: right;
            font-size: 14px;
            color: #888;
            margin-top: 8px;
        }
        .more-items-link a {
            color: #888;
            text-decoration: none;
            transition: color 0.2s;
        }
        .more-items-link a:hover {
            color: #555;
        }
        /* 오른쪽 주문 요약 박스 */
        .order-summary-box {
            width: 320px;
            background-color: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            height: fit-content;
        }
        .order-summary-title {
            font-weight: 700;
            margin-bottom: 20px;
            font-size: 18px;
        }
        .order-summary-line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 15px;
        }
        .order-summary-total {
            font-weight: 700;
            font-size: 18px;
            color: #e67e22;
        }
        .coupon-info {
            background-color: #fff8f0;
            border: 1px solid #ffd6a3;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
            color: #555;
            margin-bottom: 16px;
        }
        .min-order-warning {
            background-color: #fff9e8;
            border: 1px solid #ffe59e;
            border-radius: 4px;
            font-size: 14px;
            color: #555;
            padding: 10px;
            margin-bottom: 16px;
        }
        .btn-gift,
        .btn-order {
            display: inline-block;
            padding: 12px 16px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 15px;
            color: #fff;
            transition: background-color 0.2s;
            width: 48%;
            text-align: center;
        }
        .btn-gift {
            background-color: #ffa502;
        }
        .btn-gift:hover {
            background-color: #e68a00;
        }
        .btn-order {
            background-color: #e67e22;
        }
        .btn-order:hover {
            background-color: #cf6c1c;
        }
        @media screen and (max-width: 992px) {
            .d-flex {
                flex-direction: column;
            }
            .order-summary-box {
                width: 100%;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
<!-- 고정 헤더 -->
<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="cart-container">
        <!-- 브레드크럼 -->
<%--        <div class="breadcrumb-area">--%>
<%--            <span class="current">01 장바구니</span>--%>
<%--            <span>02 주문 결제</span>--%>
<%--            <span>03 주문 완료</span>--%>
<%--        </div>--%>

        <!-- 페이지 상단: 제목 및 전체선택/선택삭제 -->
        <div class="cart-page-header">
            <div>
                <h2>장바구니</h2>
                <span class="select-info">전체선택 (1/1개)</span>
            </div>
            <button class="btn-delete-selected" id="remove-selected">선택삭제</button>
        </div>

        <!-- 본문: 왼쪽 상품 리스트 + 오른쪽 주문 요약 -->
        <div class="d-flex" style="gap: 20px;">
            <!-- 왼쪽 영역: 장바구니 아이템들 -->
            <div class="cart-items">
                <!-- 개별 상품 박스 (반복 가능) -->
                <div class="cart-item-box">
                    <div class="cart-item-top">
                        <input type="checkbox" class="item-checkbox" checked>
                        <strong>디저트미닛 &gt;</strong>
                    </div>
                    <hr>
                    <div class="cart-item-info">
                        <img src="https://via.placeholder.com/100" alt="상품 이미지" class="cart-item-thumb">
                        <div>
                            <div>
                                <span class="cart-item-title">발렌타인데이 캐릭터 초콜릿</span>
                                <span class="cart-item-discount">28% 즉시할인</span>
                            </div>
                            <div class="cart-item-extra">주문시 제작<br>발렌타인 특가</div>
                            <div class="cart-item-extra" style="margin-top:8px;">
                                1. 종류: 하트강아지<br>
                                2. 예약 발송날짜: 2월11일 화요일 예약발송
                            </div>
                            <!-- 옵션/수량/가격 -->
                            <div class="cart-item-actions">
                                <button class="option-btn">옵션변경</button>
                                <div class="quantity-area">
                                    <button class="quantity-minus">−</button>
                                    <input type="number" class="quantity" value="1" min="1">
                                    <button class="quantity-plus">＋</button>
                                </div>
                                <span class="price-text">₩2,895</span>
                                <button class="remove-item-btn remove-item">삭제</button>
                            </div>
                            <!-- 주문 요청사항 -->
                            <div class="cart-item-request">
                                <textarea placeholder="주문 요청사항을 500자 내로 입력해주세요."></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- 하단 가격 요약 -->
                    <div class="cart-item-summary">
                        <div>작품 금액 <span class="price">2,895원</span></div>
                        <div>주문 금액 <span class="price">2,895원</span></div>
                    </div>
                    <div class="more-items-link">
                        <a href="#">작가님 작품 더보기</a>
                    </div>
                </div>
                <!-- // cart-item-box -->
            </div>

            <!-- 오른쪽 영역: 주문 예상 금액 -->
            <div class="order-summary-box">
                <div class="order-summary-title">주문 예상 금액</div>
                <div class="order-summary-line">
                    <span>총 작품금액</span>
                    <span id="total-amount" class="order-summary-total">0원</span>
                </div>
                <div class="order-summary-line">
                    <span>배송비</span>
                    <span style="font-size:15px;">무료배송</span>
                </div>
                <div class="coupon-info">
                    +1,200원으로 매월 4천원 쿠폰 + 최대 10% 할인
                </div>
                <div class="order-summary-line" style="margin-top:16px;">
                    <span>총 <strong id="total-count">0</strong>건 주문금액</span>
                    <span class="order-summary-total" id="order-total">0원</span>
                </div>
                <div class="min-order-warning">
                    최소 주문 금액 설정한 작가님이 있어요 (1건)
                </div>
                <div style="display: flex; gap: 4%;">
                    <button class="btn-gift">선물하기</button>
                    <button class="btn-order">0건 주문하기</button>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 푸터 -->
<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<!-- jQuery / JS 로직 예시 -->
<script>
    $(document).ready(function() {
        // [데모용] 페이지 로드시 총합 계산
        updateTotals();

        // '선택삭제' 버튼: 체크된 아이템 제거
        $("#remove-selected").click(function() {
            $(".item-checkbox:checked").closest(".cart-item-box").remove();
            updateTotals();
        });

        // 수량증가/감소
        $(".quantity-plus").click(function() {
            let $input = $(this).prev("input.quantity");
            let val = parseInt($input.val()) + 1;
            $input.val(val);
            updateTotals();
        });
        $(".quantity-minus").click(function() {
            let $input = $(this).next("input.quantity");
            let val = parseInt($input.val()) - 1;
            if (val > 0) {
                $input.val(val);
                updateTotals();
            }
        });
        // 수량 직접 입력
        $(".quantity").on("input", function() {
            if ($(this).val() <= 0) {
                $(this).val(1);
            }
            updateTotals();
        });

        // 간단한 합계 계산 로직
        function updateTotals() {
            let totalCount = 0;
            let totalPrice = 0;
            $(".cart-item-box").each(function() {
                let checked = $(this).find(".item-checkbox").is(":checked");
                if (!checked) return;

                let quantity = parseInt($(this).find(".quantity").val());
                let priceText = $(this).find(".price-text").text().replace("₩", "").replace(/,/g, "");
                let priceVal = parseInt(priceText) || 0;
                let itemTotal = quantity * priceVal;

                totalCount += 1;
                totalPrice += itemTotal;

                $(this).find(".cart-item-summary .price").text(itemTotal.toLocaleString() + "원");
            });
            $("#total-count").text(totalCount);
            $("#total-amount").text(totalPrice.toLocaleString() + "원");
            $("#order-total").text(totalPrice.toLocaleString() + "원");
            $(".btn-order").text(totalCount + "건 주문하기");
        }
    });
</script>
</body>
</html>
