<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width ; charset=UTF-8">
<title>Insert title here</title>
<style>
* {box-sizing : border-box;}
table{border-collapse: collapse; width: 1200px; max-width:100%;margin: 10px auto;}
table, th, td {border : 1px solid #555;}
th, td {padding : 20px; vertical-align:middle;}
</style>
</head>
<body>
<h1>상품목록 입니다.</h1>

<table>
<tr><th>썸네일</th><th>상품번호</th><th>상품명</th><th>상품가격</th><th>파일명</th></tr>
<c:choose>
	<c:when test="${fn:length(pList) > 0}">
		<c:forEach items="${pList }" var="pdt">
			<tr onclick="location.href='${pageContext.request.contextPath }/productDetail.ko?pno=${pdt.pno}'">
				<td><img src="${pageContext.request.contextPath }/resources/thumbnail/${pdt.pthumbnail }" style="width:200px;height:200px;"></td>
				<td>${pdt.pno }</td>
				<td>${pdt.pname}</td>
				<td>${pdt.pprice }</td>
				<td>${pdt.pfilename }</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<td colspan="5">등록된 상품 정보가 없습니다.</td>
	</c:otherwise>
</c:choose>
</table>
</body>
</html>