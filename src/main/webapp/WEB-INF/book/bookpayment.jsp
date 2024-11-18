<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<%@include file ="../sub/header.jsp" %>
 <input type="hidden" id="tic_ID" value="${ticket.tic_Id}"><br>
 <input type="hidden" id="tic_MemName"  value="${ticket.tic_MemName}"><br>
 <input type="hidden" id="tic_MemPhoneNum"  value="${ticket.tic_MemId}"><br>
 <% Integer point = (Integer) session.getAttribute("mem_mp"); %>
 <input type="hidden" id="mem_point"  value=<%=point%>><br>


<div id="bookpayment_con">
    <div class="bookpayment_con pd_box inner">
        <h1 class="bookpayment_title">영화 예매</h1>
        <div class="book_payment_box">
            <div class="book_payment_top">
                <div class="book_payment_left">
                    <div class="step_box">
                        <div class="step_title">STEP.1 쿠폰</div>
                        <div class="pay_coupon_box">
                            <div class="non_coupon_box">
                                보유한 쿠폰 내역이 없습니다.
                            </div>
                            <div class="exist_coupon_box">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>쿠폰이름</th>
                                            <th>할인내용</th>
                                            <th>남은기간</th>
                                            <th>비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>혹성탈출 새로운 4DX,5X 1만원 할인</td>
                                            <td>10,000원 할인</td>
                                            <td>D-7</td>
                                            <td><button class="coupon_use">사용하기</button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="step_box">
                        <div class="step_title">STEP.2 결제수단</div>
                        <div class="payment_select_list">
                            <div class="payment_box">
                                <label for="basicPayment">일반 결제</label>
                                <input type="radio" name="payment" id="basicPayment" checked>
                            </div>

                            <div class="payment_box">
                                <label for="pointPayment">포인트 결제</label>
                                <input type="radio" name="payment" id="pointPayment">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="book_payment_right">
                    <div class="payment_right_box">
                        <div class="book_pay_price_box pad_boder">
                            <div class="book_pay_price_txt payment_txt">결제금액</div>
                            <div class="book_pay_price" id="book_pay_price" ></div>
                            <input type="hidden" class="book_pay_price" id="book_pay_price1" value=${ticket.tic_Price }>
                        </div>
                        <div class="book_dis_price_box pad_boder">
                            <div class="book_dis_price_txt payment_txt">할인내역</div>
                            <input type="hidden" class="book_dis_price" id="pay_DisPrice1">
                            <div class="book_dis_price" id="trans_DisPrice1">0원</div>
                        </div>
                        <div class="payment_method_box pad_boder">
                            <div class="payment_method_txt payment_txt">결제수단</div>
                            <div class="payment_method">
                                <span class="last_payment_method_txt" id="last_payment_method_txt">일반결제</span>
                                <span class="last_payment_method_price" id="last_payment_method_price1"></span>
                                <input type="hidden" class="last_payment_method_price" id="last_payment_method_price" value=${ticket.tic_Price}>
                            </div>
                        </div>
                        <div class="last_payment_price_box">
                            <div class="last_payment_price_txt">최종 결제금액</div>
                            <div class="last_payment_price" id="last_payment_price1" ></div>
                            <input type="hidden" class="last_payment_price" id="last_payment_price" >
                        </div>
                    </div>
                </div>
            </div>
            <div class="book_payment_bot">
                <div class="book_rs_box">
                    <form class="book_rs_info_box">
                        <div class="movie_info">
                            <img class="movie_thumnail" src="${pageContext.request.contextPath}/resources/img/${tic_MovPoster}"  alt="">
                            <div class="movie_title">
                                <input type="text" name="movie_title" id="movie_title" value="${ticket.tic_MovName}"  readonly>
                                <input type="hidden" name="" id="couponNum" readonly>
                            </div>
                        </div>
                        <div class="date_info">
                            <div class="book_date_time book_sort">
                                <div class="book_txt">일시</div>
                                <input type="hidden" name="tic_WatDate" id="tic_WatDate1" value="${ticket.tic_WatDate}" readonly>
                                <input type="text" name="" id="selectedDate" value="" readonly>
                                <input type="text" class="selectedTime" name="tic_WatTime" id="selectedTime" value="${ticket.tic_WatTime}" readonly>
                            </div>
                            <div class="book_screen book_sort">
                                <div class="book_txt">상영관</div>
                                <input class="book_screen_info" type="text" id="book_movRoom" value="${ticket.tic_MovRoom}" readonly>
                            </div>
                            <div class="book_h_cnt book_sort">
                                <div class="book_txt">인원</div>
                                <input class="book_h_cnt" type="text" id="tic_WatNum" value="${ticket.tic_WatNum}" readonly>
                            </div>
                        </div>
                        <div class="seat_info step_2">
                            <div class="seat_sort">
                                <div class="seat_txt">좌석 번호</div>
                                <input type="text" name="tic_RoomSeat" id="tic_RoomSeat" value=${ticket.tic_RoomSeat} placeholder="F1, F2">
                            </div>
                        </div>

                        <div class="pay_info">
                            <div class="pay_sort pay_mg">
                                <div class="pay_txt">일반</div>
                                <input type="text" name="" value="11,000원 x ${ticket.tic_WatNum}" placeholder="11,000원 x 2">
                            </div>
                            <div class="pay_sort">
                                <div class="pay_txt">총 금액</div>
                                <input class="total_pay" type="text"  id="pay_PayPrice3" >
                                <input class="total_pay" type="hidden"  id="pay_PayPrice2" value=${ticket.tic_Price}>
                                <input class="total_pay" type="hidden" name="" id="pay_DisPrice2" >
                            </div>
                        </div>

                        <div class="go_select_seat">
                            <button class="" id="go_final_payment" type="button">결제하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="final_payment_modal">
    <div class="final_payment_modal_body">
        <div class="final_payment_modal_title">
            예매내역 확인
        </div>
        <form name="ticketForm">
            <table>
                <thead>
                    <tr>
                        <th class="final_book_info_box">예매 정보</th>
                        <th class="final_payment_info_box">결제 정보</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="final_book_info_box">
                            <div> 
                                <img src="${pageContext.request.contextPath}/resources/img/${tic_MovPoster}"alt="">
                                <input type="hidden" name="tic_MovPoster" value="${tic_MovPoster}" >
                            </div>
                            <div>
                                <div class="final_sort">
                                    <div>예매정보</div>
                                    <input class="final_input" type="text" name="pay_TicID" id="pay_TicID"  readonly>
                                    <input class="final_input" type="hidden" name="pay_MemName" id="pay_MemName" readonly>
                                    <input class="final_input" type="hidden" name="pay_MemPhoneNumber" id="pay_MemPhoneNumber" readonly>
                                    <input class="final_input" type="hidden" name="pay_MovName" id="pay_MovName" readonly>
                                    <input class="final_input" type="hidden" name="tic_WatTime" id="tic_WatTime" readonly>
                                </div>
                                <div class="final_sort">
                                    <div>상영관</div>
                                    <input class="final_input" id="movRoom" type="text"  name="tic_MovRoom" readonly>
                                </div>
                                <div class="final_sort">
                                    <div>일시</div>
                                    <input class="final_input" type="text" id="selectedDate2" readonly>
                                    <input class="final_input" type="hidden" name="tic_WatDate" id="tic_WatDate2" readonly>
                                </div>
                                <div class="final_sort">
                                    <div>인원</div>
                                    <input class="final_input" type="text" id="peopleNum" name="tic_WatNum" value=${ticket.tic_WatNum} readonly>
                                </div>
                                <div class="final_sort">
                                    <div>좌석</div>
                                    <input class="final_input" type="text" name="tic_RoomSeat" id="seat"value=${ticket.tic_RoomSeat} readonly>
                                </div>
                            </div>
                        </td>
                        <td class="final_payment_info_box final_payment">
                            <div class="final_sort">
                                <div>결제방식</div>
                                <input class="final_input" id="final_input_payment_methods" type="text" readonly>
                            </div>
                            <div class="final_sort">
                                <div>결제금액</div>
                                <input class="final_input point_price" id="trans_PayPrice" name="" type="text">
                                <input class="final_input point_price" id="pay_PayPrice" name="pay_PayPrice" type="text">
                                <input class="final_input point_price" id="pay_DisPrice" name="pay_DisPrice" type="hidden">
                                <input class="final_input point_price" id="cup_num" name="cup_num" type="hidden">
                                <input class="final_input point_price" id="Imp_uid" name="Imp_uid" type="hidden">
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="notice_box">
                <p>
                    인터넷 예매는 온라인상으로 영화상영 시간 20분 전까지 취소 가능하며 20분 이후에는 현장에서 취소를 하셔야 합니다.
                </p>
                <p>
                    현장 취소를 하는 경우 상영시간 이전까지만 가능하며 영화 상영 시작 시간 이후 취소/환불/결제 수단 변경은 불가합니다.
                </p>
                <p>
                    입장 지연에 따른 관람 불편을 최소화하기 위해 본 영화는 10분 후 상영이 시작됩니다. 
                </p>
            </div>

            <div class="button_box">
                <button type="button" class="payment_confirm" id="payTicket">결제하기</button>
                <button type="button" class="payment_cancle">취소</button>
            </div>
        </form>
    </div>
