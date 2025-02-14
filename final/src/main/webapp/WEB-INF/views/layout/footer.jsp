<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
  <!-- 이용약관, 개인정보 처리방침, 입점신청 항목을 최상단에 배치 -->
  <div class="footer-links">
    <a href="#">이용약관</a>
    <a href="#">개인정보 처리방침</a>
    <a href="${pageContext.request.contextPath}/main/write">입점신청</a>
  </div>

  <!-- 첫 번째 구분선 (이용약관, 개인정보 처리방침, 입점신청 위에 위치) -->

  <!-- 로고와 텍스트 영역 -->
  <div class="footer-content">
    <div class="footer-left">
      <img src="/dist/images/layout/logo.png" alt="로고" class="footer-logo"> <!-- 로고 이미지 추가 -->
    </div>

    <div class="footer-right">
      <p>(주) 뚝딱뚝딱</p>
      <p>대표이사: 송창</p>
      <p>서울 송파구 중대로 300</p>
      <p>사업자 등록번호: 104-93-23483</p>
      <p>전화번호: 1577-1577</p>
      <p>뚝딱뚝딱는 한국인터넷진흥원 등록 사업자입니다.</p>
    </div>
  </div>

  <!-- 두 번째 구분선 (푸터 하단) -->
