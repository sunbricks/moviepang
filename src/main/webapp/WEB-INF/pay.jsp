<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
var chk = false;
$(document).ready(function(){
   
   var IMP = window.IMP;
   IMP.init('imp01861206');
   
   var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
      
    if(!isMobile) {
       //모바일이 아닌 경우 스크립트
                console.log("rsp모바일 아닌경우1" + isMobile);
       $("#check_module").click(function () {
          IMP.request_pay({
              pg: "danal_tpay", // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount : $("#amount").val(),
             buyer_email: $("#umail").val() ,
             buyer_name: $("#unm").val() ,
             buyer_tel: $("#utel").val() ,
             buyer_addr: $("#uaddr").val() ,
             buyer_postcode: '123-456',
             }, function (rsp) {
                console.log("rsp모바일 아닌경우2" + rsp);
                if (rsp.success) {
                   var msg = '결제가 완료되었습니다.';
                   msg += '\n고유ID : ' + rsp.imp_uid;
                   msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                   msg += '\n결제 금액 : ' + rsp.paid_amount;
                   msg += '\n카드 승인번호 : ' + rsp.apply_num;
                   
                   $("#imp_uid").val(rsp.imp_uid);
                   $("#merchant_uid").val(rsp.merchant_uid);
                   chk = true;
                } else {
                   var msg = '결제에 실패하였습니다.';
                   msg += '\n에러내용 : ' + rsp.error_msg;
                }
                alert(msg);
                if(chk==true) orderList();
          });
       });
        
    } else {
        
       //모바일인 경우 스크립트
       $("#check_module").click(function () {
          IMP.request_pay({
             pg: '9810030929', // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount: $("#amount").val(),
             buyer_email: $("#umail").val() ,
             buyer_name: $("#unm").val() ,
             buyer_tel: $("#utel").val() ,
             buyer_addr: $("#uaddr").val() ,
             buyer_postcode: '123-456',
             m_redirect_url: 'http://localhost:8090/payments/complete',
//              popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
             }, function (rsp) {
                console.log("rsp모바일인 경우" + rsp);
          });
       });
        
    }
                         
   
//    $("#check_module").click(function () {
//       IMP.request_pay({
//          pg: 'A010002002', // 자신이 설정한 pg사 설정
// //          pg: 'INIpayTest', // 자신이 설정한 pg사 설정
//          pay_method: 'card',
//          merchant_uid: 'merchant_' + new Date().getTime(),
//          popup : false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
//          name: '주문명:결제테스트',
//          amount: $("#amount").val(),
//          buyer_email: $("#umail").val() ,
//          buyer_name: $("#unm").val() ,
//          buyer_tel: $("#utel").val() ,
//          buyer_addr: $("#uaddr").val() ,
//          buyer_postcode: '123-456',
//          m_redirect_url: 'http://localhost:8090/payments/complete'
//          }, function (rsp) {
//             console.log(rsp);
//             if (rsp.success) {
//                var msg = '결제가 완료되었습니다.';
//                msg += '\n고유ID : ' + rsp.imp_uid;
//                msg += '\n상점 거래ID : ' + rsp.merchant_uid;
//                msg += '\n결제 금액 : ' + rsp.paid_amount;
//                msg += '\n카드 승인번호 : ' + rsp.apply_num;
               
//                $("#imp_uid").val(rsp.imp_uid);
//                $("#merchant_uid").val(rsp.merchant_uid);
//                chk = true;
//             } else {
//                var msg = '결제에 실패하였습니다.';
//                msg += '\n에러내용 : ' + rsp.error_msg;
//             }
//             alert(msg);
//             if(chk==true) orderList();
//       });
//    });
   
   
   $("#cancel_module").click(function () {
      $.ajax({
         url : "paycan",
         data : {"mid": $("#merchant_uid").val()},
         method : "POST",
         success : function(val){
            console.log(val);
            if(val==1){
               alert("취소 완료");
               $("#all_module").trigger("click");
            }
            else alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
         },
         error :  function(request, status){
            alert("취소가 실패하였습니다.");
         }
      });
   });
   
   $("#list_module").click(function(){
      $.ajax({
         url : "payamount",
         data : {"mid": $("#merchant_uid").val()},
         method : "GET",
//          contentType : 'application/json; charset=UTF-8',
         success : function(val){
            console.log(val);
            $("#paylist").empty();
            if(val.msg!=null){
               $("#paylist").append(val.msg);
            }else{
               $("#paylist").append("고유ID: "+val.imp_uid);
               $("#paylist").append("<br>상점 거래ID: "+val.merchant_uid);
               $("#paylist").append("<br>주문상품: "+val.name);
               $("#paylist").append("<br>주문자: "+val.buyer_name);
               $("#paylist").append("<br>결제금액: "+val.amount);
            }
         },
         error :  function(request, status){
            alert("목록 가져오기를 할 수 없습니다.");
         }
      });
   });
   
   $("#all_module").click(function(){
      $.ajax({
         url : "paylist",
         method : "GET",
//          contentType : 'application/json; charset=UTF-8',
         success : function(val){
            console.log(val);
            $("#paylist").empty();
            $.each(val, function(i, v){
               $("#paylist").append("고유ID: "+v.imp_uid);
               $("#paylist").append("<br>상점 거래ID: "+v.merchant_uid);
               if(v.cancel_amount != 0 ) $("#paylist").append("<br><span style=\"color:red;font-weight:bold;\">주문취소</span>");
               else if(v.failed_at != 0 ) $("#paylist").append("<br><span style=\"color:pink;font-weight:bold;\">결제오류</span>");
               else $("#paylist").append("<br><span style=\"color:blue;font-weight:bold;\">결제완료</span>");
               $("#paylist").append("<br>주문상품: "+v.name);
               $("#paylist").append("<br>주문자: "+v.buyer_name);
               $("#paylist").append("<br>결제금액: "+v.amount+"<hr><br>");
            });
            
         },
         error :  function(request, status){
            alert("목록 가져오기를 할 수 없습니다.");
         }
      });
   });
   
});

