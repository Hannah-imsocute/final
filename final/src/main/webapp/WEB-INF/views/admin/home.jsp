<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Page</title>
    <link rel="icon" href="data;base64,iVBORw0kGgo=">

    <!-- 동적 스타일링 -->
    <jsp:include page="/WEB-INF/views/admin/adminimported.jsp"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/layout/admin.css' />">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/admin/adminheader.jsp"/>
    <jsp:include page="/WEB-INF/views/admin/adminside.jsp"/>
</header>

<main>
    <h2 id="page-title"></h2>

    <div id="main-content-authList-section" style="display: none;"></div>
    <div id="main-content-applyList-section" style="display: none;"></div>
    <div id="main-content-membershipList-section" style="display: none;"></div>
    <div id="main-content-paymentList-section" style="display: none;"></div>
    <div id="main-content-productList-section" style="display: none;"></div>
    <div id="main-content-eventList-section" style="display: none;"></div>
    <div id="main-content-noticeList-section" style="display: none;"></div>
    <div id="main-content-inquiryList-section" style="display: none;"></div>
    <div id="main-content-reportList-section" style="display: none;"></div>
    <div id="main-content-statsList-section" style="display: none;"></div>
</main>


<script>
    var contextPath = "<%= request.getContextPath() %>"; // JSP에서 contextPath를 JavaScript 변수로 전달
</script>

<!-- 동적 JS 파일 로드 -->
<script src="<c:url value='/dist/js/layout/adminSidebar.js' />"></script>

</body>
</html>
