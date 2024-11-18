<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../sub/header.jsp"%> --%>
<%
// String sts = "";
// if (session.getAttribute("userId") == null) {
//     sts = "disabled";
// }
%>
<style>
/* Your existing CSS styles */
</style>
<body>
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
        <form name="fm" action="getTicket.do" method="post">
            <input type="hidden" name="TIC_Num" value="${ticket.TIC_Num}">
            <table class="table">
                <tr>
                    <th>예매번호</th>
                    <td><input type="text" class="form-control innm" name="TIC_Num" value="${ticket.TIC_Num}" readonly></td>
                </tr>
                <tr>
                    <th>영화제목</th>
                    <td><input type="text" class="form-control innm" name="TIC_MovName" value="${ticket.TIC_MovName}" readonly></td>
                </tr>
                <tr>
                    <th>관람일</th>
                    <td><input type="text" class="form-control innm" name="TIC_WatDate" value="${ticket.TIC_WatDate}" readonly></td>
                </tr>
                <tr>
                    <th>관람시간</th>
                    <td><input type="text" class="form-control innm" name="TIC_WatTime" value="${ticket.TIC_WatTime}" readonly></td>
                </tr>
                <tr>
                    <th>관람인원</th>
                    <td><input type="text" class="form-control innm" name="TIC_WatNum" value="${ticket.TIC_WatNum}" readonly></td>
                </tr>
                <tr>
                    <th>관람좌석</th>
                    <td><input type="text" class="form-control innm" name="TIC_RoomSeat" value="${ticket.TIC_RoomSeat}" readonly></td>
                </tr>
                <tr>
                    <th>티켓금액</th>
                    <td><input type="text" class="form-control innm" name="TIC_Price" value="${ticket.TIC_Price}" readonly></td>
                </tr>
            </table>

            <div id="footer">
                
                <% if (session.getAttribute("userId") != null && session.getAttribute("userId").equals("admin")) { %>
                    <button id="conDel" type="button" class="btn btn-primary" <c:if test="${ !(userRole eq 'Admin' || userRole eq 'Super')}">disabled</c:if>>예매삭제</button>
                <% } %>
                
                <button id="conList" type="button" class="btn btn-primary">예매내역</button>
            </div>
        </form>
    </div>
</body>
