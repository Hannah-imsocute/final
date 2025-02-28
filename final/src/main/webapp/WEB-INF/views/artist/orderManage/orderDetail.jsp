<%--
  Created by IntelliJ IDEA.
  User: ujinjo
  Date: 2025. 2. 5.
  Time: 오후 2:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>


    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/boot-board.css" type="text/css">
    <jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>
</header>
<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>
<main>
    <div class="wrapper">
        <div class="body-container">
            <div class="body-title">
                <h3><i class="bi bi-app"></i> 주문 현황 </h3>
            </div>

            <div class="body-main">

                <div class="mt-3">
                    <div class="p-3 shadow bg-body rounded">
                        <p class="fs-6 fw-semibold mb-0">주문 정보</p>
                    </div>
                    <div class="mt-3 p-2">
                        <table class="table table-bordered mb-1">
                            <tr>
                                <td class="table-light" width="100">주문번호</td>
                                <td width="160">${order.order_code}</td>
                                <td class="table-light" width="105">주문자</td>
                                <td width="160">${order.nickname}</td>
                                <td class="table-light" width="105">주문일자</td>
                                <td width="150">${order.order_date}</td>
                                <td class="table-light" width="100">주문상태</td>
                                <td width="150">${Product.orderStateInfo}</td>
                            </tr>
                            <tr>
                                <td class="table-light">결제 금액</td>
                                <td class="text-primary"><fmt:formatNumber value="${order.totalMoney}"/></td>
                                <td class="table-light">결제 금액</td>
                                <td class="text-primary"><fmt:formatNumber value="${order.netPay}"/></td>
                                <td class="table-light">취소금액</td>
                                <td class="text-primary"><fmt:formatNumber value="${order.refund_amount}"/></td>
                                <td class="table-light"></td>
                                <td class="text-warning order-cancelAmount" data-cancelAmount="${order.refund_amount}">

                                </td>
                            </tr>
                            <tr>
                                <td class="table-light">배송비</td>
                                <td class="text-primary"><fmt:formatNumber value="${order.shipping}"/></td>
                                <td class="table-light">배송업체</td>
                                <td>${order.company_name}</td>
                                <td class="table-light">송장번호</td>
                                <td>${order.trackingNumber}</td>
                                <td class="table-light"></td>
                                <td>${order.orderStateDate}</td>
                            </tr>
                            <tr>
                                <td class="table-light">결제구분</td>
                                <td>${order.payMethod}</td>
                                <td class="table-light">결제카드</td>
                                <td>${order.cardName}</td>
                                <td class="table-light">결제승인번호</td>
                                <td>${order.authNumber}</td>
                                <td class="table-light">승인일자</td>
                                <td>${order.authDate}</td>
                            </tr>
                        </table>
                        <table class="table table-borderless mb-1">
                            <tr>
                                <td width="50%">
                                    <c:if test="${order.orderState < 3 || order.orderState == 9}">
                                        <button type="button" class="btn btn-light btn-cancel-order">판매취소</button>
                                    </c:if>
                                    <c:if test="${order.orderState >= 2 && order.orderState <= 5}">
                                        <button type="button" class="btn btn-light btn-delivery-detail">배송지</button>
                                    </c:if>
                                </td>
                                <td class="text-end">
                                    <c:if test="${order.orderState == 1 || order.orderState == 9}">
                                        <button type="button" class="btn btn-light btn-prepare-order">발송처리</button>
                                    </c:if>

                                    <div class="row justify-content-end delivery-update-area">
                                        <c:if test="${ (order.orderState > 1 && order.orderState < 5) }">
                                            <div class="col-auto">
                                                <select class="form-select delivery-select">
                                                    <option value="2" ${order.orderState==2?"selected":"" }>발송준비</option>
                                                    <option value="3" ${order.orderState==3?"selected":"" }>배송시작</option>
                                                    <option value="4" ${order.orderState==4?"selected":"" }>배송중</option>
                                                    <option value="5" ${order.orderState==5?"selected":"" }>배송완료</option>
                                                </select>
                                            </div>
                                            <div class="col-auto">
                                                <button type="button" class="btn btn-light btn-delivery-order">배송변경</button>
                                            </div>
                                        </c:if>
                                        <c:if test="${order.orderState == 5}">
                                            <div class="col-auto">
                                                <label>배송완료 일자 : ${order.orderStateDate}</label>
                                            </div>
                                        </c:if>
                                        <input type="hidden" name="item_code"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="mt-2 pt-2">
                    <div class="p-3 shadow bg-body rounded">
                        <p class="fs-6 fw-semibold mb-0">주문 상세정보</p>
                    </div>
                    <div class="mt-3 p-3 pb-0">
                        <table class="table board-list order-detail-list">
                            <thead class="table-light">
                            <tr>
                                <th width="75">상세번호</th>
                                <th>상품명</th>
                                <th width="90">상품가격</th>
                                <th width="90">할인가격</th>
                                <th width="130">옵션</th>
                                <th width="75">주문수량</th>
                                <th width="100">주문총금액</th>
                                <th width="70">적립금</th>
                                <th width="110">주문상태</th>
                                <th width="50">변경</th>
                            </tr>
                            </thead>

                            <tbody>
                                <tr valign="middle" id="orderDetail-list${Product.item_code}">
                                    <td>${Product.item_code}
                                    </td>
                                    <td class="text-start ${Product.orderState==3||Product.orderState==5?'text-line':''}">
                                        <img src="${pageContext.request.contextPath}/uploads/product/${Product.thumbnail}" width="60"height="55">
                                            ${Product.item}

                                    </td>
                                    <td class="${Product.orderState==3||Product.orderState==5?'text-line':''}"><fmt:formatNumber value="${Product.price}"/></td>
                                    <td class="${Product.orderState==3||Product.orderState==5?'text-line':''}"><fmt:formatNumber value="${Product.salePrice}"/></td>
                                    <td class="${Product.orderState==3||Product.orderState==5?'text-line':''}">
                                      ${Product.optionValue}

                                    </td>
                                    <td class="${Product.detailState==3||Product.detailState==5?'text-line':''}">${Product.qty}</td>
                                    <td class="${Product.detailState==3||Product.detailState==5?'text-line':''}"><fmt:formatNumber value="${Product.productMoney}"/></td>
                                    <td class="${Product.detailState==3||Product.detailState==5?'text-line':''}"><fmt:formatNumber value="${Product.savedMoney}"/></td>
                                    <td>
                                            ${(Product.orderState==1||Product.orderState==7||Product.orderState==9) && Product.detailState==0?"상품준비중":Product.detailStateInfo}
                                    </td>
                                    <td>
