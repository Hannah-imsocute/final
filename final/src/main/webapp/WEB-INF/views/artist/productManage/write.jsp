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
        
        /* 메인 이미지 & 추가 이미지 업로드 input 크기 조정 */
		.form-group input[type="file"] {
		    height: 30px;  /* 원하는 높이로 조정 (기본값보다 작게) */
		    font-size: 12px;  /* 글자 크기도 줄여서 정렬 맞추기 */
		    padding: 2px;  /* 내부 여백 줄이기 */
		}
		        
		/* 메인 이미지 업로드 영역 - 회색 테두리 추가 */
		.form-group.mainBox {

		    border: 1px solid #ccc; /* 연한 회색 테두리 */
		    padding: 5px; /* 내부 여백 */
		    border-radius: 5px; /* 모서리 둥글게 */
		}
		
	
		/* 메인 이미지 크기 조정 */
		.form-group.main img{
		    width: 40px;
		    height: 40px;
		    object-fit: cover;
		    margin-bottom:5px;
		    border-radius: 5px;
		
		}
		/* 이미지 호버 효과 */
		.form-group.main img:hover {
		    transform: scale(1.05);
		}
		
				
		/* 추가 이미지 크기 조정 */
		.form-group.add img {
		    width: 40px;
		    height: 40px;
		    object-fit: cover;
		    margin-bottom:5px;
		    border-radius: 5px;
		}
		
		
		/* 추가 이미지 업로드 영역 - 회색 테두리 추가 */
		.form-group.addBox {
		    border: 1px solid #ccc; /* 연한 회색 테두리 */
		    padding: 5px; /* 내부 여백 */
		    border-radius: 5px; /* 모서리 둥글게 */
		}
		
		
		/* 다중 이미지 미리보기 스타일 */
		.preview-grid {
		    display: grid;
		    grid-template-columns: repeat(auto-fill, minmax(40px, 1fr));
		    gap: 5px;
	
		}
		
		/* 추가 이미지 스타일 */
		.add-img {
		    width: 40px;
		    height: 40px;
		    object-fit: cover;
		    transition: transform 0.3s ease;
		}
		
		/* 이미지 호버 효과 */
		.add-img:hover {
		    transform: scale(1.05);
		}
		
		/* 페이드 인 애니메이션 */
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
                      action="${pageContext.request.contextPath}/artist/productManage/${mode}">
                    
                    <!-- 카테고리 선택 -->
                    <div class="form-group">
                        <label>카테고리</label>
                        <select name="main-category">
                            <option value="">:: 메인 카테고리 선택 ::</option>
                            <c:forEach var="vo" items="${listMainCategory}">
                                <option value="${vo.categoryCode}" ${dto.parentCategoryCode==vo.categoryCode?"selected":""}>
                                    ${vo.name}
                                </option>
                            </c:forEach>
                        </select>
                        <select name="categoryCode">
                            <option value="">:: 카테고리 선택 ::</option>
                            <c:forEach var="vo" items="${listSubCategory}">
                                <option value="${vo.categoryCode}" ${dto.categoryCode==vo.categoryCode?"selected":""}>
                                    ${vo.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- 작품 기본 정보 -->
                    <div class="form-group">
                        <label>작품명</label>
                        <input type="hidden" name="productCode" value="${dto.productCode}">  
                        <input type="text" name="item" value="${dto.item}" required>
                    </div>
                    <div class="form-group">
                        <label>작품 가격</label>
                        <input type="number" name="price" value="${dto.price}" required>
                    </div>
                    <div class="form-group">
                        <label>할인율</label>
                        <input type="number" step="any" name="discount" value="${dto.discount}">
                    </div>
                    
                    <!-- 배송비 컬럼 나중에 product 테이블에 생기면 hidden 풀기 -->
                    <div class="form-group" hidden=true>
                        <label>배송비</label>
                        <input type="number" name="shipping" value="">
                    </div>
                    
                    <!-- 옵션 관련 -->
                    <div class="form-group">
                        <label>작품 옵션</label>
  										<select name="optionCount" class="form-select">
											<option value="2" ${dto.optionCount==2?'selected':''}>옵션 둘</option>
											<option value="1" ${dto.optionCount==1?'selected':''}>옵션 하나</option>
											<option value="0" ${dto.optionCount==0?'selected':''}>옵션 없음</option>
										</select>
								
                    </div>
                    <div class="form-group">
                        <div class = "product-option1">
                        <label>옵션 1</label>
                        <input type="text" name="option_name" placeholder="옵션명" value="${dto.option_name}">
                      		<c:if test="${mode=='update'}">
								<input type="hidden" name="option_code" value="${empty dto.option_code ? 0 : dto.option_code}">
							</c:if>
							<div class = option-area>
								<div class="col-auto pe-0 d-flex flex-row optionValue-area">  <!-- 부트스트랩 -->
									<c:forEach var="vo" items="${listOptionDetail}">
										<div class="input-group pe-1">
											<input type="text" name="option_value" placeholder="옵션값" value="${vo.option_value}">
											<input type="hidden" name="optionDetail_code" value="${vo.optionDetail_code}">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:forEach>
									<c:if test="${empty listOptionDetail || listOptionDetail.size() < 1}">
										<div class="input-group pe-1">
											<input type="text" name="option_values" style="flex:none; width: 90px;" placeholder="옵션값">
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
                        <input type="text" name="option_name2" placeholder="옵션명" value="${dto.option_name2}">
                      		<c:if test="${mode=='update'}">
								<input type="hidden" name="option_code2" value="${empty dto.option_code ? 0 : dto.option_code}">
							</c:if>
							<div class = option-area2>
								<div class="col-auto pe-0 d-flex flex-row optionValue-area2">   <!-- 부트스트랩 -->
									<c:forEach var="vo" items="${listOptionDetail2}">
										<div class="input-group pe-1">
											<input type="text" name="option_value2" placeholder="옵션값" value="${vo.option_value}">
											<input type="hidden" name="optionDetail_code2" value="${vo.optionDetail_code}">
											<i class="bi bi-dash input-group-text ps-2 pe-2 bg-white option-minus"></i>
										</div>
									</c:forEach>
									<c:if test="${empty listOptionDetail2 || listOptionDetail2.size() < 1}">
										<div class="input-group pe-1">
											<input type="text" name="option_values2" style="flex:none; width: 90px;" placeholder="옵션값">
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
                        <textarea name="describe" id="ir1" rows="5" style="max-width: 95%; height: 290px;"><c:out value="${dto.describe}" escapeXml="false"/></textarea>
                    </div>
                    
                    <!-- 메인 이미지 업로드 -->
                    <div class="form-group main">
                        <label>메인 이미지</label>
                        <div class="form-group mainBox">
                        	<img src="${pageContext.request.contextPath}/uploads/product/${dto.thumbnail}">       
                        	<input type="file" name="thumbnailFile" accept="image/*">
                        </div>
                    </div>
                    
                    <!-- 추가 이미지 업로드 + 다중 미리보기 -->
                    <div class="form-group add">
                        <label>추가 이미지</label>
                        <!-- 미리보기 영역 -->
                          <div class="form-group addBox">
                        	<div id= "additional-images-preview" class="preview-grid">
                        		<c:forEach var="vo" items="${listAddFiles}">
									<img class="item img-add" src="${pageContext.request.contextPath}/uploads/product/${vo.imageFileName}"
										class="item delete-img add-img"
										data-imagecode="${vo.image_code}"		
										data-imagefilename="${vo.imageFileName}">
								</c:forEach>
                       		 </div>
                        	<input type="file" name="addFiles" multiple accept="image/*">
                        </div>
                    </div>
                    
                    <button type="submit" class="submit-btn" onclick="smartEditInDescribe()">${mode=="update"?"수정완료":"등록완료"}</button>
                	<button type="reset" class="btn btn-light">다시입력</button>
                	<button type="button" class="btn btn-light" onclick="location.href='${url}';">${mode=="update"?"수정취소":"등록취소"}</button>
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
                        const previewItem = $('<div class="preview-grid"></div>');
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
        	// 옵션1 추가버튼 클릭
        	$('.btnOptionAdd').click(function(){
        		let $el = $(this).closest('.option-area').find('.optionValue-area');
        		if($el.find('.input-group').length >= 5) {
        			alert('옵션은 최대 5개까지 가능합니다.');
        			return false;
        		}
        		
        		let $option = $('.option-area .optionValue-area .input-group:first-child').clone();
        		
        		$option.find('input[type=hidden]').remove();
        		$option.find('input[name=option_values]').removeAttr('value');
        		$option.find('input[name=option_values]').val('');
        		$el.append($option);
        	});
        	
        	// 옵션2 추가버튼 클릭
        	$('.btnOptionAdd2').click(function(){
        		let $el = $(this).closest('.option-area2').find('.optionValue-area2');
        		if($el.find('.input-group').length >= 5) {
        			alert('옵션은 최대 5개까지 가능합니다.');
        			return false;
        		}
        		
        		let $option = $('.option-area2 .optionValue-area2 .input-group:first-child').clone();
        		
        		$option.find('input[type=hidden]').remove();
        		$option.find('input[name=option_values2]').removeAttr('value');
        		$option.find('input[name=option_values2]').val('');
        		$el.append($option);
        	});
        	
        	// 옵션 1 영역의 마이너스 버튼 클릭
        	$('.option-area').on('click', '.option-minus', function(){
        		let $minus = $(this);
        		let $el = $minus.closest('.option-area').find('.optionValue-area');
        		
        		// 수정에서 등록된 자료 삭제
        		let mode = '${mode}';
        		if(mode === 'update' && $minus.parent('.input-group').find('input[name=optionDetail_code]').length === 1) {
        			// 저장된 옵션값중 최소 하나는 삭제되지 않도록 설정
        			if($el.find('.input-group input[name=detailNums]').length <= 1) {
        				alert('옵션값은 최소 하나이상 필요합니다.');	
        				return false;
        			}
        			
        			if(! confirm('옵션값을 삭제 하시겠습니까 ? ')) {
        				return false;
        			}
        			
        			let optionDetail_code = $minus.parent('.input-group').find('input[name=optionDetail_code]').val();
        			let url = '${pageContext.request.contextPath}/artist/product/deleteOptionDetail';
        			
        			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
        			$.post(url, {optionDetail_code:optionDetail_code}, function(data){
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
        			$el.find('input[name=option_value]').val('');
        			return false;
        		}
        		
        		$minus.closest('.input-group').remove();
        	});

        	// 옵션 2 영역의 마이너스 버튼 클릭
        	$('.option-area2').on('click', '.option-minus', function(){
        		let $minus = $(this);
        		let $el = $minus.closest('.option-area2').find('.optionValue-area2');
        		
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
        			
        			let optionDetail_code = $minus.parent('.input-group').find('input[name=optionDetail_code]').val();
        			let url = '${pageContext.request.contextPath}/artist/product/deleteOptionDetail';
        			
        			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
        			$.post(url, {optionDetail_code:optionDetail_code}, function(data){
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
        			$el.find('input[name=option_value]').val('');
        			return false;
        		}
        		
        		$minus.closest('.input-group').remove();
        	});
        });
        
        
        
        
     // 대표(썸네일) 이미지
	    window.addEventListener('DOMContentLoaded', () => {
	    const mainImageEL = document.querySelector('.form-group.mainBox img');
	    const inputEL = document.querySelector('.form-group.mainBox input[name=thumbnailFile]');
	
	    // 이미지 클릭 시 파일 선택
	    mainImageEL.addEventListener('click', () => {
	        inputEL.click();
	    });
	
	    // 파일 선택 시 이미지 변경
	    inputEL.addEventListener('change', (ev) => {
	        if (!ev.target.files.length) return;
	
	        const file = ev.target.files[0];
	
	        // 파일을 미리보기로 보여줌
	        const reader = new FileReader();
	        reader.onload = e => {
	            mainImageEL.setAttribute('src', e.target.result);
	        };
	        reader.readAsDataURL(file);
	    });
	});


     
     // 추가 이미지
        window.addEventListener('DOMContentLoaded', evt => {
        	var sel_files = [];
        	
        	const viewerEL = document.querySelector('.product-form .preview-grid');
        	const imgAddEL = document.querySelector('.product-form .img-add');
        	const inputEL = document.querySelector('form[name=productForm] input[name=addFiles]');
        	
        	imgAddEL.addEventListener('click', ev => {
        		inputEL.click();
        	});
        	
        	inputEL.addEventListener('change', ev => {
        		if(! ev.target.files) {
        			let dt = new DataTransfer();
        			for(let f of sel_files) {
        				dt.items.add(f);
        			}
        			document.productForm.addFiles.files = dt.files;
        			
        	    	return;
        	    }
        		
                for(let file of ev.target.files) {
                	sel_files.push(file);
                	
                	let node = document.createElement('img');
                	node.classList.add('item', 'img-item');
                	node.setAttribute('data-imagefilename', file.name);

                	const reader = new FileReader();
                    reader.onload = e => {
                    	node.setAttribute('src', e.target.result);
                    };
        			reader.readAsDataURL(file);
                	
        			viewerEL.appendChild(node);
                }
        		
        		let dt = new DataTransfer();
        		for(let f of sel_files) {
        			dt.items.add(f);
        		}
        		
        		document.productForm.addFiles.files = dt.files;		
        	});
        	
        	viewerEL.addEventListener('click', (e)=> {
        		if(e.target.matches('.img-item')) {
        			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
        				return false;
        			}
        			
        			let filename = e.target.getAttribute('data-imagefilename');
        			
        		    for(let i = 0; i < sel_files.length; i++) {
        		    	if(filename === sel_files[i].name){
        		    		sel_files.splice(i, 1);
        		    		break;
        				}
        		    }
        		
        			let dt = new DataTransfer();
        			for(let f of sel_files) {
        				dt.items.add(f);
        			}
        			document.productForm.addFiles.files = dt.files;
        			
        			e.target.remove();
        		}
        	});	
        });

        
        
     

     // 수정에서 등록된 추가 이미지 삭제
     $(function(){
     	$('.delete-img').click(function(){
     		if(! confirm('이미지를 삭제 하시겠습니까 ?')) {
     			return false;
     		}
     		
     		let $img = $(this);
     		let image_code = $img.attr('data-imagecode');
     		let imageFileName = $img.attr('data-imagefilename');
     		let url = '${pageContext.request.contextPath}/artist/productManage/deleteFile';
     		
     		$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
     		$.post(url, {image_code:image_code, imageFileName:imageFileName}, function(data){
     			$img.remove();
     		}, 'json').fail(function(jqXHR){
     			console.log(jqXHR.responseText);
     		});
     	});
     });

        //스마트에디터
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
