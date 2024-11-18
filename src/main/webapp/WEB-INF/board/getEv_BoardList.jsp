<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file ="../sub/header.jsp" %>
<style>
#searchNav {
	-webkit-justify-content: flex-end;
	justify-content: flex-end;
}
</style>
<script>
    function updateEventStatus() {
        var currentTime = new Date();
        var tableRows = document.getElementsByTagName("tr");

        for (var i = 1; i < tableRows.length; i++) {
            var endDateString = tableRows[i].getElementsByTagName("td")[4].innerText;
            var endDate = new Date(endDateString);

            if (endDate < currentTime) {
                tableRows[i].getElementsByTagName("td")[5].innerText = "종료";
                var ev_num = tableRows[i].getAttribute("onclick").match(/\d+/)[0]; 
                updateEventStatusOnServer(ev_num);
            }
        }
    }

    function updateEventStatusOnServer(ev_num) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {

            }
        };
        xhttp.open("GET", "updateEv_Board1.do?ev_num=" + ev_num, true);
        xhttp.send();
    }

    window.onload = function() {
        updateEventStatus();
    };
</script>

<body>
	<div class="jumbotron">
		<h1>이벤트 게시판</h1>
	</div>
<%-- 	<%@ include file="../../menu.jsp"%> --%>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getEv_boardList.do" method="post">
			<select class="form-control" id="sel1" name="searchCondition"
				style="display: inline-block !important; margin-right: 10px;">
				<%--         <c:forEach items="${conditionMap}" var="option"> --%>
				<%-- 	        <option value="${option.value}">${option.key}</option> --%>
				<%--         </c:forEach> --%>
				<option value="${conditionMap['제목']}">제목</option>
				<option value="${conditionMap['내용']}">내용</option>
			</select> <input class="form-control mr-sm-2" type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요.">
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</nav>
	<div class="container-fluid">
		<table class="table table-hover">
			<thead class="btn-primary">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>시작날짜</th>
					<th>종료날짜</th>
					<th>진행상태</th>
					<th>이미지</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ev_boardList}" var="ev_board" varStatus="status">
					<tr onclick="selTrr(${ev_board.ev_num})" style="cursor: pointer;">
						<%-- 						<td class="tdCenter">${status.index + 1}</td> --%>
						<td class="tdCenter">${ev_board.rowno}</td>
						<td>${ev_board.ev_title}</td>
						<td class="tdCenter">${ev_board.ev_sdate.substring(0, 16)}</td>
						<td class="tdCenter">${ev_board.ev_edate.substring(0, 16)}</td>
						<td class="tdCenter">${ev_board.ev_status}</td>
						<td><c:if test="${ev_board.ev_img ne ''}">
								<img
									src="${pageContext.request.contextPath}/resources/img/${ev_board.ev_img}"
									alt="이미지" width="100" height="100">
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div id="pageBtnParentDiv">
			<c:if test="${pi.currentPage > 1}">
				<button class="pageBtn" type="button"
					onclick="location.href='getEv_boardList.do?currentPage=${pi.currentPage - 1}';">이전</button>
			</c:if>

			<c:choose>
				<c:when test="${pi.maxPage <= 3}">
					<c:forEach var="i" begin="1" end="${pi.maxPage}" step="1">
						<button class="pageBtn" type="button"
							onclick="location.href='getEv_boardList.do?currentPage=${i}';">${i }</button>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${pi.currentPage <= 2}">
							<c:forEach var="i" begin="1" end="3" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getEv_boardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:when test="${pi.currentPage > pi.maxPage - 2}">
							<c:forEach var="i" begin="${pi.maxPage - 2}" end="${pi.maxPage}"
								step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getEv_boardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="${pi.currentPage - 1}"
								end="${pi.currentPage + 1}" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getEv_boardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<c:if test="${pi.currentPage < pi.maxPage}">
				<button class="pageBtn" type="button"
					onclick="location.href='getEv_boardList.do?currentPage=${pi.currentPage + 1}';">다음</button>
			</c:if>
		</div>



		<style>
#pageBtnParentDiv {
	text-align: center;
}

button.pageBtn {
	margin-right: 20px;
	padding: 5px 15px;
}
</style>


		<br> <br>
		<div id="footer">
			<button type="button" id="conWrite1" class="btn btn-primary"
				<c:if test="${userId eq NULL}">disabled</c:if>>글쓰기</button>

						<a class="nav-link" href="insertEv_Board.jsp">글쓰기</a>
		</div>
		
		
	</div>
</body>
</html>