</div>
<script>

function findCoupon(){
   let data={
         "mem_nm" : document.getElementById("tic_MemName").value,
         "mem_tel" : document.getElementById("tic_MemPhoneNum").value
   }
   $.ajax({
        type: 'POST',
        url: 'findCoupon.do',
        data : data,
        cache: false,
        async : false,
        success: function(couponValue) {
           
            var couponDiv = document.querySelector(".pay_coupon_box");
           couponDiv.innerHTML = '';
           
            if(couponValue.length === 0){
               var non_coupon_box = document.createElement("div");
               non_coupon_box.classList.add("non_coupon_box");
               non_coupon_box.textContent = "보유한 쿠폰 내역이 없습니다.";
               couponDiv.appendChild(non_coupon_box);
            }else{
               var exist_coupon_box = document.createElement("div");
               exist_coupon_box.classList.add("exist_coupon_box");
               couponDiv.appendChild(exist_coupon_box);
               
               // exist_coupon_box에 테이블 구조를 추가하는 코드
               var table = document.createElement("table");
               var thead = document.createElement("thead");
               var tbody = document.createElement("tbody");

               // thead에 tr과 th 추가
               var trHead = document.createElement("tr");
               var thNames = ["쿠폰이름", "할인내용", "만료일", "비고"];
               thNames.forEach(function(name) {
                   var th = document.createElement("th");
                   th.textContent = name;
                   trHead.appendChild(th);
               });
               
               thead.appendChild(trHead);
               table.appendChild(thead);
               
               var selectedCoupon = null;
               
               couponValue.forEach(function(coupon){
                   var trBody = document.createElement("tr");
                   var tdName = document.createElement("td");
                   var tdDiscount = document.createElement("td");
                   var tdRemaining = document.createElement("td");
                   var tdNote = document.createElement("td");
                      var button = document.createElement("button");
                      
                      tdName.textContent = coupon.cup_contents;
                      tdDiscount.textContent = coupon.cup_dc+"%";
                      tdRemaining.textContent = coupon.cup_edate;
                      button.textContent = "사용하기";
                      button.classList.add("coupon_use");
                        button.dataset.coupon = JSON.stringify(coupon);
                        button.addEventListener('click', function() {
                            if (selectedCoupon === button) {
                                // 쿠폰 사용 취소
                                selectedCoupon.textContent = "사용하기";
                                selectedCoupon = null;
                                removeCoupon();
                            } else {
                                // 새로운 쿠폰 적용
                                if (selectedCoupon) {
                                    selectedCoupon.textContent = "사용하기";
                                }
                                button.textContent = "사용중";
                                selectedCoupon = button;
                                applyCoupon(JSON.parse(button.dataset.coupon));
                            }
                        });

                        tdNote.appendChild(button);

                        trBody.appendChild(tdName);
                        trBody.appendChild(tdDiscount);
                        trBody.appendChild(tdRemaining);
                        trBody.appendChild(tdNote);
                        tbody.appendChild(trBody);
                    });

                    table.appendChild(tbody);
                    couponDiv.appendChild(table);
                }
            },
            error: function(error) {
                console.log(error);
            }
        });// 아작스 끝   
      
} // findCoupon 함수 끝

