<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boooooot</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/boot-board.css" type="text/css">
<style type="text/css">
      body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .new-registration-box {
            display: flex;
            justify-content: flex-end;
            padding: 10px;
        }
        .new-registration {
            background-color: white;
            color: #FF8000;
            border-color: #FF8000;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .primary {
            background-color: #D5D5D5;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .secondary {
            background-color: #D5D5D5;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .danger {
            background-color: #D5D5D5;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        
       .search-area{
         display: flex;
         justify-content: center;
         margin-top: 20px;
        }
        
       .search-area select, .search-area input, .search-area button {
            border-radius: 5px;
            padding: 5px;
            border: 1px solid #ccc;
        }
        .pagination {
            margin-top: 10px;
            display: flex;
            justify-content: center;
            
         
        }
        .pagination button {
            margin-right: 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            cursor: pointer;
            border-radius: 5px;
        }
        
        .register-box{
            display: flex;
            justify-content: flex-end;
        
        }
        .register {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #FF8000;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;

        }
</style>
</head> 
<body>
	<header>
    	<jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>
		<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>
	</header>

    <main>
        <h4>작품 관리</h4>
        <hr>
        <h6>작품 리스트</h6>
        <div class="new-registration-box">
       		<button class="new-registration">새로고침</button>
        </div>
		<div class="col-auto pt-2 text-end">
			${dataCount}개(${page}/${total_page} 페이지)
		</div>   
        <table>
            <thead> 
                <tr>
                    <th>대분류</th>
                    <th>소분류</th>
                    <th>작품 코드</th>
                    <th>작품명</th>
                    <th>작품가격</th>
                    <th>판매가격</th>
                    <th>할인 율</th>
                    <th>광고여부</th>
                    <th>수정일</th>
                    <th>변경</th>
                </tr>
            </thead>
 <!------- --------- ------------------------------------>
   
 <!------- --------- ------------------------------------>
  			<tbody>
				<c:forEach var="vo" items="${productList}" varStatus="status">
					<tr valign="middle">
						<td>대분류</td>
						<td>${vo.categoryCode }</td>
						<td>${vo.productCode}</td>
						<td class="product-subject left">
							<img src="${pageContext.request.contextPath}/uploads/products/${vo.thumbnail}">
							<a href="#"><label>${dto.item}</label></a>
						</td>
						<td><fmt:formatNumber value="${vo.price}" type="number" groupingUsed="true"/>원</td>  
						<td><fmt:formatNumber value="${vo.salePrice}" type="number" groupingUsed="true"/>원</td> 
						<td>${vo.discount}%</td>
						<td>${vo.addOptions}</td>
						<td>${vo.modified}</td>
						<td>
							<button type="button" class="btn border" onclick="location.href='${pageContext.request.contextPath}/artist/productManage/update'">수정</button>
							<button type="button" class="btn border" onclick="location.href='${pageContext.request.contextPath}/artist/productManage/delete'">삭제</button>
						</td>
					</tr>					
				</c:forEach>
			</tbody>
      
      
        </table>
        <div class="search-area">
            <select>
                <option>전체</option>
            </select>
            <input type="text" placeholder="검색">
            <button>검색</button>
        </div>
        <div class="pagination">
            <button>1</button>
            <button>2</button>
            <button>3</button>
            <button>4</button>
            <button>5</button>
        </div>
        
        
        <div class="register-box">
       	 <button class="register" onclick="location.href='${pageContext.request.contextPath}/artist/productManage/listMainCategory'">등록하기</button>
	    </div>
</main>

</body>
</html>