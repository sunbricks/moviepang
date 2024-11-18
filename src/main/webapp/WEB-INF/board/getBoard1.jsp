<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file ="../sub/header.jsp" %>
<%
String sts = "";
if (session.getAttribute("userId") == null) {
	sts = "disabled";
}
%>
<style>
#imgBox {
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	height: 100vh !important;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 999999;
}

#imgContentBox {
	width: 600px;
	max-height: 550px;
	overflow: auto;
	position: absolute;
	top: 30%;
	left: 30%;
	border-radius: 5px;
	z-index: 999999;
}

#imgBoxTitleBar {
	border-bottom: 1px solid #777;
	border-radius: 5px 5px 0 0;
	background-color: #ddd;
	width: 100%;
	padding: 10px;
	text-align: right;
	font-size: 20px;
	font-weight: bolder;
}

#imgBoxImg {
	width: 100%;
	border-radius: 0 0 5px 5px;
}

#closeX {
	padding: 5px 20px;
	border-radius: 5px;
	border: 1px solid #777;
	background-color: red;
	color: #fff;
}

#closeX:hover {
	background-color: #777;
	cursor: pointer;
}
</style>
<body>
	<div class="jumbotron">
		<h1>상세 보기admin</h1>
	</div>
<%-- 	<%@ include file="../../menu.jsp"%> --%>
	<div class="container-fluid">
		<%
		if (request.getParameter("error") != null) {
			out.println("<div class='alert alert-danger'>");
			out.println("해당 글은 작성자만이 수정할 수 있습니다.");
			out.println("</div>");
		}
		%>
		<form name="fm" action="updateBoard.do" method="post">
			<input type="hidden" name="bn_num" value="${board.bn_num}">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">제목</span>
				</div>
				<input type="text" class="form-control innm" name="bn_title" value="${board.bn_title}"  <%=sts %>>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">구분</span>
				</div>
				<input type="text" class="form-control innm" name="bn_ttpe" value="${board.bn_type}" readonly <%=sts %>> 
				<input type="radio" id="vehicle1" name="bn_type" value="시스템 점검">
				<label for="vehicle1">시스템 점검</label><br>
				<input type="radio" id="vehicle2" name="bn_type" value="극장">
				<label for="vehicle2">극장</label><br>
				<input type="radio" id="vehicle3" name="bn_type" value="행사 / 이벤트">
				<label for="vehicle3">행사 / 이벤트</label><br>
				<input type="radio" id="vehicle4" name="bn_type" value="제휴 이벤트">
				<label for="vehicle4">제휴 이벤트</label><br>
				<input type="radio" id="vehicle5" name="bn_type" value="기타">
				<label for="vehicle5">기타</label><br>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">내용</span>
				</div>
				<textarea class="form-control innm" rows="10" id="comment" name="bn_content" <%=sts%>>${board.bn_content}</textarea>
			</div>

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">등록일</span>
				</div>
				<input type="text" class="form-control innm" name="bn_date" value="${board.bn_date}" readonly <%=sts %>>
			</div>

			<div id="footer">
				<%-- 	  	<button type="submit" class="btn btn-primary" <c:if test="${ !(userRole eq 'Admin' || userRole eq 'Super' )}">disabled</c:if>>글수정</button> --%>
				<% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                    <button type="submit" class="btn btn-primary">글수정</button>
                <% } %>
                
                <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                    <button id="conWrite" type="button" class="btn btn-primary" <c:if test="${ userId eq null }">disabled</c:if>>글쓰기</button>
                <% } %>
                
                <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                    <button id="conDel" type="button" class="btn btn-primary" <c:if test="${ !(userRole eq 'Admin' || userRole eq 'Super')}">disabled</c:if>>글삭제</button>
                <% } %>
				
				<button id="conList" type="button" class="btn btn-primary">글목록</button>
			</div>
		</form>
	</div>
</body>
</html>
