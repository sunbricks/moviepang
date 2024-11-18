<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../sub/header.jsp" %>
<div id="bookmainpage_con">
    <div class="bookmainpage_con pd_box inner">
        <h1 class="bookpage_title">영화 예매</h1>
        <div class="book_selection_box">
            <div class="book_sel_movie">
                <div class="book_sel_head">영화</div>
                <div class="book_sel_box">
                    <ul class="book_movie_list_box">
                        
                    </ul>
                </div>
            </div>
            <div class="book_sel_date">
                <div class="book_sel_head">날짜</div>
                <div class="book_sel_box">
                    <div class="book_date">
                        <div class="book_year"></div>
                        <div class="book_month"></div>
                    </div>
                    <div id="calendar"></div>
                </div>
            </div>
            <div class="book_sel_time">
                <div class="book_sel_head">시간</div>
                <div class="book_sel_box" id="book_sel_box_time">
                
                    <div class="screen_box">
                        <div class="screen_info" style="display: none;">
                            <div class="screen_main">
                                <span class="screen_type"></span>
                                <span class="screen_name"></span>
                            </div>
                            <span class="screen_total_seat"></span>
                        </div>
                        <ul class="book_time_list_box">
                            
                        </ul>
                    </div>

                    <div class="screen_box">
                        <div class="screen_info" style="display: none;">
                            <div class="screen_main">
                                <span class="screen_type"></span>
                                <span class="screen_name"></span>
                            </div>
                            <span class="screen_total_seat"></span>
                        </div>
                        <ul class="book_time_list_box">
                            
                        </ul>
                    </div>

                    <div class="screen_box">
                        <div class="screen_info" style="display: none;">
                            <div class="screen_main">
                                <span class="screen_type"></span>
                                <span class="screen_name"></span>
                            </div>
                            <span class="screen_total_seat"></span>
                        </div>
                        <ul class="book_time_list_box">

                        </ul>
                    </div>
                </div>
            </div>
        </div>
     
        <div class="book_rs_box">
            <form class="book_rs_info_box" action="chooseSeat.do" method="POST">
                <div class="movie_info">
                <img class="movie_thumnail" src="${pageContext.request.contextPath}/resources/img/영화선택이미지.jpg" alt="선택된 영화가 없습니다">
                    <input type="hidden" name="tic_MovPoster" id="tic_MovPoster" readonly>
                    <div class="movie_title">
                        <input type="text" name="tic_MovName" id="movie_title" readonly>
                        <input type="hidden" id="tic_MovRT" name="tic_MovRT" readonly>
                        <input type="hidden" id="tic_MovRate" name="tic_MovRate" readonly>
                        <input type="hidden" id="tic_MovGenre" name="tic_MovGenre" readonly>
                    </div>
                </div>
                <div class="date_info">
                    <div class="book_date_time book_sort">
                        <div class="book_txt">일시</div>
                        <input type="text" name="tic_formedDate"  id="selectedDate" readonly>
                        <input type="hidden" name="tic_WatDate"  id="tic_WatDate" readonly>
                        <input class="selectedTime" type="text" name="tic_WatTime" id="selectedTime" readonly>
                    </div>
                    <div class="book_screen book_sort">
                        <div class="book_txt">상영관</div>
                        <input class="book_screen_info" type="text" name="tic_MovRoom" readonly>
                    </div>
                    <div class="book_h_cnt book_sort">
                        <div class="book_txt">인원</div>
                        <input class="book_h_cnt" type="text" name="" readonly>
                    </div>
                </div>
                <div class="seat_info">
                    <div class="seat_title">좌석 선택</div>
                </div>

                <div class="pay_info">
                    <div class="pay_title">금액 확인</div>
                </div>

                <div class="go_select_seat">
                    <button>좌석선택</button>
                </div>
            </form>
        </div>
       
    </div>
