<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>
<div id="find_myid_con">
    <div class="find_myid_con_box pd_box inner">
        <h1 class="find_myid_title">아이디 찾기 성공</h1>

        <div class="find_myid_success_box">
    <span class="find_myid_success_txt">귀하의 아이디는</span>
    <span class="find_myid">${foundId}</span>
</div>
        <div class="find_myid_btn_box">
            <a href="../index.jsp" class="find_myid_btn">메인으로</a>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  var foundIdElement = document.querySelector(".find_myid");
  if (foundIdElement) {
    var originalId = foundIdElement.textContent;
    var visibleChars = 3; // 보여줄 문자 수
    var maskedPart = "****"; // 고정된 마스킹 패턴
    foundIdElement.textContent = originalId.slice(0, visibleChars) + maskedPart;
  }
});
</script>

<%@include file="./footer.jsp"%>
