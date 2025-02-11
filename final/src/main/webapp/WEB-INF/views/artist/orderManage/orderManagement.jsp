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
                <h3><i class="bi bi-app"></i> 제목 </h3>
            </div>

            <div class="body-main">

                <div class="row board-list-header">
                    <div class="col-auto me-auto">
                        ${dataCount}개(${page}/${total_page} 페이지)
                    </div>
                    <div class="col-auto">&nbsp;</div>
                </div>

                <table class="table board-list table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>주문번호</th>
                        <th width="130">주문구분</th>
                        <th width="95">주문자</th>
                        <th width="150">주문일자</th>
                        <th width="130">결제금액</th>
                        <th width="160">${itemId==110 ? "송장번호":"주문수량"}</th>
                        <th width="85">취소요청</th>
                        <th width="85">교환요청</th>
                        <th width="85">취소완료</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="dto" items="${list}" varStatus="status">
                        <tr class="clickable"
                            onclick="location.href='${pageContext.request.contextPath}/artist/orderManage/${tebNum}/${dto.order_code}?${query}';">
                            <td>${dto.order_code}</td>
                            <td>${dto.orderStateInfo}</td>
                            <td>${dto.nickname}</td>
                            <td>${dto.order_date}</td>
                            <td><fmt:formatNumber value="${dto.netPay}"/></td>
                            <td>${tebNum==110 ? dto.trackingNumber : dto.totalQty}</td>
                            <td>${dto.cancelRequestCount}</td>
                            <td>${dto.exchangeRequestCount}</td>
                            <td>${dto.detailCancelCount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="page-navigation">
                    ${dataCount==0 ? "등록된 주문정보가 없습니다." : paging}
                </div>

                <div class="row board-list-footer">
                    <div class="col">
                        <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/order/orderManage/${itemId}';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
                    </div>
                    <div class="col-6 text-center">
                        <form class="row" name="searchForm">
                            <div class="col-auto p-1">
                                <select name="schType" class="form-select">
                                    <option value="orderNum" ${schType=="orderNum"?"selected":""}>주문번호</option>
                                    <c:if test="${itemId==110}">
                                        <option value="invoiceNumber" ${schType=="invoiceNumber"?"selected":""}>송장번호</option>
                                    </c:if>
                                    <option value="userName" ${schType=="userName"?"selected":""}>주문자</option>
                                    <option value="orderDate" ${schType=="orderDate"?"selected":""}>주문일자</option>
                                </select>
                            </div>
                            <div class="col-auto p-1">
                                <input type="text" name="kwd" value="${kwd}" class="form-control">
                            </div>
                            <div class="col-auto p-1">
                                <button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
                            </div>
                        </form>
                    </div>
                    <div class="col text-end">
                        &nbsp;
                    </div>
                </div>

            </div>
        </div>
    </div>

</main>
</body>
</html>