function findCoupon() {
    let data = {
        "mem_nm": document.getElementById("tic_MemName").value,
        "mem_tel": document.getElementById("tic_MemPhoneNum").value
    };
    $.ajax({
        type: 'POST',
        url: 'findCoupon.do',
        data: data,
        cache: false,
        async: false,
        success: function(couponValue) {
            var couponDiv = document.querySelector(".pay_coupon_box");
            couponDiv.innerHTML = '';

            if (couponValue.length === 0) {
                var non_coupon_box = document.createElement("div");
                non_coupon_box.classList.add("non_coupon_box");
                non_coupon_box.textContent = "보유한 쿠폰 내역이 없습니다.";
                couponDiv.appendChild(non_coupon_box);
            } else {
                var exist_coupon_box = document.createElement("div");
                exist_coupon_box.classList.add("exist_coupon_box");
                couponDiv.appendChild(exist_coupon_box);

                var table = document.createElement("table");
                var thead = document.createElement("thead");
                var tbody = document.createElement("tbody");

                var trHead = document.createElement("tr");
                var thNames = ["쿠폰이름", "할인내용", "만료일", "비고"];
                thNames.forEach(function(name) {
                    var th = document.createElement("th");
                    th.textContent = name;
                    trHead.appendChild(th);
                });

                thead.appendChild(trHead);
                table.appendChild(thead);

                var selectedCoupon = null;

                couponValue.forEach(function(coupon) {
                    var trBody = document.createElement("tr");
                    var tdName = document.createElement("td");
                    var tdDiscount = document.createElement("td");
                    var tdRemaining = document.createElement("td");
                    var tdNote = document.createElement("td");
                    var button = document.createElement("button");

                    tdName.textContent = coupon.cup_contents;
                    tdDiscount.textContent = coupon.cup_dc + "%";
                    tdRemaining.textContent = coupon.cup_edate;
                    button.textContent = "사용하기";
                    button.classList.add("coupon_use");
                    button.dataset.coupon = JSON.stringify(coupon);
                    button.addEventListener('click', function() {
                        if (selectedCoupon === button) {
                            // 쿠폰 사용 취소
                            selectedCoupon.textContent = "사용하기";
                            selectedCoupon = null;
                            removeCoupon();
                        } else {
                            // 새로운 쿠폰 적용
                            if (selectedCoupon) {
                                selectedCoupon.textContent = "사용하기";
                            }
                            button.textContent = "사용중";
                            selectedCoupon = button;
                            applyCoupon(JSON.parse(button.dataset.coupon));
                        }
                    });

                    tdNote.appendChild(button);

                    trBody.appendChild(tdName);
                    trBody.appendChild(tdDiscount);
                    trBody.appendChild(tdRemaining);
                    trBody.appendChild(tdNote);
                    tbody.appendChild(trBody);
                });

                table.appendChild(tbody);
                couponDiv.appendChild(table);
            }
        },
        error: function(error) {
            console.log(error);
        }
    });

    function applyCoupon(coupon) {
        var discount = originalPrice * (coupon.cup_dc / 100);
        var discountedPrice = originalPrice - discount;

        document.getElementById("couponNum").value = coupon.cup_num;
        document.getElementById("pay_PayPrice2").value = discountedPrice;
        document.getElementById("pay_PayPrice3").value = discountedPrice.toLocaleString() + "원";
        document.getElementById("last_payment_method_price1").textContent = discountedPrice.toLocaleString() + "원";
        document.getElementById("last_payment_method_price").value = discountedPrice;
        document.getElementById("last_payment_price1").textContent = discountedPrice.toLocaleString() + "원";
        document.getElementById("last_payment_price").value = discountedPrice;

        document.getElementById("pay_DisPrice1").value = discount;
        document.getElementById("pay_DisPrice2").value = discount;
        document.getElementById("pay_DisPrice").value = discount;
        document.getElementById("trans_DisPrice1").textContent = discount.toLocaleString() + "원";
    }

    function removeCoupon() {
        document.getElementById("couponNum").value = "";
        document.getElementById("pay_PayPrice2").value = originalPrice;
        document.getElementById("pay_PayPrice3").value = originalPrice.toLocaleString() + "원";
        document.getElementById("last_payment_method_price1").textContent = originalPrice.toLocaleString() + "원";
        document.getElementById("last_payment_method_price").value = originalPrice;
        document.getElementById("last_payment_price1").textContent = originalPrice.toLocaleString() + "원";
        document.getElementById("last_payment_price").value = originalPrice;

        document.getElementById("pay_DisPrice1").value = 0;
        document.getElementById("pay_DisPrice2").value = 0;
        document.getElementById("pay_DisPrice").value = 0;
        document.getElementById("trans_DisPrice1").textContent = "0원";
    }
}

