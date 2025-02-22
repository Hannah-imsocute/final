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
        
         .product-option1 {
    		margin-bottom: 15px; /* 원하는 간격(예: 20px)을 설정 */
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
                        <select name="categoryCode">
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
  										<select name="optionCount" class="form-select">
											<option value="2" ${dto.optionCount==2?'selected':''}>옵션 둘</option>
											<option value="1" ${dto.optionCount==1?'selected':''}>옵션 하나</option>
											<option value="0" ${dto.optionCount==0?'selected':''}>옵션 없음</option>
										</select>
								<small class="form-control-plaintext help-block">상품 재고가 존재하면 옵션 변경은 불가능합니다.</small>
                    </div>
                    <div class="form-group">
                        <div class = "product-option1">
                        <label>옵션 1</label>
                        <input type="text" name="option_name" placeholder="옵션명" value="${dto.option_code}">
                      		<c:if test="${mode=='update'}">
								<input type="hidden" name="option_code" value="${empty dto.option_code ? 0 : dto.option_code}">
							</c:if>
							<div >
								<div class="col-auto pe-0 d-flex flex-row optionValue-area">  <!-- 부트스트랩 -->
									<c:forEach var="vo" items="${listOptionDetail}">
										<div class="input-group pe-1">
											<input type="text" name="option_value" placeholder="옵션값" value="${vo.option_value}">
											<input type="hidden" name="optiondetail_code" value="${vo.optiondetail_code}">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:forEach>
									<c:if test="${empty listOptionDetail || listOptionDetail.size() < 1}">
										<div class="input-group pe-1">
											<input type="text" name="option_value" style="flex:none; width: 90px;" placeholder="옵션값">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:if>
								</div>
									<div class="col-auto">
										<button type="button" class="btn btn-light btnOptionAdd">추가</button>
									</div>
								</div>
							                       
        				</div>
        			
                        <div class = "product-option2">
        				<label>옵션 2</label>
                        <input type="text" name="option-name" placeholder="옵션명" value="${dto.option_code2}">
                      		<c:if test="${mode=='update'}">
								<input type="hidden" name="option_code2" value="${empty dto.option_code2 ? 0 : dto.option_code2}">
							</c:if>
							<div>
								<div class="col-auto pe-0 d-flex flex-row optionValue-area">   <!-- 부트스트랩 -->
									<c:forEach var="vo" items="${listOptionDetail2}">
										<div class="input-group pe-1">
											<input type="text" name="option_value2" placeholder="옵션값" value="${vo.option_value2}">
											<input type="hidden" name="optiondetail_code2" value="${vo.optiondetail_code2}">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:forEach>
									<c:if test="${empty listOptionDetail || listOptionDetail.size() < 1}">
										<div class="input-group pe-1">
											<input type="text" name="option_value2" style="flex:none; width: 90px;" placeholder="옵션값">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:if>
								</div>
									<div class="col-auto">
										<button type="button" class="btn btn-light btnOptionAdd2">추가</button>
									</div>
						 	 </div>
								
        				</div>
        				
        				
                    </div>
                    
					<div class="mb-2">
						<c:if test="${mode=='update'}">
							<input type="hidden" name="optionNum" value="${empty dto.option_code ? 0 : dto.option_code}">
						</c:if>
					</div>
                
                 
                    <!-- 작품 설명 -->
                    <div class="form-group">
                        <label>작품 설명</label>
                        <textarea name="describe" id="ir1" rows="5" style="max-width: 95%; height: 290px;"></textarea>
                    </div>
                    
                    <!-- 메인 이미지 업로드 -->
                    <div class="form-group">
                        <label>메인 이미지</label>
                        <input type="file" name="thumbnailFile" accept="image/*">
                    </div>
                    
                    <!-- 추가 이미지 업로드 + 다중 미리보기 -->
                    <div class="form-group">
                        <label>추가 이미지</label>
                        <input type="file" name="addFiles" multiple accept="image/*">
                        <!-- 미리보기 영역 -->
                        <div id="additional-images-preview" class="preview-grid"></div>
                    </div>
                    
                    <button type="submit" class="submit-btn" onclick="smartEditInDescribe()">등록하기</button>
                </form>
            </section>
        </div>
    </main>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
                $('form select[name=categoryCode]').empty()
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
                                $('form select[name=categoryCode]').append(option);
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
            $('input[name="addFiles"]').on('change', function(event){
                const files = event.target.files;
                const previewContainer = $('#additional-images-preview');
                previewContainer.empty();
    
                Array.from(files).forEach(file => {
                    if (file && file.type.match('imag.*')) {
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
        
        //옵션 둘인지, 하나인지, 없는지
        $(function(){
        	$('select[name=optionCount]').change(function(){
        		let count = parseInt($(this).val());
        		let mode = '${mode}';
        		let savedCount = '${dto.optionCount}';
       
        		
        		if(count === 0) {
        			$('.product-option1').hide();
        			$('.product-option2').hide();
        			
        			
        		} else if(count === 1) {
        			$('.product-option1').show();
        			$('.product-option2').hide();
        			
        			
        		} else if(count === 2) {
        			$('.product-option1').show();
        			$('.product-option2').show();
        		}
        	});
        });
        
		//옵션 추가 버튼클릭
        $(function(){
        	$('.btnOptionAdd').click(function(){
        		let $el = $(this).closest('.option-area').find('.optionValue-area');
        		if($el.find('.input-group').length >= 5) {
        			alert('옵션은 최대 5개까지 가능합니다.');
        			return false;
        		}
        		
        		let $option = $('.option-area .optionValue-area .input-group:first-child').clone();
        		
        		$option.find('input[type=hidden]').remove();
        		$option.find('input[name=optionValues]').removeAttr('value');
        		$option.find('input[name=optionValues]').val('');
        		$el.append($option);
        	});
        	
        	$('.option-area').on('click', '.option-minus', function(){
        		let $minus = $(this);
        		let $el = $minus.closest('.option-area').find('.optionValue-area');
        		
        		// 수정에서 등록된 자료 삭제
        		let mode = '${mode}';
        		if(mode === 'update' && $minus.parent('.input-group').find('input[name=detailNums]').length === 1) {
        			// 저장된 옵션값중 최소 하나는 삭제되지 않도록 설정
        			if($el.find('.input-group input[name=detailNums]').length <= 1) {
        				alert('옵션값은 최소 하나이상 필요합니다.');	
        				return false;
        			}
        			
        			if(! confirm('옵션값을 삭제 하시겠습니까 ? ')) {
        				return false;
        			}
        			
        			let detailNum = $minus.parent('.input-group').find('input[name=detailNums]').val();
        			let url = '${pageContext.request.contextPath}/admin/products/deleteOptionDetail';
        			
        			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
        			$.post(url, {detailNum:detailNum}, function(data){
        				if(data.state === 'true') {
        					$minus.closest('.input-group').remove();
        				} else {
        					alert('옵션값을 삭제할 수 없습니다.');
        				}
        			}, 'json').fail(function(jqXHR){
        				console.log(jqXHR.responseText);
        			});
        			
        			return false;			
        		}
        		
        		if($el.find('.input-group').length <= 1) {
        			$el.find('input[name=optionValues]').val('');
        			return false;
        		}
        		
        		$minus.closest('.input-group').remove();
        	});
        });
        
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: 'ir1',
            sSkinURI: '${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html',
            fCreator: 'createSEditor2',
            fOnAppLoad: function(){
                // 로딩 완료 후 기본 폰트 설정
                oEditors.getById['ir1'].setDefaultFont('돋움', 12);
            },
        });

        // 스마트에디터의 내용을 Describe 에 넣는다. 
        // 이후 form 의 button에 설정한 submit() 이 동작한다.
        function smartEditInDescribe(elClickedObj) {
            oEditors.getById['ir1'].exec('UPDATE_CONTENTS_FIELD', []); 
        }
        
    </script>
</body>
</html>
