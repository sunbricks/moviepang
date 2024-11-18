<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file ="../sub/header.jsp" %>
<div id="bookcomple_con">
    <div class="bookcomple_con_box pd_box inner">
        <h3 class="bookcomple_head_title">예매완료</h3>
        <div class="bookcomple_box">
            <h2 class="bookcomple_main_title">예매가 완료 되었습니다.</h2>
            <div class="bookcomple_info_box">
                <div class="bookcomple_mov_thumnail">
                    <img src="${pageContext.request.contextPath}${tic_MovPoster}" alt="">
                </div>
                <div class="bookcomple_mov_info_box">
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">예매번호</div>
                        <div class="bookcomple_mov_info">${pay_ID}</div>
                    </div>
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">영화정보</div>
                        <div class="bookcomple_mov_info">${tic_MovName}</div>
                    </div>
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">상영관</div>
                        <div class="bookcomple_mov_info">${tic_MovRoom}</div>
                    </div>
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">일시</div>
                        <div class="bookcomple_mov_info" id="when">${dates} 17:50~19:49</div>
                    </div>
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">인원</div>
                        <div class="bookcomple_mov_info">일반 ${tic_WatNum}명</div>
                    </div>
                    <div class="bookcomple_mov_info_list">
                        <div class="bookcomple_mov_txt">좌석</div>
                        <div class="bookcomple_mov_info">${tic_RoomSeat}</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="go_mainpage_box">
            <a href="${pageContext.request.contextPath}/index.jsp" class="go_mainpage_btn">
                홈 화면으로 돌아가기
            </a>
        </div>
    </div>
</div>
<script>
var dates = ${dates};
var time = ${tic_WatTime};
var splitTime = time.split(":");
var formedTime = "";
if(parseInt(splitTime[0])+2 > 24){
	var hour = parseInt(splitTime[0]);
	hour = hour + 2 - 24;
	
}else{
	var hour = parseInt(splitTime[0]);
	hour += 2;
}

formedTime = hour+":"+time[1];

document.getElementById("when").textContent = dates+"  "+time+"~"+formedTime;

</script>
<%@include file ="../sub/footer.jsp" %>