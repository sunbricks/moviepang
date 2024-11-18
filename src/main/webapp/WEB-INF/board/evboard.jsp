<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../sub/header.jsp"%>
<div id="evboardlist_con">
   <div class="evboardlist_con_box pd_box inner">
      <h1 class="evboard_title">EVENT</h1>

      <ul class="event_tabs">
         <li class="tab-link current" data-tab="ev_proceeding">진행중인 이벤트</li>
         <li class="tab-link" data-tab="ev_end">종료된 이벤트</li>
      </ul>

      <div id="ev_proceeding" class="tab-content current">
         <div class="evboard_list_box">
            <ul id="proceeding_event_list">
               <!-- 진행중인 이벤트 목록이 여기에 들어갈 것입니다. -->
            </ul>
         </div>
      </div>

      <div id="ev_end" class="tab-content">
         <div class="evboard_list_box">
            <ul id="ended_event_list">
               <!-- 종료된 이벤트 목록이 여기에 들어갈 것입니다. -->
            </ul>
         </div>
      </div>

      <script>
        $(document).ready(function() {
            var lastCheckedDate = new Date().toDateString(); // 마지막으로 확인한 날짜 저장

            
            function loadProceedingEvents() {
                $.ajax({
                    type: 'POST',
                    url: 'getEv_boardListt.do',
                    dataType: 'json',
                    success: function(data) {
                        var proceedingEventList = $('#proceeding_event_list');
                        
                        proceedingEventList.empty();

                        $.each(data, function(index, event) {
                            var endDate = new Date(event.ev_edate);
                            var currentDate = new Date();

//                             if (endDate < currentDate) {
//                                 event.ev_status = "종료";
//                                 updateEventStatusInDB(event.ev_num, event.ev_status);
//                             }

                            if (event.ev_status === "진행중") {
                         var listItem = $('<li class="evboard_list">');
                         var anchor = $('<a href="getEv_Board.do?ev_num=' + event.ev_num + '">');
                         var thumbnailDiv = $('<div><img class="ev_thumnail" src="/resources/evImg/' + event.ev_img + '" alt=""></div>');
                         var infoDiv = $('<div><div class="ev_info_box"><div class="ev_title">' + event.ev_title + '</div><div class="ev_date"><span class="ev_start">' + event.ev_sdate.slice(0, 10) + '</span> ~ <span class="ev_end">' + event.ev_edate.slice(0, 10) + '</span></div><div class="ev_status">' + event.ev_status + '</div></div></div>');
                     
                         anchor.append(thumbnailDiv);
                         anchor.append(infoDiv);
                         listItem.append(anchor);
                         listItem.data('ev-num', event.ev_num); // 이벤트 번호 추가
                     
                         proceedingEventList.append(listItem);
                     }
                        });

                        // 이벤트 상태 업데이트
                        updateEventStatus();
                    },
                    error: function(error) {
                        console.log("Error loading proceeding events:", error);
                    }
                });
            }

            function loadEndedEvents() {
                $.ajax({
                    type: 'POST',
                    url: 'getEv_boardListf.do',
                    dataType: 'json',
                    success: function(data) {
                        var endedEventList = $('#ended_event_list');
                        endedEventList.empty();

                        $.each(data, function(index, event) {
                            var endDate = new Date(event.ev_edate);
                            var currentDate = new Date();

                            if (endDate < currentDate) {
                                event.ev_status = "종료";
                                updateEventStatusInDB(event.ev_num, event.ev_status);
                            }

                            if (event.ev_status === "종료") {
                                var listItem = $('<li class="evboard_list">');
                                var anchor = $('<a href="getEv_Board.do?ev_num=' + event.ev_num + '">');
                                var thumbnailDiv = $('<div><img class="ev_thumnail" src="/resources/evImg/' + event.ev_img + '" alt=""></div>');
                                var infoDiv = $('<div><div class="ev_info_box"><div class="ev_title">' + event.ev_title + '</div><div class="ev_date"><span class="ev_start">' + event.ev_sdate.slice(0, 10) + '</span> ~ <span class="ev_end">' + event.ev_edate.slice(0, 10) + '</span></div><div class="ev_status">' + event.ev_status + '</div></div></div>');

                                anchor.append(thumbnailDiv);
                                anchor.append(infoDiv);
                                listItem.append(anchor);
                                endedEventList.append(listItem);
                            }
                        });
                    },
                    error: function(error) {
                        console.log("Error loading ended events:", error);
                    }
                });
            }

            function updateEventStatusInDB(ev_num, ev_status) {
                $.ajax({
                    type: 'GET',
                    url: 'updateEv_Board1.do',
                    data: { ev_num: ev_num, ev_status: ev_status },
                    success: function(response) {
                        console.log("Event status updated successfully");
                    },
                    error: function(error) {
                        console.log("Error updating event status:", error);
                    }
                });
            }

            function checkDateChange() {
                var currentDate = new Date().toDateString();
                if (currentDate !== lastCheckedDate) {
                    lastCheckedDate = currentDate;
                    updateEventStatus(); // 날짜가 바뀌면 이벤트 상태 업데이트
                }
            }

            // 페이지 로드 시 진행중인 이벤트와 종료된 이벤트를 로드
            loadProceedingEvents();
            loadEndedEvents();

            // 주기적으로 이벤트 상태를 확인하고 업데이트
            setInterval(checkDateChange, 60000); // 1분마다 확인
        });
        </script>
   </div>
</div>
<%@include file="../sub/footer.jsp"%>