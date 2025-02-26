<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ttshop 게시물</title>
<link rel="icon" href="data:image/png;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/admin/adminimported.jsp" />
<!-- Google Fonts (원하는 폰트 적용) -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
	color: #333;
}

header {
	margin-bottom: 30px;
}

main {
	width: 80%;
	margin: 150px auto;
	display: flex;
	justify-content: center;
}

.post-container {
	width: 100%;
	max-width: 900px;
	min-width: 800px;
	background: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 5px 12px rgba(0, 0, 0, 0.1);
}

.post-header {
	border-bottom: 2px solid #dee2e6;
	padding-bottom: 15px;
	margin-bottom: 25px;
	display: flex;
	flex-direction: column;
}

.post-title {
	font-size: 2rem;
	font-weight: bold;
	margin: 0 0 10px 0;
	color: #212529;
	text-align: center;
}

.post-meta {
	display: flex;
	justify-content: space-between;
	font-size: 0.9rem;
	color: #6c757d;
}

.post-content {
	font-size: 1.1rem;
	line-height: 1.8;
	overflow-wrap: break-word;
	margin-bottom: 30px;
}

.post-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.post-actions a {
	display: inline-block;
	padding: 8px 16px;
	font-size: 0.9rem;
	font-weight: 600;
	color: #fff;
	border-radius: 4px;
	text-decoration: none;
	transition: background-color 0.2s ease-in-out;
}

.post-actions a.edit-btn {
	background-color: #17a2b8;
}

.post-actions a.edit-btn:hover {
	background-color: #138496;
}

.post-actions a.delete-btn {
	background-color: #dc3545;
}

.post-actions a.delete-btn:hover {
	background-color: #c82333;
}

/* 모바일 대응 */
@media ( max-width : 1024px) {
	.post-container {
		min-width: 90%;
		padding: 20px;
	}
	.post-meta {
		flex-direction: column;
		align-items: center;
		gap: 5px;
	}
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/admin/adminheader.jsp" />
		<jsp:include page="/WEB-INF/views/admin/adminside.jsp" />
	</header>

	<main>
		<div class="post-container">
			<div class="post-header">
				<h2 class="post-title">📌 ${dto.subject}</h2>
				<div class="post-meta">
					<span>작성일: ${dto.create_date}</span> <span>작성자:
						${dto.nickname}</span>
				</div>
			</div>
			<div class="post-content">${dto.textcontent}</div>
			<div class="post-actions">
				<a href="${pageContext.request.contextPath}/admin/notice/edit/${dto.evt_not_num}" class="edit-btn">수정</a> 
				<a 	class="delete-btn">삭제</a>
			</div>
		</div>
	</main>
	<script type="text/javascript">
			$(function(){
				$('.delete-btn').click(function(){
					if(alert('정말로 삭제하시겠습니까 ?')){
						location.href = '${pageContext.request.contextPath}/admin/notice/delete/${dto.evt_not_num}';
					}
				});
			});
	</script>
</body>
</html>
