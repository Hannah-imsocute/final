<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">
        
		    <div class="row justify-content-center mt-5">
		        <div class="col-md-8">
		            <div class="border shadow-sm rounded p-4 bg-light">
		                <h4 class="text-center fw-bold text-danger mb-4">
		                    <i class="bi bi-exclamation-triangle"></i> 파일 업로드 실패
		                </h4>
		
		                <div class="d-grid pt-3">
		                    <p class="alert alert-warning text-center mb-4">
		                        <strong>파일을 업로드할 수 없습니다.</strong><br>
		                        파일의 용량이 초과 했거나 권한이 부족합니다.
		                    </p>
		                </div>
		
		                <div class="d-grid">
		                    <button type="button" class="btn btn-lg btn-primary" onclick="javascript:history.back();">
		                        이전화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
		                    </button>
		                </div>
		            </div>
		        </div>
		    </div>
        
        
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>