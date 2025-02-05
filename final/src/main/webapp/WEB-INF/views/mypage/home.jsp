<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f5f5f5;
        }
        .sidebar {
            width: 200px;
            background-color: #e07b39;
            padding: 20px;
            color: white;
            min-height: 100vh;
        }
        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #d0672b;
        }
        .content {
            flex: 1;
            padding: 20px;
        }
        .profile {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #ccc;
        }
        .points {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
        }
        .order-list {
            background: white;
            margin-top: 20px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .order-item {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .order-status {
            background: #ddd;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>MY MENU</h3>
        <a href="#">주문/배송/결제</a>
        <a href="#">환불/교환</a>
        <a href="#">찜하기</a>
        <a href="#">구매후기</a>
        <a href="#">1:1문의/신고</a>
        <a href="#">내 정보 수정</a>
        <a href="#">마이포인트</a>
    </div>
    <div class="content">
        <div class="profile">
            <img src="#" alt="프로필 사진">
            <div>○○회원님</div>
        </div>
        <div class="points">
            <div>사용 가능한 포인트<br><strong>500P</strong></div>
            <div>총 적립한 포인트<br><strong>12000P</strong></div>
            <div>사용한 포인트<br><strong>11500P</strong></div>
        </div>
        <div class="order-list">
            <h3>최근 주문 내역</h3>
            <div class="order-item">
                <p>xxxx.xx.xx 주문</p>
                <p>작품명 - 작가(브랜드명)</p>
                <span class="order-status">배송 완료</span>
            </div>
            <div class="order-item">
                <p>xxxx.xx.xx 주문</p>
                <p>작품명 - 작가(브랜드명)</p>
                <span class="order-status">배송 완료</span>
            </div>
            <div class="order-item">
                <p>xxxx.xx.xx 주문</p>
                <p>작품명 - 작가(브랜드명)</p>
                <span class="order-status">환불 완료</span>
            </div>
        </div>
    </div>
</body>
</html>
