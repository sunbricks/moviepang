<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>

<script>
    // 비밀번호 확인 필드와 새 비밀번호 필드의 값을 비교하여 유효성을 검사하는 함수
    function validatePassword() {
        var newPassword = document.getElementById("new_pwd").value;
        var confirmPassword = document.getElementById("confirm_pwd").value;
        
        // 비밀번호 확인 필드와 새 비밀번호 필드의 값이 같은지 확인
        if (newPassword !== confirmPassword) {
            alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return false; // 폼 전송을 중단
        }
        return true; // 유효성 검사 통과
    }

    // 폼이 제출될 때 validatePassword 함수를 호출하여 유효성 검사 수행
    document.querySelector(".reset_pwd_form").addEventListener("submit", function(event) {
        if (!validatePassword()) {
            event.preventDefault(); // 폼 제출 중단
        }
    });
</script>


<div id="reset_pwd_con">
    <div class="reset_pwd_mainbox pd_box">
        <h1 class="reset_pwd_title">비밀번호 재설정</h1>
        <h2 class="reset_pwd_sub">
            보안인증이 완료되었습니다. 새로 사용하실 비밀번호를 입력해주세요.
        </h2>

        <form id="resetPwdForm" action="resetPwd.do" class="reset_pwd_form" method="post" onsubmit="return validateForm()">
            <div class="form_group">
                <div class="label">아이디</div>
                <%-- 아이디 값을 가져와서 마스킹 처리 --%>
                <%
                String memberId = request.getParameter("mem_id");
                %>
                <input id="mem_id" name="mem_id" type="text" readonly value="<%=memberId%>" />
            </div>

            <div class="form_group">
                <div class="label">새 비밀번호</div>
                <input type="password" name="mem_pwd" id="mem_pwd" pattern="[a-zA-Z0-9!_\-!@#$%^&*]+" minlength="10" maxlength="16" placeholder="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)" required>
            </div>

            <div class="form_group">
                <div class="label">비밀번호 확인</div>
                <input type="password" name="confirm_pwd" id="confirm_pwd" pattern="[a-zA-Z0-9!_\-!@#$%^&*]+" minlength="10" maxlength="16" placeholder="비밀번호와 같이 입력해주세요" required>
            </div>

            <div class="form_group">
                <button type="submit" class="btn2 submit_btn">비밀번호 변경</button>
            </div>
        </form>
    </div>
</div>

<script>
function validateForm() {
    var pwd = document.getElementById("mem_pwd").value;
    var confirmPwd = document.getElementById("confirm_pwd").value;

    if (pwd !== confirmPwd) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }

    var pwdPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{10,16}$/;
    if (!pwdPattern.test(pwd)) {
        alert("비밀번호 형식이 맞지 않습니다.");
        return false;
    }

    return true;
}

// document.addEventListener("DOMContentLoaded", function() {
<%--     var sucessMessage = "<%= request.getSession().getAttribute("success") %>"; --%>
<%--     var errorMescsage = "<%= request.getSession().getAttribute("error") %>"; --%>

//     if (successMessage) {
//         alert(successMessage);
//         request.getSession().removeAttribute("success");
//     }

//     if (errorMessage) {
//         alert(errorMessage);
//         request.getSession().removeAttribute("error");
//     }
// });
</script>

<%@include file="./footer.jsp"%>
