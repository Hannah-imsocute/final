<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin page</title>
<link rel="icon" href="data;base64,iVBORw0kGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp"/>
</head>
<body>

<header>
<jsp:include page="/WEB-INF/views/admin/adminheader.jsp"/>
</header>

<nav>
<jsp:include page="/WEB-INF/views/admin/adminside.jsp"/>
</nav>

<main>
	sdfsdfsdf
</main>

<script type="text/javascript">
$(document).ready(function() {
	$('.sidebar-menu').on('click', 'a.accordion-button', function(event) {
		event.preventDefault(); // 기본 이동 방지
		
		let url = $(this).attr('href');
		if (url === "javascript:void(0)") return; // 이동할 주소가 없으면
		
		$.ajax({
			url: url,
			type: 'GET',
			dataType: 'html',
			success: function(response) {
				$('main').html(response); 
				history.pushState(null, null, url); // 주소 변경
			},
			error: function() {
				alert('페이지를 불러오는데 실패했습니다.');
			}
		});
	});
	
	// 브라우저 "뒤로가기" 클릭 시, 변경된 URL에 맞는 페이지 로드
    window.onpopstate = function() {
        $.ajax({
            url: window.location.pathname, // 현재 URL을 가져와 요청
            type: 'GET',
            dataType: 'html',
            success: function(response) {
                $('main').html(response);
            }
        });
    };
});

</script>

</body>
</html>