</div>
<script>
(function () {
    $.ajax({
        type: 'POST',
        url: 'getMovNameList.do',
        cache: false,
        async: false,
        success: function(movNameList) {
            var ul = document.querySelector(".book_movie_list_box");
            ul.innerHTML = '';
            
            var urlParams = new URLSearchParams(window.location.search);
            mov_name = urlParams.get('mov_name');
            mov_Post = urlParams.get('mov_Post');
            console.log(mov_name);
            console.log(mov_Post);
            
            if (movNameList.length === 0) {
                console.log("영화 목록이 비어 있습니다.");
                return;
            }
            
            movNameList.forEach(function(movieName) {
                var li = document.createElement("li");
                li.classList.add("book_movie_list");
                var spanAge = document.createElement("span");
                spanAge.classList.add("movie_age");
                if(movieName.mov_Rate == 0){
                   movieName.mov_Rate = "all"
                }
                spanAge.classList.add("age_"+movieName.mov_Rate);
                spanAge.textContent = movieName.mov_Rate.toUpperCase(); // 나이 제한 정보를 여기서 설정해야 할 것 같습니다.
                li.appendChild(spanAge);
                var spanName = document.createElement("span");
                spanName.classList.add("movie_name");
                spanName.textContent = movieName.mov_Nm;
                
                console.log(movieName.mov_Nm);
                li.appendChild(spanName);
                ul.appendChild(li);
                
                if (movieName.mov_Nm == mov_name) {
                   $(".book_movie_list").removeClass("clicked selected_movie");
                   console.log("영화목록 일치");
                    $(li).addClass("clicked selected_movie");
                    li.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    console.log("mov_name : ", mov_name);
                    console.log("mov_Post : ", mov_Post);
                    $("#movie_title").val(mov_name);
                    var img = document.querySelector(".movie_thumnail");
                    img.src = "${pageContext.request.contextPath}/resources/img/" + mov_Post;
                    $("#tic_MovPoster").val(mov_Post);
                    handleClickedMovie(movieName);
                }
                
                function handleClickedMovie(movie) {
                    console.log("클릭된 영화 정보:", movie);
                }
             
            });
         },
         error: function(error) {
             console.log(error);
         }
     });
 })();

$(document).ready(function() {     
    $(document).on('click', '.book_movie_list', function() {  
        console.log("곧 있음 findMovScreenDate 실행함");
        var movieName = $(this).find('.movie_name').text();
        $(".book_time_list_box").empty(); // 시간 목록 초기화
        $("#selectedDate").val(""); // 선택된 날짜 초기화
        $("#tic_WatDate").val(""); // 숨겨진 입력 초기화
        $(".screen_info").hide(); // screen_info 숨기기
        findMovScreenDate(movieName);    
    });  
}); 

function findMovScreenDate(movieName){
    let data = {
        "mov_sMovieName" : movieName
    };
    
    $.ajax({
        type:'POST',
        url : 'findMovScreenDate.do',
        data : data,
        cache:false,
        success: function(dateAndMov){
            
            const calendarContainer = document.getElementById('calendar'); // 캘린더 컨테이너 선택
            calendarContainer.innerHTML = ''; // 캘린더 초기화
            
            let selectedDiv;
            const today = new Date(); 
            today.setHours(0,0,0,0); // 오늘 날짜의 시간을 00:00:00.000으로 설정(상영일 날짜와 비교용)
            
            const dates = dateAndMov.movDateList;
            let dateList = [];
            
            dates.forEach(date => {
                const dateDiv = document.createElement('div');
                const [year, month, day] = date.split('-');
                const dateObj = new Date(year, month - 1, day); // JavaScript Date 객체 생성
            
                const dayName = ['일', '월', '화', '수', '목', '금', '토'][dateObj.getDay()];
                
                if(dateObj >= today){
                    dateDiv.textContent = day+" "+dayName;
                    
                    if (dayName === '일') {
                        dateDiv.style.color = '#FF79C2';
                    } else if (dayName === '토') {
                        dateDiv.style.color = '#7E8CD9';
                    }
                    dateDiv.classList.add('clickable');
                }
                
                console.log("요일에 색상 입히는 것 까지 실행완료");
                dateDiv.onclick = function() {
                    if (dateObj >= today) {
                        const selectedDateText = year+"년 "+month+"월 "+day+"일 ("+dayName+")";
                        document.getElementById('selectedDate').value = selectedDateText;
                       
                        if (selectedDiv) {
                            selectedDiv.classList.remove('selected_date');
                        }
                        
                        dateDiv.classList.add('selected_date');
                        selectedDiv = dateDiv; // 현재 선택된 div 업데이트
                        findMovScreenTime();   
                    }
                };

                calendarContainer.appendChild(dateDiv);
            });
            
            var movInfo = dateAndMov.movInfo;
            console.log(movInfo);
            $("#movie_title").empty();
            $("#movie_title").val(movInfo.mov_Nm);
            document.querySelector(".movie_thumnail").src = "${pageContext.request.contextPath}/resources/img/"+movInfo.mov_Post;
            document.getElementById("tic_MovPoster").value = movInfo.mov_Post; // 영화 포스터
            $("#tic_MovRT").val(movInfo.mov_Rt); // 상영시간
            $("#tic_MovRate").val(movInfo.mov_Rate); // 등급
            $("#tic_MovGenre").val(movInfo.mov_Con1);// 장르
            
        },
        error : function(error){
            console.log(error);
        }
        
    });
}

