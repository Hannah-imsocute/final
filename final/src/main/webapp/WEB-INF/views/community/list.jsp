<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boooooot</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin-top: 50px;
            padding-top: 50px;
            background-color: #f8f8f8;
        }
        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            max-width: 1200px;
            margin: 20px auto;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card img {
            width: 100%;
            height: auto;
            display: block;
        }
        .card .content {
            padding: 15px;
        }
        .title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .description {
            font-size: 14px;
            color: #555;
        }
        
        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            padding-right: 20px;
        }
        .button-container button {
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button-container button:hover {
            background-color: #ff4f4f;
        }
        

    </style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
    <div class="button-container">
            <button type="button">글올리기</button>
    </div>
    <div class="container">
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploads/community/noimage.png" alt="작가 이벤트">
            <div class="title">진행중인 작가 이벤트</div>
            <div class="description">플로로하니와 상상지기의 새로운 작품들을 만나보세요.</div>
        </div>
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploads/community/noimage.png"  alt="백설쌀">
            <div class="title">백설쌀(영월백설오곡기능장)</div>
            <div class="description">엄선된 품질의 백설쌀을 확인하세요!</div>
        </div>
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploads/community/noimage.png"  alt="비단가게">
            <div class="title">비단가게</div>
            <div class="description">수공예 패션 아이템을 만나보세요.</div>
        </div>
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploads/community/noimage.png"  alt="리스캣">
            <div class="title">리스캣</div>
            <div class="description">자동차 악세서리를 스타일리시하게!</div>
        </div>
    </div>
    
    <div class="container">
    <c:forEach var="dto" items="${list}" varStatus="status">
					<div class="col-md-4 col-lg-3 mt-4">
						<div class="border rounded product-item" data-productNum="${dto.productNum}">
							<img class="thumbnail-img" src="${pageContext.request.contextPath}/uploads/community/noimage.png">
							<div class="p-2">
								<div class="text-truncate fw-semibold pb-1">
									와니네 빵집
								</div>
								<div class="text-truncate fw-semibold pb-1">
									갓 구운 신상 베이커리! 촉촉+바삭한 맛을 경험하세요!
								</div>
							
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
    

    </main>
</body>
</html>