<%--										<span class="orderDetailStatus-update"--%>
<%--                                              data-item_code="${order.item_code}"--%>
<%--                                              data-orderState="${order.orderState}"--%>
<%--                                              data-usedSaved="${order.usedSaved}"--%>
<%--                                              data-userId="${order.userId}"--%>
<%--                                              data-payment="${order.payment}"--%>
<%--                                              data-orderDate="${order.orderDate}"--%>
<%--                                              data-productMoney="${dto.productMoney}"--%>
<%--                                              data-orderDetailNum="${dto.orderDetailNum}"--%>
<%--                                              data-productNum="${dto.productNum}"--%>
<%--                                              data-optionCount="${dto.optionCount}"--%>
<%--                                              data-detailNum="${dto.detailNum}"--%>
<%--                                              data-detailNum2="${dto.detailNum2}"--%>
<%--                                              data-savedMoney="${dto.savedMoney}"--%>
<%--                                              data-qty="${dto.qty}"--%>
<%--                                              data-detailState="${dto.detailState}">수정</span>--%>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <table class="table table-borderless">
                    <tr>
                        <td width="50%">
                            <button type="button" class="btn btn-light">이전주문</button>
                            <button type="button" class="btn btn-light">다음주문</button>
                        </td>
                        <td class="text-end">
                            <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/artist/orderManage/${tebNum}';">리스트</button>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>


