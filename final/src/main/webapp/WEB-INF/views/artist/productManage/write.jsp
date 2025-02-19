<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Boooooot</title>
<jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/boot-board.css" type="text/css">

<style type="text/css">

.content {
    margin:50px;
    margin-top:10px;
    background-color: #f9f9f9;
    max-width: 900px;
    padding: 20px;

}
.product-management {
    max-width: 900px;
    margin :auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 

}

.product-form .form-group {
    margin-bottom: 15px;
}
.product-form label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}
.product-form input, .product-form select, .product-form textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}
.product-form button {
    display: inline-block;
    padding: 10px 15px;
    background: #ff8c00;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.form-group select {
    margin-bottom: 10px; /* 오른쪽 여백 추가 */
	hegith: 40px;
}
</style>

</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>
</header>
<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>

 <main>
    <h4>작품 관리</h4>
    <hr>
    <h6>작품 등록</h6>
    <br>
   <div class="content">
    <section class="product-management">
        <form action="#" method="post" class="product-form" enctype="multipart/form-data">
            <div class="form-group">
                <label>카테고리</label>
                <select name="main-category">
                    <option>:: 메인 카테고리 선택 ::</option>
                    <c:forEach var="vo" items="${listCategory}">
                    	<option value="${vo.categoryNum}" ${parentNum==vo.categoryNum?"selected":""}>${vo.categoryName}</option>
                    </c:forEach>
                </select>
                <select name="sub-category">
                    <option>:: 카테고리 선택 ::</option>
                    <c:forEach var="vo" items="${listSubCategory}">
						<option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?"selected":""}>${vo.categoryName}</option>
					</c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>작품명</label>
                <input type="text" name="title" required>
            </div>

            <div class="form-group">
                <label>작품 가격</label>
                <input type="number" name="price" required>
            </div>

            <div class="form-group">
                <label>할인율</label>
                <input type="number" name="discount">
            </div>

            <div class="form-group">
                <label>배송비</label>
                <input type="number" name="shipping">
            </div>

            <div class="form-group">
                <label>작품 옵션</label>
                <select name="option-limit">
                    <option>옵션 한계</option>
                </select>
            </div>

            <div class="form-group">
                <label>옵션1</label>
                <input type="text" name="option1-name" placeholder="옵션명">
                <input type="text" name="option1-value" placeholder="옵션 값">
                <button type="button">추가</button>
            </div>

            <div class="form-group">
                <label>옵션2</label>
                <input type="text" name="option2-name" placeholder="옵션명">
                <input type="text" name="option2-value" placeholder="옵션 값">
                <button type="button">추가</button>
            </div>

            <div class="form-group">
                <label>작품 설명</label>
                <textarea name="description" rows="5"></textarea>
            </div>

            <div class="form-group">
                <label>메인 이미지</label>
                <input type="file" name="main-image">
            </div>

            <div class="form-group">
                <label>추가 이미지</label>
                <input type="file" name="additional-images" multiple>
            </div>

            <button type="submit" class="submit-btn">등록하기</button>
        </form>
    </section>
   </div> 
</main>

</body>
</html>