function formingDate() {
    var getDate = document.getElementById("tic_WatDate1").value;
    var [year, month, day] = getDate.split("-");
    var formedDate = year + "년 " + month + "월 " + day + "일";
    document.getElementById("selectedDate").value = formedDate;
    document.getElementById("selectedDate2").value = formedDate;
}

(function() {
    var tic_Price = ${ticket.tic_Price};
    originalPrice = tic_Price; // 원래 가격을 전역 변수에 저장
    var trans_ticPrice = tic_Price.toLocaleString() + "원";
    document.getElementById("book_pay_price").textContent = trans_ticPrice; // 결제 금액
    document.getElementById("last_payment_method_price1").textContent = trans_ticPrice; // 메소드 결제 금액
    document.getElementById("last_payment_price1").textContent = trans_ticPrice; // 최종 결제 금액
    document.getElementById("pay_PayPrice3").value = trans_ticPrice; // 최종 결제 금액

    findCoupon();
    formingDate();
})();


function useCoupon(coupon) {
    let discountRate = coupon.cup_dc;
    discountRate = parseInt(discountRate);
    document.getElementById("couponNum").value = coupon.cup_num;
    let price = originalPrice; // price 값은 원래 가격
    let lowPrice = price * ((100 - discountRate) / 100);
    document.getElementById("pay_PayPrice2").value = lowPrice; // 할인된 값 할당
    document.getElementById("pay_PayPrice3").value = lowPrice.toLocaleString() + "원"; // 할인된 값 변형
    document.getElementById("last_payment_method_price1").textContent = lowPrice.toLocaleString() + "원";
    document.getElementById("last_payment_method_price").value = lowPrice;
    document.getElementById("last_payment_price1").textContent = lowPrice.toLocaleString() + "원";
    document.getElementById("last_payment_price").value = lowPrice;

    var discountAmount = price * (discountRate / 100);
    document.getElementById("pay_DisPrice1").value = discountAmount;
    document.getElementById("pay_DisPrice2").value = discountAmount;
    document.getElementById("pay_DisPrice").value = discountAmount;
    document.getElementById("trans_DisPrice1").textContent = discountAmount.toLocaleString() + "원";
}

