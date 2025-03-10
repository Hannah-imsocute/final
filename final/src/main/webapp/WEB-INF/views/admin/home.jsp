<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>  <!-- 동적으로 페이지 제목 표시 -->
    <link rel="icon" href="data;base64,iVBORw0kGgo=">

    <!-- 공통 스타일 -->
    <jsp:include page="/WEB-INF/views/admin/adminimported.jsp"/>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/admin/adminheader.jsp"/>
    <jsp:include page="/WEB-INF/views/admin/adminside.jsp"/>
</header>

<main>
    <h3 id="page-title">${pageTitle}</h3>

    <!-- 동적으로 지정된 페이지의 콘텐츠 -->
    <jsp:include page="/WEB-INF/views/${contentPage}" />
</main>

</body>
</html>

