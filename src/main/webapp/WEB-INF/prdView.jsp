<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <%@include file ="sub/header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

$(function(){
   //수량 버튼 조작
      let count = $(".prdcount").val();
      $(".plus_btn").on("click", function(){
         $(".prdcount").val(++count);
      });
      $(".min_btn").on("click", function(){
         if(count > 1){
            $(".prdcount").val(--count);   
         }
      });


      
      // 장바구니 추가 버튼
      $(".btn_cart").on("click", function(e){
         
         // 서버로 전송할 데이터
         const form = {
               mem_id : '<%= id %>',
               prd_num : '${prd.prd_num}',
               cart_count : $(".prdcount").val()
         }
         
         $.ajax({
            url: 'insertCart.do',
            type: 'POST',
            data: form,
            success: function(result){
               alert("장바구니에 추가했습니다.");
            }
         })
      });
      
   });
</script>
</head>
<body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
   
${prd.prd_name}
${prd.prd_type}
${prd.prd_desc}
${prd.prd_price}
   <form action="gift.do" method ="post" >
   <input type="hidden" name="prd_num" value="${prd.prd_num}">
   <input type="hidden" name="prd_name" value="${prd.prd_name}">
   <input type="hidden" name="prd_type" value="${prd.prd_type}">
   <input type="hidden" name="prd_desc" value="${prd.prd_desc}">
   <input type="hidden" name="prd_price" value="${prd.prd_price}">
<button type="submit">선물하기</button>
   </form>



<input type="hidden" name="mem_id" value="<%= id %>">
      <input type   ="text" name="cart_count" class="prdcount" value="1">
      <span>
         <button type="button" class="plus_btn">+</button>
         <button type="button" class="min_btn">-</button>
      </span>   <br>
      <br><br><br>
      <div class="button_set">
         <a class="btn_cart" style="cursor:pointer;" >장바구니 담기</a><br><br>   
         <a href="/getCartList.do?mem_id=<%=id %>" style="cursor:pointer;" >장바구니 가기</a>
         
         
         
         <a class="btn_buy">바로 구매</a>
      </div>
   
   <br>




</body>
</html>