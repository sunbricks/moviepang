<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../sub/header.jsp"%>
<%
String sts = "";
if (session.getAttribute("userId") == null) {
    sts = "disabled";
}
%>
<style>
/* Your existing CSS styles */
</style>
<body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="jumbotron">
        <h1>상세 보기</h1>
    </div>
<%--     <%@ include file="../../menu.jsp"%> --%>
    <div class="container-fluid">
        <% if (request.getParameter("error") != null) { %>
            <div class='alert alert-danger'>
                해당 글은 작성자만이 수정할 수 있습니다.
            </div>
        <% } %>
        <form name="fm" action="getBoard1.do" method="post">
            <input type="hidden" name="bn_num" value="${Board.bn_num}">
            <table class="table">
                <tr>
                    <th>제목</th>
                    <td><input type="text" class="form-control innm" name="bn_title" value="${Board.bn_title}" readonly <%=sts %>></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea class="form-control innm" rows="10" id="comment" name="bn_content" readonly <%=sts%>>${Board.bn_content}</textarea></td>
                </tr>
                <tr>
                    <th>등록일</th>
                    <td><input type="text" class="form-control innm" name="bn_date" value="${Board.bn_date}" readonly <%=sts %>></td>
                </tr>
            </table>
               
                <button id="conList" type="button" class="btn btn-primary">글목록</button>
        </form>
    </div>
</body>