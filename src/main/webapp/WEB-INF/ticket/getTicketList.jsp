<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.4.js" -->
<!-- 	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" -->
<!-- 	crossorigin="anonymous"></script> -->
<title>Insert title here</title>
</head>
<body>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getTicketList.do" method="post">
			<select class="form-control" id="sel1" name="searchCondition"
				style="display: inline-block !important; margin-right: 10px;">
				<%-- 				<option value="${conditionMap['아이디']}">아이디</option> --%>
				<option value="${ticketConditionMap['이름']}">이름</option>
			</select> <input class="form-control mr-sm-2" type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요.">
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</nav>

	<div class="container-fluid">
		<table class="table table-hover">
			<thead class="btn-primary">
				<tr>
					<th>예매번호</th>
					<th>예매자</th>
					<th>상영명</th>
					<th>관람일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ticketList}" var="ticket">
					<tr onclick="selTr(${ticket.TIC_Num})" style="cursor: pointer;">
						<%-- 						<td class="tdCenter"><img src="${pageContext.request.contextPath}/resources/img/${movie.mov_Post}" ></td> --%>
						<td class="tdCenter">${ticket.TIC_Num}</td>
						<td>${ticket.TIC_Name}</td>
						<td>${ticket.TIC_MovName}</td>
						<td class="tdCenter">${ticket.TIC_WatDate}</td>
						<td><button onclick="ticDelete(${ticket.TIC_Num})">예매취소</button>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br> <br>

		<div id="pageBtnParentDiv">
			<c:if test="${pi.currentPage > 1}">
				<button class="pageBtn" type="button"
					onclick="location.href='getTicketList.do?currentPage=${pi.currentPage - 1}';">이전</button>
			</c:if>

			<c:choose>
				<c:when test="${pi.maxPage <= 3}">
					<c:forEach var="i" begin="1" end="${pi.maxPage}" step="1">
						<button class="pageBtn" type="button"
							onclick="location.href='getTicketList.do?currentPage=${i}';">${i }</button>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${pi.currentPage <= 2}">
							<c:forEach var="i" begin="1" end="3" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getTicketList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:when test="${pi.currentPage > pi.maxPage - 2}">
							<c:forEach var="i" begin="${pi.maxPage - 2}" end="${pi.maxPage}"
								step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getTicketList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="${pi.currentPage - 1}"
								end="${pi.currentPage + 1}" step="1">
								<button class="pageBtn" type="button"
									onclick="location.href='getBoardTicketList.do?currentPage=${i}';">${i }</button>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<c:if test="${pi.currentPage < pi.maxPage}">
				<button class="pageBtn" type="button"
					onclick="location.href='getTicketList.do?currentPage=${pi.currentPage + 1}';">다음</button>
			</c:if>
		</div>
		<script>
		  function ticDelete(val){
			  var conf = confirm("예매를 취소하시겠습니까?");
			  if(conf == true){
			  location.href = "deleteTicket.do?TIC_Num=" + val ;
			  }else{
				  confirm("이미 예매가 취소되었습니다.");
			  }
		  }

		  function selTr(val){
				location.href = "getTicket.do?TIC_Num="+val;
			}
		
		
  </script>
</body>
</html>