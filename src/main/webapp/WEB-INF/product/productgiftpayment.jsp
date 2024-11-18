<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../sub/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
       $("#check_module").click(function () {
          var selectPay = $(".payHow").text().trim();
           var prd_name = $('#prd_name').val();
           console.log("selectPay " + selectPay);
           console.log("prd_name "+ prd_name);
           

           if (selectPay === "일반 결제" && prd_name.trim() != ""){
               console.log("Processing 일반 결제");
               console.log("처음" + isMobile);
          IMP.request_pay({
              pg: "danal_tpay", // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             imp_uid: 'imp_uid',
             name: '주문명:결제테스트',
             amount: $("#amount2").val(),
             buyer_email: $("#umail").val() ,
             buyer_name: $("#unm").val() ,
             buyer_tel: $("#utel").val() ,
             buyer_addr: $("#uaddr").val() ,
             prdStatus: $("#paymethod").val(),
             prd_serial: $("#prd_serial").val(),
             prd_name: $("#prd_name").val(),
             prd_num: $("#prd_num").val(),
             prd_price: $("#amount2").val(),
             gift_buyer: $("#unm").val(),
             gift_owner: $("#gift_owner").val(),
             gift_owntel: $("#gift_owntel").val(),
             prd_cnt: $("#prd_cnt").val(),
             buyer_postcode: '123-456',
           
             }, function (rsp) {

                console.log(rsp);
                if (rsp.success) {
                   var msg = '결제가 완료되었습니다.';
                   msg += '\n고유ID : ' + rsp.imp_uid;
                   msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                   msg += '\n결제 금액 : ' + rsp.paid_amount;
                   msg += '\n카드 승인번호 : ' + rsp.apply_num;
                   
                   $("#imp_uid").val(rsp.imp_uid);
                   $("#merchant_uid").val(rsp.merchant_uid);
                   chk = true;
                   giftCheckBtn();
                } else {
                   
                   var msg = '결제에 실패하였습니다.';
                   msg += '\n에러내용 : ' + rsp.error_msg;
                }
                alert(msg);
                if(chk==true) orderList();
          });
          }else if(selectPay === "포인트 결제" && prd_name.trim() != ""){
               
               console.log("Processing 포인트 결제");
               orderList();
               giftCheckBtn();
           }else{
              console.log("장바구니 아무것도 없는 경우");
              alert("장바구니에 아무것도 없습니다.");
           }
       });
        
    } else {
        
       //모바일인 경우 스크립트
       $("#check_module").click(function () {
          IMP.request_pay({
             pg: 'danal_tpay', // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount: $("#amount2").val(),
             buyer_email: $("#umail").val() ,
             buyer_name: $("#unm").val() ,
             buyer_tel: $("#utel").val() ,
             buyer_addr: $("#uaddr").val() ,
             prdStatus: $("#paymethod").val(),
             prd_serial: $("#prd_serial").val(),
             prd_name: $("#prd_name").val(),
             prd_num: $("#prd_num").val(),
             prd_price: $("#amount2").val(),
             gift_buyer: $("#unm").val(),
             gift_owner: $("#gift_owner").val(),
             gift_owntel: $("#gift_owntel").val(),
             prd_cnt: $("#prd_cnt").val(),
             buyer_postcode: '123-456',
             m_redirect_url: 'http://localhost:8090/giftpayments/complete',
//              popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
             }, function (rsp) {
                console.log(rsp);
          });
       });
        
    }
                         
   
   
   
   $("#cancel_module").click(function () {
      $.ajax({
         url : "paycan.do",
         data : 
         {
            "mid": $("#merchant_uid").val(),
            "prd_serial": $("#merchant_uid").val()
            },
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

            
         },
         error :  function(request, status){
            alert("목록 가져오기를 할 수 없습니다.");
         }
      });
   });
   
});

function orderList(){
   let fm = document.fm;
   fm.action ="giftPaying.do";
   fm.method="post";
   fm.submit();
}

var code;
var telSent = false; // 문자 전송 여부를 추적하는 변수

