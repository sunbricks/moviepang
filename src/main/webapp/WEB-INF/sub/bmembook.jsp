<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="bmembook.do" method="post">
<input id="agree_1" type="radio" name="agree" value="y"><label for="agree_1">동의</label><br>
<input id="agree_2" type="radio" name="agree" value="n"><label for="agree_2">비동의</label><br>
<label for="txtNm">이름</label>
<input id="txtNm" type="text" name="bmem_nm"><br>
<label for="txtBirthday">법정 생년월일(8자리)</label>
<input id="txtBirthday" type="text" name="bmem_bir"><br>
<label for="txtMobile">휴대폰 번호</label>
<input id="txtMobile" type="text" name="bmem_tel"><br>
<label for="txtAuthNum">인증번호</label>
<input id="txtAuthNum" type="text" name="bmem_telchk"><br>
<label for="txtPwd">비밀번호(4자리)</label>
<input id="txtPwd" type="password" name="bmem_pwd"><br>
<label for="txtChkPwd">비밀번호확인</label>
<input id="txtChkPwd" type="password" name="bmem_pwdchk"><br>
<button>비회원예매하기</button>
</form>
</body>
</html>