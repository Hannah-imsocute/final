<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>카카오 회원가입 성공</title>
</head>
<body>
<h1>회원가입이 완료되었습니다!</h1>
<p>다음은 가입된 사용자 정보입니다:</p>
<ul>
    <li><strong>사용자 ID:</strong> ${kakaoInfo.id}</li>
    <li><strong>닉네임:</strong> ${kakaoInfo.nickName}</li>
</ul>
<a href="${pageContext.request.contextPath}/main/list">홈으로 돌아가기</a>
</body>
</html>