<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file ="../sub/header.jsp" %>

<style>
#searchNav {
	-webkit-justify-content: flex-end;
	justify-content: flex-end;
}

#paging {
	margin-top: 20px;
}

#paging ul.pagination li.page-item {
	display: inline-block;
	margin-right: 5px;
}

#paging ul.pagination li.page-item.active span {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
	cursor: default;
}
</style>

<body>
	<div class="jumbotron">
		<h1>공지 사항</h1>
	</div>
<%-- 	<%@ include file="../../menu.jsp"%> --%>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getBoardList.do" method="post">
			<select class="form-control" id="sel1" name="searchCondition"
				style="display: inline-block !important; margin-right: 10px;">
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
					<th>구분</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList}" var="board" varStatus="status">
					<tr onclick="selTr(${board.bn_num})" style="cursor: pointer;">
						<%--                             <td class="tdCenter">${status.index + 1}</td> --%>
						<td class="tdCenter">${board.rowno}</td>
						<td>${board.bn_title}</td>
						<td class="tdCenter">${board.bn_type}</td>
						<td class="tdCenter">${board.bn_date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="pageBtnParentDiv">
			<c:if test="${pi.currentPage > 1}">
				<button class="pageBtn" type="button"
					onclick="location.href='getBoardList.do?currentPage=${pi.currentPage - 1}';">이전</button>
			</c:if>

			<c:choose>
				<c:when test="${pi.maxPage <= 3}">
					<c:forEach var="i" begin="1" end="${pi.maxPage}" step="1">
						<button class="pageBtn" type="button"
							onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${pi.currentPage <= 2}">
							<c:forEach var="i" begin="1" end="3" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:when test="${pi.currentPage > pi.maxPage - 2}">
							<c:forEach var="i" begin="${pi.maxPage - 2}" end="${pi.maxPage}"
								step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="${pi.currentPage - 1}"
								end="${pi.currentPage + 1}" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<c:if test="${pi.currentPage < pi.maxPage}">
				<button class="pageBtn" type="button"
					onclick="location.href='getBoardList.do?currentPage=${pi.currentPage + 1}';">다음</button>
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


		<div id="footer">
			<button type="button" id="conWrite" class="btn btn-primary"
				<c:if test="${userId eq NULL}">disabled</c:if>>글쓰기</button>
				
				<a class="nav-link" href="insertBoard.jsp">글쓰기</a>
		</div>
	</div>
</body>
</html>