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
        /* 기본 컨테이너 스타일 */
        .content {
            margin: 50px;
            margin-top: 10px;
            background-color: #f9f9f9;
            max-width: 900px;
            padding: 20px;
        }
        .product-management {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .product-form .form-group {
            margin-bottom: 15px;
        }
        .product-form label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .product-form input,
        .product-form select,
        .product-form textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .product-form button {
            display: inline-block;
            padding: 10px 15px;
            background: #ff8c00;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group select {
            margin-bottom: 10px;
            height: 40px;
        }
        
        /* 다중 이미지 미리보기 스타일 */
        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        .preview-item {
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            animation: fadeIn 0.4s ease;
        }
        .preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .preview-item:hover img {
            transform: scale(1.05);
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
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
                <!-- 새롭게 추가한 등록 전용 엔드포인트(create)로 전송 -->
                <form name="productForm" class="product-form" method="post" 
                      enctype="multipart/form-data" 
                      action="${pageContext.request.contextPath}/artist/productManage/create">
                    
                    <!-- 카테고리 선택 -->
                    <div class="form-group">
                        <label>카테고리</label>
                        <select name="main-category">
                            <option value="">:: 메인 카테고리 선택 ::</option>
                            <c:forEach var="vo" items="${listMainCategory}">
                                <option value="${vo.categoryCode}" ${parentCategoryCode==vo.categoryCode?"selected":""}>
                                    ${vo.name}
                                </option>
                            </c:forEach>
                        </select>
                        <select name="sub-category">
                            <option value="">:: 카테고리 선택 ::</option>
                            <c:forEach var="vo" items="${listSubCategory}">
                                <option value="${vo.categoryCode}" ${categoryCode==vo.categoryCode?"selected":""}>
                                    ${vo.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- 작품 기본 정보 -->
                    <div class="form-group">
                        <label>작품명</label>
                        <input type="text" name="item" required>
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
                    
                    <!-- 옵션 관련 -->
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
                    
                    <!-- 작품 설명 -->
                    <div class="form-group">
                        <label>작품 설명</label>
                        <textarea name="describe" rows="5"></textarea>
                    </div>
                    
                    <!-- 메인 이미지 업로드 -->
                    <div class="form-group">
                        <label>메인 이미지</label>
                        <input type="file" name="thumbnail" accept="image/*">
                    </div>
                    
                    <!-- 추가 이미지 업로드 + 다중 미리보기 -->
                    <div class="form-group">
                        <label>추가 이미지</label>
                        <input type="file" name="imagefilename" multiple accept="image/*">
                        <!-- 미리보기 영역 -->
                        <div id="additional-images-preview" class="preview-grid"></div>
                    </div>
                    
                    <button type="submit" class="submit-btn">등록하기</button>
                </form>
            </section>
        </div>
    </main>
    
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    
        // 페이지 로드 시 전체 카테고리 불러오기 (필요에 따라 활용)
        $(document).ready(function() {
            $.ajax({
                url: '/artist/productManage/listMainCategory',
                method: 'GET',
                dataType: 'json',
                beforeSend: function() {
                	// TODO: 기존에 메인리스트 카테고리 값 체크해서 이미 있으면 return false 호출해서 api 요청 보내지 않기 
                },
                success: function(response) {
                    // 응답 처리 (필요시 추가)
                }
            });
        });
    
        // 메인 카테고리 선택 시 서브 카테고리 동적 로딩
        $(function(){
            $('form select[name=main-category]').change(function(){
                let parentCategoryCode = $(this).val();
                $('form select[name=sub-category]').empty()
                   .append('<option value="">:: 카테고리 선택 ::</option>');
    
                if (!parentCategoryCode) return false;
    
                $.ajax({
                    url: contextPath + '/artist/productManage/listSubCategory',
                    method: 'get',
                    data: { parentCategoryCode: parentCategoryCode },
                    dataType: 'json',
                    success: function(response) {
                        if (response && Array.isArray(response.listSubCategory)) {
                            $.each(response.listSubCategory, function(_, item) {
                                let option = '<option value="' + item.categoryCode + '">' + item.name + '</option>';
                                $('form select[name=sub-category]').append(option);
                            });
                        } else {
                            console.warn("서브 카테고리 로딩 실패");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("서브 카테고리 로딩 실패");
                        console.error(error, xhr.responseText);
                    }
                });
            });
        });
    
        // 추가 이미지 다중 미리보기 처리
        $(function(){
            $('input[name="additional-images"]').on('change', function(event){
                const files = event.target.files;
                const previewContainer = $('#additional-images-preview');
                previewContainer.empty();
    
                Array.from(files).forEach(file => {
                    if (file && file.type.match('image.*')) {
                        const objectUrl = URL.createObjectURL(file);
                        const previewItem = $('<div class="preview-item"></div>');
                        const img = $('<img>').attr('src', objectUrl);
    
                        // 이미지 로드 후 메모리 해제
                        img.on('load', function() {
                            URL.revokeObjectURL(objectUrl);
                        });
    
                        previewItem.append(img);
                        previewContainer.append(previewItem);
                    }
                });
            });
        });
    </script>
</body>
</html>
