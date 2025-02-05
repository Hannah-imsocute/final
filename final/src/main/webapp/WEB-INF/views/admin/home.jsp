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
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/admin.css' />">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/admin/adminheader.jsp"/>
    <jsp:include page="/WEB-INF/views/admin/adminside.jsp"/>
</header>

<main>
    <h2 id="page-title">통계 및 보고</h2>
	<!-- 여기서 페이지마다 다른 콘텐츠를 동적으로 불러오기 -->
    <div id="main-content-authList-" style="display: none;">
        <p>여기는 권한관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-applyList-" style="display: none;">
        <p>여기는 입점신청관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-membershipList-" style="display: none;">
        <p>여기는 멤버십관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-paymentList-" style="display: none;">
        <p>여기는 결제 및 정산관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-productList-" style="display: none;">
        <p>여기는 상품관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-eventList-" style="display: none;">
        <p>여기는 이벤트관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-noticeList-" style="display: none;">
        <p>여기는 공지사항관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-inquiryList-" style="display: none;">
        <p>여기는 문의사항관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-reportList-" style="display: none;">
        <p>여기는 신고관리 관리 콘텐츠입니다.</p>
    </div>
    <div id="main-content-statsList-" style="display: none;">
        <p>여기는 통계 및 보고 관리 콘텐츠입니다.</p>
    </div>
</main>

<script>
    var contextPath = "<%= request.getContextPath() %>"; // JSP에서 contextPath를 JavaScript 변수로 전달
</script>

<!-- 동적 JS 파일 로드 -->
<script src="<c:url value='/dist/js/layout/adminSidebar.js' />"></script>

</body>
</html>
