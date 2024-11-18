<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
    
    <meta content="yes" name="apple-mobile-web-app-capable" />  
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=no" name="viewport" />
    <title>Movie Pang</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.min.css" />

</head>
<body>
    <div id="admin_con">
        <div class="admin_con_box">
            <h1 class="admin_title">관리자 로그인</h1>
            <form action="adminlogin.do">
                <div>
                    <input type="text" id="userId" name="mem_id" placeholder="관리자 아이디">
                </div>
                <div>
                    <input type="password" id="password" name="mem_pwd" placeholder="비밀번호">
                </div>
                <div>
                    <button type="submit" class="btn2 submit_btn"  value="Login" onclick="validateLogin()">로그인</button>
                </div>
            </form>

            <a href="/index.jsp" class="go_mainpage" >
                홈으로 돌아가기
            </a>
        </div>
    </div>
</body>
</html>