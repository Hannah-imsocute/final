<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mypage/side.css" />

<div class="sidebar">
    <!-- 프로필 박스 (원형) -->
    <div class="profile-box">
        <!-- 파일 업로드 (숨김) -->
        <input type="file" id="profileFile" name="profileFile" accept="image/*" style="display: none;" />
        <!-- 클릭 시 파일 선택 창 열기 -->
        <button type="button" class="profile-upload-btn" onclick="document.getElementById('profileFile').click()">
            <c:choose>
                <c:when test="${not empty sessionScope.profileImageFile}">
                    <img src="${pageContext.request.contextPath}/uploads/mypage/${sessionScope.profileImageFile}"
                         alt="프로필" class="profile-pic" id="profilePreview">
                </c:when>
                <c:otherwise>
                    <!-- 기본 프로필 아이콘 (Font Awesome) -->
                    <i class="fas fa-user default-icon" id="profilePreview"></i>
                </c:otherwise>
            </c:choose>
        </button>
    </div>
    <!-- 닉네임 영역 (프로필 박스 아래 중앙) -->
    <div class="nickname">
        <c:choose>
            <c:when test="${not empty sessionScope.userProfile.nickName}">
                ${sessionScope.userProfile.nickName}
            </c:when>
            <c:otherwise>
                기본
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 메뉴 타이틀 -->
    <div class="menu-title">MY MENU</div>
    <!-- 메뉴 리스트 -->
    <div class="menu-list">
        <div class="menu-item">
            <div class="main-text">주문 배송</div>
            <div class="sub-text">
                <a href="${pageContext.request.contextPath}/mypage/detail">주문/배송 내역</a>
            </div>
        </div>
        <div class="menu-item">
            <div class="main-text">
                <a href="${pageContext.request.contextPath}/ask/list">문의내역</a>
            </div>
        </div>
        <div class="menu-item">
            <div class="main-text">
                <a href="${pageContext.request.contextPath}/mypage/refunds/detail">교환/반품 내역</a>
            </div>
        </div>
        <div class="menu-item">
            <div class="main-text">
                <a href="${pageContext.request.contextPath}/review/list">나의 구매후기</a>
            </div>
<%--            <div class="sub-text">--%>
<%--                <a href="#">작성 가능한 후기</a>--%>
<%--                <a href="#">작성한 후기</a>--%>
<%--            </div>--%>
        </div>
        <div class="menu-item">
            <div class="main-text">
               적립내역
            </div>
            <div class="sub-text">
                <a href="${pageContext.request.contextPath}/point/detail">포인트 적립 내역</a>
                <a href="${pageContext.request.contextPath}/coupon/detail">쿠폰 적립 내역</a>
            </div>
        </div>
        <div class="menu-item">
            <div class="main-text">
                <a href="${pageContext.request.contextPath}/notice/main">고객센터</a>
            </div>
        </div>
    </div>
</div>

<!-- jQuery (프로필 업로드 스크립트) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){
        $("#profileFile").change(function(){
            var file = this.files[0];
            if(file) {
                var formData = new FormData();
                formData.append("profileFile", file);

                $.ajax({
                    url: "${pageContext.request.contextPath}/mypage/image",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    dataType: "json",
                    success: function(data) {
                        if(data.success) {
                            // 업로드 후 아이콘을 이미지로 대체하고 alert 출력
                            $("#profilePreview").replaceWith(
                                '<img src="' + "${pageContext.request.contextPath}/uploads/mypage/" + data.image + '" alt="프로필" class="profile-pic" id="profilePreview">'
                            );
                            alert("이미지가 등록되었습니다.");
                        } else {
                            alert("이미지 업로드 실패: " + data.error);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("이미지 업로드 중 오류 발생", error);
                        alert("이미지 업로드 중 오류가 발생했습니다.");
                    }
                });
            }
        });
    });
</script>