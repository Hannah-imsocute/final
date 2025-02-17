<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ttshop</title>
    <link rel="icon" href="data;base64,iVBORw0kGgo=">
    <jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .post-container {
            max-width: 900px; /* 일정한 너비 유지 */
            min-width : 800px;
            min-height: 600px; /* 항상 일정한 높이 유지 */
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .post-title {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .post-date {
            color: #6c757d;
            font-size: 1rem;
            text-align: right; /* 날짜 우측 정렬 */
            margin-bottom: 20px;
        }
        .post-content {
            font-size: 1.3rem;
            line-height: 1.8;
            text-align: justify; /* 가독성 향상 */
            flex-grow: 1; /* 내용이 짧아도 일정한 공간 유지 */
            overflow-wrap: break-word; /* 긴 단어가 넘치지 않도록 설정 */
        }
    </style>
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
        <jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
    </header>

    <main style="width: 80%; margin-top: 150px; margin-left: auto; margin-right: auto; display: flex; justify-content: center;">
        <div class="post-container">
            <h2 class="post-title">📌 ${dto.subject }</h2>
            <p class="post-date">작성일: ${dto.create_date}</p>
            <div class="post-content">
               ${dto.textcontent}
            </div>
        </div>
    </main>

    <script type="text/javascript"></script>
</body>
</html>
