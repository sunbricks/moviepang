<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8"><title>login</title>
</head><body>
<jsp:include page="../commons/menu.jsp" />
	<h1>로그인</h1>
	<form method="post" action="./login.do">
		<input type="text" name="userId">
		<input type="password" name="userPw">
		<input type="submit" value="로그인">
	</form>
</body></html>
