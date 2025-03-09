<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />


<style type="text/css">
    /* 기본 스타일 */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7fa;

    }

    /* 콘텐츠 박스 스타일 */
    .container {
        max-width: 900px;
        

    }

    .community-form {
        background-color: #ffffff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;

        margin-bottom: 40px;
    }

    .community_num {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-top: 200px;
    }

    .brandName {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        padding-bottom: 10px;
        border-bottom: 2px solid #e0e0e0;
    }

    .content {
        font-size: 16px;
        color: #555;
        line-height: 1.6;
        padding-top: 15px;
    }


    /* 모바일 대응 */
    @media (max-width: 768px) {
        .container {
            padding: 15px;
        }

        .community-form {
            padding: 20px;
        }
    }
    .button-container {
        display: flex;
        justify-content: flex-end;
        padding-right: 20px;
        width: auto;
    }
    .button-container button {
        background-color: #ff6b6b;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .button-container button:hover {
        background-color: #ff4f4f;
    }
    .content img{
    	width: 90%;
    }
</style>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	
	
	<main class="container">
        <div class="community-form">
				<div class="community_num" data-community_num="${dto.community_num}">
					<div class="p-2 px-4">
						<div class="brandName">
							${dto.brandName}
						 </div>
						 <div class="content">
							${dto.content}
				 	     </div>
					 </div>
				</div>

      	 </div>

        <!--댓글 작성 버튼 -->
        <form name="replyForm" method="post" >

			<div class="form-header">
				<span class="bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
			</div>
			<table class="table table-borderless reply-form">
				<tr>
					<td>
						<textarea class="form-control" name="content"></textarea>
					</td>
				</tr>
				<tr>
				   <td align="right">
						<button type="button" class="btn btn-light btnSendReply">댓글 등록</button>
					</td>
				 </tr>
			</table>
		</form>
	     <div class="mt-4 mb-1 wrap-inner">

			<div id="listReply"></div>
			<!-- 댓글 리스트가 그려지는 부분-->
	
		</div>
  
 </main>
    
<script type="text/javascript">

$.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
};


//댓글
$(function(){
	listPage(1);
});

//댓글 리스트
function listPage(page){  //listReply.jsp의  paging이 부르는 것
	let url='${pageContext.request.contextPath}/reply/list';
	let num = '${dto.community_num}';
	let params = {community_num:num, pageNo:page};

	
	const fn = function(data){
		$('#listReply').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}


$(function(){
	$('.btnSendReply').click(function(){
		let num = '${dto.community_num}';  //댓글의 아버지(게시글 번호)
		const $tb = $(this).closest('table');
		
		let content = $tb.find('textarea').val().trim();
		
		if(!content){
			$tb.find('textarea').focus();
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/reply/insert'
		let params = {community_num:num, content:content, parentNum:0};  // 답글인지(댓글의 답. 0이 아닌 숫자) 댓글(0)인지를 나타냄

		const fn = function(data){
			$tb.find('textarea').val('');
			
			let state = data.state;
			if(state === 'true'){
				listPage(1);
			} else{
				alert('댓글을 추가하지 못했습니다.')
			}
			
		};
		
		ajaxRequest(url,'post',params,'json',fn);
	});
	
});
</script>
</body>
</html>