document.addEventListener('DOMContentLoaded', function() {
    const basicPayment = document.getElementById('basicPayment');
    const pointPayment = document.getElementById('pointPayment');
    const payment_methods = document.getElementById('final_input_payment_methods');
    const paymentText = document.querySelector('.last_payment_method_txt');

    function updatePaymentText() {
        if (basicPayment.checked) {
            paymentText.textContent = '일반결제';
            payment_methods.value = "일반결제";
        } else if (pointPayment.checked) {
            paymentText.textContent = '포인트결제';
            payment_methods.value = '포인트결제';
        }
    }

    basicPayment.addEventListener('change', updatePaymentText);
    pointPayment.addEventListener('change', updatePaymentText);

    // 초기 설정
    updatePaymentText();
});

$(document).ready(function() {
    $('#go_final_payment').click(function() {
       
         document.getElementById("pay_TicID").value = document.getElementById("tic_ID").value;
         document.getElementById("pay_MemName").value = document.getElementById("tic_MemName").value;
         document.getElementById("pay_MemPhoneNumber").value = document.getElementById("tic_MemPhoneNum").value;
         document.getElementById("pay_MovName").value = document.getElementById("movie_title").value;
         
         // 할인 금액
         var disprice = document.getElementById("pay_DisPrice1").value;
         if(disprice==""||disprice == null||disprice == "0원"){
            document.getElementById("pay_DisPrice").value = 0;   
         }else{
         document.getElementById("pay_DisPrice").value = disprice;
         }
         document.getElementById("pay_PayPrice").value = document.getElementById("pay_PayPrice2").value;
         
         var stringValue = document.getElementById("pay_PayPrice2").value;
         document.getElementById("trans_PayPrice").value = parseInt(stringValue.toLocaleString())+"원";
         
         // 결제 방식
         var paymentMethod = document.getElementById("last_payment_method_txt").textContent;
        var checkPointLack =  document.getElementById("mem_point").value - parseInt(stringValue);
                document.getElementById("final_input_payment_methods").value = paymentMethod;
         // 상영관
         console.log("document.getElementById('book_movRoom').value : ",document.getElementById("book_movRoom").value);
         document.getElementById("movRoom").value = document.getElementById("book_movRoom").value;
         console.log("document.getElementById('movRoom').value : ",document.getElementById("movRoom").value);
         //일시
         document.getElementById("selectedDate2").value = document.getElementById("selectedDate").value;
         document.getElementById("tic_WatTime").value = document.getElementById("selectedTime").value;
         document.getElementById("tic_WatDate2").value = document.getElementById("tic_WatDate1").value;
         //인원
         document.getElementById("peopleNum").value = document.getElementById("tic_WatNum").value;
         //좌석
         document.getElementById("seat").value = document.getElementById("tic_RoomSeat").value ;
         // 쿠폰번호
         document.getElementById("cup_num").value = document.getElementById("couponNum").value;
    });
});


