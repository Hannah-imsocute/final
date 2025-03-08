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
            gap: 30px;
            max-width: 1200px;
            margin: 20px auto;
        }
        .card:hover {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transform:scale(1.03);
            cursor: pointer;
            transition: transform 0.3s ease-in-out;
            
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
            padding-right: 20px;
            width: auto;
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
        
        <div class="row community-list-search d-flex align-items-center justify-content-end">
            <div class="col">
                <form class="row justify-content-center" name="searchForm">
                    <div class="col-auto p-1">
                        <select name="schType" class="form-select">
                            <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
							<option value="userName" ${schType=="userName"?"selected":""}>작가명</option>
							<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
							<option value="content" ${schType=="content"?"selected":""}>내용</optio>
                            </select>
                        </div>
                        <div class="col-auto p-1">
                            <input type="text" name="kwd" value="${kwd}" class="form-control">
                        </div>
                        <div class="col-auto p-1">
                            <button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
                        </div>
                        <div class="col-auto p-1">
                            <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/list';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
                        </div>
                        <div class="button-container">
                                <button type="button" onclick="location.href='${pageContext.request.contextPath}/community/write'">글올리기</button>
                        </div>
                    </form>
                </div>
                
            </div>
    
    <div class="container">
    	<c:forEach var="dto" items="${list}" varStatus="status">
					<div class="card">
						<div class="card-content" data-community_num="${dto.community_num}">
							<img class="thumbnail-img" src="${pageContext.request.contextPath}/uploads/community/noimage.png">
							<div class="p-2 px-4">
								<div class="title">
									${dto.brandName}
								</div>
								<div class="description">
									${dto.content}
								</div>
							
							</div>
						</div>
					</div>
		</c:forEach>
	</div>

	
    </main>
</body>
<script type="text/javascript">

/* 3. 컨텐츠 클릭 시 상세보기 이벤트 */
$(document).ready(function() {
	$('.card-content').on('click', function(){
		let community_num = $(this).attr('data-community_num');
		 if (!community_num) {
		        console.warn("게시글이 없습니다.", $(this).attr('data-community_num'));
		        alert("게시글이 없습니다.");
		        return;
		 }
		 // 페이지 이동 (쿼리스트링 방식으로 productCode 전달)
		
		 let url = '${pageContext.request.contextPath}/community/detail/' + community_num;
		 location.href = url;

	});
});

</script>
</html>
