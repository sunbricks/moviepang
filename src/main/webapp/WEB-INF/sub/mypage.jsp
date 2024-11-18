<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
     <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<%@include file="./header.jsp"%>
<%
    // 세션에서 mem_id 가져오기
    String memId = (String) session.getAttribute("mem_id");
%>
%>
<%if(memId == null){ 
    response.sendRedirect("index.jsp");
} else { %>

<script>
document.addEventListener("DOMContentLoaded", function() {
  var foundIdElement = document.querySelector(".find_my_name");
  if (foundIdElement) {
    var originalId = foundIdElement.textContent;
    if (originalId.length === 2) {
      // 이름이 2글자인 경우: 첫 글자 + * 
      foundIdElement.textContent = originalId.charAt(0) + "*";
    } else if (originalId.length === 3) {
      // 이름이 3글자인 경우: 첫 글자 + * + 마지막 글자
      foundIdElement.textContent = originalId.charAt(0) + "*" + originalId.charAt(2);
    } else {
      // 기본: 첫 글자 + ** + 마지막 글자 (4글자 이상인 경우)
      foundIdElement.textContent = originalId.charAt(0) + "**" + originalId.charAt(originalId.length - 1);
    }
  }
});
</script>
<div id="mypage_con">
    <div class="mypage_con pd_box inner">
        <div class="mypage_top">
            <h1 class="mypage_title">
            	<span class="find_my_name">${sessionScope.mem_nm}</span>님의 마이페이지
            </h1>
            <div class="mypage_top_con_box">
                <div class="mycp mycp_1">
                    <div class="mycp_txt">MY COUPON</div>
	        		<div id="couponCount" class="mycp_cnt">0 개</div>
		   		</div>
		
			    <script>
			        $(document).ready(function() {
			            $.ajax({
			                type: 'GET',
			                url: '/couponCount.do',
			                success: function(count) {
			                    $('#couponCount').text(count + ' 개');
			                },
			                error: function(error) {
			                    console.log("Error: ", error);
			                }
			            });
			        });
			    </script>
                <div class="mycp mycp_2">
                    <div class="mycp_txt">MY POINT</div>
                    <div class="mycp_cnt">
                    <fmt:formatNumber value="<%= mp %>" pattern="#,### P" />
                    </div>
                </div>
            </div>
        </div>
        <div class="mypage_bot">
            <div class="mypage_left_con_box">
                <ul class="mypage_tabs">
                    <li id="my_home" class="tab-link add" data-tab="mypage_home">마이페이지 홈</li>
                    <li class="tab-link" data-tab="mypage_myinfo">내 정보</li>
                    <li class="tab-link" data-tab="mypage_coupon">내 쿠폰함</li>
                    <li class="tab-link" data-tab="mypage_gift">내 선물함</li>
                    <li class="tab-link" id = "mypage_buy_history_tab" data-tab="mypage_buy_history">구매 내역</li>
                    <li class="tab-link" data-tab="mypage_movie_history">이용 내역</li>
                    <li class="tab-link" data-tab="my_point">내 포인트</li>
                </ul>
                <div class="w_membership">
                    <a href="javascript:void(0);" onclick="confirmLeave('leave.do?mem_id=<%= memId %>')">회원 탈퇴 ></a>
                </div>
            </div>
<script type="text/javascript">
    function confirmLeave(url) {
        var result = confirm("정말로 회원 탈퇴를 하시겠습니까?");
        if (result) {
            window.location.href = url;
        }
    }
</script>
<script>
// 인증번호 요청 함수
var timer;
var isRunning = false;
var code;
var telSent = false; // 문자 전송 여부를 추적하는 변수

function telCheckBtn() {
    $('#tel-Check-Btn').click(function() {
        let tel = $('#userTel1').val()
        console.log('입력 전화번호 : ' + tel);
        let checkInput = $('.tel-check-input');

        // 이미  문자가 전송되었는지 확인
        if (telSent) {
            alert('이미 문자가 전송되었습니다. 인증번호를 확인해주세요.');
            return; // 함수 종료하여 문자를 여러 번 보내는 것을 방지
        }

        $.ajax({
            url: "telCheck.do?tel=" + tel,
            type: 'GET',
            data: { tel: $('#userTel1').val() }, // 폰 번호 데이터 전송
            success: function(code1) {
                checkInput.prop('disabled', false);
                code = code1;
                alert('인증번호가 전송되었습니다.');
                sendAuthNum1(); // 인증번호 발송 및 타이머 시작 함수 호출
                telSent = true; // 문자 전송 상태 업데이트
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
                checkInput.prop('disabled', false);

      telSent = true;
      sendAuthNum1();
    });
}

//인증번호 발송하고 타이머 함수 실행
function sendAuthNum1(){
       // 남은 시간
   var leftSec = 180,
   display = document.querySelector('#timer3');
   // 이미 타이머가 작동중이면 중지
   if (isRunning){
      clearInterval(timer);
   } else {
       isRunning = true;
    }
     startTimer1(leftSec, display);}

function startTimer1(count, display) {
    var minutes, seconds;
    timer1 = setInterval(function () {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        // 타이머 끝
        if (--count < 0) {
            clearInterval(timer);
            display.textContent = "";
            isRunning = false;
            code = null; // 발급받은 코드를 null로 설정
            telSent = false; // 이메일 전송 상태 초기화
        }
    }, 1000);
}

function compareCode1() {
    $('.tel-check-input').blur(function() {
        const inputCode = $(this).val();
        const $resultMsg = $('#tel-check-warn');
        console.log(inputCode);
        console.log(code);

        if (code === null) { // 인증 시간이 만료되었는지 확인
            $resultMsg.html('*인증 시간이 만료되었습니다. 다시 인증해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

            return; // 함수 종료
        }

        if (inputCode === code) {
            $resultMsg.html('*인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $resultMsg.css('display', 'inline');

            $('#userTel1').attr('readonly', true);
            $('#userTel2').attr('readonly', true);
            $('#userTel2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userTel2').attr('onChange', 'this.selectedIndex = this.initialSelect');
            clearTimeout(timer); // 타이머 초기화
            $('#timer3').hide();
            $('.tel-check-input').attr('readonly', true);
        } else {
            $resultMsg.html('*인증번호가 불일치 합니다. 다시 확인해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

        }
    });
}

$(document).ready(function() {
    telCheckBtn();
    compareCode1();
});

    </script>
    <script>
    /* 전화번호 유효성 검사 */
    if(tel == "" ){
        $('#result_checkTel').css('display','inline');
        $('#result_checkTel').css('color', 'red');
     $('#result_checkTel').html("전화번호를 입력해주세요");
        telCheck = false;
    }else{
        $('#result_checkTel').css('display', 'none');
        telCheck = true;
    }
    
    /* 이메일 유효성 검사 */
    if(mail.trim() == ""){
        $('#result_checkEm').css('display','inline');
        $('#result_checkEm').css('color', 'red');
     $('#result_checkEm').html("이메일을 입력해주세요");
        mailCheck = false;
    }else{
        $('#result_checkEm').css('display', 'none');
        mailCheck = true;
    }
    </script>
    <script type="text/javascript">
        function confirmLeave(url) {
            var result = confirm("정말로 회원 탈퇴를 하시겠습니까?");
            if (result) {
                window.location.href = url;
            }
        }
    </script>
    <!-- 이메일 인증 스크립트 -->
<script>
var timer;
var isRunning = false;
var code;
var emailSent = false; // 이메일 전송 여부를 추적하는 변수

function mailCheckBtn() {
    $('#mail-Check-Btn').click(function() {
        let email = $('#userEmail1').val()
        console.log('완성된 이메일 : ' + email);
        let checkInput = $('.mail-check-input');
      
        if (!email.trim()) {
            alert('이메일을 입력해주세요.');
            return;
        }
        
        // 이미 이메일이 전송되었는지 확인
        if (emailSent) {
            alert('이미 이메일이 전송되었습니다. 인증번호를 확인해주세요.');
            return; // 함수 종료하여 이메일을 여러 번 보내는 것을 방지
        }

        $.ajax({
            type: 'get',
            url: "mailCheck.do?email=" + email,
            success: function(data) {
                console.log("data : " + data);
                checkInput.prop('disabled', false);
                code = data;
                alert('인증번호가 전송되었습니다.');
                sendAuthNum(); // 인증번호 발송 및 타이머 시작 함수 호출
                emailSent = true; // 이메일 전송 상태 업데이트
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });
}

//인증번호 발송하고 타이머 함수 실행
function sendAuthNum(){
       // 남은 시간
   var leftSec = 180,
   display = document.querySelector('#timer4');
   // 이미 타이머가 작동중이면 중지
   if (isRunning){
      clearInterval(timer);
   } else {
       isRunning = true;
    }
     startTimer(leftSec, display);}

function startTimer(count, display) {
    var minutes, seconds;
    timer = setInterval(function () {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        // 타이머 끝
        if (--count < 0) {
            clearInterval(timer);
            display.textContent = "";
            isRunning = false;
            code = null; // 발급받은 코드를 null로 설정
            emailSent = false; // 이메일 전송 상태 초기화
        }
    }, 1000);
}

function compareCode() {
    $('.mail-check-input').blur(function() {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-check-warn');

        if (code === null) { // 인증 시간이 만료되었는지 확인
            $resultMsg.html('*인증 시간이 만료되었습니다. 다시 인증해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

            return; // 함수 종료
        }

        if (inputCode === code) {
            $resultMsg.html('*인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $resultMsg.css('display', 'inline');

            $('#mail-Check-Btn').attr('disabled', true);
            $('#userEamil1').attr('readonly', true);
            $('#userEamil2').attr('readonly', true);
            $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
            clearTimeout(timer); // 타이머 초기화
            $('#timer4').hide();
            $('.mail-check-input').attr('readonly', true);

        } else {
            $resultMsg.html('*인증번호가 불일치 합니다. 다시 확인해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');
        }
        
        
    });
}

$(document).ready(function() {
    mailCheckBtn();
    compareCode();
});

</script>
            <div class="mypage_right_con_box">
            	
<!-- 마이페이지 홈 시작 -->
			<div class="mypage_right_con_box">
				<%
				String memName = (String) session.getAttribute("mem_nm");
				String memTel = (String) session.getAttribute("mem_tel");
				%>

				<form method="POST" enctype="multipart/form-data"
					id="fileUploadForm">
					<input type="hidden" name="tic_MemName" id="memName"
						value=<%=memName%>> <input type="hidden"
						name="tic_MemPhoneNum" id="memTel" value=<%=memTel%>>
				</form>


				<div id="mypage_home" class="mypage-content add">
					<div class="mycon_title">예매 내역</div>
					<div class="my_book_list_box">
						<div class="non_my_book">예매 내역이 없습니다.</div>
						<ul>
							<li class="my_book_list">
							</li>
						</ul>
					</div>

					<div class="my_book_cancle_box">
						<div class="sub_title">MY 취소내역</div>
						<table>
							<thead>
								<tr>
									<th>에매영화</th>
									<th>관람일시</th>
									<th>취소일</th>
									<th>결제취소금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<!-- <td>범죄도시4</td>
									<td>2024.05.15(수) 17:50</td>
									<td>2024.05.15(수)</td>
									<td>15,000원</td> -->
								</tr>
							</tbody>
						</table>
					</div>
					<script>
            	
              	function getTicketMypage(){
	              	  var form = document.getElementById('fileUploadForm');  
	                  var data = new FormData(form);  

            		$.ajax({
            	        type: 'POST',
            	        enctype: 'multipart/form-data', 
            	        url: 'getTicketMypage.do',
            	        data : data,
            	        processData: false,    
            	        contentType: false,     
            	        cache: false,
            	        async : false,
            	        success: function(ticketInfo) {
            	            var bookDiv = document.querySelector(".my_book_list_box");
            	            bookDiv.innerHTML = ''; // 기존 내용을 초기화
            	            
            	            if (ticketInfo.length === 0) {
            	                var non_my_book = document.createElement("div");
            	                non_my_book.classList.add("non_my_book");
            	                non_my_book.textContent = "예약 내역이 없습니다.";
            	                bookDiv.appendChild(non_my_book);
            	            } else {
            	                ticketInfo.forEach(function(ticket) {
            	                    // 예매 정보가 있는 경우, HTML 요소를 생성하여 추가
            	                    var li = document.createElement("li");
            	                    li.classList.add("my_book_list");

            	                    var form = document.createElement("form");
            	                    form.action = ""; // 필요한 action URL 설정

            	                    var mybookInfoBox = document.createElement("div");
            	                    mybookInfoBox.classList.add("mybook_info_box");

            	                    var mybookLeftBox = document.createElement("div");
            	                    mybookLeftBox.classList.add("mybook_left_box");
            	                    var img = document.createElement("img");
            	                    img.src = "${pageContext.request.contextPath}/resources/img/"+ticket.mov_Post; // 포스터 이미지 경로 설정
            	                    mybookLeftBox.appendChild(img);

            	                    var mybookRightBox = document.createElement("div");
            	                    mybookRightBox.classList.add("mybook_right_box");

            	                    // 영화 이름
            	                    var mypageBookStNameBox = document.createElement("div");
            	                    mypageBookStNameBox.classList.add("mypage_book_st", "my_book_movie_name_box");
            	                    
            	                    var inputMovieName = document.createElement("input");
            	                    inputMovieName.classList.add("my_book_movie_name");
            	                    inputMovieName.type = "text";
            	                    inputMovieName.readOnly = true;
            	                    inputMovieName.placeholder = ticket.tic_MovName; // 영화 이름 설정
            	                    mypageBookStNameBox.appendChild(inputMovieName);
            	                    mybookRightBox.appendChild(mypageBookStNameBox);
            	                   
							        const mypageBookSt = document.createElement('div');
							        mypageBookSt.classList.add("mypage_book_st");
							        
							        // 첫 번째 book_info_line 생성
							        const bookInfoLine1 = document.createElement('div');
							        bookInfoLine1.className = 'book_info_line';
							
							        const bookSortName1 = document.createElement('div');
							        bookSortName1.className = 'book_sort_name';
							        bookSortName1.innerText = '관람일시';
							
							        const input1 = document.createElement('input');
							        input1.type = 'text';
							        input1.placeholder = ticket.tic_WatDate+" "+ticket.tic_WatTime;
							        input1.readOnly = true;
							
							        bookInfoLine1.appendChild(bookSortName1);
							        bookInfoLine1.appendChild(input1);
							
							        // 두 번째 book_info_line 생성
							        const bookInfoLine2 = document.createElement('div');
							        bookInfoLine2.className = 'book_info_line';
							
							        const bookSortName2 = document.createElement('div');
							        bookSortName2.className = 'book_sort_name';
							        bookSortName2.innerText = '상영관';
							
							        const input2 = document.createElement('input');
							        input2.type = 'text';
							        input2.placeholder = ticket.tic_MovRoom;
							        input2.readOnly = true;
							
							        bookInfoLine2.appendChild(bookSortName2);
							        bookInfoLine2.appendChild(input2);
							        
							        // 부모 div 요소에 추가
							        mypageBookSt.appendChild(bookInfoLine1);
							        mypageBookSt.appendChild(bookInfoLine2);
							        
							        const mypageBookSt2 = document.createElement('div');
							        mypageBookSt2.classList.add("mypage_book_st");

							        // 3 번째 book_info_line 생성
							        const bookInfoLine3 = document.createElement('div');
							        bookInfoLine3.className = 'book_info_line';
							
							        const bookSortName3 = document.createElement('div');
							        bookSortName3.className = 'book_sort_name';
							        bookSortName3.innerText = '관람인원';
							
							        const input3 = document.createElement('input');
							        input3.type = 'text';
							        input3.placeholder = ticket.tic_WatNum+"명";
							        input3.readOnly = true;
							
							        bookInfoLine3.appendChild(bookSortName3);
							        bookInfoLine3.appendChild(input3);
							
							        // 4 번째 book_info_line 생성
							        const bookInfoLine4 = document.createElement('div');
							        bookInfoLine4.className = 'book_info_line';
							
							        const bookSortName4 = document.createElement('div');
							        bookSortName4.className = 'book_sort_name';
							        bookSortName4.innerText = '관람좌석';
							
							        const input4 = document.createElement('input');
							        input4.type = 'text';
							        input4.placeholder = ticket.tic_RoomSeat;
							        input4.readOnly = true;
							
							        bookInfoLine4.appendChild(bookSortName4);
							        bookInfoLine4.appendChild(input4);
							
							        // 부모 div 요소에 추가
							        mypageBookSt2.appendChild(bookInfoLine3);
							        mypageBookSt2.appendChild(bookInfoLine4);

							        const mypageBookSt3 = document.createElement('div');
							        mypageBookSt3.classList.add("mypage_book_st");
							        
							        // 5 번째 book_info_line 생성
							        const bookInfoLine5 = document.createElement('div');
							        bookInfoLine5.className = 'book_info_line';
							
							        const bookSortName5 = document.createElement('div');
							        bookSortName5.className = 'book_sort_name';
							        bookSortName5.innerText = '예매번호';
							
							        const input5 = document.createElement('input');
							        input5.type = 'text';
							        input5.name = "tic_ID";
							        input5.placeholder = ticket.tic_Id;
							        input5.readOnly = true;
							
							        bookInfoLine5.appendChild(bookSortName5);
							        bookInfoLine5.appendChild(input5);
							        
							        mypageBookSt3.appendChild(bookInfoLine5);
							        
							        const mypageBookSt4 = document.createElement('div');
							        mypageBookSt4.classList.add("mypage_book_st");
							
							        // 6 번째 book_info_line 생성
							        const bookInfoLine6 = document.createElement('div');
							        bookInfoLine6.className = 'book_info_line';
							
							        const bookSortName6 = document.createElement('div');
							        bookSortName6.className = 'book_sort_name';
							        bookSortName6.innerText = '결제금액';
							
							        const input6 = document.createElement('input');
							        input6.type = 'text';
							        input6.placeholder = ticket.tic_Price;
							        input6.readOnly = true;
							
							        bookInfoLine6.appendChild(bookSortName6);
							        bookInfoLine6.appendChild(input6);
							
							        // 부모 div 요소에 추가
							        mypageBookSt4.appendChild(bookInfoLine6);
							        
							        mybookRightBox.appendChild(mypageBookSt);
							        mybookRightBox.appendChild(mypageBookSt2);
							        mybookRightBox.appendChild(mypageBookSt3);
							        mybookRightBox.appendChild(mypageBookSt4);
            	                    

            	                    mybookInfoBox.appendChild(mybookLeftBox);
            	                    mybookInfoBox.appendChild(mybookRightBox);
            	                    form.appendChild(mybookInfoBox);

            	                    // 예매 취소 버튼 추가
            	                    var bookCancelBtn = document.createElement("div");
            	                    bookCancelBtn.classList.add("book_cancle_btn");
            	                    var cancelButton = document.createElement("button");
            	                    cancelButton.type="button";
            	                    cancelButton.classList.add("cancel-ticket");
            	                    cancelButton.dataset.ticket = JSON.stringify(ticket); 
            	                    var cancelImg = document.createElement("img");
            	                    cancelImg.src = "${pageContext.request.contextPath}/resources/img/cancle_ico.png";
            	                    cancelButton.appendChild(cancelImg);
            	                    bookCancelBtn.appendChild(cancelButton);

            	                    form.appendChild(bookCancelBtn);
            	                    li.appendChild(form);

            	                    bookDiv.appendChild(li); // 최종적으로 생성한 li 요소를 bookDiv에 추가
            	                });
            	            }
            	        },
            	        error: function(error) {
            	            console.log(error);
            	        }
            	    });// 아작스 끝	
            			
            	} // 함수 끝
            	
            	document.addEventListener("click", function(event) {
            	    if (event.target && event.target.closest(".cancel-ticket")) {
            	        let ticket = JSON.parse(event.target.closest(".cancel-ticket").dataset.ticket);
            	        let result = confirm("정말 예매된 티켓을 취소하시겠습니까?");
            	        if (result) {
            	        	cancledTicket(ticket);
                	        getTicketMypage();
                	        canceledData();
            	        } else {
            	        }
            	        
            	    }
            	});
            	
            	function cancledTicket(ticket){
                    
                    $.ajax({
                         type: 'POST',
                         url: 'ticketPayCancle.do',
                         data : JSON.stringify(ticket), // JSON으로 변환
                         contentType: "application/json", // 컨텐트 타입을 JSON으로 명시
                         cache: false,
                         async : false,   
                         success: function(ticketInfo) {
                       
                         },error: function(error) {
                             console.log(error);
                         }
                     });
                 } // cancledTicket 끝

            	
            	function canceledData(){
            		var form = document.getElementById('fileUploadForm');  
	                  var data = new FormData(form);  
	                  
            		$.ajax({
            	        type: 'POST',
            	        url: 'getCancledData.do',
            	        enctype: 'multipart/form-data', 
            	        processData: false,    
            	        contentType: false,  
            	        data : data,
            	        cache: false,
            	        async : false,	
            	        success: function(ticketInfo) {
            	        
            	        	 var tbody = document.querySelector("tbody");
            	        	 tbody.innerHTML = ''; // 기존 내용을 초기화
             	            
             	            if (ticketInfo.length === 0) {
             	                return ;
             	            } else {
             	            	var ticketpart = (ticketInfo.length > 5 ? ticketInfo.slice(0,5) :ticketInfo);
             	            	
             	            	ticketpart.forEach(function(ticket) {
             	               
             	                    var tr = document.createElement("tr");
             	                    var td_movName = document.createElement("td");
             	                    var td_watDate = document.createElement("td");
             	                    var td_canDate = document.createElement("td");
             	                    var td_payPrice = document.createElement("td");
             	                    
             	                    td_movName.textContent = ticket.tic_MovName;
             	                    var time = ticket.tic_WatTime;
             	                    var hour = parseInt(time.slice(0,time.indexOf(":")));
             	                    var endHour = (hour + 2 >=24 ? hour +2 - 24 : hour+2);
             	                    var startTime = hour + time.slice(time.indexOf(":"),time.indexOf(":")+3);
             	                    var endTime = endHour + time.slice(time.indexOf(":"),time.indexOf(":")+3);
             	                    td_watDate.textContent = ticket.tic_WatDate+" "+startTime+"~"+endTime;
             	                    td_canDate.textContent = ticket.tic_cancledDate;
             	                    td_payPrice.textContent = ticket.pay_PayPrice;
             	                    
									tr.appendChild(td_movName);
									tr.appendChild(td_watDate);
									tr.appendChild(td_canDate);
									tr.appendChild(td_payPrice);
									
									tbody.appendChild(tr);
             	                })
             	            }// else 닫기
            	        	
            	        },error: function(error) {
            	            console.log(error);
            	        }
            	    });
            	}
            	
(function(){
	
    getTicketMypage();
    canceledData();
})();
</script>
				</div>
				<!-- 마이페이지 홈 끝 -->


                <!-- 마이페이지 내정보 시작 -->

                <div id="mypage_myinfo" class="mypage-content">
                    <div class="mycon_title">내 정보</div>

                    <div class="myinfo_con_box">
                        <form action="">       
                                <div class="info_id_box myinfo_box">
                                    <div class="existing_id_box existing_box">
                                        <div class="info_box_title">아이디</div>
                                        <input class="info_id_input" type="text" name="" value="${sessionScope.mem_id}" readonly>
                                    </div>
                                </div>
                        </form>

                        <form action="">       
                            <div class="info_name_box myinfo_box">
                                <div class="existing_name_box existing_box">
                                    <div class="info_box_title">이름</div>
                                    <input class="info_name_input" type="text" name="" value="${sessionScope.mem_nm}" readonly>
                                </div>
                            </div>
                        </form>

                        <form action="updateTel.do">       
                                <div class="info_phone_box myinfo_box">
                                    <div class="existing_phone_box existing_box">
                        				<input type="hidden" name="mem_id" value="${sessionScope.mem_id}">
                                        <div class="info_box_title">휴대폰<span id="result_checkTel" class="identify">* 전화번호를 입력해주세요</span></div>
                                        <input class="info_phone_input" type="text" name="mem_tel" value="${sessionScope.mem_tel}" readonly>
                                        <button type="button" class="change_phone change_btn">변경하기</button>
                                    </div>

                                    <div class="change_phone_box">
                                        <div class="info_box_title">휴대폰 인증번호<span id="tel-check-warn" class="identify">* 휴대폰 인증번호를 입력해주세요</span></div>
                                        <input class="info_phone_input tel-check-input" id="userTel1" type="text" name=""><span id="timer3"></span>
                                        <button type="button" class="veri_confirm_btn">인증확인</button>
                                    </div>
                                    
                                    <button type="button" id="tel-Check-Btn" class="phone_need_veri_btn">인증요청</button>
                                    <button type="submit" class="change_con_btn">변경확인</button>
                                    <button type="button" class="phone_cancle_btn change_cancle_btn">취소</button>
                                </div>
                            </form>

                        <form action="updateEmail.do">       
                                <div class="info_email_box myinfo_box">
                                    <div class="existing_email_box existing_box">
                                    	<input type="hidden" name="mem_id" value="${sessionScope.mem_id}">
                                        <div class="info_box_title">이메일 <span id="result_checkEm" class="identify">* 이메일을 입력해주세요</span></div>
                                        <input class="info_email_input" type="text" id="userEmail1" name="mem_em" value="${sessionScope.mem_em}" readonly>
                                        <button type="button" class="change_email change_btn">변경하기</button>
                                    </div>

                                    <div class="change_email_box">
                                        <div class="info_box_title">
                                        이메일 인증번호 <span id="mail-check-warn" class="identify">* 이메일 인증번호를 입력해주세요</span>
                                        </div>
                                        <input class="info_email_input mail-check-input" type="text" name=""><span id="timer4"></span>
                                        <button onclick="verifyCode()" type="button" class="veri_confirm_btn">인증확인</button>
                                    </div>
                                    <button type="button" id="mail-Check-Btn" class="email_need_veri_btn">인증요청</button>
                                    <button type="submit" class="change_con_btn">변경확인</button>
                                    <button type="button" class="email_cancle_btn change_cancle_btn">취소</button>
                                </div>
                            </form>
                    </div>

            <!-- /////////////////////////////////////////// -->
                     <div class="change_my_pwd_box">
        <button type="button" class="change_my_pwd_btn">비밀번호 변경하기</button>
        <form action="changePwd.do" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="mem_id" value="${sessionScope.mem_id}">
            <div class="change_pwd_box">
                <div class="label_name">현재 비밀번호</div>
                <input id="mem_pwd" name="mem_pwd" type="password" placeholder="현재 비밀번호" required/>
            </div>

            <div class="change_pwd_box">
                <div class="label_name">변경할 비밀번호</div>
                <input id="mem_chpwd" name="mem_chpwd" type="password" placeholder="영문, 숫자, 특수기호 모두 조합" required/>
            </div>
            <div class="change_pwd_box">
                <div class="label_name">비밀번호 확인</div>
                <input id="mem_chpwdchk" name="mem_chpwdchk" type="password" placeholder="영문, 숫자, 특수기호 모두 조합" required/>
            </div>  

            <div class="">
                <button type="submit" class="change_pwd_confirm_btn">비밀번호 변경확인</button>
            </div>
            <div>
                <button type="button" class="change_pwd_cancle_btn">취소</button>
            </div>
        </form>
    </div>
    <c:if test="${not empty message}">
        <script type="text/javascript">
            alert("${message}");
            window.location.href = "index.jsp"; // 비밀번호 변경 성공 시 이동할 페이지
        </script>
    </c:if>
    <c:if test="${not empty error}">
        <script type="text/javascript">
            alert("${error}");
        </script>
    </c:if>
    <script>
    function validateForm() {
        const currentPassword = document.getElementById('mem_pwd').value;
        const newPassword = document.getElementById('mem_chpwd').value;
        const confirmPassword = document.getElementById('mem_chpwdchk').value;

        if (newPassword !== confirmPassword) {
            alert('변경할 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
            return false;
        }

        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
        if (!passwordPattern.test(newPassword)) {
            alert('비밀번호는 영문, 숫자, 특수기호를 모두 포함하여 8자 이상이어야 합니다.');
            return false;
        }

        return true;
    }
    </script>
    <!-- /////////////////////////////////////////// -->
                    <script>
                        $(document).ready(function() {
                            // 변경하기 버튼 클릭 이벤트
                            $('.change_phone').click(function() {
                                // change_phone_box, submit 버튼, 취소 버튼 보이기
                                $('.change_phone_box, .info_phone_box > button[type=submit], .phone_cancle_btn, .phone_need_veri_btn').show();
                                // 휴대폰 입력 필드의 readonly 속성 제거
                                $('.info_phone_box .info_phone_input[readonly]').removeAttr('readonly');
                            });
                
                            // 취소 버튼 클릭 이벤트
                            $('.phone_cancle_btn').click(function() {
                                // change_phone_box, submit 버튼, 취소 버튼 숨기기
                                $('.change_phone_box, .info_phone_box > button[type=submit], .phone_cancle_btn, .phone_need_veri_btn').hide();
                                // 휴대폰 입력 필드에 다시 readonly 속성 추가
                                $('.info_phone_box .info_phone_input').attr('readonly', true);
                            });

                            // 변경하기 버튼 클릭 이벤트
                            $('.change_email').click(function() {
                                // change_email_box, submit 버튼, 취소 버튼 보이기
                                $('.change_email_box, .info_email_box > button[type=submit], .email_cancle_btn, .email_need_veri_btn').show();
                                // 이메일 입력 필드의 readonly 속성 제거
                                $('.info_email_box .info_email_input[readonly]').removeAttr('readonly');
                            });

                            // 취소 버튼 클릭 이벤트
                            $('.email_cancle_btn').click(function() {
                                // change_email_box, submit 버튼, 취소 버튼 숨기기
                                $('.change_email_box, .info_email_box > button[type=submit], .email_cancle_btn, .email_need_veri_btn').hide();
                                // 이메일 입력 필드에 다시 readonly 속성 추가
                                $('.info_email_box .info_email_input').attr('readonly', true);
                            });

                            $('.change_my_pwd_btn').click(function() {
                                // form 태그 보이기
                                $(this).next('form').show();
                                // "비밀번호 변경하기" 버튼 숨기기
                                $(this).hide();
                            });

                            // "취소" 버튼 클릭 이벤트
                            $('.change_pwd_cancle_btn').click(function() {
                                // form 태그 숨기기
                                $('.change_my_pwd_box form').hide();
                                // "비밀번호 변경하기" 버튼 다시 보이기
                                $('.change_my_pwd_btn').show();
                            });
                        });
                    </script>
                </div>
                <!-- 마이페이지 내정보 끝 -->


     <style>
        .hidden { 
             display: none;
        }
     </style>
				<!-- 마이페이지 쿠폰 시작 -->
				<div id="mypage_coupon" class="mypage-content">
				    <div class="mycon_title">나의 쿠폰내역</div>
				    <div class="my_coupon_box down_box">
				        <div class="sub_title">발급 가능 쿠폰 리스트</div>
				        <table>
				            <thead>
				                <tr>
				                    <th>쿠폰이름</th>
				                    <th>시작일</th>
				                    <th>만료일</th>
				                    <th>할인율</th>
				                    <th>발급</th>
				                </tr>
				            </thead>
				            <tbody id="coupongetList">
				                <!-- 쿠폰 데이터가 여기에 추가됩니다 -->
				            </tbody>
				        </table>
				    </div>
				
				    <div class="my_coupon_box top_box">
				        <div class="sub_title">쿠폰 보유 내역</div>
				        <table>
				            <thead id="couponTableHeader" class="hidden">
				                <tr>
				                    <th>쿠폰이름</th>
				                    <th>사용기간</th>
				                </tr>
				            </thead>
				            <tbody id="couponTableBody">
				                <!-- 쿠폰 데이터가 여기에 추가됩니다 -->
				            </tbody>
				        </table>
				        <div id="noCouponsMessage" class="non_my_book hidden">쿠폰이 없습니다.</div>
				    </div>
				
				    <div class="my_coupon_box">
				        <div class="sub_title">쿠폰 사용 내역</div>
				        <table>
				            <thead id="usedCouponTableHeader" class="hidden">
				                <tr>
				                    <th>쿠폰이름</th>
				                    <th>사용일</th>
				                </tr>
				            </thead>
				            <tbody id="couponBody">
				                <!-- 쿠폰 데이터가 여기에 추가됩니다 -->
				            </tbody>
				        </table>
				        <div id="noUsedCouponsMessage" class="non_my_book hidden">쿠폰 사용 내역이 없습니다.</div>
				    </div>
				</div>

<script>
$(document).ready(function() {
    function loadCoupons() {
        // 발급 가능 쿠폰 리스트 가져오기
        $.ajax({
            type: 'GET',
            url: '/getCouponList.do',
            success: function(data) {
                var couponList = data.couponList;
                var downloadedCoupons = data.downloadedCoupons;
                var tableBody = $('#coupongetList');
                tableBody.empty();

                console.log(couponList);

                if (couponList.length === 0) {
                    tableBody.append('<tr><td colspan="5">발급 가능 쿠폰이 없습니다.</td></tr>');
                } else {
                    $.each(couponList, function(index, coupon) {
                        var row = $('<tr>');
                        row.append($('<td>').text(coupon.cup_contents));
                        row.append($('<td>').text(coupon.cup_sdate));
                        row.append($('<td>').text(coupon.cup_edate));
                        row.append($('<td>').text(coupon.cup_dc + " %"));

                        var downloadButton = $('<a href="#" class="download_btn">');
                        if (downloadedCoupons.includes(coupon.cup_num)) {
                            downloadButton.text('발급 완료');
                            downloadButton.addClass('disabled');
                        } else {
                            downloadButton.text('발급하기');
                            downloadButton.data('cup-num', coupon.cup_num);
                        }
                        row.append($('<td>').html(downloadButton));
                        tableBody.append(row);
                    });

                    // Add click event listener for download buttons
                    $('.download_btn').click(function(e) {
                        e.preventDefault();
                        if ($(this).hasClass('disabled')) {
                            return;
                        }
                        var cupNum = $(this).data('cup-num');
                        var $button = $(this); // 현재 클릭된 버튼을 참조
                        $.ajax({
                            type: 'GET',
                            url: '/downloadCoupon.do',
                            data: { cup_num: cupNum },
                            success: function(response) {
                                if (response === 'alreadyDownloaded') {
                                    alert('이미 다운 받으신 쿠폰입니다.');
                                } else if (response === 'success') {
                                    alert('쿠폰이 발급되었습니다.');
                                    $button.text('발급 완료'); // 버튼 텍스트 변경
                                    $button.addClass('disabled'); // 버튼 비활성화
                                } else {
                                    alert('쿠폰 발급 중 오류가 발생했습니다.');
                                }
                            },
                            error: function() {
                                alert('서버 오류가 발생했습니다.');
                            }
                        });
                    });
                }
            },
            error: function(error) {
                console.log(error);
            }
        });

        // 보유 쿠폰 내역 가져오기
        $.ajax({
            type: 'GET',
            url: '/myCouponList.do',
            success: function(couponList) {
                var tableHeader = $('#couponTableHeader');
                var tableBody = $('#couponTableBody');
                var noCouponsMessage = $('#noCouponsMessage');
                tableBody.empty();

                if (couponList.length === 0) {
                    noCouponsMessage.removeClass('hidden');
                    tableHeader.addClass('hidden');
                } else {
                    noCouponsMessage.addClass('hidden');
                    tableHeader.removeClass('hidden');
                    $.each(couponList, function(index, coupon) {
                        var row = $('<tr>');
                        row.append($('<td>').text(coupon.cup_contents));
                        row.append($('<td>').text(coupon.cup_sdate + ' ~ ' + coupon.cup_edate));
                        tableBody.append(row);
                    });
                }
            },
            error: function(error) {
                console.log(error);
            }
        });

        // 사용한 쿠폰 내역 가져오기
        $.ajax({
            type: 'GET',
            url: '/myCouponList1.do',
            success: function(couponList) {
                var tableHeader = $('#usedCouponTableHeader');
                var tableBody = $('#couponBody');
                var noUsedCouponsMessage = $('#noUsedCouponsMessage');
                tableBody.empty();

                if (couponList.length === 0) {
                    noUsedCouponsMessage.removeClass('hidden');
                    tableHeader.addClass('hidden');
                } else {
                    noUsedCouponsMessage.addClass('hidden');
                    tableHeader.removeClass('hidden');
                    $.each(couponList, function(index, coupon) {
                        var row = $('<tr>');
                        row.append($('<td>').text(coupon.cup_contents));
                        row.append($('<td>').text(coupon.cup_fdate));
                        tableBody.append(row);
                    });
                }
            },
            error: function(error) {
                console.log(error);
            }
        });
    }

    // 페이지 로드 시 쿠폰 목록을 로드
    loadCoupons();
});
</script>
                <!-- 마이페이지 쿠폰 끝 -->

				<!-- 마이페이지 선물 시작 -->
				               <div id="mypage_gift" class="mypage-content">
				    <div class="mycon_title">나의 선물내역</div>
				    <div class="my_gift_box">
				        <div class="sub_title">받은 선물 내역</div>
				        <c:set var="hasReceivedGifts" value="false" />
				        <table>
				            <thead>
				                <tr>
				                    <th>보낸사람</th>
				                    <th>상품명</th>
				                    <th>상품번호</th>
				                    <th>받은날짜</th>
				                    <th>가격</th>
				                    <th>상태</th>
				                </tr>
				            </thead>
				            <tbody>
				                <c:forEach var="gift" items="${giftList}">
				                    <c:if test="${sessionScope.mem_tel == gift.gift_owntel && sessionScope.mem_nm == gift.gift_owner}">
				                        <c:set var="hasReceivedGifts" value="true" />
				                        <tr>
				                            <td>${gift.gift_buyer}</td>
				                            <td>${gift.prd_name}</td>
				                            <td>${gift.prd_serial}</td>
				                            <td>${gift.gift_date}</td>
				                            <td><fmt:formatNumber value="${gift.prd_price}" pattern="#,### 원" /></td>
				                            <td>${gift.state}</td>
				                        </tr>
				                    </c:if>
				                </c:forEach>
				                <c:if test="${!hasReceivedGifts}">
				                    <tr>
				                        <td colspan="6">받은 선물이 없습니다</td>
				                    </tr>
				                </c:if>
				            </tbody>
				        </table>
				    </div>
				
				    <div class="my_gift_box">
				        <div class="sub_title">보낸 선물 내역</div>
				        <c:set var="hasSentGifts" value="false" />
				        <table>
				            <thead>
				                <tr>
				                    <th>받는사람</th>
				                    <th>상품명</th>
				                    <th>보낸날짜</th>
				                    <th>가격</th>
				                </tr>
				            </thead>
				            <tbody>
				                <c:forEach var="gift" items="${giftList}">
				                    <c:if test="${sessionScope.mem_tel == gift.gift_buyertel && sessionScope.mem_nm == gift.gift_buyer}">
				                        <c:set var="hasSentGifts" value="true" />
				                        <tr>
				                            <td>${gift.gift_owner}</td>
				                            <td>${gift.prd_name}</td>
				                            <td>${gift.gift_date}</td>
				                            <td><fmt:formatNumber value="${gift.prd_price}" pattern="#,### 원" /></td>
				                        </tr>
				                    </c:if>
				                </c:forEach>
				                <c:if test="${!hasSentGifts}">
				                    <tr>
				                        <td colspan="4">보낸 선물이 없습니다</td>
				                    </tr>
				                </c:if>
				            </tbody>
				        </table>
				    </div>
				</div>
				<!-- 마이페이지 선물 끝 -->


                <!-- 마이페이지 구매내역 시작 -->
                <div id="mypage_buy_history" class="mypage-content">
                    <div class="mycon_title">나의 구매내역</div>
                    <div class="my_coupon_box top_box">
                        <div class="sub_title">구매 내역</div>
                        <table>
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>상품이름</th>
                                    <th>결제방식</th>
                                    <th>상품가격</th>
                                    <th>결제상태</th>
                                    <th>환불하기</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                            <div class="dash_bill_paging paging_box">
                               
                 			</div>
                    </div>
                </div>
                
                <script>
                $('#mypage_buy_history_tab').click(function() {
                    $.ajax({
                        type: 'POST',
                        url: 'getBillList.do',
                        cache: false,
                        async: false,
                        success: function(BillList) {
                            var tableBody = $('#mypage_buy_history tbody');
                            var pageSize = 7;
                            var currentPage = 1;
                            var pagination = $('.dash_bill_paging');
                            var maxPagesToShow = 3;
                            var uniqueBillNumbers = [];
                            var billMap = {};
                            var billCountMap = {};

                            function displayCoupons() {
                                uniqueBillNumbers = [];
                                billMap = {};
                                billCountMap = {};

                                BillList.forEach(function(bill) {
                                    if (!uniqueBillNumbers.includes(bill.bill_num)) {
                                        uniqueBillNumbers.push(bill.bill_num);
                                    }
                                });

                                BillList.forEach(function(bill) {
                                    if (!billMap[bill.bill_num]) {
                                        billMap[bill.bill_num] = bill;
                                    }
                                    if (!billCountMap[bill.bill_num]) {
                                        billCountMap[bill.bill_num] = 0;
                                    }
                                    billCountMap[bill.bill_num]++;
                                });

                                var start = (currentPage - 1) * pageSize;
                                var end = start + pageSize;
                                var displayedBillNumbers = uniqueBillNumbers.slice(start, end);

                                tableBody.empty();
                                if (displayedBillNumbers.length > 0) {
                                    displayedBillNumbers.forEach(function(billNumber) {
                                        var bill = billMap[billNumber];
                                        var row = $('<tr>');
                                        var billMessage = (billCountMap[billNumber] > 1) ? ' 외 ' + (billCountMap[billNumber] - 1) + ' 건' : '';

                                        row.append('<td>' + bill.bill_num + '</td>');
                                        row.append('<td>' + bill.bill_prd_name + billMessage + '</td>');
                                        row.append('<td>' + bill.bill_method + '</td>');
                                        row.append('<td>' + Number(bill.bill_price).toLocaleString() + '</td>');
                                        row.append('<td>' + bill.bill_status + '</td>');
                                        if(bill.bill_method == "일반 결제"){
                                            row.append('<td><button class="cancel_module_basic dash_btn_1" data-bill-num="' + bill.bill_num + '">일반 환불</button></td>');
                                            }else{
                                            row.append('<td><button class="cancel_module_point dash_btn_1" data-bill-num="' + bill.bill_num + '">포인트 환불</button></td>');
                                               
                                            }
                                        tableBody.append(row);
                                    });
                                } else {
                                    var noDataMessage = $('<tr><td colspan="6">구매 내역이 없습니다.</td></tr>');
                                    tableBody.append(noDataMessage);
                                }

                                generatePagination();
                            }

                            function generatePagination() {
                                pagination.empty();
                                var pageCount = Math.ceil(uniqueBillNumbers.length / pageSize);
                                if (pageCount > 0) {
                                    var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                    var startPage = groupIndex * maxPagesToShow + 1;
                                    var endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                    if (startPage > 1) pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                    for (var i = startPage; i <= endPage; i++) {
                                        pagination.append('<a href="#" class="page_link' + (i === currentPage ? ' current_page' : '') + '">' + i + '</a>');
                                    }
                                    if (endPage < pageCount) pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                }
                            }

                            pagination.off('click', '.prev_group, .next_group, .page_link');
                            pagination.on('click', '.prev_group', function(event) {
                                event.preventDefault();
                                if (currentPage > maxPagesToShow) {
                                    currentPage -= maxPagesToShow;
                                    displayCoupons();
                                }
                            });

                            pagination.on('click', '.next_group', function(event) {
                                event.preventDefault();
                                if (currentPage <= uniqueBillNumbers.length - maxPagesToShow) {
                                    currentPage += maxPagesToShow;
                                    displayCoupons();
                                }
                            });

                            pagination.on('click', '.page_link', function(event) {
                                event.preventDefault();
                                currentPage = parseInt($(this).text());
                                displayCoupons();
                            });

                            displayCoupons();
                        },
                        error: function(error) {
                            console.log(error);
                        }
                    });
                });

	
                
                $(document).on('click', '.cancel_module_basic', function () {
                    var billNum = $(this).data('bill-num');
                    console.log("billNum " + billNum);
                    $.ajax({
                       url: "paycan.do",
                       data: {
                          "mid": "merchant_" + billNum
//                           "payment" : bill_Method
                       },
                       method: "POST",
                       success: function(val){
                          console.log(val);
                          if(val == 1){
                             alert("취소 완료");
                           location.reload(); 
                             $("#all_module").trigger("click");
                          }else if(val == -2){
                             alert("이미 취소된 건입니다.");
                          }else {
                             alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
                          }
                       },
                       error: function(request, status){
                          alert("취소가 실패하였습니다.");
                       }
                    });
                });
                
                $(document).on('click', '.cancel_module_point', function () {
                    var billNum = $(this).data('bill-num');
                    console.log("billNum " + billNum);
                    $.ajax({
                       url: "paycanPoint.do",
                       data: {
                          "mid": billNum
//                           "payment" : bill_Method
                       },
                       method: "POST",
                       success: function(val){
                          console.log(val);
                          if(val == 1){
                             alert("취소 완료");
                              location.reload(); 
                             $("#all_module").trigger("click");
                             
                          }else if(val == -2){
                             alert("이미 취소된 건입니다.");
                          }else {
                             alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
                          }
                       },
                       error: function(request, status){
                          alert("취소가 실패하였습니다.");
                       }
                    });
                });
                
                </script>
                <!-- 마이페이지 구매내역 끝 -->
                



           <!-- 마이페이지 나의 이용내역 시작 -->
				<div id="mypage_movie_history" class="mypage-content">
					<div class="mycon_title">나의 이용내역</div>

					<div class="my_book_list_box" id="pastTicketInfo">
						<div class="non_my_book">예약 내역이 없습니다.</div>
						<ul>
							<li class="my_book_list">
								<form action="">
									<div class="mybook_info_box">
										<div class="mybook_left_box">
											<img
												src="${pageContext.request.contextPath}/resources/img/movie_poster_01.png"
												alt="">
										</div>
										<div class="mybook_right_box">
											<div class="mypage_book_st my_book_movie_name_box">
												<input class="my_book_movie_name" type="text" name=""
													placeholder="범죄도시 4" readonly>
											</div>

											<div class="mypage_book_st">
												<div class="book_info_line">
													<div class="book_sort_name">관람일시</div>
													<input class="" type="text" name=""
														placeholder="2024.05.15(수) 17:50" readonly>
												</div>

												<div class="book_info_line">
													<div class="book_sort_name">상영관</div>
													<input class="" type="text" name="" placeholder="1 관"
														readonly>
												</div>
											</div>

											<div class="mypage_book_st">
												<div class="book_info_line">
													<div class="book_sort_name">관람인원</div>
													<input class="" type="text" name="" placeholder="1 명"
														readonly>
												</div>

												<div class="book_info_line">
													<div class="book_sort_name">관람좌석</div>
													<input class="" type="text" name="" placeholder="L 15"
														readonly>
												</div>
											</div>

											<div class="mypage_book_st">
												<div class="book_info_line">
													<div class="book_sort_name">예매번호</div>
													<input class="" type="text" name=""
														placeholder="1132-1234-6434-0011" readonly>
												</div>
											</div>

											<div class="mypage_book_st">
												<div class="book_info_line">
													<div class="book_sort_name">결제금액</div>
													<input class="book_price" type="text" name=""
														placeholder="15,000원" readonly>
												</div>
											</div>
										</div>
									</div>
									<div class="book_cancle_btn">
										<button>
											<img
												src="${pageContext.request.contextPath}/resources/img/cancle_ico.png"
												alt="">
										</button>
									</div>
								</form>
							</li>
						</ul>
					</div>
					<script>
					function getPastTicket(){
		              	  var form = document.getElementById('fileUploadForm');  
		                  var data = new FormData(form);  

	            		$.ajax({
	            	        type: 'POST',
	            	        enctype: 'multipart/form-data', 
	            	        url: 'getPastTicket.do',
	            	        data : data,
	            	        processData: false,    
	            	        contentType: false,     
	            	        cache: false,
	            	        async : false,
	            	        success: function(ticketInfo) {
	            	            console.log("ticketInfo", ticketInfo);
	            	            var bookDiv = document.querySelector("#pastTicketInfo"); // 하나의 거대한 덩어리로 되어 있어서 여기 부분 오류가 발생할 수 있음.
	            	            bookDiv.innerHTML = ''; // 기존 내용을 초기화
	            	            
	            	            if (ticketInfo.length === 0) {
	            	                var non_my_book = document.createElement("div");
	            	                non_my_book.classList.add("non_my_book");
	            	                non_my_book.textContent = "이용 내역이 없습니다.";
	            	                bookDiv.appendChild(non_my_book);
	            	            } else {
	            	                ticketInfo.forEach(function(ticket) {
	            	                    // 예매 정보가 있는 경우, HTML 요소를 생성하여 추가
	            	                    var li = document.createElement("li");
	            	                    li.classList.add("my_book_list");

	            	                    var form = document.createElement("form");
	            	                    

	            	                    var mybookInfoBox = document.createElement("div");
	            	                    mybookInfoBox.classList.add("mybook_info_box");

	            	                    var mybookLeftBox = document.createElement("div");
	            	                    mybookLeftBox.classList.add("mybook_left_box");
	            	                    var img = document.createElement("img");
	            	                    img.src = "${pageContext.request.contextPath}/resources/img/"+ticket.mov_Post; // 포스터 이미지 경로 설정
	            	                    mybookLeftBox.appendChild(img);

	            	                    var mybookRightBox = document.createElement("div");
	            	                    mybookRightBox.classList.add("mybook_right_box");

	            	                    // 영화 이름
	            	                    var mypageBookStNameBox = document.createElement("div");
	            	                    mypageBookStNameBox.classList.add("mypage_book_st", "my_book_movie_name_box");
	            	                    
	            	                    var inputMovieName = document.createElement("input");
	            	                    inputMovieName.classList.add("my_book_movie_name");
	            	                    inputMovieName.type = "text";
	            	                    inputMovieName.readOnly = true;
	            	                    inputMovieName.placeholder = ticket.tic_MovName; // 영화 이름 설정
	            	                    mypageBookStNameBox.appendChild(inputMovieName);
	            	                    mybookRightBox.appendChild(mypageBookStNameBox);
	            	                   
								        const mypageBookSt = document.createElement('div');
								        mypageBookSt.classList.add("mypage_book_st");
								        
								        // 첫 번째 book_info_line 생성
								        const bookInfoLine1 = document.createElement('div');
								        bookInfoLine1.className = 'book_info_line';
								
								        const bookSortName1 = document.createElement('div');
								        bookSortName1.className = 'book_sort_name';
								        bookSortName1.innerText = '관람일시';
								
								        const input1 = document.createElement('input');
								        input1.type = 'text';
								        input1.placeholder = ticket.tic_WatDate+" "+ticket.tic_WatTime;
								        input1.readOnly = true;
								
								        bookInfoLine1.appendChild(bookSortName1);
								        bookInfoLine1.appendChild(input1);
								
								        // 두 번째 book_info_line 생성
								        const bookInfoLine2 = document.createElement('div');
								        bookInfoLine2.className = 'book_info_line';
								
								        const bookSortName2 = document.createElement('div');
								        bookSortName2.className = 'book_sort_name';
								        bookSortName2.innerText = '상영관';
								
								        const input2 = document.createElement('input');
								        input2.type = 'text';
								        input2.placeholder = ticket.tic_MovRoom;
								        input2.readOnly = true;
								
								        bookInfoLine2.appendChild(bookSortName2);
								        bookInfoLine2.appendChild(input2);
								        
								        // 부모 div 요소에 추가
								        mypageBookSt.appendChild(bookInfoLine1);
								        mypageBookSt.appendChild(bookInfoLine2);
								        
								        const mypageBookSt2 = document.createElement('div');
								        mypageBookSt2.classList.add("mypage_book_st");

								        // 3 번째 book_info_line 생성
								        const bookInfoLine3 = document.createElement('div');
								        bookInfoLine3.className = 'book_info_line';
								
								        const bookSortName3 = document.createElement('div');
								        bookSortName3.className = 'book_sort_name';
								        bookSortName3.innerText = '관람인원';
								
								        const input3 = document.createElement('input');
								        input3.type = 'text';
								        input3.placeholder = ticket.tic_WatNum+"명";
								        input3.readOnly = true;
								
								        bookInfoLine3.appendChild(bookSortName3);
								        bookInfoLine3.appendChild(input3);
								
								        // 4 번째 book_info_line 생성
								        const bookInfoLine4 = document.createElement('div');
								        bookInfoLine4.className = 'book_info_line';
								
								        const bookSortName4 = document.createElement('div');
								        bookSortName4.className = 'book_sort_name';
								        bookSortName4.innerText = '관람좌석';
								
								        const input4 = document.createElement('input');
								        input4.type = 'text';
								        input4.placeholder = ticket.tic_RoomSeat;
								        input4.readOnly = true;
								
								        bookInfoLine4.appendChild(bookSortName4);
								        bookInfoLine4.appendChild(input4);
								
								        // 부모 div 요소에 추가
								        mypageBookSt2.appendChild(bookInfoLine3);
								        mypageBookSt2.appendChild(bookInfoLine4);

								        const mypageBookSt3 = document.createElement('div');
								        mypageBookSt3.classList.add("mypage_book_st");
								        
								        // 5 번째 book_info_line 생성
								        const bookInfoLine5 = document.createElement('div');
								        bookInfoLine5.className = 'book_info_line';
								
								        const bookSortName5 = document.createElement('div');
								        bookSortName5.className = 'book_sort_name';
								        bookSortName5.innerText = '예매번호';
								
								        const input5 = document.createElement('input');
								        input5.type = 'text';
								        input5.name = "tic_ID";
								        input5.placeholder = ticket.tic_Id;
								        input5.readOnly = true;
								
								        bookInfoLine5.appendChild(bookSortName5);
								        bookInfoLine5.appendChild(input5);
								        
								        mypageBookSt3.appendChild(bookInfoLine5);
								        
								        const mypageBookSt4 = document.createElement('div');
								        mypageBookSt4.classList.add("mypage_book_st");
								
								        // 6 번째 book_info_line 생성
								        const bookInfoLine6 = document.createElement('div');
								        bookInfoLine6.className = 'book_info_line';
								
								        const bookSortName6 = document.createElement('div');
								        bookSortName6.className = 'book_sort_name';
								        bookSortName6.innerText = '결제금액';
								
								        const input6 = document.createElement('input');
								        input6.type = 'text';
								        input6.placeholder = ticket.tic_Price;
								        input6.readOnly = true;
								
								        bookInfoLine6.appendChild(bookSortName6);
								        bookInfoLine6.appendChild(input6);
								
								        // 부모 div 요소에 추가
								        mypageBookSt4.appendChild(bookInfoLine6);
								        
								        mybookRightBox.appendChild(mypageBookSt);
								        mybookRightBox.appendChild(mypageBookSt2);
								        mybookRightBox.appendChild(mypageBookSt3);
								        mybookRightBox.appendChild(mypageBookSt4);
	            	                    

	            	                    mybookInfoBox.appendChild(mybookLeftBox);
	            	                    mybookInfoBox.appendChild(mybookRightBox);
	            	                    form.appendChild(mybookInfoBox);

	            	                    // 예매 취소 버튼 추가
	            	                    var bookCancelBtn = document.createElement("div");
	            	                    bookCancelBtn.classList.add("book_cancle_btn");
	            	                    var cancelButton = document.createElement("button");
	            	                    cancelButton.type="button";
	            	                    cancelButton.classList.add("cancel-ticket");
	            	                    var cancelImg = document.createElement("img");
	            	                    cancelImg.src = "${pageContext.request.contextPath}/resources/img/cancle_ico.png";
	            	                    cancelButton.appendChild(cancelImg);
	            	                    bookCancelBtn.appendChild(cancelButton);

	            	                    form.appendChild(bookCancelBtn);
	            	                    li.appendChild(form);

	            	                    bookDiv.appendChild(li); // 최종적으로 생성한 li 요소를 bookDiv에 추가
	            	                });
	            	            }
	            	        },
	            	        error: function(error) {
	            	            console.log(error);
	            	        }
	            	    });// 아작스 끝	
	            			
	            	} // 함수 끝
	            	
	            	(function(){getPastTicket()})();
					</script>
				</div>
				<!-- 마이페이지 나의 이용내역 끝 -->
<script>
var chk = false;
$(document).ready(function(){
   
   var IMP = window.IMP;
      IMP.init('imp01861206');
   
   var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
      console.log("isMobile " + isMobile );
      
       //모바일이 아닌 경우 스크립트
    if(!isMobile) {
       $("#check_module").click(function () {
          var selectPay = $(".payHow").text().trim();
           var prd_num = $('#prd_name').val();
           console.log("selectPay " + selectPay);
           console.log("prd_num "+ prd_num);
           
               console.log("처음" + isMobile);
          IMP.request_pay({
              pg: "danal_tpay", // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             imp_uid: 'imp_uid',
             name: '주문명:결제테스트',
             amount: $("#amount").val(),     
             buyer_email: $("#umail").val() ,  
             buyer_name: $("#unm").val() ,      
             buyer_tel: $("#utel").val() ,       
             buyer_addr: $("#uaddr").val(),
             prdStatus: $("#paymethod").val(),
             prd_name: $("#prd_name").val(),   
             prd_num: $("#prd_num").val(),      
             prd_cnt: $("#prd_cnt").val(),
             buyer_postcode: '123-456',
             paymethod : $("#paymethod").val()
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
          var selectPay = $(".payHow").text().trim();
           var prd_num = $('#prd_name').val();
        if (selectPay === "일반 결제" && prd_num != "") {
            console.log("Processing 일반 결제 모바일");
          IMP.request_pay({
             pg: 'danal_tpay', // 자신이 설정한 pg사 설정
             pay_method: 'card',
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: '주문명:결제테스트',
             amount: $("#amount").val(),     
             buyer_email: $("#umail").val() ,  
             buyer_name: $("#unm").val() ,      
             buyer_tel: $("#utel").val() ,       
             buyer_addr: $("#uaddr").val(),
             prdStatus: $("#paymethod").val(),
             prd_name: $("#prd_name").val(),   
             prd_num: $("#prd_num").val(),      
             prd_cnt: $("#prd_cnt").val(),
             buyer_postcode: '123-456',
             paymethod : $("#paymethod").val(),
             m_redirect_url: 'http://localhost:8090/payments/complete1',
//              popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
             }, function (rsp) {
                console.log("모바일 시작" + rsp);
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
        }else if(selectPay === "포인트 결제" && prd_num != ""){
            
            console.log("paymethod" + paymethod);
             console.log("Processing 포인트 결제 모바일");
            orderList();

         }else{
            console.log("장바구니 아무것도 없는 경우")
         }
       });
        
    }
});

    function orderList(){
          alert('주문내역 처리할 곳. 컨트롤러 호출');
          let fm = document.fm;
          fm.action ="payment.do";
          fm.method="post";
          fm.submit();
       }
       </script>

                <!-- 마이페이지 나의포인트 시작 -->
                <div id="my_point" class="mypage-content">
                    <div class="mycon_title">나의 포인트 내역</div>
                    <div class="my_point_con_box">
                        <div class="my_point_title">보유 포인트</div>
                        <div class="my_point_box">
                            <div class="point_txt">MY POINT</div>
                            <div class="point_cnt"><fmt:formatNumber value="<%= mp %>" pattern="#,### P" /></div>
                        </div>
                    </div>

                    <div class="my_point_add_box">
                        <div class="my_point_title">포인트 충전</div>
                        <div class="add_point_box">
                            <form action="">
                                <div class="point_line point_top">
                                    <div class="point_name">충전 방식 선택</div>
                                    <div class="radio_box">
                                        <div class="point_sort">
                                              <div>일반 결제</div>
                                            <input type="radio" name="addpoint" id="basicPayment" checked>
                                            
                                     <input type="hidden" id="merchant_uid" name="merchant_uid" value="">
                                     <input type="hidden" id="prd_name" name="prd_name" value="포인트 충전">
                                     <input type="hidden" id="prd_num" name="prd_num" value="포인트">
                                     <input type="hidden" id="utel" name="utel" value=<%=tel%>>    
                                     <input type="hidden" id="paymethod" name="paymethod" value="일반 결제">                                                                          
                                     <input type="hidden" id="unm" name="unm" value="${sessionScope.mem_nm}">
                                        </div>
                                        <div class="point_sort">
                                            <div>기프트카드</div>
                                            <input type="radio" name="addpoint" id="pointPayment">
                                        </div>
                                    </div>
                                </div>

                                <div class="point_line basicPayment_box">
                                    <div>
                                        <input type="text" id="amount" name="amount" value="" placeholder="충전 금액 입력">
                                    </div>

                                    <button type="button" id="check_module">충전하기</button>
                                </div>

                                <div class="point_line pointPayment_box">
                                    <div>
                                        <input type="text" name="" id="giftCardNumber" placeholder="기프트카드 번호 입력">
                                    </div>

                                    <button class="" type="button" id="chargeButton">충전하기</button>
                                </div>
<script>
    $(document).ready(function() {
        $('#chargeButton').click(function() {
            var giftCardNumber = $('#giftCardNumber').val();
            console.log("giftCardNumber :" + giftCardNumber);
            $.ajax({
                url: '/chargePoints.do',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: {
                    prd_serial: giftCardNumber
                },
                success: function(response) {
                    alert('충전 성공: 현재 포인트는 ' + response + '점입니다.');
                },
                error: function(xhr, status, error) {
                    try {
                        var errorMessage = JSON.parse(xhr.responseText).message;
                        alert('충전 실패: ' + errorMessage);
                    } catch (e) {
                        alert('충전 실패: 알 수 없는 오류가 발생했습니다.');
                    }
                }
            });
        });
    });
</script>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- 마이페이지 나의포인트 끝 -->
            </div>
        </div>
    </div>
</div>
<%} %>
<%@include file="./footer.jsp"%>