//결제

var chk = false;
$(document).ready(function(){ // 여기서 선언적 함수를 선언하면 선언적 함수가 지역 함수로 됨.

var IMP = window.IMP;
IMP.init('imp01861206');

var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
   
var cup_num = $("#cup_num").val();
var cup_tf = $("#cup_tf").val();
if(!isMobile) {
    //모바일이 아닌 경우 스크립트
    $("#payTicket").click(function () {
        var selectPay = $(".last_payment_method_txt").text().trim();
         var movie_title = $('#movie_title').val();
         console.log("selectPay : ",selectPay);
         console.log("movie_title : ",movie_title);

if (selectPay === "일반결제" && movie_title.trim() != "") {
            console.log("Processing 일반 결제");
            console.log("처음" + isMobile);
       IMP.request_pay({
           pg: "danal_tpay", // 자신이 설정한 pg사 설정
          pay_method: 'card',
          merchant_uid: 'ticket_' + new Date().getTime(),
          name: '주문명:결제테스트' + $('#pay_TicID').val(),
          amount : $("#pay_PayPrice").val(),
          buyer_name: $("#pay_MemName").val() ,
          buyer_tel: $("#pay_MemPhoneNumber").val() ,
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
             if(chk==true) orderList(rsp.merchant_uid);
       });
       
        }else if(selectPay === "포인트결제" && movie_title.trim() != ""){
            
            console.log("Processing 포인트 결제");
            
            orderList();
        }else{
           console.log("장바구니 아무것도 없는 경우");
           alert("장바구니에 아무것도 없습니다.");
        }
    });
     
 } else {
    var selectPay = $(".last_payment_method_txt").text().trim();
     var movie_title = $('#movie_title').val();
     console.log("selectPay " + selectPay);
     console.log("movie_title "+ movie_title);
     
    //모바일인 경우 스크립트
    $("#payTicket").click(function () {
        if (selectPay === "일반결제" && movie_title.trim() != "") {
             console.log("Processing 일반 결제");
             console.log("처음" + isMobile);
       
       IMP.request_pay({
 
          pg: 'danal_tpay', // 자신이 설정한 pg사 설정
          pay_method: 'card',
          merchant_uid: 'ticket_' + new Date().getTime(),
          name: '주문명:결제테스트' + $('#pay_TicID').val(),
          amount : $("#pay_PayPrice").val(),
          buyer_name: $("#pay_MemName").val() ,
          buyer_tel: $("#pay_MemPhoneNumber").val() ,
          buyer_postcode: '123-456',
          m_redirect_url: 'http://localhost:8090/payments/complete'
//           popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
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
               if(chk==true) orderList(rsp.merchant_uid);
             
       });
    }else if(selectPay === "포인트결제" && movie_title.trim() != ""){
           console.log("paymethod" + paymethod);
           console.log("Processing 포인트 결제");
           orderList();
       }else{
          console.log("장바구니 아무것도 없는 경우");
          alert("장바구니에 아무것도 없습니다.");
       }
    });
     
 }
});

function orderList(imp_uid){
let fm = document.ticketForm;
fm.action ="ticketPaying.do";
fm.method="post";
fm.Imp_uid.value = imp_uid;
fm.submit();
}

//'결제하기' 버튼에 클릭 이벤트 리스너 추가
document.getElementById('go_final_payment').addEventListener('click', function() {

    var stringValue = document.getElementById("pay_PayPrice2").value;
    var paymentMethod = document.getElementById("last_payment_method_txt").textContent;
    var checkPointLack =  document.getElementById("mem_point").value - parseInt(stringValue);
    
     if(paymentMethod ==="포인트결제" && checkPointLack < 0){
    	 alert("포인트가 부족합니다.");
    	 document.querySelector('.final_product_payment_modal').style.display = 'none';
     }else{// 'final_payment_modal' 클래스를 가진 요소를 찾아서 표시
         document.querySelector('.final_payment_modal').style.display = 'block';
     }
});

// '취소' 버튼에 클릭 이벤트 리스너 추가
document.querySelector('.payment_cancle').addEventListener('click', function() {
    // 'final_payment_modal' 클래스를 가진 요소를 찾아서 숨김
    document.querySelector('.final_payment_modal').style.display = 'none';
});

</script>
<%@include file ="../sub/footer.jsp" %>