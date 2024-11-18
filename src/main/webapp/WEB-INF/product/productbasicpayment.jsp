<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../sub/header.jsp"%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script>
var chk = false;
$(document).ready(function(){
   
   var IMP = window.IMP;
   IMP.init('imp01861206');
   var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
      
       //모바일이 아닌 경우 스크립트
    if(!isMobile) {
       $("#check_module").click(function () {
        var selectPay = $(".payHow").text().trim();
          var prd_num = $('#prd_name').val();

         if (selectPay === "일반 결제" && prd_num.trim() != "") {
          IMP.request_pay({
              pg: "danal_tpay", // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             mem_id : $("#mem_id").val(),
             amount : $("#amount2").val(),
             mem_nm : $("#mem_nm").val(),
             prd_type : $("#prd_type").val(),
             buyer_name: $("#mem_nm").val() ,
             buyer_tel: $("#mem_tel").val() ,
             buyer_postcode: '123-456',
             paymethod : $("#paymethod").val(),
             }, function (rsp) {
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
                if(chk==true) orderList();
          });
         }else if(selectPay === "포인트 결제" && prd_num.trim() != ""){
            
             orderList();
         }else{
            alert("장바구니에 아무것도 없습니다.");
         }
       });
        
    } else {
        
       //모바일인 경우 스크립트
       $("#check_module").click(function () {
          var selectPay = $(".payHow").text().trim();
          var prd_num = $('#prd_name').val();
           if (selectPay === "일반 결제" && prd_num != "") {
          IMP.request_pay({
             pg: "danal_tpay", // 자신이 설정한 pg사 설정
              pay_method: 'card',
              merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount: $("#amount").val(),
//              name: '주문명:결제테스트',
             mem_id : $("#mem_id").val(),
             amount : $("#amount2").val(),
             mem_nm : $("#mem_nm").val(),
             prd_type : $("#prd_type").val(),
             buyer_name: $("#mem_nm").val() ,
             buyer_tel: $("#mem_tel").val() ,
             buyer_postcode: '123-456',
             paymethod : $("#paymethod").val(),
             m_redirect_url: 'http://localhost:8090/payments/complete',
//              popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
             }, function (rsp) {
                if (rsp.success) {
                   $("#imp_uid").val(rsp.imp_uid);
                   $("#merchant_uid").val(rsp.merchant_uid);

                   chk = true;
                } else {
                   var msg = '결제에 실패하였습니다.';
                   msg += '\n에러내용 : ' + rsp.error_msg;
                }
                if(chk==true) orderList();
          });
       }else if(selectPay === "포인트 결제" && prd_num != ""){
          
          orderList();

       }else{
           alert("장바구니에 아무것도 없습니다.");
       }
       });
        
    }

   $("#cancel_module").click(function () {
      $.ajax({
         url : "paycanPoint.do",
         data : {"mid": $("#merchant_uid1").val()},
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
   let fm = document.fm;
   fm.action ="paying.do";
   fm.method="post";
   fm.submit();
}

</script>
<div id="product_payment_con">
   <div class="product_payment_con pd_box inner">
      <h1 class="product_payment_title">구매상품 정보</h1>
      <div class="product_payment_info_box">
         <table>
            <thead>
               <tr>
                  <th>상품명</th>
                  <th>판매금액</th>
                  <th>수량</th>
                  <th>구매금액</th>
               </tr>
            </thead>
               <tbody>
            <c:forEach items="${CartList}" var="cart">
                  <tr>
                     <td>
                        <div class="pro_sort">
                           <img style="width:200px; height:200px;" src="${pageContext.request.contextPath}/resources/prdImg/${cart.prd_img }" alt="사진없음">
                           <div>${cart.prd_name }</div>
                        </div>
                     </td>
                     <td class="cartPrice_input">${cart.prd_price }</td>
                     <td class="cartCount_input">${cart.cart_count }</td>
                     <td class="totalPrice_input"><fmt:formatNumber value="${cart.prd_price * cart.cart_count}" pattern = "#,### 원"/></td>
                  </tr>
            </c:forEach>
               </tbody>
         </table>
         <div class="total_payment_price_box">
<!--             <label for="couponList">할인 쿠폰 선택:</label> <select name="couponList" -->
<!--                id="couponList"> -->
<!--                <option value="">쿠폰을 선택하세요</option> -->
<%--                <c:forEach items="${couponList}" var="coupon"> --%>
<%--                   <option value="${coupon.cup_contents}">${coupon.cup_dc}%</option> --%>
<%--                </c:forEach> --%>
<!--             </select>  -->
 <c:set var="totalPaymentPrice" value="0" />
    <c:forEach items="${CartList}" var="cart">
        <c:set var="totalPaymentPrice" value="${totalPaymentPrice + (cart.prd_price * cart.cart_count)}" />
    </c:forEach>
            <span class="total_payment_txt">총 결제 예정금액</span><span class="total_payment_price"><fmt:formatNumber value="${totalPaymentPrice}" pattern = "#,### 원"/></span>

         </div>

         <form>
            <div class="payment_con_box">
               <div class="pay_con_title">결제자 정보</div>
               <div class="pay_info_box">
                  <div class="pay_sort_box">
                     <div class="pay_sort">
                        <div>결제자 이름</div>
                        <input type="text" name="mem_nm" value="<%=name%>" readonly>
                     </div>

                     <div class="pay_sort">
                        <div>결제자 번호</div>
                        <input type="text" name="mem_tel" value="<%=tel%>" readonly>
                     </div>
                  </div>
               </div>
            </div>

            <div class="payment_con_box">
               <div class="pay_con_title">결제 수단</div>
               <div class="pay_info_box">
                  <div class="pay_sort_box">
                     <div class="pay_sort">
                        <label for="basicpay">일반결제</label> <input type="radio"
                           name="payment" value="일반 결제" id="basicpay" checked>
                     </div>

                     <div class="pay_sort">
                        <label for="pointpay">포인트결제</label> <input type="radio"
                           name="payment" value="포인트 결제" id="pointpay">
                     </div>
                     
                     <input type="hidden" id="amount"  class="total_payment_price" readonly>
                  </div>
               </div>
            </div>

            <button type="button" class="payments_btn" id="go_final_prd_payment">결제하기</button>
         </form>
      </div>
   </div>
</div>

<div class="final_product_payment_modal">
   <div class="final_product_payment_modal_body">
      <div class="final_product_pay_modal_title">구매내역 확인</div>

      <form name="fm">
      
         <input type="hidden" id="imp_uid" name="imp_uid">
         <input type="hidden" id="merchant_uid" name="merchant_uid" value="">
         <input type="hidden" id="mem_id" name="mem_id" value=<%=id %>>
         <table>
            <thead>
               <tr>
                  <th class="final_product_info_box">구매 정보</th>
                  <th class="final_payment_info_box">결제 정보</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td class="final_product_info_box">
                     <div>
                        <img style="width:200px; height:200px;" src="${pageContext.request.contextPath}/resources/prdImg/${CartList[0].prd_img }" alt="사진없음">
                     </div>
                     <div>
                        <div class="final_sort">
                           <div>구매상품</div>
                           <input style="font-size:0px" class="final_input" id="prd_name" name="prd_name" type="text" value="${CartList[0].prd_name} " readonly>
                           <span> ${CartList[0].prd_name} </span>&nbsp;
                           
                              <span id="cartSizeSpan"> 외 ${CartList.size()-1} 건</span>

                           <script>
                                document.addEventListener("DOMContentLoaded", function() {
                               var cartSize = ${CartList.size()};
                               var cartSizeSpan = document.getElementById("cartSizeSpan");

                               if (cartSize < 2) {
                                    cartSizeSpan.style.display = 'none';
                                  }      
                                });
                             </script>
                        </div>

                        <div class="final_sort">
                           <div>상품정보</div>
                           <input style="font-size:0px" class="final_input" id="prd_type" name="prd_type" type="text" value=" ${CartList[0].prd_type }" readonly>${CartList[0].prd_type }
                        </div>

                        <div class="final_sort">
                           <div>결제자 이름</div>
                           <input style="font-size:0px" class="final_input" id="mem_nm" name="mem_nm" type="text" value=<%=name%> readonly><%=name%>
                        </div>

                        <div class="final_sort">
                           <div>결제자 번호</div>
                           <input style="font-size:0px" class="final_input" id="mem_tel" name="mem_tel" type="text" value=<%=tel %> readonly> <%=tel%>
                        </div>
                     </div>
                  </td>
                  <td class="final_payment_info_box final_payment">
                     <div class="final_sort">
                        <div>결제방식</div>
                        <input style="font-size:0px" class="final_input" type="hidden"  id="paymethod" name="paymethod" value="" readonly><span class="payHow"></span>
                     </div>
                     <div class="mypoint">
                     <div class="final_sort" >
                        <div>MyPoint</div>
                        <input style="font-size:0px; " class="final_input" type="text" name="mypoint" value=<%=mp %> readonly><span class="mp"><%=mp %> </span>
                     </div>
                     </div>
                     <div class="final_sort">
                        <div>결제금액</div>
                        <input class="final_input point_price" type="text" id="amount1" value="" readonly>
                        <input class="final_input point_price" type="hidden" id="amount2" name="amount" value="" readonly>
<!--                         <span class="totalprice"></span> -->
                     </div>
                  </td>
               </tr>
            </tbody>
         </table>

         <div class="button_box">
            <button type="button" class="payment_confirm" id="check_module">결제하기</button>
            <button type="button" class="product_payment_cancle">취소</button>
         </div>
      </form>
   </div>
</div>
<script>
var totalPaymentElement = document.querySelector('.total_payment_price');

// 요소가 존재하는지 확인 후 값 가져오기
if (totalPaymentElement) {
    var totalPayment = totalPaymentElement.textContent; // 요소의 텍스트 내용 가져오기
} else {
}

  document.querySelector('#amount1').value = totalPayment;
  
  var totalPaymentElement1 = document.querySelector('.total_payment_price');

// 요소가 존재하는지 확인 후 값 가져오기
if (totalPaymentElement1) {
    var totalPayment1 = totalPaymentElement1.textContent; // 요소의 텍스트 내용 가져오기
    // 콤마, 공백, '원' 문자열 제거
    totalPayment1 = totalPayment1.replace(/,/g, '').replace(/\s+/g, '').replace('원', '');
} else {
    // 요소를 찾을 수 없는 경우에 대한 처리 추가
}



// input 요소에 값 설정
document.querySelector('#amount2').value = totalPayment1;

</script>
   <script>
   
      document.addEventListener('DOMContentLoaded', (event) => {
           // 함수 정의: 결제 방식을 업데이트하는 함수
           function updatePaymentMethod() {
               const selectedPayment = document.querySelector('input[name="payment"]:checked').value;
               document.querySelector('.payHow').textContent = selectedPayment;
               
           }
           // 페이지 로드 시 초기 결제 방식 설정
           updatePaymentMethod();

           // 모든 결제 방식 라디오 버튼에 이벤트 리스너 추가
           const paymentRadios = document.querySelectorAll('input[name="payment"]');
           paymentRadios.forEach((radio) => {
               radio.addEventListener('change', updatePaymentMethod);
           });
       });

 var originalTotalAmount = 0; // 원래의 전체 금액 저장 변수

 
$(document).ready(function(){
    const mp = document.querySelector('.mp').value;
    /* 종합 정보 섹션 정보 삽입 */
    setTotalInfo();   
    $("#couponList").click(function() {
        applyCoupon();
    });
   
});   

 
 //전체 값 가져오기
function setTotalInfo(){

  var totalPriceInputs = $(".totalPrice_input"); // 클래스명이 "totalPrice_input"인 모든 요소를 선택
  const merchant = 'merchant_' + new Date().getTime();
  var selectPay = $(".payHow").text().trim();
  
    
//     applyCoupon();
    
    //mid만들기
    document.querySelector("#merchant_uid").value = merchant;
   
}

 
 
//  //할인 쿠폰 적용하기
// function applyCoupon() {
//     var couponName = $("#couponList option:selected").text();
//     var couponValue = parseInt(couponName.replace('%', ''));
//     var totalAmount = originalTotalAmount; // 원래의 전체 금액으로 초기화

//     if (couponValue > 0) { // 쿠폰이 선택된 경우
//         // 할인된 전체 금액 계산
//         var discountedTotal = totalAmount - (totalAmount * (couponValue / 100));
//         $(".total_payment_price").text(discountedTotal.toLocaleString());
//         $("#amount").text(discountedTotal.toLocaleString());
//         document.getElementById("amount").value = discountedTotal;
//         document.querySelector('.point_price').value = discountedTotal;


//     } else { // 쿠폰을 선택하지 않은 경우
//         $(".total_payment_price").text(totalAmount.toLocaleString());
//         document.getElementById("amount").value = totalAmount;

//     }
// }

 
 // 포인트 결제와 일반 결제 분리
$(document).ready(function(){
    $(".mypoint").css('display', 'none');
});   

$("#go_final_prd_payment").click(function(e) {
    var selectPay = $(".payHow").text().trim(); // jQuery로 클래스 payHow를 선택
    var prd_num = $('#prd_name').val();
    if(selectPay === "일반 결제" && prd_num.trim() != ""){
        document.querySelector('#paymethod').value = selectPay;
        $(".mypoint").css('display', 'none'); 
    }else if(selectPay === "포인트 결제" && prd_num.trim() != "") {
        document.querySelector('#paymethod').value = selectPay;
        $(".mypoint").css('display', 'inline'); 
    }else{
        e.preventDefault(); // 기본 폼 제출 막기
        $(".final_product_payment_modal_body").css('display', 'none'); 
//         $(".final_product_payment_modal").css('display', 'none');
      $(".final_product_payment_modal").remove();

        alert("장바구니에 아무것도 없습니다.")
    }
});



 </script>
<%@include file="../sub/footer.jsp"%>