function giftCheckBtn() {
       
      let tel = $('#gift_owntel').val()
        let name = $('#unm').val()
        let prdName= $('#prd_name').val()
        let prd_num = $('#prd_num').val()
        console.log('구매자이름:' + name);
        console.log('상품이름:' + prdName);
        console.log('상품이름:' + prd_num);
        console.log('입력 전화번호 : ' + tel);

        $.ajax({
            url: "gifttelCheck.do?tel=" + tel, 
            type: 'GET',
            data: { 
               tel: $('#gift_owntel').val(),
               name: $('#unm').val(),
               prdName: $('#prd_name').val(),
               prd_num: $('#prd_num').val()
               }, // 폰 번호 데이터 전송
            success: function(code1) {
                $('#prd_num').val(code1);
                console.log("code1 : " + code1);
                code = code1;
                telSent = true; // 문자 전송 상태 업데이트
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });

      telSent = true;
      console.log("code: " + code);
      console.log("tel: " + tel);
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
                    <tr>
                        <td>
                            <div class="pro_sort">
                                <img src="/resources/prdImg/${prd.prd_img}" alt="">
                                <div>${prd.prd_name}</div>
                            </div>
                        </td>
                        <td><fmt:formatNumber value="${prd.prd_price}" pattern="#,### 원" /></td>
                        <td>${param.prd_cnt}</td>
                        <td id="totalPrice"><fmt:formatNumber value="${prd.prd_price * param.prd_cnt}" pattern="#,### 원" /></td>
                    </tr>
                </tbody>
            </table>
            <div class="total_payment_price_box">
                <span class="total_payment_txt">총 결제 예정금액</span>
                <span id="prd_price" class="total_payment_price"><fmt:formatNumber value="${prd.prd_price * param.prd_cnt}" pattern="#,### 원" /></span>
            </div>

            <form>
<%--               <input type="hidden" id="prd_serial" name="prd_serial" value="${param.prd_serial}"> --%>
<%--               <input type="hidden" id="prd_num" name="prd_num" value="${prd.prd_num}"> --%>
            <input type="hidden" id="prd_name" name="prd_name" value="${prd.prd_name}" readonly><br>
              <input type="hidden" id="prd_totalprice" name="prd_price" value="${prd.prd_price * param.prd_cnt}" readonly>
              <input type="hidden" id="unm" name="gift_buyer" value="${sessionScope.mem_nm}"><br>
              <input type="hidden" name="utel" id="utel" placeholder="예시: 010-1111-2222" value="${sessionScope.mem_tel}">
<%--               <input type="hidden" id="prd_cnt" name = "prd_cnt" value="${param.prd_cnt}"> --%>
                <div class="payment_con_box">
                    <div class="pay_con_title">선물 받는 분 정보</div>
                    <div class="pay_info_box">
                        <div class="pay_sort_box">
                            <div class="pay_sort">
                                <div>이름</div> 
                                <input type="text" id="recName" name="gift_owner"  placeholder="받는 사람 이름 입력">
                            </div>

                            <div class="pay_sort">
                                <div>휴대전화 번호</div>
                                <input type="text" id="rectel" name="gift_owntel" placeholder="- 없이 입력">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="payment_con_box">
                    <div class="pay_con_title">결제 수단</div>
                    <div class="pay_info_box">
                        <div class="pay_sort_box">
                            <div class="pay_sort">
                                    <label for="basicpay">일반결제</label>
                                    <input type="radio" name="payment" id="basicpay" value="일반 결제" checked>
                                </div>

                                <div class="pay_sort">
                                    <label for="pointpay">포인트결제</label>
                                    <input type="radio" name="payment" id="pointpay" value="포인트 결제">
                                </div>
                        </div>
                    </div>
                </div>

                <button type="button" id="go_final_prd_payment" class="payments_btn">결제하기</button>
            </form>
        </div>
    </div>
</div>
<div class="final_product_payment_modal">
        <div class="final_product_payment_modal_body">
            <div class="final_product_pay_modal_title">
                구매내역 확인
            </div>

            <form name="fm">
             <input type="hidden" id="imp_uid" name="imp_uid">
        	 <input type="hidden" id="merchant_uid" name="merchant_uid" value="">
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
                                    <img src="${pageContext.request.contextPath}/resources/prdImg/${prd.prd_img}" alt="">
                                </div>
                                <div>
                                    <div class="final_sort">
                                        <div>구매상품</div>
                                        <input class="final_input" name="prd_name" id="prd_name" type="text" value="${prd.prd_name}" >
                                    </div>
                                    <div class="final_sort">
                                        <div>상품정보</div>
                                        <input class="final_input" type="text" value="${prd.prd_type}" >
                                    </div>
                                    <input type="hidden" id="prd_serial" name="prd_serial" value="${param.prd_serial}">
                                     <input type="hidden" id="gift_buyer" name = "gift_buyer" value="${sessionScope.mem_nm}">
                                     <input type="hidden" name="amount" id="amount"  value="${prd.prd_price * param.prd_cnt}">
                                     <input type="hidden" name="prd_cnt" id="prd_cnt"  value="${param.prd_cnt}">
                                     <input type="hidden" id="prd_num" name="prd_num" value="${prd.prd_num}">
                                     <input type="hidden" name="gift_buyertel" id="utel" placeholder="예시: 010-1111-2222" value="${sessionScope.mem_tel}">

                                    <div class="final_sort">
                                        <div>받는 사람 이름&nbsp;</div>
                                        <input class="final_input" type="text" id="gift_owner" name="gift_owner" value="" readonly>
                                    </div>

                                    <div class="final_sort">
                                        <div>받는 사람 번호&nbsp;</div>
                                        <input class="final_input" id="gift_owntel" name="gift_owntel" value="" type="text" readonly>
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
                                    <input class="final_input point_price" id = "amount1" name="" type="text" value="" readonly>
                                    <input class="final_input point_price" id = "amount2" name="prd_price" type="hidden" value="" readonly>
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
    
    function validateForm(e) {
        console.log("몇번호출되나요?");
         var recName = $("#recName").val();
         var rectel = $("#rectel").val();

         if (!recName || !rectel) {
             alert("받는 사람의 이름과 번호를 입력해주세요.");
           //  e.preventDefault(); // 이벤트 객체를 통해 기본 동작을 방지
             return false;
         }
         document.querySelector('.final_product_payment_modal').style.display = 'block';
         return true; // 검증 성공 시 true 반환
     }
    
     document.getElementById("recName").addEventListener("blur", function(e){
      console.log(e.target.value);
      let recname = e.target.value;
      document.getElementById("gift_owner").value = recname;
      console.log(document.getElementById("gift_owner").value);
   });
   document.getElementById("rectel").addEventListener("blur", function(e){
      console.log(e.target.value);
      let rectel = e.target.value;
      document.getElementById("gift_owntel").value = rectel;
      console.log(document.getElementById("gift_owntel").value);
   });
   document.getElementById("basicpay").addEventListener("blur", function(e){
      console.log(e.target.value);
      let basicpay = e.target.value;
      document.getElementById("paymethod").value = basicpay;
      console.log(document.getElementById("paymethod").value);
   });
   document.getElementById("pointpay").addEventListener("blur", function(e){
      console.log(e.target.value);
      let pointpay = e.target.value;
      document.getElementById("paymethod").value = pointpay;
      console.log(document.getElementById("paymethod").value);
   });

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
   console.log("mp " + mp);
    /* 종합 정보 섹션 정보 삽입 */
    setTotalInfo();   
    $("#couponList").click(function() {
        applyCoupon();
    });
   
});   
 
 
//전체 값 가져오기
function setTotalInfo(){

//   var totalPriceInputs = $(".totalPrice_input"); // 클래스명이 "totalPrice_input"인 모든 요소를 선택
  const merchant = 'merchant_' + new Date().getTime();
  
//     totalPriceInputs.each(function() {
//          originalTotalAmount += parseInt($(this).text()); // 현재 요소의 텍스트 내용을 가져와 정수로 변환
//     });
     
// //     $(".total_payment_price").text(originalTotalAmount.toLocaleString());
//     document.querySelector('.point_price').value = originalTotalAmount;
    
//     applyCoupon();
    
//     //mid만들기
    document.querySelector("#merchant_uid").value = merchant;
   console.log("merchant " + merchant);
   
}