function findMovScreenTime(){
    let movDate = document.getElementById("selectedDate").value;
    console.log("movDate : ",movDate);
    movDate = movDate.slice(0,movDate.indexOf("(")).replace("년 ","-").replace("월 ","-").replace("일","").trim();
    console.log("movDate : ",movDate);
    document.getElementById("tic_WatDate").value = movDate;
    var data = {
        "mov_sMovieName" : document.getElementById("movie_title").value,
        "mov_sDate" : movDate
    };
    $.ajax({
        type:'POST',
        url : 'findMovScreenTime.do',
        data : data,
        cache:false,
        success: function(screenTimeAndRoomCnt){
            console.log("시간 정보 반환 데이터 : ",screenTimeAndRoomCnt);
            console.log("movScreenList :",screenTimeAndRoomCnt.movTimeList);
            console.log("ticketSeatInfo :",screenTimeAndRoomCnt.ticketSeatInfo);
            let countRoom = [];

            screenTimeAndRoomCnt.movTimeList.forEach(movScreen => {
                countRoom.push(movScreen.mov_sName);
            }); 
                
            console.log("countRoom : ",countRoom);
            
            const uniqueRoom = new Set(countRoom);
            console.log("uniqueRoom :",uniqueRoom);
            
            var book_sel_box = document.querySelector("#book_sel_box_time");
            book_sel_box.innerHTML = '';
            
            uniqueRoom.forEach(room => {
                var screen_box = document.createElement("div");
                screen_box.classList.add("screen_box");
                
                var screen_info = document.createElement("div");
                screen_info.classList.add("screen_info");
                screen_info.style.display = 'block'; // 시간 정보를 가져올 때 보이도록 설정
                
                var screen_main = document.createElement("div");
                screen_main.classList.add("screen_main");
                
                var screen_type = document.createElement("span");
                screen_type.classList.add("screen_type");
                console.log("screen_type :",room.slice(room.indexOf("(")+1,room.indexOf(")")));
                screen_type.textContent = room.slice(room.indexOf("(")+1,room.indexOf(")"));
                
                var screen_name = document.createElement("span");
                screen_name.classList.add("screen_name");
                screen_name.textContent = room.slice(0,room.indexOf("("));
                
                var screen_total_seat = document.createElement("span");
                screen_total_seat.textContent = "(총 100석)";
                
                screen_main.appendChild(screen_type);
                screen_main.appendChild(screen_name);
                screen_info.appendChild(screen_main);
                screen_info.appendChild(screen_total_seat);
                screen_box.appendChild(screen_info);
                
                var book_time_list_box = document.createElement("ul");
                book_time_list_box.classList.add("book_time_list_box");
                
                screenTimeAndRoomCnt.movTimeList.forEach(movScreen => { 
                    if (movScreen.mov_sName === room) {
                        let time = movScreen.mov_sTime;
                        console.log("time : ",time);
                        
                        var book_time_list = document.createElement("li");
                        book_time_list.classList.add("book_time_list");
                        
                        var screen_time = document.createElement("span");
                        screen_time.classList.add("screen_time");
                        console.log("time.slice(0,6) : ",time.slice(0,5));
                        screen_time.textContent = time.slice(0,5);
                        
                        var screen_seat = document.createElement("span");
                        let seatInfo = screenTimeAndRoomCnt.ticketSeatInfo.find(ticketSeat => ticketSeat.TIC_MOVROOM === room && ticketSeat.TIC_WATTIME === time);
                        console.log("seatInfo : ",seatInfo);
                        screen_seat.textContent = seatInfo ? (100 - parseInt(seatInfo.ROOMCNT)) + "석" : "100석";
                        
                        book_time_list.appendChild(screen_time);
                        book_time_list.appendChild(screen_seat);
                        book_time_list_box.appendChild(book_time_list);
                    }
                });
                
                screen_box.appendChild(book_time_list_box);
                book_sel_box.appendChild(screen_box);
            });
        },
        error : function(error){
            console.log(error);
        }
    });
}
</script>
<%@include file ="../sub/footer.jsp" %>