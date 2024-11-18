<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../sub/header.jsp" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   String Name = (String) session.getAttribute("mem_nm");
   String Phone = (String) session.getAttribute("mem_tel");
%> 
<div id="bookmainpage_con">
   <div class="bookmainpage_con pd_box inner">
      <h1 class="bookpage_title">영화 예매</h1>
      
      <div class="seat_selection_box">
            <div class="seat_sel_head book_ls">인원/좌석</div>
        </div>
        <form action="insertTicket.do" method="POST">
        <input type="hidden" name="tic_MemName" value=<%= Name%>>
        <input type="hidden" name="tic_MemPhoneNum" value=<%=Phone%>>
        <input type="hidden" id="tic_MovRT" name="tic_MovRT" value="${tic_MovRT}" readonly>
        <input type="hidden" id="tic_MovRate" name="tic_MovRate" value="${tic_MovRate}" readonly>
        <input type="hidden" id="tic_MovGenre" name="tic_MovGenre" value="${tic_MovGenre}" readonly>
           <div class="select_nop_box">
              <div class="nop_box">
              <span>일반</span>
                 <select id="number" name="tic_WatNum">
                 <option value="1">1</option>
                 <option value="2">2</option>
                 <option value="3">3</option>
                 <option value="4">4</option>
                 <option value="5">5</option>
                 <option value="6">6</option>
               </select>
            </div>
            <div class="book_info_box">   
               <div class="book_info_box">
                      <div class="book_info_top">
                          <span class="screen_name">${ticket.tic_MovRoom}</span>
                          <span class="seat_cnt"></span>
                      </div>
                      <div class="book_info_bot">
                          <span class="book_day">${tic_formedDate}</span>
                          <span class="book_time">${tic_WatStartTime} ~ ${tic_WatLastTime}</span>
                      </div>
                  </div>
               </div>
           </div>
        
         
         <div class="select_seat_box">
                <div class="screen_screen">SCREEN</div>
                <div class="seat_box">
               <c:forEach items="${seatInfo}" var="seatInfo" varStatus="loop">
                     <button class="mov_seat" type="button" id="${seatInfo.mov_rSeatRow}${seatInfo.mov_rSeatCol}"
                     onclick="setSeatValue('${seatInfo.mov_rSeatRow}', '${seatInfo.mov_rSeatCol}')">${seatInfo.mov_rSeatRow}${seatInfo.mov_rSeatCol}</button>
                   <c:if test="${loop.index % 10 == 9}"><br/></c:if>
               </c:forEach>
            </div>
           </div>
           
           <div class="book_rs_box">
              <div class="book_rs_info_box">
                   <div class="movie_info">
                       <img class="movie_thumnail" src="${pageContext.request.contextPath}/resources/img/${tic_MovPoster}" alt="">
                       <input type="hidden" name="tic_MovPoster" value="${tic_MovPoster}">
                       <div class="movie_title">
                          <input name="tic_MovName" value="${tic_MovName}">
                       </div>
                   </div>
                   
                   <div class="date_info">
                       <div class="book_date_time book_sort">
                           <div class="book_txt">일시</div>
                           <input class="selected_date" name="tic_formedDate" value="${tic_formedDate}">
                           <input type="hidden" class="selected_date" name="tic_WatDate" value="${tic_WatDate}">
                           <input class="selected_time" name="tic_WatTime" value="${tic_WatStartTime}">
                       </div>
                       <div class="book_screen book_sort">
                           <div class="book_txt">상영관</div>
                           <input name="tic_MovRoom" value="${tic_movRoom}">
                           <input type="hidden" name="tic_SeatType" value="${tic_SeatType}">
                       </div>
                       <div class="book_h_cnt book_sort">
                           <div class="book_txt">인원</div>
                           <input class="book_h_cnt" type="text" id="book_h_cnt" value=1 readonly>
                       </div>
                   </div>
                   
                   <div class="seat_info step_2">
                       <div class="seat_sort">
                           <div class="seat_txt">좌석 번호</div>
                           <input id="tic_RoomSeat" name="tic_RoomSeat" >
                       </div>
                   </div>

                   <div class="pay_info">
                       <div class="pay_sort pay_mg">
                           <div class="pay_txt">일반</div>
                           <input id="" name="" placeholder="11,000원">
                       </div>
                       <div class="pay_sort">
                           <div class="pay_txt">총 금액</div>
                           <input class="total_pay" type="text" name="" id="tic_Price2" value="0원">
                           <input class="total_pay" type="hidden" name="tic_Price" id="tic_Price"  value=0>
                       </div>
                  </div>
                  
                  <div class="go_select_seat">
                       <input type="submit" value="결제하기">
                   </div>
               </div>
            </div>
         
         </form>
   </div>
</div>
<script>
// 버튼 클릭 이벤트에 대한 핸들러
var selectedCount = 0; 

var alreadySeats = ${alreadySeats};
function coloredAlreadySeats() {
    alreadySeats.forEach(function(seat) {
    	console.log(seat);
        var seatId = seat;
        var seatButton = document.getElementById(seatId);
        if (seatButton) {
            seatButton.style.backgroundColor = 'darkgray';
        }
    });
}

( function() {
	coloredAlreadySeats();
})();
function setSeatValue(row, col) {
  var number = document.getElementById("number").value;
  document.getElementById("book_h_cnt").value = number;
  var seatInput = document.getElementById('tic_RoomSeat');
  var priceInput = document.getElementById('tic_Price');
  var priceInput2 = document.getElementById('tic_Price2');
  var currentSeat = seatInput.value;
  var updatedSeat = currentSeat + ',' + row+col;
  var mov_rPrice = 11000;
	console.log("row+col",row+col);
  if(selectedCount < number){
     if(seatInput.value.indexOf(row+col) == -1 && alreadySeats.includes(row+col)== false){
        priceInput.value = parseInt(priceInput.value) + mov_rPrice;
        priceInput2.value = parseInt(priceInput.value).toLocaleString()+"원";
        selectedCount++;
        document.getElementById(row+col).style.backgroundColor = "#EB093B";
        updatedSeat = updatedSeat.replace(/^,/, "");
        seatInput.value = updatedSeat;
     }
  }else{
     selectedCount = 0;
     seatInput.value = "";
     priceInput.value = 0;
     priceInput2.value = "0원";
     document.querySelectorAll('.mov_seat').forEach(function(button) {
         // 해당 버튼의 배경색을 null로 설정
         button.style.backgroundColor = null;
     });
     coloredAlreadySeats();
  }  
}

</script>
<%@include file ="../sub/footer.jsp" %>