<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/cart/cartlist.css">

</head>
<body>

<div class="container cart-container">
    <div class="cart-header">장바구니</div>

    <table class="table cart-table">
        <thead>
        <tr>
            <th><input type="checkbox" id="select-all"></th>
            <th>상품 정보</th>
            <th>수량</th>
            <th>가격</th>
            <th>총 가격</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <tr class="cart-item">
            <td><input type="checkbox" class="item-checkbox"></td>
            <td>
                <div class="d-flex align-items-center">
                    <img src="https://via.placeholder.com/80" alt="상품 이미지">
                    <div class="ms-3">
                        <strong>코로나 사과곰 테디 플러쉬 파우치</strong><br>
                        <small>사이즈: M</small><br>
                        <small>추가 옵션: 손잡이(₩4,000), 보관 케이스(₩5,000)</small>
                    </div>
                </div>
            </td>
            <td>
                <button class="btn btn-sm btn-light quantity-minus">-</button>
                <input type="number" class="form-control d-inline w-25 text-center quantity" value="1" min="1">
                <button class="btn btn-sm btn-light quantity-plus">+</button>
            </td>
            <td><span class="price">₩44,000</span></td>
            <td><span class="total-price price">₩44,000</span></td>
            <td><button class="btn btn-danger btn-sm remove-item">X</button></td>
        </tr>
        </tbody>
    </table>

    <div class="d-flex justify-content-between align-items-center">
        <div>
            <button class="btn btn-light btn-sm" id="remove-selected">선택 삭제</button>
        </div>
        <div class="order-summary text-end">
            <div><strong>총 주문금액:</strong> <span id="total-amount" class="price">₩44,000</span></div>
            <button class="btn btn-orange mt-2">주문하기</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 전체 선택 체크박스
        $("#select-all").on("change", function() {
            $(".item-checkbox").prop("checked", $(this).prop("checked"));
        });

        // 개별 체크박스 선택 시 전체 선택 체크 여부 확인
        $(".item-checkbox").on("change", function() {
            $("#select-all").prop("checked", $(".item-checkbox:checked").length === $(".item-checkbox").length);
        });

        // 수량 증가 / 감소 버튼
        $(".quantity-plus").click(function() {
            let input = $(this).prev(".quantity");
            let quantity = parseInt(input.val()) + 1;
            input.val(quantity);
            updateTotalPrice($(this).closest("tr"));
        });

        $(".quantity-minus").click(function() {
            let input = $(this).next(".quantity");
            let quantity = parseInt(input.val()) - 1;
            if (quantity > 0) {
                input.val(quantity);
                updateTotalPrice($(this).closest("tr"));
            }
        });

        // 수량 변경 시 총 가격 업데이트
        $(".quantity").on("input", function() {
            updateTotalPrice($(this).closest("tr"));
        });

        // 장바구니에서 상품 삭제
        $(".remove-item").click(function() {
            $(this).closest("tr").remove();
            updateTotalAmount();
        });

        // 선택된 상품 삭제
        $("#remove-selected").click(function() {
            $(".item-checkbox:checked").closest("tr").remove();
            updateTotalAmount();
        });

        // 가격 업데이트 함수
        function updateTotalPrice(row) {
            let quantity = row.find(".quantity").val();
            let price = parseInt(row.find(".price").text().replace("₩", "").replace(",", ""));
            let totalPrice = price * quantity;
            row.find(".total-price").text("₩" + totalPrice.toLocaleString());
            updateTotalAmount();
        }

        // 총 주문 금액 업데이트
        function updateTotalAmount() {
            let totalAmount = 0;
            $(".total-price").each(function() {
                totalAmount += parseInt($(this).text().replace("₩", "").replace(",", ""));
            });
            $("#total-amount").text("₩" + totalAmount.toLocaleString());
        }
    });
</script>

</body>
</html>
