<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ttshop 게시물</title>
    <link rel="icon" href="data:image/png;base64,iVBORw0KGgo=">
    <jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
    <!-- Google Fonts (원하는 폰트 적용) -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }
        header {
            margin-bottom: 30px;
        }
        main {
            width: 80%;
            margin: 150px auto;
            display: flex;
            justify-content: center;
        }
        .post-container {
            width: 100%;
            max-width: 900px;
            min-width: 800px;
            min-height: 600px;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }
        .post-title {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .post-date {
            color: #6c757d;
            font-size: 0.9rem;
            text-align: right;
            margin-bottom: 20px;
        }
        .post-content {
            font-size: 1.1rem;
            line-height: 1.8;
            text-align: justify;
            overflow-wrap: break-word;
        }
        /* 모바일 대응 */
        @media (max-width: 1024px) {
            .post-container {
                min-width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
        <jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
    </header>

    <main>
        <div class="post-container">
            <h2 class="post-title">📌 ${dto.subject}</h2>
            <p class="post-date">작성일: ${dto.create_date}</p>
            <div class="post-content">
                ${dto.textcontent}
            </div>
        </div>
    </main>

    <script type="text/javascript">
        // 필요에 따라 JavaScript 추가
    </script>
</body>
</html>
