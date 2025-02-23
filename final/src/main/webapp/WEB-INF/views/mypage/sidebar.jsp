<!-- /WEB-INF/views/mypage/side.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage/side.css" />
<div class="sidebar">
  <div class="profile-box">
    <input type="file" id="profileFile" name="profileFile" accept="image/*" style="display: none;">
    <button type="button" onclick="document.getElementById('profileFile').click()">
    <%--  <img src="<c:choose>
                  <c:when test='${not empty profileImageFile}'>
                    ${pageContext.request.contextPath}/uploads/mypage/${profileImageFile}
                  </c:when>
                  <c:otherwise>
                    http://placehold.it/80x80
                  </c:otherwise>
                </c:choose>"
           alt="프로필" class="profile-pic" id="profilePreview">--%>
    </button>
    <div class="realname">${userProfile.nickName}</div>
  </div>
  <div class="menu-title">MY MENU</div>
  <div class="menu-list">
    <div class="menu-item">
      <div class="main-text">주문 배송</div>
      <div class="sub-text"><a href="${pageContext.request.contextPath}/mypage/detail">주문/배송 내역</a></div>
    </div>
    <div class="menu-item">
      <div class="main-text"><a href="#">알림 및 메시지</a></div>
      <div class="sub-text">
        <a href="#">알림</a>
        <a href="#">메시지</a>
      </div>
    </div>
    <div class="menu-item">
      <div class="main-text"><a href="#">선물함</a></div>
      <div class="sub-text">
        <a href="#">받은 선물함</a>
        <a href="#">보낸 선물함</a>
      </div>
    </div>
    <div class="menu-item">
      <div class="main-text"><a href="#">기프트카드함</a></div>
      <div class="sub-text">
        <a href="#">받은 카드함</a>
        <a href="#">보낸 카드함</a>
      </div>
    </div>
    <div class="menu-item">
      <div class="main-text"><a href="#">나의 구매후기</a></div>
      <div class="sub-text">
        <a href="#">작성 가능한 후기</a>
        <a href="#">작성한 후기</a>
      </div>
    </div>
  </div>
</div>