</main>
<!-- 주문상세정보-상태변경/상태확인 대화상자  -->
<div class="modal fade" id="orderDetailStateDialogModal" tabindex="-1" aria-labelledby="orderDetailStateDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderDetailStateDialogModalLabel">주문상세정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-1">
                <div class="mt-1 p-1">
                    <div class="p-1"><p class="form-control-plaintext optionDetail-value"></p></div>
                    <table class="table board-list">
                        <thead class="table-light">
                        <tr>
                            <td width="50">코드</td>
                            <td width="120">구분</td>
                            <td width="90">작성자</td>
                            <td width="120">날짜</td>
                            <td>설명</td>
                        </tr>
                        </thead>
                        <tbody class="detailState-list"></tbody>
                    </table>
                </div>

                <div class="p-1 detailStateUpdate-form">
                    <form name="detailStateForm" class="row justify-content-center">
                        <div class="col-auto p-1">
                            <select name="detailState" class="form-select"></select>
                        </div>
                        <div class="col-8 p-1">
                            <input type="text" name="stateMemo" class="form-control" placeholder="상태 메시지 입력">
                        </div>
                        <div class="col-auto p-1">
                            <input type="hidden" name="orderNum">
                            <input type="hidden" name="orderDetailNum">
                            <input type="hidden" name="productNum">
                            <input type="hidden" name="usedSaved">
                            <input type="hidden" name="payment">
                            <input type="hidden" name="userId">
                            <input type="hidden" name="orderDate">
                            <input type="hidden" name="optionCount">
                            <input type="hidden" name="detailNum">
                            <input type="hidden" name="detailNum2">
                            <input type="hidden" name="qty">
                            <input type="hidden" name="productMoney">
                            <input type="hidden" name="savedMoney">
                            <input type="hidden" name="cancelAmount">
                            <button type="button" class="btn btn-light btnDetailStateUpdateOk"> 변경 </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 발송처리 대화상자 -->
<div class="modal fade" id="prepareDialogModal" tabindex="-1" aria-labelledby="prepareDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="prepareDialogModalLabel">발송처리</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-1">
                <div class="row">
                    <div class="col">
                        <p class="form-control-plaintext">
                            배송지 : (${shippingInfo.postCode}) ${shippingInfo.addrTitle} ${shippingInfo.addrDetail}
                        </p>
                    </div>
                </div>
                <form class="row text-center" name="invoiceNumberForm" method="post">
                    <div class="col-auto p-1">
                        <select name="deliveryName" class="form-select">
                            <c:forEach var="vo" items="${listDeliveryCompany}" varStatus="status">
                                <option value="${status.index + 1}">${vo.DELIVERYNAME}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col p-1">
                        <input name="invoiceNumber" type="text" class="form-control" placeholder="송장번호입력">
                    </div>
                    <div class="col-auto p-1">
                        <input type="hidden" name="orderNum" value="${Product.item_code}">
                        <input type="hidden" name="orderState" value="2">

                        <button type="button" class="btn btnInvoiceNumberOk">등록완료</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 배송지 대화상자 -->
