<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>
<div id="loginpage_con">
	<div class="loginpage_mainbox pd_box">
		<h1 class="login_title">무비팡 로그인</h1>
		<%
	      if ("true".equals(request.getParameter("error"))) {      %>
	      <script>
	         alert("아이디 또는 비밀번호 불일치");
	      </script>
	      <%
	      }
	      %>

		<form action="login.do" class="login_form">
			<div>
				<input type="text" name="mem_id" placeholder="아이디">
			</div>
			<div>
				<input type="password" name="mem_pwd" placeholder="비밀번호">
			</div>
			<div>
				<button type="submit" class="btn2 submit_btn">로그인</button>
			</div>
		</form>

		<div class="sub_menu_box">
			<div class="go_joinform">
				<a href="/joinform.do">회원가입</a>
			</div>
			<div class="find_myinfo">
				<a href="/findinfo.do">ID/PW 찾기</a>
			</div>
<!-- 			<div class="nonmember_chk"> -->
<!-- 				<a href="#">비회원 예매확인</a> -->
<!-- 			</div> -->
<!-- 			<div class="nonmember_chk"> -->
<!-- 				<a href="/bmem.do">비회원 예매하기</a> -->
<!-- 			</div> -->

		</div>

		<div class="sns_login_box">
			<a href="getNaverAuthUrl.do?inout=1" class="naver_login"> 
				<img src="${pageContext.request.contextPath}/resources/img/sns_naver.png" alt="네이버 계정으로 로그인">
			</a> 
			<a class="kakao_login">
				<img onclick="kakaoLogin()" src="${pageContext.request.contextPath}/resources/img/sns_kakao.png" alt="카카오 계정으로 로그인">
			</a>
		</div>
	</div>
</div>
<%@include file="./footer.jsp"%>