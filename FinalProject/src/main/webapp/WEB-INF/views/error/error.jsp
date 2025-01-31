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
		
			<div class="row justify-content-md-center mt-5">
			    <div class="col-md-8">
			        <div class="border shadow-sm rounded mt-5 p-5 bg-light">
			            <h4 class="text-center fw-bold text-danger mb-4">
			                <i class="bi bi-exclamation-triangle"></i> 시스템 오류
			            </h4>
			
			            <div class="d-grid pt-3">
			                <p class="alert alert-danger text-center bg-light">
								죄송합니다.<br>
								<strong>잠시후 다시 시도 해보시기 바랍니다.</strong>					
			                </p>
			            </div>
			
			            <div class="d-grid">
			                <button type="button" class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/';">
			                    메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
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