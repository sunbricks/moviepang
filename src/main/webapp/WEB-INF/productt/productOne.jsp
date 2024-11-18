<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {box-sizing : border-box;}
div#topDiv {width: 1200px; max-width: 100%; margin: 30px auto; overflow: auto;}
div.topDiv {float:left;}
div.topDiv:first-child {padding-left: 10px;width:20%;}
div.topDiv:nth-of-type(2) {width:80%;padding-left: 10px;}
h2 {text-align:center;}
</style>
</head>
<body>
<h1>상품 상세 페이지</h1>
<a href="${pageContext.request.contextPath }/updateForm.ko?pno=${pOne.pno}">
<button type="button" >수정하기</button>
</a>
<div id="topDiv">
	<div class="topDiv">
		<p>썸네일 <br><img src="${pageContext.request.contextPath }/resources/thumbnail/${pOne.pthumbnail }" style="width:200px;height:200px;"></p>
	</div>
	<div class="topDiv">
		<p>상품명 : ${pOne.pname }</p>
		<p>상품가격 : <fmt:formatNumber value="${pOne.pprice }" />원</p>
	</div>
</div>
<div style="clear:both;">
	<h2>상품상세페이지 보기 (데이터베이스 longtext)</h2>
	${pOne.pdetail }
</div><br><hr><br>
<div>
	<h2>상품상세페이지 보기 2 (file생성한 데이터)</h2>
	<div id="detail2">${pageContext.request.contextPath }/WEB-INF/product/${pOne.pfilename }"></div>
</div>
<script>
window.onload = function(){
		let str = '<%=request.getParameter("msg")%>';
		var httpReq = new XMLHttpRequest();
		httpReq.open("GET", './productDetailpage.ko?pno=${pOne.pno}', false);
		httpReq.onreadystatechange = function(){
			if( httpReq.readyState == 4 && httpReq.status == 200  ) {
				var fileData = httpReq.responseText;
				console.log('fileData: ',fileData);
				document.querySelector("#detail2").innerHTML = fileData;
			}
		};
		httpReq.send();
};
</script>
</body>
</html>