function orderList(){
   alert('주문내역 처리할 곳. 컨트롤러 호출');
   let fm = document.fm;
   fm.action ="paying.do";
   fm.method="post";
   fm.submit();
}







</script>

</head>
<body>
<form name="fm">
<div style="position:sticky;top:0;left:0;background-color:#fff;padding-bottom:20px;border-bottom:1px solid #000;">
   <h2>아임 서포트 결제 모듈 테스트 해보기</h2><br>
   <h2>결제하기</h2>
   이름: <input type="text" name="unm" id="unm" placeholder="이름 입력" value="김성준"><br>
   전화번호: <input type="text" name="utel" id="utel" placeholder="예시: 010-1111-2222" value=""><br>
   금액: <input type="number" name="amount" id="amount" class="totalprice">
   <button id="check_module" type="button">결제하기</button>
   <br><hr>   
   
   ${CartList}
   <table>
   <tr>
      <th>상품명</th>
      <th>상품수량</th>
      <th>상품가격</th>
      <th></th>
   </tr>
   <c:forEach items="${CartList}" var="cart">
   <tr>
   <td>${cart.prd_name }</td>
   <td>${cart.cart_count }</td>
   <td class="price_td">${cart.prd_price * cart.cart_count }</td>
                        <td class="td_width_1 cart_info_td">
                           <input type="hidden" class="cartPrice_input" value="${cart.prd_price}">
                           <input type="hidden" class="cartCount_input" value="${cart.cart_count}">
                           <input type="hidden" class="totalPrice_input" value="${cart.prd_price * cart.cart_count}">
                           <input type="hidden" class="prdNum_input" value="${cart.prd_num}">                        
                        </td>
                        
   </tr>
  </c:forEach>
   </table>
   <p>전체 금액 : <span class="totalprice"></span> </p>
    <label for="couponList">할인 쿠폰 선택:</label>
    <select name="couponList" id="couponList">
        <option value="">쿠폰을 선택하세요</option>
        <c:forEach items="${couponList}" var="coupon">
            <option value="${coupon.cup_contents}">${coupon.cup_dc}%</option>
        </c:forEach>
    </select>
   <button id="check_module" type="button">결제하기</button>
                        
   
   <h2>결제내역 관련</h2>
   imp_uid: <input type="text" name="imp_uid" id="imp_uid" placeholder="imp_uid 입력"><br>
   
: <input type="text" name="merchant_uid" id="merchant_uid" placeholder="merchant_uid 입력"><br>
   <button id="cancel_module" type="button">취소하기</button>
   <button id="list_module" type="button">결제완료목록조회</button>
   <button id="all_module" type="button">모든목록조회</button>
</div>
   
   <p id="paylist"></p>
</form>

<script>

var originalTotalAmount = 0; // 원래의 전체 금액 저장 변수

$(document).ready(function(){
    /* 종합 정보 섹션 정보 삽입 */
    setTotalInfo();   
    $("#couponList").click(function() {
        applyCoupon();
    });
});   

function setTotalInfo(){
    $(".totalPrice_input").each(function(){
        originalTotalAmount += parseInt($(this).val());
    });
    $(".totalprice").text(originalTotalAmount.toLocaleString());
    document.getElementById("amount").value = originalTotalAmount;

}

function applyCoupon() {
    var couponName = $("#couponList option:selected").text();
    var couponValue = parseInt(couponName.replace('%', ''));
    var totalAmount = originalTotalAmount; // 원래의 전체 금액으로 초기화

    if (couponValue > 0) { // 쿠폰이 선택된 경우
        // 할인된 전체 금액 계산
        var discountedTotal = totalAmount - (totalAmount * (couponValue / 100));
        $(".totalprice").text(discountedTotal.toLocaleString());
        document.getElementById("amount").value = discountedTotal;

    } else { // 쿠폰을 선택하지 않은 경우
        $(".totalprice").text(totalAmount.toLocaleString());
        document.getElementById("amount").value = totalAmount;

    }
}
</script>

</body>
</html>