//포인트 결제와 일반 결제 분리
$(document).ready(function(){
    $(".mypoint").css('display', 'none');
});   

$("#go_final_prd_payment").click(function(e) {
	validateForm(e);
    var selectPay = $(".payHow").text().trim(); // jQuery로 클래스 payHow를 선택
    var prd_name = $('#prd_name').val();
    console.log("selectPay " + selectPay);
    console.log("prd_name " + prd_name);
    if(selectPay === "일반 결제" && prd_name.trim() != ""){
        document.querySelector('#paymethod').value = selectPay;
        $(".mypoint").css('display', 'none'); 
        console.log("일반 결제 " + selectPay);
    }else if(selectPay === "포인트 결제" && prd_name.trim() != "") {
        document.querySelector('#paymethod').value = selectPay;
        $(".mypoint").css('display', 'inline'); 
        console.log("포인트 결제 " + selectPay);
    }else{
        e.preventDefault(); // 기본 폼 제출 막기
        $(".final_product_payment_modal_body").css('display', 'none'); 
//         $(".final_product_payment_modal").css('display', 'none');
      $(".final_product_payment_modal").remove();

        alert("장바구니에 아무것도 없습니다.")
    }
});
</script>
<script>
var totalPaymentElement = document.querySelector('.total_payment_price');

// 요소가 존재하는지 확인 후 값 가져오기
if (totalPaymentElement) {
    var totalPayment = totalPaymentElement.textContent; // 요소의 텍스트 내용 가져오기
    console.log("총 결제 예정금액:", totalPayment);
} else {
    console.log("요소를 찾을 수 없습니다.");
}

  document.querySelector('#amount1').value = totalPayment;
  
  var totalPaymentElement1 = document.querySelector('.total_payment_price');

// 요소가 존재하는지 확인 후 값 가져오기
if (totalPaymentElement1) {
    var totalPayment1 = totalPaymentElement1.textContent; // 요소의 텍스트 내용 가져오기
    console.log("총 결제 예정금액:", totalPayment1);
    // 콤마, 공백, '원' 문자열 제거
    totalPayment1 = totalPayment1.replace(/,/g, '').replace(/\s+/g, '').replace('원', '');
} else {
    console.log("요소를 찾을 수 없습니다.");
    // 요소를 찾을 수 없는 경우에 대한 처리 추가
}
// input 요소에 값 설정
document.querySelector('#amount2').value = totalPayment1;
</script>
<%@include file ="../sub/footer.jsp" %>