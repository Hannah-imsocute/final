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
        <table>
            <thead>
                <tr>
                    <th>대분류</th>
                    <th>소분류</th>
                    <th>작품 코드</th>
                    <th>작품명</th>
                    <th>가격</th>
                    <th>할인 율</th>
                    <th>광고여부</th>
                    <th>재고</th>
                    <th>수정일</th>
                    <th>변경</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>식품</td>
                    <td>베이커리</td>
                    <td>1112</td>
                    <td>케이크</td>
                    <td>10,000</td>
                    <td>5%</td>
                    <td>부</td>
                    <td>20</td>
                    <td>2025-01-31</td>
                    <td>
                        <button class="primary">재고</button>
                        <button class="secondary">수정</button>
                        <button class="danger">삭제</button>
                    </td>
                </tr>
                <tr>
                    <td>식품</td>
                    <td>베이커리</td>
                    <td>1111</td>
                    <td>구름빵</td>
                    <td>10,000</td>
                    <td>5%</td>
                    <td>여</td>
                    <td>20</td>
                    <td>2025-01-31</td>
                    <td>
                        <button class="primary">재고</button>
                        <button class="secondary">수정</button>
                        <button class="danger">삭제</button>
                    </td>
                </tr>
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