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

        .content {
            margin: 50px;
            margin-top: 200px;
            background-color: #f9f9f9;
            max-width: 900px;
            padding: 20px;
        }
		.form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group button {
            display: inline-block;
            padding: 10px 15px;
            background: #ff8c00;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>
	<div class="content">
        <!-- 작품 설명 -->
        <form name="communityForm" class="communityForm" method="post" enctype="multipart/form-data" 
        	action="${pageContext.request.contextPath}/community/${mode}"
		    onsubmit="return validateProductForm()">
       		<div class="form-group">
            	<label>작품 설명</label>
            	<textarea name="content" id="ir1" rows="5" style="max-width: 95%; height: 290px;"><c:out value="${dto.content}" escapeXml="false"/></textarea>
       			<button type="submit" class="submit-btn" onclick="smartEditInDescribe()">${mode=="update"?"수정완료":"등록완료"}</button>
	    		<button type="reset" class="btn btn-light">다시입력</button>
	    		<button type="button" class="btn btn-light" onclick="location.href='${url}';">${mode=="update"?"수정취소":"등록취소"}</button>
		   </div>
	   </form>
 	</div>
	</main>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
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