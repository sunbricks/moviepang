<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Path Variable 페이지입니다.</h2>
	<p>key1 = ${ key1 } ${param.key1 } <%=request.getParameter("key1") %>></p>
	<p>key2 = ${ key2 } ${param.key2 } <%=request.getParameter("key2") %></p>
</body>
</html>