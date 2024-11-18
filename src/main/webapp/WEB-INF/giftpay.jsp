<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
       $("#check_module").click(function () {
          IMP.request_pay({
              pg: "danal_tpay", // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount: $("#amount").val(),
             buyer_email: $("#umail").val() ,
             buyer_name: $("#unm").val() ,
             buyer_tel: $("#utel").val() ,
             buyer_addr: $("#uaddr").val() ,
//              prd_serial: $("#prd_serial").val(),
             prd_name: $("#prd_name").val(),
             prd_num: $("#prd_num").val(),
             prd_price: $("#amount").val(),
             gift_buyer: $("#gift_buyer").val(),
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
             prd_num: $("#").val(),
             buyer_postcode: '123-456',
             m_redirect_url: 'http://localhost:8090/payments/complete',
//              popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
             }, function (rsp) {
                console.log(rsp);
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
//       });1715328178283
//    });
   
   
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
   fm.action ="giftPaying.do";
   fm.method="post";
   fm.submit();
}

var code;
var telSent = false; // 문자 전송 여부를 추적하는 변수
function giftCheckBtn() {
    	console.log("선물하기 타니");
    	console.log("결제버튼 클릭");
        let tel = $('#gift_owntel').val()
        let name = $('#gift_buyer').val()
        let prdName= $('#prd_name').val()
        let prd_num = $('#prd_num').val()
        console.log('입력 전화번호 : ' + tel);

        $.ajax({
        	 url: "gifttelCheck.do?tel=" + tel, 
            type: 'GET',
            data: { 
            	tel: $('#gift_owntel').val(),
            	name: $('#gift_buyer').val(),
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


</head>
<body>
<form name="fm">
<div style="position:sticky;top:0;left:0;background-color:#fff;padding-bottom:20px;border-bottom:1px solid #000;">
   <h2>아임 서포트 결제 모듈 테스트 해보기</h2><br>
   <h2>결제하기</h2>
   이름: <input type="text" name="unm" id="unm" placeholder="이름 입력" value="${sessionScope.mem_nm}"><br>
   전화번호: <input type="text" name="utel" id="utel" placeholder="예시: 010-1111-2222" value="${sessionScope.mem_tel}"><br>
   금액: <input type="number" name="amount" id="amount"  value="${param.prd_price}"><br>   
   <input type="hidden" id="prd_serial" name="prd_serial" value="${param.prd_serial}">
   <input type="hidden" id="prd_num" name = "prd_num" value="${param.prd_num }">
   <input type="hidden" id="prd_name" name = "prd_name" value="${param.prd_name }">
   <input type="hidden" id="prd_price" name = "prd_price" value="${param.prd_price }">
   <input type="hidden" id="gift_buyer" name = "gift_buyer" value="${param.gift_buyer }">
   <input type="hidden" id="gift_owner" name = "gift_owner" value="${param.gift_owner }">
   <input type="hidden" id="gift_owntel" name = "gift_owntel" value="${param.gift_owntel }">
   <input type="hidden" id="prd_cnt" name = "prd_cnt" value="${param.prd_cnt}">
   <button id="check_module" type="button">결제하기</button>
   <br><hr>   
   
   <h2>결제내역 관련</h2>
   imp_uid: <input type="text" name="imp_uid" id="imp_uid" placeholder="imp_uid 입력"><br>
   merchant_uid: <input type="text" name="merchant_uid" id="merchant_uid" placeholder="merchant_uid 입력"><br>
   <button id="cancel_module" type="button">취소하기</button>
   <button id="list_module" type="button">결제완료목록조회</button>
   <button id="all_module" type="button">모든목록조회</button>
</div>
   
   <p id="paylist"></p>
</form>

</body>
</html>