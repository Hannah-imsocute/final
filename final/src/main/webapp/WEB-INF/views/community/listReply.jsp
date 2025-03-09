<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style type ="text/css">
/* 댓글 컨테이너 */
.table-borderless {
    width: 100%;
    border-collapse: collapse;
}

.border {
    border-bottom: 1px solid #dee2e6;
}

.table-light {
    background-color: #f8f9fa;
}

.reply-writer {
    display: flex;
    align-items: center;
}

.icon {
    font-size: 1.5rem;
}

.name {
    font-weight: 600;
    color: #495057;
}

.date {
    font-size: 0.875rem;
    color: #6c757d;
}

.reply-dropdown {
    cursor: pointer;
    padding: 5px;
    border-radius: 50%;
    transition: background-color 0.2s ease-in-out;
}

.reply-dropdown:hover {
    background-color: #e9ecef;
}

.reply-menu {
    display: none;
    position: absolute;
    background-color: white;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    padding: 8px 0;
    z-index: 10;
}

.reply-dropdown:hover + .reply-menu,
.reply-menu:hover {
    display: block;
}

.reply-menu-item {
    padding: 8px 12px;
    cursor: pointer;
    color: #495057;
    transition: background-color 0.2s ease-in-out;
}

.reply-menu-item:hover {
    background-color: #f8f9fa;
}

.text-primary.text-opacity-50 {
    color: #6c757d !important; /* 기본적인 회색 */
}


.align-middle {
    vertical-align: middle;
    text-align: right;
}

/* 모바일 최적화 */
@media (max-width: 768px) {
    .reply-writer {
        flex-direction: column;
        align-items: flex-start;
    }

    .reply-menu {
        position: static;
        box-shadow: none;
    }

    .reply-dropdown {
        display: inline-block;
    }
}
</style>

<div class="reply-info">
	<span class="fw-bold text-primary item-count">댓글 ${dataCount}개</span>
	
	<span>[목록, ${pageNo }/${total_page } 페이지]</span>
</div>

<table class="table table-borderless">
	<c:forEach var="dto" items="${list}">
		<tr class="border table-light">
			<td width="50%">
				<div class="row reply-writer">
					<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
					<div class="col-auto align-self-center">
						<div class="name">${dto.nickName }</div>
						<div class="date">${dto.created }</div>
					</div>
				</div>				
			</td>
			<td width="50%" align="right" class="align-middle">
				<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu">
					<c:choose>
						<c:when test = "${sessionScope.member.memberIdx==dto.memberIdx}">
							<div class="deleteReply reply-menu-item" data-reply_num="${dto.reply_num }" data-pageNo="${pageNo}">삭제</div>
							<div class="hideReply reply-menu-item" data-reply_num="${dto.reply_num}" data-showReply="${dto.blind}">${dto.blind==1?"숨김":"표시"}</div>
						</c:when>
						<c:when test = "${sessionScope.member.userLevel>50}">
							<div class="deleteReply reply-menu-item" data-replyNum="${dto.reply_num }" data-pageNo="${pageNo}">삭제</div>
							<div class="blockReply reply-menu-item">차단</div>
						</c:when>
						<c:otherwise>
							<div class="notifyReply reply-menu-item">신고</div>
							<div class="blockReply reply-menu-item">차단</div>
						</c:otherwise>
					</c:choose>				
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top" class="${dto.blind == 0 ? 'text-primary text-opacity-50':''}">${dto.content }</td>
		</tr>


</c:forEach>
</table>

<div class="page-navigation">
	${paging}
</div>			
</body>
</html>