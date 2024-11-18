<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 쿠폰함</title>
</head>
<body>

    <h2>내 쿠폰함</h2>
    <table border="1">
        <tr>
            <th>쿠폰번호</th>
            <th>시작일</th>
            <th>만료일</th>
            <th>내용</th>            
            <th>할인가</th>
            <th>쿠폰종류</th>
        </tr>
        <!-- 사용자가 보유한 쿠폰을 표시하는 부분 -->
        <c:forEach items="${couponList}" var="coupon">
            <tr>
                <td>${coupon.cup_num}</td>
                <td>${coupon.cup_sdate}</td>
                <td>${coupon.cup_edate}</td>
                <td>${coupon.cup_contents}</td>
                <td>${coupon.cup_dc}</td>
                <td>${coupon.cup_type}</td>
            </tr>
        </c:forEach>
    </table>
    <a href="/getCouponList.do">쿠폰 목록</a>
</body>
</html>