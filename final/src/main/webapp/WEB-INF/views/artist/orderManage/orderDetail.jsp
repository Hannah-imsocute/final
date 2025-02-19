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
                                <td width="160">${order.item_code}</td>
                                <td class="table-light" width="105">주문자</td>
                                <td width="160">${order.nickname}</td>
                                <td class="table-light" width="105">주문일자</td>
                                <td width="150">${order.order_date}</td>
                                <td class="table-light" width="100">주문상태</td>
                                <td width="150">${order.orderStateInfo}</td>
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
                                    <td>${Product.item_code}</td>
                                    <td class="text-start ${Product.orderState==3||Product.orderState==5?'text-line':''}">
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
                            <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/artist/orderManage/orderManagement/${tebNum}';">리스트</button>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>


</main>
</body>
</html>
