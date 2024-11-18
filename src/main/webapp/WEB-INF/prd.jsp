<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <%@include file ="sub/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script> 
function giftFunction(val, event) {
    console.log("val:", val); // val 값 확인
    location.href = "/getPrd.do?prd_num=" + val;
}
</script>
</head>
<body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

   <div>스토어</div>
<ul>
    <li><a href="/getPrdList.do?type=스낵">스낵</a></li>
</ul>
<c:forEach items="${prd_List}" var="prd">
    <c:if test="${prd.prd_type eq '스낵'}">
        <div>
            <a href="#" onclick="giftFunction('${prd.prd_num}')">${prd.prd_name}</a>
            <span>${prd.prd_price}</span> <span>${prd.prd_num}</span>
        </div>
    </c:if>
</c:forEach>

<ul>
    <li><a href="/getPrdList.do?type=기프트카드">기프티콘</a></li>
</ul>
<c:forEach items="${prd_List}" var="prd">
    <c:if test="${prd.prd_type eq '기프트카드'}">
        <div>
            <a href="#" onclick="giftFunction('${prd.prd_num}')">${prd.prd_name}</a>
            <span>${prd.prd_price}</span> <span>${prd.prd_num}</span>
        </div>
    </c:if>
</c:forEach>
   

   <div>
      상품 등록
      <form action="insertPrd.do" method="post" enctype="multipart/form-data">
         <input type="text" name="prd_num" placeholder="상품번호를 입력해주세요">
         <input type="text" name="prd_name" placeholder="상품 이름을 입력해주세요">
         <input type="text" name="prd_type" placeholder="상품 종류를 입력해주세요">
         <input type="text" name="prd_desc" placeholder="상품 설명을 입력해주세요">
         <input type="text" name="prd_price" placeholder="상품 가격을 입력해주세요">
         <div class="form-group">
                        <label for="prd_img">파일선택</label>
                        <input type="file" class="form-control" id="prd_img" name="uploadFile" onchange="readURL(this);">
                        <img id="preview"/>
                    </div>
         <button type="submit">상품등록</button>
      </form>
   </div>
</body>
</html>