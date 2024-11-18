<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="jumbotron">
        <h1>상세 보기</h1>
    </div>
<%--     <%@ include file="../../menu.jsp"%> --%>
    <div class="container-fluid">
        <%
        if (request.getParameter("error") != null) {
            out.println("<div class='alert alert-danger'>");
            out.println("해당 글은 작성자만이 수정할 수 있습니다.");
            out.println("</div>");
        }
        %>
        <form name="fm" action="getEv_Board1.do" method="post">
            <input type="hidden" name="ev_num" value="${Ev_board.ev_num}">
            <table class="table table-bordered">
                <tr>
                    <td>제목</td>
                    <td><input type="text" class="form-control innm" name="ev_title" value="${Ev_board.ev_title}" readonly <%=sts %>></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea class="form-control innm" name="ev_content" readonly <%=sts%>>${Ev_board.ev_content}</textarea></td>
                </tr>
                <tr>
                    <td>시작날짜</td>
                    <td><input type="datetime-local" class="form-control" id="ev_sdate" name="ev_sdate" value="${Ev_board.ev_sdate}" readonly <%=sts%>></td>
                </tr>
                <tr>
                    <td>종료날짜</td>
                    <td><input type="datetime-local" class="form-control" id="ev_edate" name="ev_edate" value="${Ev_board.ev_edate}" readonly <%=sts%>></td>
                </tr>
                <tr>
                    <td>진행상태</td>
                    <td>
                        <input type="text" class="form-control innm" id="ev_status_display" value="${Ev_board.ev_status}" disabled>
                        <input type="hidden" name="ev_status" id="ev_status" value="${Ev_board.ev_status}" <%=sts %>>
                    </td>
                </tr>
                <tr>
                    <td>이미지 파일</td>
                    <td>
                        <c:if test="${not empty Ev_board.ev_img}">
                            <img src="<%=request.getContextPath()%>/resources/prdImg/${Ev_board.ev_img}" alt="이미지" width="100" height="100">
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                            <button type="submit" class="btn btn-primary">글수정</button>
                        <% } %>
                        <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                            <button id="conWrite1" type="button" class="btn btn-primary" <%=sts%>>글쓰기</button>
                        <% } %>
                        <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                            <button id="conDel1" type="button" class="btn btn-primary">글삭제</button>
                        <% } %>
                        <button id="conList1" type="button" class="btn btn-primary">글목록</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>