<div class="modal fade" id="deliveryDialogModal" tabindex="-1" aria-labelledby="deliveryDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 700px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deliveryDialogModalLabel">배송지 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-1">
                <table class="table table-bordered">
                    <tr valign="middle">
                        <th class="table-light" width="100">주문번호</th>
                        <td width="250">
                            <p class="form-control-plaintext">${order.item_code}</p>
                        </td>
                        <th class="table-light" width="100">주문자</th>
                        <td width="250">
                            <p class="form-control-plaintext">${order.nickname}</p>
                        </td>
                    </tr>
                    <tr valign="middle">
                        <th class="table-light" width="100">구매상품</th>
                        <td colspan="3">
                            <c:forEach var="dto" items="${listDetail}" varStatus="status">
                                <c:if test="${dto.detailState < 3 || dto.detailState > 5 }">
                                    <p class="form-control-plaintext">
                                            ${dto.productName}
                                        <c:choose>
                                            <c:when test="${dto.optionCount==1}">(${dto.optionValue})</c:when>
                                            <c:when test="${dto.optionCount==2}">(${dto.optionValue} / ${dto.optionValue2})</c:when>
                                        </c:choose>
                                    </p>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr valign="middle">
                        <th class="table-light">받는사람</th>
                        <td>
                            <p class="form-control-plaintext">${shippingInfo.addrName}</p>
                        </td>
                        <th class="table-light">전화번호</th>
                        <td>
                            <p class="form-control-plaintext">${shippingInfo.phone}</p>
                        </td>
                    </tr>
                    <tr valign="middle">
                        <th class="table-light">주소</th>
                        <td colspan="3">
                            <p class="form-control-plaintext">(${shippingInfo.postCode}) ${shippingInfo.addrTitle} ${shippingInfo.addrDetail}</p>
                        </td>
                    </tr>
                    <tr valign="middle">
                        <th class="table-light">배송메모</th>
                        <td colspan="3">
                            <p class="form-control-plaintext">${shippingInfo.require}</p>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light btn-delivery-print">배송지 인쇄</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function (){

    $('.btn-prepare-order').on('click',function (){
        $('#prepareDialogModal').modal('show');
    });

    //송장번호 등록
    $('.btnInvoiceNumberOk').click(function (){
        let requestCount = '${order.cancelRequestCount}';

        if (requestCount !== '0'){
            alert('주문취소를 처리한 후 발송처리가 가능합니다.');
            return false;
        }
        const f = document.invoiceNumberForm;
        if (! f.invoiceNumber.value.trim()){
            alert('송장 번호를 입력하세요');
            return false;
        }
        let requestParams = $('form[name=invoiceNumberForm]').serialize();
        let url = '${pageContext.request.contextPath}/artist/orderManage/invoiceNumber';



        const fn = function (data){

            if (data.state =='true'){
                $("#prepareDialogModal").modal("hide");

                let reloadUrl = '${pageContext.request.contextPath}/artist/orderManage/${tebNum}';
                location.href = reloadUrl;
                console.log("asdfsadfas",data)

            }else {
                alert('발송처리가 실패 했습니다.');
            }
        };


        ajaxRequest(url,'post',requestParams,'json',fn);


    })


})

// 배송 변경(배송중/배송완료)
$(function(){
    $('.btn-delivery-order').on('click', function() {

        const $EL = $(this);
        let orderNum = '${Product.item_code}';
        let preState = '${order.orderState}';

        let orderState = $EL.closest('.delivery-update-area').find('select').val();
        let orderStateInfo = $EL.closest('.delivery-update-area').find('select option:selected').text();
        if(preState >= orderState) {
            alert('배송 변경은 현 배송 단계보다 적거나 같을수 없습니다.');
            return false;
        }
        let requestParams = 'item_code=' + orderNum + '&orderState=' + orderState;
        let url = '${pageContext.request.contextPath}/artist/orderManage/delivery';
        console.log(url)
        console.log(requestParams+"requestParams")
        const fn = function(data) {
            console.log(data.state)
            if(data.state === 'true') {

                let reloadUrl = '${pageContext.request.contextPath}/artist/orderManage/${tebNum}';
                location.href = reloadUrl;
            }
        };

        ajaxRequest(url, 'post', requestParams, 'json', fn)


    });
});




$(function(){
    $('.btn-delivery-detail').click(function(){
        $('#deliveryDialogModal').modal('show');
    });
});

$('#deliveryDialogModal').on('hide.bs.modal', function () {
    $('button, input, select, textarea, div').each(function () {
        $(this).blur();
    });
});

</script>
</body>
</html>
