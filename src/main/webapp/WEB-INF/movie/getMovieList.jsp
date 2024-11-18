<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getMovieList.do"
			method="post">
			<input class="form-control mr-sm-2" type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요.">
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</nav>
	
	<div class="container-fluid">
		<table class="table table-hover">
			<thead class="btn-primary">
				<tr>
					<th>번호</th>
					<th>상영관명</th>
					<th>상영영화제목</th>
<!-- 					<th>상영날짜</th> -->
<!-- 					<th>상영시작시간</th> -->
<!-- 					<th>등록일</th> -->
<!-- 					<th>조조,심야할인</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${MovieList}" var="movie">
					<tr onclick="selTr(${movie.mov_Num})" style="cursor: pointer;">
						<td class="tdCenter"><img src="${pageContext.request.contextPath}/resources/img/${movie.mov_Post}" ></td>
						<td class="tdCenter">${movie.mov_Num}</td>
						<td>${movie.mov_Nm}</td>
<%-- 						<td class="tdCenter">${MovScreen.mov_sTime}</td> --%>
<%-- 						<td class="tdCenter">${MovScreen.mov_sRegistDate}</td> --%>
<%-- 						<td class="tdCenter">${MovScreen.mov_sDiscount}</td> --%>
						<td><button onclick="movDelete(${movie.mov_Num})">삭제</button>
							<button onclick="movModify(${movie.mov_Num})">수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<br>
		<script>
		  function movDelete(mov_Num){
			  var conf = confirm("상영 정보를 삭제하시겠습니까?");
			  if(conf == true){
			  location.href = "deleteMovie.do?mov_Num=" + mov_Num ;
			  }else{
				  confirm("삭제불가");
			  }
		  }
		  
		  function movModify(mov_Num){
			  location.href = "gotoupdateMovie.do?mov_Num=" + mov_Num ;
		  }
// 		  function selTr(val){
// 				location.href = "getMovie.do?seq="+val;
// 			}
		
		
  </script>
</body>
</html>