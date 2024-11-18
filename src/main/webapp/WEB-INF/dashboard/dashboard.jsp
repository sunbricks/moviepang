<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head lang="ko">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">

<meta content="yes" name="apple-mobile-web-app-capable" />
<meta
	content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=no"
	name="viewport" />
<title>Movie Pang</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/dashboard.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/dashmodal.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.min.css" />
<script defer
	src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body style="margin: 0px;">
	<div id="dashboard_con_box">
		<div id="left_header_box">
			<div class="side_menu_box">
				<h1 class="logo">
					<a href="index.jsp"> <img
						src="${pageContext.request.contextPath}/resources/img/logo.png"
						alt="무비팡 로고 이미지">
					</a>
				</h1>
				<ul class="tabs">
					<li class="tab-link current" data-tab="home">홈</li>
					<li class="tab-link" data-tab="chart" id="chart-tab">차트 통계</li>
					<li class="tab-link" id="member_tab" data-tab="member">회원 관리</li>
					<li class="tab-link" id="movie_tab" data-tab="movie">영화 관리</li>
					<li class="tab-link" id="screen-tab" data-tab="screening">상영
						관리</li>
					<li class="tab-link" id="prd_tab" data-tab="prd">상품 관리</li>
					<li class="tab-link" id="board_tab" data-tab="annoboard">공지사항
						게시판 관리</li>
					<li class="tab-link" id="Evboard_tab" data-tab="evboard">이벤트
						게시판 관리</li>
					<li class="tab-link" id="pre_coupon_tab" data-tab="pre_coupon">쿠폰
						관리</li>
					<li class="tab-link" id="coupon_tab" data-tab="coupon">쿠폰 사용자
						관리</li>
					<button class="tab-link" onclick="logoutAndPreventBack()">로그아웃</button>

				</ul>
			</div>
		</div>
		<script>
      
      function logoutAndPreventBack() {
          // 로그아웃 요청 보내기
          fetch('logout1.do')
              .then(response => {
                  if (response.ok) {
                      // 메인 페이지로 리다이렉트
                      window.location.replace('index.jsp'); 

                      // 뒤로가기를 막기 위한 히스토리 조작
                      setTimeout(function() {
                          history.pushState(null, null, 'index.jsp');
                          history.pushState(null, null, 'index.jsp');
                          history.pushState(null, null, 'index.jsp');
                          window.onpopstate = function () {
                              window.location.replace('index.jsp');
                          };
                      }, 0);
                  }
              })
              .catch(error => {
                  console.error('Error during logout:', error);
              });
      }

      
      console.log("window.location.search : ",window.location.search);
      $(document).ready(function() {
    	  var queryString = window.location.search;
    	    if (queryString.includes("screen")) {
    	    	 $('ul.tabs li').removeClass('current');
    	         $('.tab-content').removeClass('current');
    	         
    	         $("#screen-tab").addClass('current');
   	        	 $('#screening').addClass('current');
   	        	
    	    }
      });
      
      </script>
		<div id="right_main_box">
			<div class="main_ajax_box">
				<div id="home" class="tab-content current">
               <div class="dash_home_box">
                  <div class="home_left">
                     <div class="home_left_top d_pd_box">
                        <ul class="date_tabs">
                           <li class="tab-link plus" data-tab="day">주간</li>
                           <li class="tab-link" data-tab="week">월간</li>
                           <li class="tab-link" data-tab="month">년간</li>
                        </ul>
                        <div id="day" class="date_tabs_content plus">
                           <ul class="data-day data_list">
                              <li>
                                 <p class="total_member_cnt real_value"></p>
                                 <p class="total_member_txt value_txt">총 회원</p>
                              </li>

                              <li>
                                 <p class="new_member_cnt real_value week_cnt"></p>
                                 <p class="new_member_txt value_txt">신규 회원</p>
                              </li>

                              <li>
                                 <p class="audience_cnt real_value week_use_cnt"></p>
                                 <p class="audience_txt value_txt">이용 관객수</p>
                              </li>

                              <li>
                                 <p class="sales_cnt real_value week_sales_cnt"></p>
                                 <p class="sales_txt value_txt">영화 매출액</p>
                              </li>
                           </ul>
                        </div>
                        <div id="week" class="date_tabs_content">
                           <ul class="data-week data_list">
                              <li>
                                 <p class="total_member_cnt real_value"></p>
                                 <p class="total_member_txt value_txt">총 회원</p>
                              </li>

                              <li>
                                 <p class="new_member_cnt real_value month_cnt"></p>
                                 <p class="new_member_txt value_txt">신규 회원</p>
                              </li>

                              <li>
                                 <p class="audience_cnt real_value month_use_cnt"></p>
                                 <p class="audience_txt value_txt">이용 관객수</p>
                              </li>

                              <li>
                                 <p class="sales_cnt real_value month_sales_cnt"></p>
                                 <p class="sales_txt value_txt">영화 매출액</p>
                              </li>
                           </ul>
                        </div>
                        <div id="month" class="date_tabs_content">
                           <ul class="data-month data_list">
                              <li>
                                 <p class="total_member_cnt real_value"></p>
                                 <p class="total_member_txt value_txt">총 회원</p>
                              </li>

                              <li>
                                 <p class="new_member_cnt real_value year_cnt"></p>
                                 <p class="new_member_txt value_txt">신규 회원</p>
                              </li>

                              <li>
                                 <p class="audience_cnt real_value year_use_cnt"></p>
                                 <p class="audience_txt value_txt">이용 관객수</p>
                              </li>

                              <li>
                                 <p class="sales_cnt real_value year_sales_cnt"></p>
                                 <p class="sales_txt value_txt">영화 매출액</p>
                              </li>
                           </ul>
                        </div>
                     </div>
                     <div class="home_left_bot d_pd_box">
                        <div class="best_movie_box">
                           <h3 class="best_txt">베스트 인기 영화</h3>
                           <img  class="best_movie_img" src="" alt="">
                           <p class="best_movie_title best_title"></p>
                        </div>
                        <div class="best_product_box">
                           <h3 class="best_txt">베스트 판매 상품</h3>
                           <img class="best_product_img" src="" alt="">
                           <p class="best_product_title best_title"></p>
                        </div>
                     </div>
                  </div>
                  <script>
                     (function(){
                        $.ajax({
                         type: 'POST',
                         url: 'getMemAllCnt.do',
                         success: function(MemberCnt) {
                             $('.total_member_cnt').html(MemberCnt);
                         },
                         error: function(error) {
                             console.log(error);
                         }
                     });
                     })();
                     
                     (function(){
                          $.ajax({
                          type: 'POST',
                          url: 'getMemWeekCnt.do',
                          success: function(MemberCnt) {
                              $('.week_cnt').html(MemberCnt);
                          },
                          error: function(error) {
                             console.log(error);	
                          }
                          });
                        })();

                       (function(){
                          $.ajax({
                          type: 'POST',
                          url: 'getMemMonthCnt.do',
                          success: function(MemberCnt) {
                              $('.month_cnt').html(MemberCnt);
                          },
                          error: function(error) {
                             console.log(error);
                          }
                          });
                        })();

                       (function(){
                          $.ajax({
                          type: 'POST',
                          url: 'getMemYearCnt.do',
                          success: function(MemberCnt) {
                              $('.year_cnt').html(MemberCnt);
                          },
                          error: function(error) {
                             console.log(error);
                          }
                          });
                        })();
                       
                       (function(){
                           $.ajax({
                           type: 'POST',
                           url: 'getUseMemWeekCnt.do',
                           success: function(MemberUseCnt) {
                               $('.week_use_cnt').html(MemberUseCnt);
                           },
                           error: function(error) {
                              console.log(error);
                           }
                           });
                         })();

                        (function(){
                           $.ajax({
                           type: 'POST',
                           url: 'getUseMemMonthCnt.do',
                           success: function(MemberUseCnt) {
                               $('.month_use_cnt').html(MemberUseCnt);
                           },
                           error: function(error) {
                              console.log(error);
                           }
                           });
                         })();

                        (function(){
                           $.ajax({
                           type: 'POST',
                           url: 'getUseMemYearCnt.do',
                           success: function(MemberUseCnt) {
                               $('.year_use_cnt').html(MemberUseCnt);
                           },
                           error: function(error) {
                              console.log(error);
                           }
                           });
                         })();
                        
                        (function() {
                            $.ajax({
                                type: 'POST',
                                url: '/bestPrdName.do',
                                success: function(data) {
                                    console.log("AJAX Success: ", data);
                                    if (data.bill_prd_name && data.prd_Img) {
                                        $('.best_product_title').text(data.bill_prd_name);
                                        $('.best_product_img').attr('src', '/resources/prdImg/' + data.prd_Img);
                                    } else {
                                        console.log("Data is missing: ", data);
                                    }
                                },
                                error: function(error) {
                                    console.log("AJAX Error: ", error);
                                }
                            });
                        })();
                        
                        (function() {
                            $.ajax({
                                type: 'POST',
                                url: '/popularMovie.do',
                                success: function(data) {
                                    console.log("AJAX Success: ", data);
                                    if (data.movieName && data.poster) {
                                        $('.best_movie_title').text(data.movieName);
                                        $('.best_movie_img').attr('src', '/resources/img/' + data.poster);
                                    } else {
                                        console.log("Data is missing: ", data);
                                    }
                                },
                                error: function(error) {
                                    console.log("AJAX Error: ", error);
                                }
                            });
                        })();
                        
                        (function(){
                           $.ajax({
                           type: 'POST',
                           url: 'getWeeklyTicketSales.do',
                           success: function(salesCnt) {
                               $('.week_sales_cnt').html(salesCnt);
                           },
                           error: function(error) {
                              console.log(error);
                           }
                           });
                         })();
                        
                        (function(){
                            $.ajax({
                            type: 'POST',
                            url: 'getMonthlyTicketSales.do',
                            success: function(salesCnt) {
                                $('.month_sales_cnt').html(salesCnt);
                            },
                            error: function(error) {
                               console.log(error);
                            }
                            });
                          })();
                        
                        (function(){
                             $.ajax({
                             type: 'POST',
                             url: 'getYearTicketSales.do',
                             success: function(salesCnt) {
                                 $('.year_sales_cnt').html(salesCnt);
                             },
                             error: function(error) {
                                console.log(error);
                             }
                             });
                           })();


                  </script>
                  <div class="home_right d_pd_box">
                     <h3 class="movie_rank_title">박스오피스 순위</h3>
                     <div class="movie_rank_list">
                        <table>
                           <thead>
                              <tr>
                                 <th class="movie_rank">순위</th>
                                 <th class="movie_name">영화명</th>
                              </tr>
                           </thead>
                           <tbody>

                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
            
        <!-- 대시보드 home 끝  -->

				<!-- dashboard.jsp -->
				<!-- 차트 시작 -->

				<div id="chart" class="tab-content">
					<script type="text/javascript">
               let ageGroup = {};
            	let dayOfCnt = new Map();               
                let movRatio = [];
                let total = 0;
               // 영화 연령 데이터 가져오기
                  $("#chart-tab").click(function () {
                    
                     console.log("영화 차트 데이터 가져오기");
                     $.ajax({
                        url:"findTicketAge.do",
                        type : "POST",
                        cache : false,
                        async : false,
                        success : function(ticketAgeData){
                        	
                         console.log("ticketAgeData",ticketAgeData);
                         ageGroup = ticketAgeData;
                           
                           console.log("ageGroup",ageGroup);
                           getTicketOfDay();
                           getTicketRatio();
                           
                           google.charts.load('current', {packages: ['corechart', 'table']}); // Google 차트 API 로드
                           google.charts.setOnLoadCallback(drawChart);
    
                        },
                        error : function(error){
                           console.log(error);
                        }
                        
                     });
                  });
                     
                   function getTicketOfDay(){
                      $.ajax({
                           url:"findTicketDays.do",
                           type : "POST",
                           cache : false,
                           async : false,
                           success : function(dateAndCnts){
                              
                        	   console.log("dateAndCnts",dateAndCnts);
                        	   
                              for (dateAndCnt of dateAndCnts){
                                 const date = new Date(dateAndCnt.pay_PaymentDate);
                                 const dayOfWeek = date.getDay();
                                 const days = ['일','월', '화', '수', '목', '금', '토'];
                                 const day = days[dayOfWeek];
                                 const cnt = dateAndCnt.cnt;
                                 dayOfCnt.set(day, cnt);
                              }
                          
                           },
                           error : function(error){
                              console.log(error);
                           }
                           
                        });                  
                  }// getTicketOfDay() 
                  
				function getTicketRatio(){
                      $.ajax({
                           url:"getTicketRatio.do",
                           type : "POST",
                           cache : false,
                           async : false,
                           success : function(data){
                        	   console.log("getTicketRatio.do");
                        	   console.log("data :",data);
                              movRatio = data;
                              console.log("movRatio : ",movRatio);
                              for (let i = 0;i<movRatio.length;i++){
                            	  total += movRatio[i].watNum;
                              }
                              console.log("total :",total);
                           },
                           error : function(error){
                              console.log(error);
                           }
                           
                        });                  
                  }// getTicketRatio()
                  
                  
                  function drawChart() {

                   var dataPie = google.visualization.arrayToDataTable([
                      ['나이대', '일주일동안 영화 예매율'],
                      ['10대', ageGroup.teen],
                      ['20대', ageGroup.twenties],
                      ['30대', ageGroup.thirties],
                      ['40대', ageGroup.fourties],
                      ['50대', ageGroup.fifties],
                      ['기타', ageGroup.others]
                   ]);
                   
                   if(ageGroup.total === 0){
                	   var dataPie = google.visualization.arrayToDataTable([
                           ['나이대', '일주일동안 영화 예매율'],
                           ['없음', 1]
                        ]);
                	  
                   }
                
                   var optionsPie = {
                		   title: '일주일동안 연령대별 영화 예매율',
                		   titleTextStyle: {
                		     fontSize: 20, // 제목의 텍스트 크기를 20으로 설정
                		   },
                		   legend: {
                			    position: 'bottom', // 범례를 아래쪽으로 위치시킴
                			  },
                		   // 다른 옵션들...
                		 };
                   
                
                   var chartPie = new google.visualization.PieChart(document.getElementById('pieChart'));
                
                  chartPie.draw(dataPie, optionsPie);
                  
                  // 컬럼 차트
                  var dataColumn = google.visualization.arrayToDataTable([
                      ['요일', '요일별 영화 예매건수 '],
                      ['일', dayOfCnt.get("일") == null? 0 : dayOfCnt.get("일")],
                      ['월', dayOfCnt.get("월") == null? 0 : dayOfCnt.get("월")],
                      ['화', dayOfCnt.get("화") == null? 0 : dayOfCnt.get("화")],
                      ['수', dayOfCnt.get("수") == null? 0 : dayOfCnt.get("수")],
                      ['목', dayOfCnt.get("목") == null? 0 : dayOfCnt.get("목")],
                      ['금', dayOfCnt.get("금") == null? 0 : dayOfCnt.get("금")],
                      ['토', dayOfCnt.get("토") == null? 0 : dayOfCnt.get("토")]
                   ]);
                  
                 var optionsColumn = {
                          title: '일주일동안 요일별 영화 예매건 수',
                          sliceVisibilityThreshold : 0
                       };
                 
                var chartColumn = new google.visualization.ColumnChart(document.getElementById('columnChart'));
                
               
                chartColumn.draw(dataColumn, optionsColumn);
                
                // DataTable 만들기
                var data = new google.visualization.DataTable();
                
                data.addColumn('string', '영화');
                data.addColumn('string', '장르');
                data.addColumn('number', '관객수');
                data.addColumn('number', '평점');
                data.addColumn('number', '예매율');
                
                movRatio.forEach(function(mov){
                	data.addRows([
                        [mov.movName,mov.movGenre, mov.watNum, mov.movScore, (mov.watNum /total)*100  ]
                     
                 ]);
                })
                
                
                 var table = new google.visualization.Table(document.getElementById('tableDiv'));

                  table.draw(data, {showRowNumber: true, width: '100%', height: '100%'});
                     
                }
               </script>
					<div class="chart_pd_box">
						<div class="top_chart">
							<div id="pieChart"></div>
							<div id="columnChart"></div>
						</div>
						<div class="bot_chart">
							<div id="tableDiv"></div>
						</div>
					</div>
				</div>

				<!-- 차트 끝 -->



				<div id="member" class="tab-content">
					<div class="dash_member_box">
						<div class="dash_member_top">
							<h1 class="dash_member_title">회원 정보 관리</h1>
							<form id="searchForm">
								<select name="searchOption" id="searchOption">
									<option value="mem_id">아이디</option>
									<option value="mem_nm">이름</option>
									<option value="mem_bir">생년월일</option>
									<option value="mem_tel">전화번호</option>
								</select> <input type="text" id="searchValue">
								<button type="button" class="search_btn">검색</button>
							</form>
						</div>
						<div class="dash_member_list">
							<table>
								<thead>
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>생년월일</th>
										<th>가입날짜</th>
										<th>회원관리</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
						<div class="dash_member_paging paging_box"></div>
					</div>
				</div>

				<script>
$(document).ready(function() {
    $('#member_tab').click(function() {
        loadMemberList('getMemberList.do');
    });

    $('.search_btn').click(function() {
        var searchOption = $('#searchOption').val();
        var searchValue = $('#searchValue').val();
        loadMemberList('searchMember.do', { option: searchOption, value: searchValue });
    });

    $('.confirm_btn').click(function() {
        $('.member_info_modal').hide();
    });

    function loadMemberList(url, data = {}) {
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            cache: false,
            success: function(memberList) {
                var tableBody = $('#member tbody');
                var pageSize = 7;
                var currentPage = 1;
                var pagination = $('.dash_member_paging');
                var maxPagesToShow = 3;

                function displayMembers() {
                    var start = (currentPage - 1) * pageSize;
                    var end = start + pageSize;
                    var displayedMembers = memberList.slice(start, end);

                    tableBody.empty();
                    displayedMembers.forEach(member => {
                        var row = $('<tr>');
                        row.append('<td>' + member.mem_id + '</td>');
                        row.append('<td>' + member.mem_nm + '</td>');
                        row.append('<td>' + member.mem_bir.slice(0, 10) + '</td>');
                        row.append('<td>' + member.mem_jd.slice(0, 10) + '</td>');
                        row.append('<td><button class="member_detail dash_btn_1">상세보기</button></td>');
                        tableBody.append(row);
                    });

                    generatePagination();
                    bindMemberDetailClickEvent();
                }

                function generatePagination() {
                    pagination.empty();
                    var pageCount = Math.ceil(memberList.length / pageSize);
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
                        displayMembers();
                    }
                });

                pagination.on('click', '.next_group', function(event) {
                    event.preventDefault();
                    if (currentPage <= memberList.length - maxPagesToShow) {
                        currentPage += maxPagesToShow;
                        displayMembers();
                    }
                });

                pagination.on('click', '.page_link', function(event) {
                    event.preventDefault();
                    currentPage = parseInt($(this).text());
                    displayMembers();
                });

                displayMembers();
            },
            error: function(error) {
                console.log(error);
            }
        });
    }

    function bindMemberDetailClickEvent() {
        $('.member_detail').click(function() {
            var mem_id = $(this).closest('tr').find('td:first').text();
            $.ajax({
                type: 'POST',
                url: 'getMemberInfo.do',
                data: { mem_id: mem_id },
                success: function(memberInfo) {
                    var member = memberInfo[0];
                    $('#mem_st').val(member.mem_st);
                    $('#mem_jd').val(member.mem_jd.slice(0, 10));
                    $('#mem_id').val(member.mem_id);
                    $('#mem_nm').val(member.mem_nm);
                    $('#mem_bir').val(member.mem_bir.slice(0, 10));
                    $('#mem_gen').val(member.mem_gen);
                    $('#mem_tel').val(member.mem_tel);
                    $('#mem_em').val(member.mem_em);
                    $('#mem_mp').val(member.mem_mp);
                    $('.member_info_modal').show();
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });
    }
});
</script>

				</tbody>
				</table>
				<div class="member_info_modal modal_common">
					<div class="member_info_modal_body modal_body_common">
						<h2 class="member_modal_title">회원상세보기</h2>
						<form action="">
							<div class="list_sort">
								<div class="list_name">회원 상태</div>
								<input type="text" id="mem_st" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">가입 날짜</div>
								<input type="text" id="mem_jd" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">아이디</div>
								<input type="text" id="mem_id" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">이름</div>
								<input type="text" id="mem_nm" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">생년월일</div>
								<input type="text" id="mem_bir" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">성별</div>
								<input type="text" id="mem_gen" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">휴대폰번호</div>
								<input type="text" id="mem_tel" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">이메일</div>
								<input type="text" id="mem_em" readonly>
							</div>
							<div class="list_sort">
								<div class="list_name">보유포인트</div>
								<input type="text" id="mem_mp" readonly>
							</div>
						</form>
						<button type="button" class="confirm_btn close_member_modal">확인</button>
					</div>
				</div>
				<!-- 회원관리 끝 -->

				<!-- 영화 관리 시작 -->
				<div id="movie" class="tab-content">
					<div class="dash_movie_box">
						<div class="dash_movie_top">
							<h1 class="dash_movie_title">영화 정보 관리</h1>
							<form action="" method="post">
								<select id="searchCondition" name="searchCondition">
									<option value="mov_Nm">영화제목</option>
									<option value="mov_Con1">장르</option>
									<option value="mov_Pd">감독</option>
									<option value="mov_Act">배우</option>
								</select> <input class="form-control mr-sm-2" type="text"
									id="searchKeyword" name="searchKeyword"
									placeholder="검색어를 입력하세요.">
								<button class="search_btn mov_search_btn" type="button">검색</button>
							</form>
						</div>
						<div class="movie_add_btn_box">
							<button class="movie_add_btn" type="button">+ 신규 영화 등록</button>
						</div>
						<div class="dash_movie_list">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>영화제목</th>
										<th>장르</th>
										<th>감독</th>
										<th>배우</th>
										<th>영화관리</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
						<div class="dash_movie_paging paging_box"></div>
					</div>
					<script>
               $(document).ready(function() {
                   $('#movie_tab').click(function() {
                       loadMovList('getMovList.do');
                   });

                   $('.dash_movie_top').on('click', '.mov_search_btn', function() {
                       var searchCondition = $('#searchCondition').val();
                       var searchKeyword = $('#searchKeyword').val();
                       loadMovList('searchMov.do', { searchCondition: searchCondition, searchKeyword: searchKeyword });
                   });

                   function loadMovList(url, data = {}) {
                       $.ajax({
                           type: 'POST',
                           url: url,
                           data: data,
                           cache: false,
                           success: function(movList) {
                               var tableBody = $('#movie tbody');
                               var pageSize = 7;
                               var currentPage = 1;
                               var pagination = $('.dash_movie_paging');
                               var maxPagesToShow = 3;

                               function displayMovies() {
                                   var start = (currentPage - 1) * pageSize;
                                   var end = start + pageSize;
                                   var displayedMovies = movList.slice(start, end);
                                   tableBody.empty();
                                   displayedMovies.forEach(movie => {
                                       var row = $('<tr>');
                                       let actorStr; // 영화배우 이름
                                       if(movie.mov_Act.split(",").length > 0) { // 영화배우 텍스트중 "," 을 발견했을 때
                                        	if(movie.mov_Act.split(",").length-1 > 0)  actorStr =  movie.mov_Act.split(",")[0]+ ' 외 '+(movie.mov_Act.split(",").length-1)+'명'; //첫번째 "," 기준으로 배우 명수를 센다.
                                        	else actorStr =  movie.mov_Act.split(",")[0]; // 배우이름이 1개만 존재할 경우
                                       } else {
                                          actorStr = ''; // 배우이름이 없을 경우 빈문자열로 반환
                                       }
                                       row.append('<td>'+ movie.mov_Num+ '</td>');
                                       row.append('<td>'+ movie.mov_Nm+ '</td>');
                                       row.append('<td>'+ movie.mov_Con1+ '</td>');
                                       row.append('<td>'+ movie.mov_Pd+ '</td>');
                                       row.append('<td>'+ actorStr+ '</td>');
                                       row.append('<td><button class="movie_detail dash_btn_1">상세보기</button><button class="movie_modify dash_btn_1">수정</button></td>');
                                       tableBody.append(row);
                                   });
                                   generatePagination();
                               }

                               function generatePagination() {
                                   pagination.empty();
                                   var pageCount = Math.ceil(movList.length / pageSize);
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
                                       displayMovies();
                                   }
                               });

                               pagination.on('click', '.next_group', function(event) {
                                   event.preventDefault();
                                   if (currentPage <= movList.length - maxPagesToShow) {
                                       currentPage += maxPagesToShow;
                                       displayMovies();
                                   }
                               });

                               pagination.on('click', '.page_link', function(event) {
                                   event.preventDefault();
                                   currentPage = parseInt($(this).text());
                                   displayMovies();
                               });

                               displayMovies();
                           },
                           error: function(error) {
                               console.log(error);
                           }
                       });
                   }

                   // 이벤트 위임을 사용하여 동적으로 추가된 버튼에 핸들러 연결
                   $('#movie tbody').on('click', '.movie_detail', function() {
                       var mov_Num = $(this).closest('tr').find('td:first').text();

                       $.ajax({
                           type: 'POST',
                           url: 'getMovDetail.do',
                           data: { mov_Num: mov_Num },
                           cache: false,
                           async: false,
                           success: function(movieInfo) {
                               $('#mov_Post_detail').attr('src', 'resources/img/' + movieInfo[0].mov_Post); // 이미지 URL 설정
                               $('#mov_Num_detail').val(movieInfo[0].mov_Num);
                               $('#mov_Nm_detail').val(movieInfo[0].mov_Nm);
                               $('#mov_Con1_detail').val(movieInfo[0].mov_Con1);
                               $('#mov_Date_detail').val(movieInfo[0].mov_Date);
                               $('#mov_Pd_detail').val(movieInfo[0].mov_Pd);
                               $('#mov_Act_detail').val(movieInfo[0].mov_Act);
                               $('#mov_Rt_detail').val(movieInfo[0].mov_Rt);
                               $('#mov_Lang_detail').val(movieInfo[0].mov_Lang);
                               $('#mov_Sub_detail').val(movieInfo[0].mov_Sub);
                               $('#mov_Nation_detail').val(movieInfo[0].mov_Nation);
                               $('#mov_Detail_detail').val(movieInfo[0].mov_Detail);
                               $('#mov_EndDate_detail').val(movieInfo[0].mov_EndDate);

                               $('.movie_info_modal').show();
                           },
                           error: function(error) {
                               console.log(error);
                           }
                       });
                   });
                   
                   
                   $('#movie tbody').on('click', '.movie_modify', function() {
                          var mov_Num = $(this).closest('tr').find('td:first').text();
                          
                          $.ajax({
                           type: 'POST',
                           url: 'getMovModify.do',
                           data: { mov_Num: mov_Num },
                           cache: false,
                           async: false,
                           success: function(movieInfo) {
                              $('#image_modify_preview').attr('src', 'resources/img/' + movieInfo[0].mov_Post); // 이미지 URL 설정
                                  $('#mov_Num_modify').val(movieInfo[0].mov_Num);
                                  $('#mov_Nm_modify').val(movieInfo[0].mov_Nm);
                                  $('#mov_Con1_modify').val(movieInfo[0].mov_Con1);
                                  $('#mov_Con2_modify').val(movieInfo[0].mov_Con2);
                                  $('#mov_Con3_modify').val(movieInfo[0].mov_Con3);
                                  $('#mov_Date_modify').val(movieInfo[0].mov_Date);
                                  $('#mov_Pd_modify').val(movieInfo[0].mov_Pd);
                                  $('#mov_Act_modify').val(movieInfo[0].mov_Act);
                                  $('#mov_Rt_modify').val(movieInfo[0].mov_Rt);
                                  $('#mov_Lang_modify').val(movieInfo[0].mov_Lang);
                                  $('#mov_Sub_modify').val(movieInfo[0].mov_Sub);
                                  $('#mov_Nation_modify').val(movieInfo[0].mov_Nation);
                                  $('#mov_Detail_modify').val(movieInfo[0].mov_Detail);
                                  $('#mov_EndDate_modify').val(movieInfo[0].mov_EndDate);

                                  $('.movie_modify_modal').show();
                              },
                              error: function(error) {
                                  console.log(error);
                              }
                          });
                      });

                   $('.movie_add_btn').click(function() {
                       $('.movie_add_modal').show();
                   });
               });
</script>

					<div class="movie_info_modal modal_common">
						<div class="movie_info_modal_body modal_body_common">
							<h2 class="movie_modal_title">영화상세보기</h2>
							<form action="">
								<div class="form_sort_box">
									<div class="movie_lt_info">
										<div>
											<img src="${pageContext.request.contextPath}/" alt=""
												id="mov_Post_detail" name="uploadFile">
											<!--                                     <input type="file" id="mov_Post_detail" name="uploadFile" readonly> -->
										</div>
									</div>
									<div class="movie_rt_info">
										<div class="list_sort">
											<div class="list_name">번호</div>
											<input type="text" id="mov_Num_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">제목</div>
											<input type="text" id="mov_Nm_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">장르</div>
											<input type="text" id="mov_Con1_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">개봉일</div>
											<input type="text" id="mov_Date_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">마감일</div>
											<input type="text" id="mov_EndDate_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">감독</div>
											<input type="text" id="mov_Pd_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">배우</div>
											<input type="text" id="mov_Act_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">상영시간</div>
											<input type="text" id="mov_Rt_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">주요언어</div>
											<input type="text" id="mov_Lang_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">더빙/자막</div>
											<input type="text" id="mov_Sub_detail" readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">국가</div>
											<input type="text" id="mov_Nation_detail" readonly>
										</div>
									</div>
								</div>

								<div class="movie_bt_info">
									<div class="movie_story">줄거리</div>
									<textarea style="resize: none;" name="mov_Detail_detail"
										id="mov_Detail_detail" cols="100" rows="6" readonly> </textarea>
								</div>
								<button type="button" class="confirm_btn">확인</button>

							</form>

						</div>
					</div>
					<script>
                  $(document).ready(function() {
//                       $('.movie_detail').click(function() {
//                           var mov_Num = $(this).closest('tr').find('td:first').text();
// //                           var mov_Num = $('#mov_Num_detail').val();
//                           $.ajax({
//                               type: 'POST',
//                               url: 'getMovDetail.do',
//                               data: { mov_Num: mov_Num },
//                               cache : false,
//                               async : false,
//                               success: function(movieInfo) {
//                                  $('#mov_Post').attr('src', 'resources/img/' + movieInfo[0].mov_Post); // 이미지 URL 설정//                                
//                                  $('#mov_Num_detail').val(movieInfo[0].mov_Num);
//                                   $('#mov_Nm_detail').val(movieInfo[0].mov_Nm);
//                                   $('#mov_Con1_detail').val(movieInfo[0].mov_Con1);
//                                   $('#mov_Date_detail').val(movieInfo[0].mov_Date);
//                                   $('#mov_EndDate_detail').val(movieInfo[0].mov_EndDate);
//                                   $('#mov_Pd_detail').val(movieInfo[0].mov_Pd);
//                                   $('#mov_Act_detail').val(movieInfo[0].mov_Act);
//                                   $('#mov_Rt_detail').val(movieInfo[0].mov_Rt);
//                                   $('#mov_Lang_detail').val(movieInfo[0].mov_Lang);
//                                   $('#mov_Sub_detail').val(movieInfo[0].mov_Sub);
//                                   $('#mov_Nation_detail').val(movieInfo[0].mov_Nation);
//                                  $('#mov_Detail_detail').val(movieInfo[0].mov_Detail);
                                  
//                                   $('.movie_info_modal').show();
//                               },
//                               error: function(error) {
//                                   console.log(error);
//                               }
//                           });
//                       });
               
                      $('.confirm_btn').click(function() {
                          $('.movie_info_modal').hide();
                      });
                  });
               </script>
					<div class="movie_modify_modal modal_common">
						<div class="movie_modify_modal_body modal_body_common">
							<h2 class="movie_modify_modal_title">영화 수정</h2>
							<form action="updateMovie.do" method="post" id="movModify"
								enctype="multipart/form-data">
								<div class="form_sort_box">
									<div class="movie_lt_modify">
										<div>
											<img id="image_modify_preview"
												src="${pageContext.request.contextPath}/" alt=""> <label
												class="add_thumnail_btn" for="movie_thumnail">포스터 선택</label>
											<input type="file" id="movie_thumnail" name="uploadFile">
										</div>
									</div>
									<div class="movie_rt_modify">
										<div class="list_sort">
											<div class="list_name">번호</div>
											<input type="text" id="mov_Num_modify" name="mov_Num"
												readonly>
										</div>
										<div class="list_sort">
											<div class="list_name">제목</div>
											<input type="text" id="mov_Nm_modify" name="mov_Nm" required>
										</div>
										<div class="list_sort">
											<div class="list_name">장르1</div>
											<input type="text" id="mov_Con1_modify" name="mov_Con1"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">장르2</div>
											<input type="text" id="mov_Con2_modify" name="mov_Con2">
										</div>
										<div class="list_sort">
											<div class="list_name">장르3</div>
											<input type="text" id="mov_Con3_modify" name="mov_Con3">
										</div>
										<div class="list_sort">
											<div class="list_name">개봉일</div>
											<input type="date" id="mov_Date_modify" name="mov_Date"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">마감일</div>
											<input type="date" id="mov_EndDate_modify" name="mov_EndDate"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">감독</div>
											<input type="text" id="mov_Pd_modify" name="mov_Pd" required>
										</div>
										<div class="list_sort">
											<div class="list_name">배우</div>
											<input type="text" id="mov_Act_modify" name="mov_Act">
										</div>
										<div class="list_sort">
											<div class="list_name">상영시간</div>
											<input type="text" id="mov_Rt_modify" name="mov_Rt" required>
										</div>
										<div class="list_sort">
											<div class="list_name">주요언어</div>
											<input type="text" id="mov_Lang_modify" name="mov_Lang"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">더빙/자막</div>
											<select name="mov_Sub" id="mov_Sub_modify" required>
												<option value="없음">자막없음</option>
												<option value="더빙">더빙</option>
												<option value="자막">자막</option>
											</select>
										</div>
										<div class="list_sort">
											<div class="list_name">상영등급</div>
											<select name="mov_Rate" id="mov_Rate_modify" required>
												<option value="0">전체 관람가</option>
												<option value="12">12세 이상 관람가</option>
												<option value="15">15세 이상 관람가</option>
												<option value="17">17세 이상 관람가</option>
												<option value="19">청소년 관람불가</option>
											</select>
										</div>
										<div class="list_sort">
											<div class="list_name">국가</div>
											<input type="text" id="mov_Nation_modify" name="mov_Nation"
												required>
										</div>
									</div>
								</div>

								<div class="movie_bt_modify">
									<div class="movie_story">줄거리</div>
									<textarea style="resize: none;" name="mov_Detail"
										id="mov_Detail_modify" cols="100" rows="6" required></textarea>
								</div>
								<button type="button" class="modify_btn mov_modify_btn">수정</button>
								<button type="button" class="delete_btn mov_delete_btn">삭제</button>
								<button type="button" class="confirm_btn">닫기</button>
							</form>
						</div>
					</div>

					<script>
$(document).ready(function() {
    $('.movie_modify').click(function() {
        var mov_Num = $(this).closest('tr').find('td:first').text();
        var form = $('#movModify')[0]
        var formData = new FormData(form);
        console.log("mov_Num: ", mov_Num);
        $.ajax({
            type: 'POST',
            url: 'getMovDetail.do',
            data: { mov_Num: mov_Num, formData },
            cache: false,
            async: false,
            success: function(movieInfo) {
                console.log(movieInfo);
                $('#image_modify_preview').attr('src', 'resources/img/' + movieInfo[0].mov_Post); // 이미지 URL 설정
                $('#mov_Num_modify').val(movieInfo[0].mov_Num);
                $('#mov_Nm_modify').val(movieInfo[0].mov_Nm);
                $('#mov_Con1_modify').val(movieInfo[0].mov_Con1);
                $('#mov_Con2_modify').val(movieInfo[0].mov_Con2);
                $('#mov_Con3_modify').val(movieInfo[0].mov_Con3);
                $('#mov_Date_modify').val(movieInfo[0].mov_Date);
                $('#mov_Pd_modify').val(movieInfo[0].mov_Pd);
                $('#mov_Act_modify').val(movieInfo[0].mov_Act);
                $('#mov_Rt_modify').val(movieInfo[0].mov_Rt);
                $('#mov_Lang_modify').val(movieInfo[0].mov_Lang);
                $('#mov_Sub_modify').val(movieInfo[0].mov_Sub);
                $('#mov_Nation_modify').val(movieInfo[0].mov_Nation);
                $('#mov_Detail_modify').val(movieInfo[0].mov_Detail);
                $('#mov_EndDate_modify').val(movieInfo[0].mov_EndDate);

                $('.movie_modify_modal').show();
            },
            error: function(error) {
                console.log(error);
            }
        });
    });

    $('.mov_modify_btn').click(function(event) {
        event.preventDefault(); // Prevent default form submission
        
        var form = $('#movModify')[0]; // Get the DOM element from the jQuery object
        var formData = new FormData(form);

        // No need to append these fields manually if they're already in the form
        // Ensure mov_Post is correctly assigned if necessary
        // formData.append('mov_Post', $('#movie_thumnail')[0].files[0]); // Example if manual append needed

        $.ajax({
            type: 'POST',
            url: 'updateMovie.do',
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            async: false,
            success: function(data) {
                alert("영화가 성공적으로 수정되었습니다.");
                $('.movie_modify_modal').hide();
            },
            error: function(error) {
                alert("영화 수정에 실패했습니다.");
                $('.movie_modify_modal').hide();
            }
        });
    });

    $('.mov_delete_btn').click(function() {
        var confirmDelete = confirm("정말 삭제하시겠습니까?");
        var mov_Num = $('#mov_Num_modify').val();
        
        if(confirmDelete) {
            $.ajax({
                type: 'POST', // Or 'DELETE' if server supports it
                url: 'deleteMovie.do',
                data: { mov_Num: mov_Num },
                cache: false,
                async: false,
                success: function() {
                    alert("영화가 삭제되었습니다.");
                    $('.movie_modify_modal').hide();
                    location.reload(); // Reload the page to reflect changes
                },
                error: function(error) {
                    alert("영화 삭제 중 오류가 발생했습니다.");
                    $('.movie_modify_modal').hide();
                }
            });
        }
    });

    $('.confirm_btn').click(function() {
        $('.movie_modify_modal').hide();
    });
});
</script>
					<div class="movie_add_modal modal_common">
						<div class="movie_add_modal_body modal_body_common">
							<h2 class="movie_add_modal_title">신규 영화 등록</h2>
							<form action="insertMovie.do" method="post"
								enctype="multipart/form-data" id="movIns">
								<div class="form_sort_box">
									<div class="movie_lt_add">
										<div>
											<img id="image_add_preview"> <label
												class="add_thumnail_btn" for="add_movie_thumnail">포스터
												선택</label> <input type="file" id="add_movie_thumnail"
												name="uploadFile">
										</div>
									</div>
									<div class="movie_rt_add">
										<div class="list_sort">
											<div class="list_name">제목</div>
											<input type="text" id="mov_Nm_insert" name="mov_Nm" required>
										</div>
										<div class="list_sort">
											<div class="list_name">장르 1</div>
											<input type="text" id="mov_Con1_insert" name="mov_Con1"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">장르 2</div>
											<input type="text" id="mov_Con2_insert" name="mov_Con2">
										</div>
										<div class="list_sort">
											<div class="list_name">장르 3</div>
											<input type="text" id="mov_Con3_insert" name="mov_Con3">
										</div>
										<div class="list_sort">
											<div class="list_name">개봉일</div>
											<input type="date" id="mov_Date_insert" name="mov_Date"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">마감일</div>
											<input type="date" id="mov_EndDate_insert" name="mov_EndDate"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">감독</div>
											<input type="text" id="mov_Pd_insert" name="mov_Pd" required>
										</div>
										<div class="list_sort">
											<div class="list_name">배우</div>
											<input type="text" id="mov_Act_insert" name="mov_Act">
										</div>
										<div class="list_sort">
											<div class="list_name">상영시간</div>
											<input type="text" id="mov_Rt_insert" name="mov_Rt" required>
										</div>
										<div class="list_sort">
											<div class="list_name">주요언어</div>
											<input type="text" id="mov_Lang_insert" name="mov_Lang"
												required>
										</div>
										<div class="list_sort">
											<div class="list_name">더빙/자막</div>
											<select name="mov_Sub" id="mov_Sub_insert" required>
												<option value="없음">없음</option>
												<option value="더빙">더빙</option>
												<option value="자막">자막</option>
											</select>
										</div>
										<div class="list_sort">
											<div class="list_name">상영등급</div>
											<select name="mov_Rate" id="mov_Rate_insert" required>
												<option value="0">전체 관람가</option>
												<option value="12">12세 이상 관람가</option>
												<option value="15">15세 이상 관람가</option>
												<option value="17">17세 이상 관람가</option>
												<option value="19">청소년 관람불가</option>
											</select>
										</div>
										<div class="list_sort">
											<div class="list_name">국가</div>
											<input type="text" id="mov_Nation_insert" name="mov_Nation"
												required>
										</div>
									</div>
								</div>

								<div class="movie_bt_add">
									<div class="movie_story">줄거리</div>
									<textarea style="resize: none;" name="mov_Detail"
										id="mov_Detail_modify" cols="100" rows="6" required></textarea>
								</div>
								<button type="submit" class="add_btn">등록</button>
								<button type="button" class="confirm_btn"
									onclick="closeMovieAdd()">닫기</button>
							</form>
						</div>
					</div>
					<script>
               $(document).ready(function() {
                   $('.movie_add_btn').click(function() {
                          var form=$('#movIns');
                        var formData = new FormData(form);
                          formData.append('uploadFile',uploadFile); 
                          formData.append('mov_Nm',mov_Nm);
                          formData.append('mov_Con1',mov_Con1);
                          formData.append('mov_Con2',mov_Con2);
                          formData.append('mov_Con3',mov_Con3);
                          formData.append('mov_Date',mov_Date);
                          formData.append('mov_EndDate',mov_EndDate);
                          formData.append('mov_Pd',mov_Pd);
                          formData.append('mov_Act',mov_Act);
                          formData.append('mov_Rt',mov_Rt);
                          formData.append('mov_Lang',mov_Lang);
                          formData.append('mov_Sub',mov_Sub);
                          formData.append('mov_Nation',mov_Nation);
                          formData.append('mov_Detail',mov_Detail);
                          
                        var formData = new FormData(form);
                          $.ajax({
                                 type: 'POST',
                                 url: 'insertMovie.do',
                                 data: formData,
                                 processData: false,
                                 contentType: false,
                                 cache: false,
                                  async: false,
                                 success: function(data) {
                                    alert("영화가 성공적으로 수정되었습니다.");
                                 $('.movie_modify_modal').hide();
                              },
                              error: function(error) {
                                 alert("영화가 실패되었습니다.");
                                 $('.movie_modify_modal').hide();
                              }
                          });
                    });

                   $('.movieAdd_btn').click(function() {
                       $('.movie_add_modal').hide();
                   });
                   $('.confirm_btn').click(function() {
                       $('.movie_add_modal').hide();
                   });
               });
             </script>
				</div>
				<!-- 영화 관리 끝 -->


				<!-- 상영 관리 시작 -->
				<div id="screening" class="tab-content">
					<div class="dash_screen_box">
						<div class="dash_screen_top">
							<h1 class="dash_screen_title">상영 정보 관리</h1>
							<form action="">
								<select name="movScreenSearchCondition"
									id="movScreenSearchCondition">
									<option value="mov_sMovieName">영화제목</option>
									<option value="mov_sName">상영관</option>
									<option value="mov_sDate">상영날짜</option>
								</select> <input type="text" id="movScreenSearchValue">
								<button type="button" class="search_btn" id="screen_search_btn">검색</button>
							</form>
						</div>
						<div class="screen_add_btn_box">
							<button class="screen_add_btn" type="button"
								onclick="NewMovieScreenAdd()">+ 신규 상영 등록</button>
						</div>

						<div class="dash_screen_list">
							<table>
								<thead>
									<tr>
										<th>상영번호</th>
										<th>상영관명</th>
										<th>상영영화제목</th>
										<th>상영날짜</th>
										<th>상영시작시간</th>
										<th>등록일</th>
										<th>상영관리</th>
									</tr>
								</thead>
								<tbody>
									<!-- 상영정보가 들어가는 곳 -->
								</tbody>
							</table>
						</div>
						<div class="dash_screen_paging"></div>
					</div>
					<script>
             $(document).ready(function() {
                 $('#screen-tab').click(MovScreenList()); // 스크린 탭 클릭
                 
                 function MovScreenList() {
                     $.ajax({
                         type: 'POST', // POST 방식으로 서버에 요청을 보냄
                         url: 'selectMovScreenList.do', // 멤버 목록을 가져올 서버의 URL
                         cache: false, // 브라우저 캐시 사용 안 함
                         async: false, // 비동기적으로 요청을 보내지 않음 (비권장)
                         success: function(MovScreenList) { // 요청이 성공했을 때 실행되는 콜백 함수 --
                             var tableBody = $('#screening tbody'); // 멤버 목록을 표시할 테이블의 tbody 요소
                             var pageSize = 7; // 페이지당 표시할 멤버 수
                             var pageCount = Math.ceil(MovScreenList.length / pageSize); // 전체 페이지 수
                             var currentPage = 1; // 현재 페이지 번호
                             var pagination = $('.dash_screen_paging'); // 페이징을 표시할 요소
                             var maxPagesToShow = 3; // 표시할 최대 페이지 수

                             function displayScreen() { // 멤버 목록을 표시하는 함수
                                 var start = (currentPage - 1) * pageSize; // 표시할 멤버의 시작 인덱스
                                 var end = start + pageSize; // 표시할 멤버의 끝 인덱스
                                 var displayedScreen = MovScreenList.slice(start, end); // 현재 페이지에 표시할 멤버 목록

                                 tableBody.empty(); // 테이블 목록을 비움

                                 for (var i = 0; i < displayedScreen.length; i++) { // 표시할 멤버 수만큼 반복
                                     var MovScreen = displayedScreen[i]; // 현재 멤버
                                     var row = $('<tr>'); // 행 생성
                                       row.append('<td>'+ MovScreen.mov_sNum+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sName+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sMovieName+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sDate+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sTime+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sRegistDate+ '</td>');
                                       row.append('<td><button class="screen_modify dash_btn_1">수정</button></td>');

                                       tableBody.append(row);
                                 }

                                 generatePagination(); // 페이징 생성
                                 bindScreenDetailClickEvent(); // 멤버 상세 정보 버튼에 클릭 이벤트 바인딩
                             }

                             function generatePagination() {
                                 pagination.empty(); // 페이징 요소 비움

                                 if (pageCount > 0) { // 페이지가 존재하는 경우
                                     var startPage, endPage; // 시작 페이지와 끝 페이지

                                     // 현재 그룹의 시작 페이지와 끝 페이지 계산
                                     var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                     startPage = groupIndex * maxPagesToShow + 1;
                                     endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                     // "이전" 버튼 추가
                                     if (startPage > 1) {
                                         pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                     }

                                     // 페이지 번호 추가
                                     for (var i = startPage; i <= endPage; i++) {
                                         var pageLink = $('<a>', {
                                             href: '#',
                                             text: i,
                                             class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                         });
                                         pagination.append(pageLink);
                                     }

                                     // "다음" 버튼 추가
                                     if (endPage < pageCount) {
                                         pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                     }
                                 }
                             }

                             pagination.on('click', '.prev_group', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                 if (groupIndex > 0) { // 현재 그룹이 첫 그룹이 아닌 경우
                                    currentPage = (groupIndex - 1) * maxPagesToShow + 1; // 이전 그룹의 마지막 페이지로 이동
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             pagination.on('click', '.next_group', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                 var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                                 if (groupIndex < totalGroups - 1) { // 현재 그룹이 마지막 그룹이 아닌 경우
                                     currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1; // 다음 그룹의 첫 페이지로 이동
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             pagination.on('click', '.page_link', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var newPage = parseInt($(this).text()); // 클릭한 페이지 번호 가져오기
                                 if (newPage !== currentPage) { // 현재 페이지와 클릭한 페이지가 다른 경우에만 처리
                                     currentPage = newPage; // 현재 페이지 변경
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             generatePagination(); // 페이지 생성
                             displayScreen(); // 멤버 목록 표시
                         },
                         error: function(error) { // 요청 실패 시 실행되는 콜백 함수
                             console.log(error); // 에러 메시지를 콘솔에 출력
                         }
                     });// 아작스 끝 버튼

               };


 $('#screen_search_btn').click(function() {
        let data={
                        "condition": document.getElementById("movScreenSearchCondition").value,
                        "value" : document.getElementById("movScreenSearchValue").value
                  }

        $.ajax({
            type: 'POST',
            url: 'findMovScreenList.do',
            data: data,
            success: function(MovScreenList) {
                 var tableBody = $('#screening tbody'); // 멤버 목록을 표시할 테이블의 tbody 요소
                 var pageSize = 7; // 페이지당 표시할 멤버 수
                 var pageCount = Math.ceil(MovScreenList.length / pageSize); // 전체 페이지 수
                 var currentPage = 1; // 현재 페이지 번호
                 var pagination = $('.dash_screen_paging'); // 페이징을 표시할 요소
                 var maxPagesToShow = 3; // 표시할 최대 페이지 수

               function displayScreen() { // 멤버 목록을 표시하는 함수
                                 var start = (currentPage - 1) * pageSize; // 표시할 멤버의 시작 인덱스
                                 var end = start + pageSize; // 표시할 멤버의 끝 인덱스
                                 var displayedScreen = MovScreenList.slice(start, end); // 현재 페이지에 표시할 멤버 목록

                                 tableBody.empty(); // 테이블 목록을 비움

                                 for (var i = 0; i < displayedScreen.length; i++) { // 표시할 멤버 수만큼 반복
                                     var MovScreen = displayedScreen[i]; // 현재 멤버
                                     var row = $('<tr>'); // 행 생성
                                       row.append('<td>'+ MovScreen.mov_sNum+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sName+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sMovieName+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sDate+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sTime+ '</td>');
                                       row.append('<td>'+ MovScreen.mov_sRegistDate+ '</td>');
                                       row.append('<td><button class="screen_modify dash_btn_1">수정</button></td>');

                                       tableBody.append(row);
                                 }

                                 generatePagination(); // 페이징 생성
                                 bindScreenDetailClickEvent(); // 멤버 상세 정보 버튼에 클릭 이벤트 바인딩
                             }

                             function generatePagination() {
                                 pagination.empty(); // 페이징 요소 비움

                                 if (pageCount > 0) { // 페이지가 존재하는 경우
                                     var startPage, endPage; // 시작 페이지와 끝 페이지

                                     // 현재 그룹의 시작 페이지와 끝 페이지 계산
                                     var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                     startPage = groupIndex * maxPagesToShow + 1;
                                     endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                     // "이전" 버튼 추가
                                     if (startPage > 1) {
                                         pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                     }

                                     // 페이지 번호 추가
                                     for (var i = startPage; i <= endPage; i++) {
                                         var pageLink = $('<a>', {
                                             href: '#',
                                             text: i,
                                             class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                         });
                                         pagination.append(pageLink);
                                     }

                                     // "다음" 버튼 추가
                                     if (endPage < pageCount) {
                                         pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                     }
                                 }
                             }

                             pagination.on('click', '.prev_group', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                 if (groupIndex > 0) { // 현재 그룹이 첫 그룹이 아닌 경우
                                    currentPage = (groupIndex - 1) * maxPagesToShow + 1; // 이전 그룹의 마지막 페이지로 이동
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             pagination.on('click', '.next_group', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                 var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                                 if (groupIndex < totalGroups - 1) { // 현재 그룹이 마지막 그룹이 아닌 경우
                                     currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1; // 다음 그룹의 첫 페이지로 이동
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             pagination.on('click', '.page_link', function(event) {
                                 event.preventDefault(); // 기본 동작 방지
                                 var newPage = parseInt($(this).text()); // 클릭한 페이지 번호 가져오기
                                 if (newPage !== currentPage) { // 현재 페이지와 클릭한 페이지가 다른 경우에만 처리
                                     currentPage = newPage; // 현재 페이지 변경
                                     displayScreen(); // 멤버 목록 다시 표시
                                 }
                             });

                             generatePagination(); // 페이지 생성
                             displayScreen(); // 멤버 목록 표시
                         },
                         error: function(error) { // 요청 실패 시 실행되는 콜백 함수
                             console.log(error); // 에러 메시지를 콘솔에 출력
                         }
                     });// 아작스 끝 버튼
    }); // 스크린탭 끝
    
  function bindScreenDetailClickEvent(){  
    $('.screen_modify').click(function() {   
       console.log("대시보드 페이지에서 데이터 반환");
       $.ajax({
            type: 'POST',
            url: 'getMovNameList.do',
            cache: false,
            success: function(movNameList) {
                console.log("영화 이름 데이터 반환 완료");
                console.log(movNameList);
                // select 태그에 옵션 추가
               var select = document.getElementById("mov_sMovieName"); // select 태그의 id를 가져옵니다.
         select.innerHTML = ""; // 기존 옵션들을 모두 삭제합니다.
         for (var i = 0; i < movNameList.length; i++) {
             var option = document.createElement("option"); // 새로운 option 엘리먼트를 생성합니다.
             option.text = movNameList[i].mov_Nm; // 옵션의 텍스트를 설정합니다.
             select.appendChild(option); // select 태그에 옵션을 추가합니다.
         }
          },
            error: function(error) {
                console.log(error);
            }
        });
       
    var mov_sNum = $(this).closest('tr').find('td:first').text();
    
    $.ajax({
        type: 'POST',
        url: 'selectMovScreen.do',
        data: { "mov_sNum" : mov_sNum },
        success: function(movScreen) {
            $('#mov_sNum').val(movScreen.mov_sNum);
            $('#mov_sName').val(movScreen.mov_sName);
            $('#mov_sMovieName').val(movScreen.mov_sMovieName);
            $('#mov_sDate').val(movScreen.mov_sDate);
            $('#mov_sTime').val(movScreen.mov_sTime);
            $('#mov_sRegistDate').val(movScreen.mov_sRegistDate);
            
            $('.screen_modify_modal').show();
        },
        error: function(error) {
            console.log(error);
        }
    });
});
    }
    
$('.confirm_btn').click(function() {
 $('.screen_modify_modal').hide();
});
    
})// 전체 로드시 실행 함수        
                       
               
                   </script>


					<!-- 상영 정보 수정 모달 시작 -->
					<div class="screen_modify_modal modal_common">
						<div class="screen_modify_modal_body modal_body_common">
							<h2 class="screen_modify_modal_title">상영 수정</h2>
							<form action="">
								<div class="list_sort">
									<div class="list_name">상영 번호</div>
									<input id="mov_sNum" type="text" readonly>
								</div>

								<div class="list_sort">
									<div class="list_name">상영관 명</div>
									<select id="mov_sName">
										<option value="1관(2D)" default>1관(2D)</option>
										<option value="2관(3D)">2관(3D)</option>
										<option value="3관(4D)">3관(4D)</option>
										<option value="4관(iMax)">4관(iMax)</option>
										<option value="5관(리클라이너)">5관(리클라이너)</option>
									</select>
								</div>

								<div class="list_sort">
									<div class="list_name">상영 영화 제목</div>
									<select id="mov_sMovieName">
									</select>
								</div>

								<div class="list_sort">
									<div class="list_name">상영 날짜</div>
									<input id="mov_sDate" type="date">
								</div>

								<div class="list_sort">
									<div class="list_name">상영 시작 시간</div>
									<input id="mov_sTime" type="time">
								</div>

								<div class="list_sort">
									<div class="list_name">등록일</div>
									<input id="mov_sRegistDate" type="text">
								</div>

								<div class="modal_btn_box">
									<button type="button" class="modify_btn"
										onclick="updateMovScreen()">수정</button>
									<button type="button" class="delete_btn"
										onclick="deleteMovSereen()">삭제</button>
									<button type="button" class="confirm_btn close_screen_modify"
										onclick="closeScreenModify()">닫기</button>
								</div>

							</form>

						</div>
					</div>
					<script>
                  $(document).ready(function() {
                      $('.screen_modify').click(function() {
                          $.ajax({
                              type: 'POST',
                              url: 'getMovNameList.do',
                              cache: false,
                              success: function(movNameList) {
                                  console.log("영화 이름 데이터 반환 완료");
                                  console.log(movNameList);
                                  // select 태그에 옵션 추가
                                 var select = document.getElementById("mov_sMovieName"); // select 태그의 id를 가져옵니다.
                           select.innerHTML = ""; // 기존 옵션들을 모두 삭제합니다.
                           for (var i = 0; i < movNameList.length; i++) {
                               var option = document.createElement("option"); // 새로운 option 엘리먼트를 생성합니다.
                               option.text = movNameList[i].mov_Nm; // 옵션의 텍스트를 설정합니다.
                               select.appendChild(option); // select 태그에 옵션을 추가합니다.
                           }
                            },
                              error: function(error) {
                                  console.log(error);
                              }
                          });
                          
                          var mov_sNum = $(this).closest('tr').find('td:first').text();
                          
                          $.ajax({
                              type: 'POST',
                              url: 'selectMovScreen.do',
                              data: { "mov_sNum" : mov_sNum },
                              success: function(movScreen) {
                                  $('#mov_sNum').val(movScreen.mov_sNum);
                                  $('#mov_sName').val(movScreen.mov_sName);
                                  $('#mov_sMovieName').val(movScreen.mov_sMovieName);
                                  $('#mov_sDate').val(movScreen.mov_sDate);
                                  $('#mov_sTime').val(movScreen.mov_sTime);
                                  $('#mov_sRegistDate').val(movScreen.mov_sRegistDate);
                                  
                                  $('.screen_modify_modal').show();
                              },
                              error: function(error) {
                                  console.log(error);
                              }
                          });
                      });
               
                      $('.confirm_btn').click(function() {
                          $('.screen_modify_modal').hide();
                      });
                  });
                  
                  function resetModifyModal() {
                        // Clear input fields
                        $('.screen_modify_modal input').val('');
                        // Uncheck checkboxes
                       $('.screen_modify_modal select').empty();
                        // Reset other form elements as needed
                    }
                  
                  function updateMovScreen(){
                     $.ajax({
                           type: 'POST',
                           url: 'updateMovScreen.do',
                           data: { "mov_sNum" : document.getElementById("mov_sNum").value,
                           "mov_sName"   : document.getElementById("mov_sName").value,
                           "mov_sMovieName"   : document.getElementById("mov_sMovieName").value,
                           "mov_sDate"   : document.getElementById("mov_sDate").value,
                           "mov_sTime"   : document.getElementById("mov_sTime").value,
                           "mov_sRegistDate"   : document.getElementById("mov_sRegistDate").value
                           
                           },
                           success: function(movScreen) {
                              
                               $('.screen_modify_modal').hide();
                               resetModifyModal();
                               location.replace("dashboard.do?screen");
                               $('#screen-tab').click();
                           },
                           error: function(error) {
                               console.log(error);
                           }
                   });
                  }
//                   상영 정보 삭제
                  function deleteMovSereen(){
                     $.ajax({
                           type: 'POST',
                           url: 'deleteMovScreen.do',
                           data: { "mov_sNum" : document.getElementById("mov_sNum").value
                           
                           },
                           success: function(movScreen) {
                              
                               $('.screen_modify_modal').hide();
                               resetModifyModal();
                               location.replace("dashboard.do?screen");
//                                $('#screen-tab').click();
                           },
                           error: function(error) {
                               console.log(error);
                           }
                   });
}
               </script>
					<!-- 상영 정보 수정 모달 끝 -->

					<!-- 신규 상영 등록 모달 시작 -->
					<div class="screen_add_modal modal_common">
						<div class="screen_add_modal_body modal_body_common">
							<h2 class="screen_add_modal_title">신규 상영 등록</h2>
							<form action="">


								<div class="list_sort">
									<div class="list_name">상영관 명</div>
									<select name="mov_sName" id="add_mov_sName">
										<option value="1관(2D)" default>1관(2D)</option>
										<option value="2관(3D)">2관(3D)</option>
										<option value="3관(4D)">3관(4D)</option>
										<option value="4관(iMax)">4관(iMax)</option>
										<option value="5관(리클라이너)">5관(리클라이너)</option>
									</select>

								</div>

								<div class="list_sort">
									<div class="list_name">상영 영화 제목</div>
									<select name="" id="add_mov_sMovieName">
									</select>
								</div>

								<div class="list_sort">
									<div class="list_name" name="mov_sDate">상영 날짜</div>
									<input id="add_mov_sDate" type="date">
								</div>

								<div class="list_sort">
									<div class="list_name">상영 시작 시간</div>
									<input type="time" name="mov_sTime" id="add_mov_sTime">
								</div>


								<div class="modal_btn_box">
									<button type="button" class="modify_btn"
										onclick="insertMovScreen()">등록</button>
									<button type="button" class="confirm_btn close_screen_add"
										onclick="closeScreenAdd()">닫기</button>
								</div>

							</form>

						</div>
					</div>
					<script>
          const dateInput = document.getElementById('add_mov_sDate');
          const modifyDateInput = document.getElementById('mov_sDate');
          let offset = 1000 * 60 * 60 * 9 ;
          const today = new Date(Date.now()+offset).toISOString().split('T')[0];
          dateInput.setAttribute('min', today);
          modifyDateInput.setAttribute('min', today);
      
          //상영중인 영화 리스트 반환
              function NewMovieScreenAdd() {
             console.log("대시보드 페이지에서 데이터 반환");
                 $.ajax({
                     type: 'POST',
                     url: 'getMovNameList.do',
                     cache: false,
                     success: function(movNameList) {
                         console.log("데이터 반환 완료");
                         console.log(movNameList);
                         // select 태그에 옵션 추가
                        var select = document.getElementById("add_mov_sMovieName"); // select 태그의 id를 가져옵니다.
                  select.innerHTML = ""; // 기존 옵션들을 모두 삭제합니다.
                  for (var i = 0; i < movNameList.length; i++) {
                      var option = document.createElement("option"); // 새로운 option 엘리먼트를 생성합니다.
                      option.text = movNameList[i].mov_Nm; // 옵션의 텍스트를 설정합니다.
                      select.appendChild(option); // select 태그에 옵션을 추가합니다.
                  }
                   },
                     error: function(error) {
                         console.log(error);
                     }
                 });
          }

              function resetModal() {
                  // Clear input fields
                  $('.screen_add_modal input').val('');
                  // Uncheck checkboxes
                 $('.screen_add_modal select').empty();
                  // Reset other form elements as needed
              }

          function insertMovScreen(){
             let data = {
                   "mov_sName" :   document.getElementById("add_mov_sName").value,
                   "mov_sMovieName" : document.getElementById("add_mov_sMovieName").value ,
                   "mov_sDate" : document.getElementById("add_mov_sDate").value,    
                   "mov_sTime" :   document.getElementById("add_mov_sTime").value 
             };
             console.log("data : ", data);
             $.ajax({
                type:'POST',
                url : 'insertMovScreen.do',
                data : data,
                cache:false,
                success: function(){
                        alert("상영 정보가 입력되었습니다.");
                       $('.screen_add_modal').hide();
                     resetModal();
                     location.replace("dashboard.do?screen");
                   
                },
                error : function(error){
                   console.log(error);
                }
                
             });
          }
          </script>

					<!-- 신규 상영 등록 모달 끝 -->

				</div>

				<!-- 상영 관리 끝 -->


				<!-- 상품 관리 시작 -->

				<div id="prd" class="tab-content">
					<div class="dash_product_box">
						<div class="dash_product_top">
							<h1 class="dash_product_title">상품 정보 관리</h1>
							<form id="searchForm">
								<select name="searchOptionPrd" id="searchOptionPrd">
									<option value="prd_num">상품번호</option>
									<option value="prd_name">상품명</option>
								</select> <input type="text" id="searchValuePrd" name="searchValuePrd">
								<button type="button" class="search_btn" id="search_btnPrd">검색</button>
							</form>
						</div>
						<div class="product_add_btn_box">
							<button class="product_add_btn" type="button">+ 신규 상품 등록
							</button>
						</div>

						<div class="dash_product_list">
							<table>
								<thead>
									<tr>
										<th>상품 번호</th>
										<th>상품 이름</th>
										<th>상품 종류</th>
										<th>상품 가격</th>
										<th>상품 설명</th>
										<th>상품 관리</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>

						</div>
						<div class="dash_prd_paging paging_box"></div>
					</div>
					<script>
$(document).ready(function() {
    var maxPagesToShow = 3; // 한 번에 보여줄 페이지 수

    $('#prd_tab').click(function() {
        loadPrdList('dashboardgetPrdList.do');
    });

    $('#search_btnPrd').click(function() {
        var searchOptionPrd = $('#searchOptionPrd').val();
        var searchValuePrd = $('#searchValuePrd').val();
        loadPrdList('searchPrd.do', { option: searchOptionPrd, value: searchValuePrd });
    });

    function loadPrdList(url, data = {}) {
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            cache: false,
            success: function(prdList){
                var tableBody = $('#prd tbody');
                var pageSize = 7;
                var currentPage = 1;
                var pagination = $('.dash_prd_paging');

                function displayPrd() {
                    var start = (currentPage - 1) * pageSize;
                    var end = start + pageSize;
                    var displayedPrdList = prdList.slice(start, end);

                    tableBody.empty();
                    displayedPrdList.forEach(prd => {
                        var row = $('<tr>');
                        row.append('<td>' + prd.prd_num + '</td>');
                        row.append('<td>' + prd.prd_name + '</td>');
                        row.append('<td>'+ prd.prd_type+ '</td>');
                        row.append('<td>'+ prd.prd_price+ '</td>');
                        row.append('<td>'+ prd.prd_desc+ '</td>');
                        row.append('<td><button style="margin-right: 5px;" class="prd_detail dash_btn_1">상세보기</button><button class="prd_modify dash_btn_1">수정</button></td>');

                        tableBody.append(row);
                    });

                    generatePagination();
                }

                function generatePagination() {
                    pagination.empty();
                    var pageCount = Math.ceil(prdList.length / pageSize);
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
                        displayPrd();
                    }
                });

                pagination.on('click', '.next_group', function(event) {
                    event.preventDefault();
                    var pageCount = Math.ceil(prdList.length / pageSize);
                    var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                    var totalPages = Math.ceil(pageCount / maxPagesToShow);

                    if (groupIndex < totalPages - 1) {
                        currentPage = (groupIndex + 1) * maxPagesToShow + 1;
                        displayPrd();
                    }
                });

                pagination.on('click', '.page_link', function(event) {
                    event.preventDefault();
                    currentPage = parseInt($(this).text());
                    displayPrd();
                });

                displayPrd();
            },
            error: function(error) {
                console.log(error);
            }
        });
    }
});
    
    
    $(document).ready(function() {
        // 상세보기 버튼 클릭 이벤트 핸들러
        $(document).on('click', '.prd_detail', function() {
            var prd_num = $(this).closest('tr').find('td:first').text();
            // AJAX 요청을 사용하여 상세 정보 가져오기
            $.ajax({
                type: 'POST',
                url: 'dashboardgetPrd.do',
                cache: false,
                async: false,
                data: { prd_num: prd_num },
                success: function(prd) {
                    console.log(prd);
                    // 상세 정보를 모달 창에 표시
                    $('#prd_num').val(prd.prd_num);
                    $('#prd_name').val(prd.prd_name);
                    $('#prd_type').val(prd.prd_type);
                    $('#prd_price').val(prd.prd_price);
                    $('#prd_desc').val(prd.prd_desc);
                    $('#product_view_preview').val(prd.prd_img);
                    $('#product_view_preview').attr('src', '/resources/prdImg/' + prd.prd_img);
                    // 모달 창 보이기
                    $('.product_view_modal').show();
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });

        // 수정 버튼 클릭 이벤트 핸들러
        $(document).on('click', '.prd_modify', function() {
           var prd_num = $(this).closest('tr').find('td:first').text();
           $.ajax({
              type: 'POST',
                url: 'dashboardgetPrd.do',
                cache : false,
                async: false,
                data: { prd_num: prd_num },
                success: function(prd) {
                    console.log(prd);
                    // 상세 정보를 모달 창에 표시
                    $('#modify_prd_num').val(prd.prd_num);
                    $('#modify_prd_name').val(prd.prd_name);
                    $('#modify_prd_type').val(prd.prd_type);
                    $('#modify_prd_price').val(prd.prd_price);
                    $('#modify_prd_desc').val(prd.prd_desc);
                    $('#product_modify_preview').val(prd.prd_img);
                    $('#product_modify_preview').attr('src', '/resources/prdImg/' + prd.prd_img);
                    // 모달 창 보이기
                    $('.product_modify_modal').show();
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });


        $('.prd_delete_btn').click(function() {
            var prd_num = $('#modify_prd_num').val();

            $.ajax({
                type: 'POST',
                url: 'deletePrd.do',
                data: { prd_num: prd_num },
                success: function() {
                    // 성공적으로 삭제되면 모달을 닫고 페이지를 새로고침하여 변경된 데이터를 반영합니다.
                    
                    location.reload();
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });

        // 상세보기 모달 닫기 버튼 클릭 이벤트 핸들러
        $(document).on('click', '.close_product_view', function() {
            $('.product_view_modal').hide();
           
        }); //닫기
        $(document).on('click', '.close_product_modify', function() {
            $('.product_modify_modal').hide();
           
        }); //닫기
       
    });
</script>
					<!-- 신규 상품 등록 모달 시작 -->
					<div class="product_add_modal modal_common">
						<div class="product_add_modal_body modal_body_common">
							<h2 class="product_add_modal_title">신규 상품 등록</h2>
							<form action="insertPrd.do" method="post"
								enctype="multipart/form-data">

								<!--                         <div class="list_sort"> -->
								<!--                            <div class="list_name">상품 번호</div> -->
								<!--                            <input type="text" name="prd_num"> -->
								<!--                         </div> -->

								<div class="list_sort">
									<div class="list_name">상품 이름</div>
									<input type="text" name="prd_name">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 종류</div>
									<input type="text" name="prd_type">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 가격</div>
									<input type="text" name="prd_price">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 설명</div>
									<input type="text" name="prd_desc">
								</div>


								<div class="list_sort">
									<div>
										<img id="product_add_preview"
											src="${pageContext.request.contextPath}/resources/img" alt="">
										<label class="add_thumnail_btn" for="add_product_thumnail">상품이미지
											선택</label> <input type="file" name="uploadFile"
											id="add_product_thumnail">
									</div>
								</div>

								<div class="modal_btn_box">
									<button type="submit" class="modify_btn" onclick="">등록</button>
									<button type="button" class="confirm_btn close_product_add"
										onclick="closeProductAdd()">닫기</button>
								</div>
							</form>
						</div>
					</div>
					<!-- 신규 상품 등록 모달 끝 -->


					<!-- 상품상세보기 -->
					<div class="product_view_modal modal_common">
						<div class="product_view_modal_body modal_body_common">
							<h2 class="product_view_modal_title">상품 상세보기</h2>
							<form action="dashboardgetPrd.do">
								<div class="list_sort">
									<div class="list_name">상품 번호</div>
									<input type="text" id="prd_num" name="prd_num" readonly>
								</div>

								<div class="list_sort">
									<div class="list_name">상품 이름</div>
									<input type="text" id="prd_name" name="prd_name" readonly>
								</div>

								<div class="list_sort">
									<div class="list_name">상품 종류</div>
									<input type="text" id="prd_type" name="prd_type" readonly>
								</div>

								<div class="list_sort">
									<div class="list_name">상품 가격</div>
									<input type="text" id="prd_price" name="prd_price" readonly>
								</div>

								<div class="list_sort">
									<div class="list_name">상품 설명</div>
									<input type="text" id="prd_desc" name="prd_desc" readonly>
								</div>

								<div class="list_sort">
									<div>
										<div class="list_name">상품 이미지</div>
										<img id="product_view_preview" alt="">
									</div>
								</div>

								<div class="modal_btn_box">
									<button type="button" class="confirm_btn close_product_view">닫기</button>
								</div>
							</form>
						</div>
					</div>

					<!-- 상품 수정 모달 시작  -->
					<div class="product_modify_modal modal_common">
						<div class="product_modify_modal_body modal_body_common">
							<h2 class="product_modify_modal_title">상품 수정</h2>
							<form action="updatePrd.do" method="post"
								enctype="multipart/form-data">

								<div class="list_sort">
									<div class="list_name">상품 번호</div>
									<input type="text" id="modify_prd_num" name="prd_num">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 이름</div>
									<input type="text" id="modify_prd_name" name="prd_name">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 종류</div>
									<input type="text" id="modify_prd_type" name="prd_type">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 가격</div>
									<input type="text" id="modify_prd_price" name="prd_price">
								</div>

								<div class="list_sort">
									<div class="list_name">상품 설명</div>
									<input type="text" id="modify_prd_desc" name="prd_desc">
								</div>

								<div class="list_sort">
									<div>
										<img id="product_modify_preview"> <label
											class="modify_thumnail_btn" for="product_thumnail">상품이미지
											선택</label> <input type="file" id="product_thumnail" name="uploadFile">
									</div>
								</div>

								<div class="modal_btn_box">
									<button type="submit" class="modify_btn" onclick=""
										id="modify_btn">수정</button>
									<button type="button" class="delete_btn prd_delete_btn"
										onclick="">삭제</button>
									<button type="button" class="confirm_btn close_product_modify">닫기</button>
								</div>
							</form>
						</div>
					</div>
					<!-- 상품 수정 모달 끝  -->

				</div>
				<!-- 상품 관리 끝 -->


				<!-- 공지사항 게시판 관리 시작 -->
				<div id="annoboard" class="tab-content">
					<div class="dash_annoboard_box">
						<div class="dash_annoboard_top">
							<h1 class="dash_annoboard_title">공지사항</h1>
							<form id="searchForm" action="modifyBoard.do">
								<select name="option" id="searchOption1">
									<option value="bn_title">제목</option>
									<option value="bn_content">내용</option>
								</select> <input type="text" id="searchValue1" name="value">
								<button type="button" class="search_btn">검색</button>
								<!-- 버튼 타입을 submit으로 변경 -->
							</form>
						</div>
						<div class="annoboard_add_btn_box">
							<button class="annoboard_add_btn" type="button"
								onclick="location.href='./insertboard.jsp'">+ 신규 공지 등록</button>
						</div>

						<div class="dash_annoboard_list">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>등록일</th>
										<th>게시글 관리</th>
									</tr>
								</thead>
								<tbody id="annoboardBody">
									<!-- 여기에 게시글 목록이 추가될 것입니다. -->
								</tbody>
							</table>
						</div>

						<div class="dash_annoboard_paging paging_box">
							<!-- 여기에 페이징 버튼이 추가될 것입니다. -->
						</div>


						<script>
                           $(document).ready(function() {
                        	   
                              // 눌렀을때 바로 보여짐
                               $('#board_tab').click(function() {
                                  $.ajax({
                                       type: 'POST',
                                       url: 'getDashboardBoardList.do',
                                       cache: false,
                                       async: false,
                                       success: function(response) {
                                           console.log("데이터 반환 완료");
                                           console.log(response);
                                           
                                           var boardList = response.boardList;
                                           var pageInfo = response.pageInfo;
                                           
                                           var pageSize = 7; // 페이지당 표시할 멤버 수
                                           var pageCount = Math.ceil(boardList.length / pageSize); // 전체 페이지 수
                                           var currentPage = 1; // 현재 페이지 번호
                                           var pagination = $('.dash_annoboard_paging'); // 페이징을 표시할 요소
                                           var maxPagesToShow = 3; // 표시할 최대 페이지 수
                                           
                                           function displayBoards() { // 멤버 목록을 표시하는 함수
                                               var start = (currentPage - 1) * pageSize; // 표시할 멤버의 시작 인덱스
                                               var end = start + pageSize; // 표시할 멤버의 끝 인덱스
                                               var displayedBoards = boardList.slice(start, end); // 현재 페이지에 표시할 멤버 목록
                                           
                                           var tableBody = $('#annoboard tbody');
                                           tableBody.empty();

                                           // 각 게시글을 테이블에 추가합니다.
                                           for (var i = 0; i < displayedBoards.length; i++) {
                                               var board = displayedBoards[i];
                                               
                                               var row = $('<tr>');
                                               row.append('<td>' + board.bn_num + '</td>');
                                               row.append('<td>' + board.bn_title + '</td>');
                                               row.append('<td>' + board.bn_date + '</td>');
                                               row.append('<td> <button class="annoboard_view dash_btn_1">상세보기</button><button class="dash_btn_1"><a href="getBoardDetail.do?bn_num=' + board.bn_num + '" class="annoboard_modify" style="text-decoration: none; color: inherit;">수정</a></button></td>');
                                               tableBody.append(row);
                                           }
                                           
                                           
                                           generatePagination(); 
                                           bindBoardDetailClickEvent();
                                           
                                           }
                                           
                                           function generatePagination() {
                                               pagination.empty(); // 페이징 요소 비움

                                               if (pageCount > 0) { // 페이지가 존재하는 경우
                                                   var startPage, endPage; // 시작 페이지와 끝 페이지

                                                   // 현재 그룹의 시작 페이지와 끝 페이지 계산
                                                   var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                                   startPage = groupIndex * maxPagesToShow + 1;
                                                   endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                                   // "이전" 버튼 추가
                                                   if (startPage > 1) {
                                                       pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                                   }

                                                   // 페이지 번호 추가
                                                   for (var i = startPage; i <= endPage; i++) {
                                                       var pageLink = $('<a>', {
                                                           href: '#',
                                                           text: i,
                                                           class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                                       });
                                                       pagination.append(pageLink);
                                                   }

                                                   // "다음" 버튼 추가
                                                   if (endPage < pageCount) {
                                                       pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                                   }
                                               }
                                           }

                                           pagination.on('click', '.prev_group', function(event) {
                                               event.preventDefault(); // 기본 동작 방지
                                               var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                               if (groupIndex > 0) { // 현재 그룹이 첫 그룹이 아닌 경우
                                                  currentPage = (groupIndex - 1) * maxPagesToShow + 1; // 이전 그룹의 마지막 페이지로 이동
                                                  displayBoards(); // 멤버 목록 다시 표시
                                               }
                                           });

                                           pagination.on('click', '.next_group', function(event) {
                                               event.preventDefault(); // 기본 동작 방지
                                               var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                               var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                                               if (groupIndex < totalGroups - 1) { // 현재 그룹이 마지막 그룹이 아닌 경우
                                                   currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1; // 다음 그룹의 첫 페이지로 이동
                                                   displayBoards(); // 멤버 목록 다시 표시
                                               }
                                           });

                                           pagination.on('click', '.page_link', function(event) {
                                               event.preventDefault(); // 기본 동작 방지
                                               var newPage = parseInt($(this).text()); // 클릭한 페이지 번호 가져오기
                                               if (newPage !== currentPage) { // 현재 페이지와 클릭한 페이지가 다른 경우에만 처리
                                                   currentPage = newPage; // 현재 페이지 변경
                                                   displayBoards(); // 멤버 목록 다시 표시
                                               }
                                           });

                                           generatePagination(); // 페이지 생성
                                           displayBoards(); // 멤버 목록 표시
                                           
                                           
                                       },
                                       error: function(error) {
                                           console.log(error);
                                       }
                                   });
                               });
                              
                              
                               function bindBoardDetailClickEvent() {
                                  
                                   $('.annoboard_view').click(function() {
                                       var bn_num = $(this).closest('tr').find('td:first').text();
                                       
                                       $.ajax({
                                           type: 'POST',
                                           url: 'getDashboardBoard.do',
                                           data: { bn_num: bn_num },
                                           success: function(annoboard) {
                                              console.log(annoboard);
                                               $('#bn_num').val(annoboard.bn_num);
                                               $('#bn_title').val(annoboard.bn_title);
                                               $('#bn_content').html(annoboard.bn_content);
//                                                $('#bn_content').val(annoboard.bn_content);
//                                                $('#bn_date').val(memberInfo[0].mem_nm);

                                               
                                               $('.view_annoboard_modal').show();
                                           },
                                           error: function(error) {
                                               console.log(error);
                                           }
                                       });
                                   });
                               
                               
                                 
                               }

                               $('.confirm_btn').click(function() {
                                   $('.view_annoboard_modal').hide();
                               });
                           
                               
                               $('.search_btn').click(function() {
                                   var searchOption = $('#searchOption1').val();
                                   var searchValue = $('#searchValue1').val();

                                   $.ajax({
                                       type: 'POST',
                                       url: 'getBoardList1.do', // 관리자 공지사항 페이지의 URL로 변경
                                       data: { option: searchOption, value: searchValue },
                                       cache: false,
                                       async: false,
                                       success: function(annoboard) {
                                           console.log("데이터 반환 완료");
                                           console.log(annoboard);
                                           var tableBody = $('#annoboard tbody');
                                       
                                           var pageSize = 7; // 페이지당 표시할 멤버 수
                                                 var pageCount = Math.ceil(annoboard.length / pageSize); // 전체 페이지 수
                                                 var currentPage = 1; // 현재 페이지 번호
                                                 var pagination = $('.dash_annoboard_paging'); // 페이징을 표시할 요소
                                                 var maxPagesToShow = 3; // 표시할 최대 페이지 수
                                           
                                                 function displayBoards() {
                                                     var start = (currentPage - 1) * pageSize;
                                                     var end = start + pageSize;
                                                     var displayedBoards  = annoboard.slice(start, end);
                                           
                                           tableBody.empty();
                           
                                           for (var i = 0; i < displayedBoards.length; i++) {
                                               var board = displayedBoards[i];
                           
                                               var row = $('<tr>');
                           
                                               row.append('<td>' + board.bn_num + '</td>');
                                               row.append('<td>' + board.bn_title + '</td>');
//                                                row.append('<td>' + board.bn_content + '</td>');
                                               row.append('<td>' + board.bn_date.slice(0, 10) + '</td>');
                                               row.append('<td><button style="margin-right: 5px;" class="annoboard_view dash_btn_1">상세보기</button><button class="annoboard_modify dash_btn_1">수정</button></td>');
                           
                                               tableBody.append(row);
                                           }
                                           
                                           generatePagination();
                                            bindBoardDetailClickEvent();
                                        }

                                        function generatePagination() {
                                            pagination.empty();

                                            if (pageCount > 0) {
                                                var startPage, endPage;

                                                var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                                startPage = groupIndex * maxPagesToShow + 1;
                                                endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                                if (startPage > 1) {
                                                    pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                                }

                                                for (var i = startPage; i <= endPage; i++) {
                                                    var pageLink = $('<a>', {
                                                        href: '#',
                                                        text: i,
                                                        class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                                    });
                                                    pagination.append(pageLink);
                                                }

                                                if (endPage < pageCount) {
                                                    pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                                }
                                            }
                                        }

                                        pagination.on('click', '.prev_group', function(event) {
                                            event.preventDefault();
                                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                            if (groupIndex > 0) {
                                                currentPage = (groupIndex - 1) * maxPagesToShow + 1;
                                                displayBoards();
                                            }
                                        });

                                        pagination.on('click', '.next_group', function(event) {
                                            event.preventDefault();
                                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                            var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                                            if (groupIndex < totalGroups - 1) {
                                                currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1;
                                                displayBoards();
                                            }
                                        });

                                        pagination.on('click', '.page_link', function(event) {
                                            event.preventDefault();
                                            var newPage = parseInt($(this).text());
                                            if (newPage !== currentPage) {
                                                currentPage = newPage;
                                                displayBoards();
                                            }
                                        });

                                        generatePagination();
                                        displayBoards();
                                       },
                                       
                                       
                                       error: function(xhr, status, error) {
                                           console.error("오류 발생:", error);
                                       }
                                   });
                               });
                        });
                           
                         </script>

						<!-- 공지사항 상세보기 -->

						<div class="view_annoboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title ">공지사항</h2>
								<form action="">
									<div class="board_sort annoboard_title">
										<input type="text" id="bn_title" readonly name="">
									</div>

									<div class="board_sort">
										<div id="bn_content" style="resize: none;" name="bn_content"></div>
									</div>
									<div class="modal_btn_box">

										<!--                              <button type="button" class="delete_btn anno_delete_btn" id="deleteButton">삭제</button> -->
										<button type="button"
											class="confirm_btn close_view_board_modal">닫기</button>
									</div>
								</form>
							</div>
						</div>

						<!--공지사항 글쓰기 -->
						<div class="add_annoboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title">공지사항 글쓰기</h2>

								<%@include file="../../insertboard.jsp"%>
								<!--                         <form id="addBoardForm" action="insertBoard.do" method="POST"> -->
								<!--                            method를 POST로 변경 -->
								<!--                            <div class="board_sort"> -->
								<!--                               <div class="board_name">글 제목</div> -->
								<!--                               <input type="text" id="bn_title" name="bn_title"> -->
								<!--                            </div> -->

								<!--                            <div class="board_sort"> -->
								<!--                               <div class="board_name">글 내용</div> -->

								<!--                               <textarea style="resize: none;" id="bn_content" name="bn_content" cols="100" rows="20"></textarea> -->
								<!--                            </div> -->

								<!--                            <div class="modal_btn_box"> -->
								<!--                               <button type="submit" class="add_btn" id="boardinsert">등록</button> -->
								<!--                               <button type="button" -->
								<!--                                  class="confirm_btn close_add_board_modal">닫기</button> -->
								<!--                            </div> -->
								<!--                         </form> -->
							</div>
						</div>


						<!-- 공지사항 수정 -->
						<!-- 공지사항 수정 모달 -->
						<div class="modify_annoboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title">공지사항 글수정</h2>

								<%--                         <%@include file ="./updateboard.jsp" %> --%>
								<%--                         <%@include file ="./WEB-INF/productt/productUpdate.jsp" %> --%>
								<!--                         <form id="modifyBoardForm" action="updateBoard.do" method="POST"> -->
								<!--                            수정된 부분 -->
								<!--                            <div class="board_sort"> -->
								<!--                               <div class="board_name">글 제목</div> -->
								<!--                               <input type="text" id="modified_bn_title" name="bn_title"> -->
								<!--                            </div> -->

								<!--                            <div class="board_sort"> -->
								<!--                               <div class="board_name">글 내용</div> -->
								<!--                               <textarea style="resize: none;" id="modified_bn_content" -->
								<!--                                  name="bn_content" cols="100" rows="20"></textarea> -->
								<!--                            </div> -->

								<!--                            <div class="modal_btn_box"> -->
								<!--                               <input type="hidden" id="modified_bn_num" name="bn_num"> -->
								<!--                               수정된 부분 -->
								<!--                               <button type="submit" class="modify_btn">수정</button> -->
								<!--                               <button type="button" class="delete_btn anno_delete_btn">삭제</button> -->
								<!--                               <button type="button" -->
								<!--                                  class="confirm_btn close_modify_board_modal">닫기</button> -->
								<!--                            </div> -->
								<!--                         </form> -->
							</div>
						</div>
					</div>
				</div>

				<!-- 공지사항 게시판 관리 끝 -->

				<!-- 이벤트 게시판 -->
				<div id="evboard" class="tab-content">
					<div class="dash_evboard_box">
						<div class="dash_evboard_top">
							<h1 class="dash_evboard_title">이벤트</h1>
							<form>
								<select name="option" id="searchOption2">
									<option value="ev_title">글 제목</option>
									<option value="ev_content">글 내용</option>
								</select> <input type="text" id="searchValue2" name="value">
								<button type="button" class="search_btn">검색</button>
							</form>
						</div>
						<div class="evboard_add_btn_box">
							<button class="evboard_add_btn" type="button">+ 신규 이벤트
								등록</button>
						</div>
						<div class="dash_evboard_list">
							<ul>
							</ul>
							<script>
                $(document).ready(function() {
                    function updateEventStatus(ev_num, newStatus) {
                        $.ajax({
                            type: 'POST',
                            url: '/updateEventStatus.do',
                            data: { ev_num: ev_num, new_status: newStatus },
                            success: function(response) {
                                console.log("이벤트 상태 업데이트 완료");
                            },
                            error: function(error) {
                                console.log("이벤트 상태 업데이트 실패:", error);
                            }
                        });
                    }

                    $(document).on('click', '.update_event_status_btn', function() {
                        var ev_num = $(this).data('evnum');
                        var newStatus = '종료';
                        updateEventStatus(ev_num, newStatus);
                    });

                    function displayBoards(Ev_boardList) {
                        var pageSize = 4;
                        var pageCount = Math.ceil(Ev_boardList.length / pageSize);
                        var currentPage = 1;
                        var pagination = $('.dash_evboard_paging');
                        var maxPagesToShow = 3;

                        function showPage(page) {
                            var start = (page - 1) * pageSize;
                            var end = start + pageSize;
                            var displayedBoards = Ev_boardList.slice(start, end);

                            var EvBoard = $('#evboard ul');
                            EvBoard.empty();

                            for (var i = 0; i < displayedBoards.length; i++) {
                                var evboard = displayedBoards[i];
                                var listItem = $('<li class="evboard_list">');

                                var thumbnailDiv = $('<div><img class="ev_thumnail" src="/resources/evImg/' + evboard.ev_img + '" alt=""></div>');
                                var infoDiv = $('<div><div class="ev_info_box"><div class="ev_title">' + evboard.ev_title + '</div><div class="ev_date"><span class="ev_start">' + evboard.ev_sdate.slice(0, 10) + '</span> ~ <span class="ev_end">' + evboard.ev_edate.slice(0, 10) + '</span></div><div class="ev_status">' + evboard.ev_status + '</div><button class="evboard_view dash_btn_1" data-evnum="' + evboard.ev_num + '">조회</button><button class="evboard_modify dash_btn_1" data-evnum="' + evboard.ev_num + '">수정</button></div></div>');

                                listItem.append(thumbnailDiv);
                                listItem.append(infoDiv);

                                EvBoard.append(listItem);
                            }

                            generatePagination();
                            bindBoardDetailClickEvent();
                            bindBoardModifyClickEvent();
                        }

                        function generatePagination() {
                            pagination.empty();

                            if (pageCount > 0) {
                                var startPage, endPage;
                                var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                startPage = groupIndex * maxPagesToShow + 1;
                                endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                if (startPage > 1) {
                                    pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                }

                                for (var i = startPage; i <= endPage; i++) {
                                    var pageLink = $('<a>', {
                                        href: '#',
                                        text: i,
                                        class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                    });
                                    pagination.append(pageLink);
                                }

                                if (endPage < pageCount) {
                                    pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                }
                            }
                        }

                        pagination.on('click', '.prev_group', function(event) {
                            event.preventDefault();
                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                            if (groupIndex > 0) {
                                currentPage = (groupIndex - 1) * maxPagesToShow + 1;
                                showPage(currentPage);
                            }
                        });

                        pagination.on('click', '.next_group', function(event) {
                            event.preventDefault();
                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                            var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                            if (groupIndex < totalGroups - 1) {
                                currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1;
                                showPage(currentPage);
                            }
                        });

                        pagination.on('click', '.page_link', function(event) {
                            event.preventDefault();
                            var newPage = parseInt($(this).text());
                            if (newPage !== currentPage) {
                                currentPage = newPage;
                                showPage(currentPage);
                            }
                        });

                        showPage(currentPage);
                    }

                    function bindBoardDetailClickEvent() {
                        $(document).on('click', '.evboard_view', function() {
                            var ev_num = $(this).data('evnum');
                            $.ajax({
                                type: 'POST',
                                url: 'getDashboardEv_Board.do',
                                data: { ev_num: ev_num },
                                success: function(evboard) {
                                    $('.ev_title').val(evboard.ev_title);
                                    $('.evboard_thumnail_preview').val(evboard.ev_img);
                                    $('.evboard_thumnail_preview').attr('src', '/resources/evImg/' + evboard.ev_img);
                                    $('.fir_input').val(evboard.ev_sdate.slice(0, 10));
                                    $('.sec_input').val(evboard.ev_edate.slice(0, 10));
                                    $('.ev_content').val(evboard.ev_content);
                                    $('.ev_status').val(evboard.ev_status);

                                    $('.view_evboard_modal').show();
                                },
                                error: function(error) {
                                    console.log(error);
                                }
                            });
                        });
                    }

                    function bindBoardModifyClickEvent() {
                        $(document).on('click', '.evboard_modify', function() {
                            var ev_num = $(this).data('evnum');
                            $.ajax({
                                type: 'POST',
                                url: 'getDashboardEv_Board.do',
                                data: { ev_num: ev_num },
                                success: function(evboard) {
                                    $('#modify_ev_title').val(evboard.ev_title);
                                    $('.modify_evboard_thumnail_preview').val(evboard.ev_img);
                                    $('.modify_evboard_thumnail_preview').attr('src', '/resources/evImg/' + evboard.ev_img);
                                    $('#modify_fir_input').val(evboard.ev_sdate.slice(0, 10));
                                    $('#modify_sec_input').val(evboard.ev_edate.slice(0, 10));
                                    $('#modify_ev_content').val(evboard.ev_content);
                                    $('#modify_ev_status').val(evboard.ev_status);

                                    $('#modify_ev_num').val(ev_num);

                                    $('.modify_evboard_modal').show();
                                },
                                error: function(error) {
                                    console.log(error);
                                }
                            });
                        });
                        $(document).on('click', '.delete_btn', function() {
                            var ev_num = $('#modify_ev_num').val();
                            $.ajax({
                                type: 'POST',
                                url: 'deleteEv_Board.do',
                                data: { ev_num: ev_num },
                                success: function() {
                                    $('.modify_evboard_modal').hide();
                                    location.reload();
                                },
                                error: function(error) {
                                    console.log(error);
                                }
                            });
                        });
                    }

                    $(document).on('click', '.close_view_evboard_modal', function() {
                        $('.view_evboard_modal').hide();
                    });

                    $(document).on('click', '.close_modifyEv_board_modal', function() {
                        $('.modify_evboard_modal').hide();
                    });

                    $('.search_btn').click(function() {
                        var searchOption = $('#searchOption2').val();
                        var searchValue = $('#searchValue2').val();

                        $.ajax({
                            type: 'POST',
                            url: 'getDashboardEv_boardList1.do',
                            data: { option: searchOption, value: searchValue },
                            cache: false,
                            async: false,
                            success: function(Ev_boardList) {
                                displayBoards(Ev_boardList);
                            },
                            error: function(xhr, status, error) {
                                console.error("오류 발생:", error);
                            }
                        });
                    });

                    $('#Evboard_tab').click(function() {
                        $.ajax({
                            type: 'POST',
                            url: 'getDashboardEv_boardList.do',
                            cache: false,
                            async: false,
                            success: function(Ev_boardList) {
                                displayBoards(Ev_boardList);
                            },
                            error: function(error) {
                                console.log(error);
                            }
                        });
                    });
                });
            </script>
						</div>
						<div style="margin-top: 30px;"
							class="dash_evboard_paging paging_box"></div>

						<!-- 글쓰기 모달 -->
						<div class="add_evboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title">이벤트 글쓰기</h2>
								<form action="insertEv_Board.do" method="POST"
									enctype="multipart/form-data">
									<div class="board_sort">
										<div class="board_name">글 제목</div>
										<input type="text" id="ev_title" name="ev_title">
									</div>
									<div class="board_sort">
										<div>
											<div class="board_name">이벤트 썸네일</div>
											<img id="add_evboard_thumnail_preview"
												class="evboard_thumnail_preview" alt=""> <label
												class="ev_thumnail_add_btn" for="ev_thumnail_add_btn">이미지
												선택</label> <input type="file" id="ev_thumnail_add_btn"
												name="uploadFile">
										</div>
									</div>
									<div class="board_sort">
										<div class="board_sort_box">
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 시작</div>
												<input class="fir_input" type="date" id="ev_sdate"
													name="ev_sdate">
											</div>
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 종료</div>
												<input class="sec_input" type="date" id="ev_edate"
													name="ev_edate">
											</div>
										</div>
									</div>
									<div class="board_sort">
										<div class="board_name">글 내용</div>
										<textarea style="resize: none;" name="ev_content"
											id="ev_content" cols="100" rows="10"></textarea>
									</div>
									<div class="modal_btn_box">
										<button type="submit" class="add_btn">등록</button>
										<button type="button"
											class="confirm_btn close_add_evboard_modal">닫기</button>
									</div>
								</form>
							</div>
						</div>
						<!-- 글조회 모달 -->
						<div class="view_evboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title">이벤트 글조회</h2>
								<form action="">
									<div class="board_sort">
										<div class="board_name">글 제목</div>
										<input type="text" id="ev_title" name="ev_title"
											class="ev_title" readonly>
									</div>
									<div class="board_sort">
										<div>
											<div class="board_name">이벤트 썸네일</div>
											<img id="evboard_thumnail_preview"
												class="evboard_thumnail_preview" src="" alt="이미지를 넣어주세요">
										</div>
									</div>
									<div class="board_sort">
										<div class="board_sort_box">
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 시작</div>
												<input class="fir_input" type="date" readonly>
											</div>
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 종료</div>
												<input class="sec_input" type="date" readonly>
											</div>
										</div>
									</div>
									<div class="board_sort">
										<div class="board_name">진행 상태</div>
										<input type="text" class="ev_status" readonly>
									</div>
									<div class="board_sort">
										<div class="board_name">글 내용</div>
										<textarea style="resize: none;" id="ev_content"
											class="ev_content" cols="100" rows="10" readonly></textarea>
									</div>
									<div class="modal_btn_box">
										<button type="button"
											class="confirm_btn close_view_evboard_modal">닫기</button>
									</div>
								</form>
							</div>
						</div>
						<!-- 글수정 모달 -->
						<div class="modify_evboard_modal board_modal">
							<div class="board_modal_body">
								<h2 class="board_modal_title">이벤트 글수정</h2>
								<form id="modify_evboard_form" action="/updateEvBoard.do"
									method="POST" enctype="multipart/form-data">
									<div class="board_sort">
										<div class="board_name">글 제목</div>
										<input type="text" id="modify_ev_title" name="ev_title">
									</div>
									<div class="board_sort">
										<div>
											<div class="board_name">이벤트 썸네일</div>
											<img id="modify_evboard_thumnail_preview"
												class="modify_evboard_thumnail_preview" alt=""> <label
												class="ev_thumnail_modify_btn" for="ev_thumnail_modify_btn">이미지
												선택</label> <input type="file" id="ev_thumnail_modify_btn"
												name="uploadFile">
										</div>
									</div>
									<div class="board_sort">
										<div class="board_sort_box">
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 시작</div>
												<input id="modify_fir_input" class="fir_input" type="date"
													name="ev_sdate">
											</div>
											<div class="board_sort_box_flex">
												<div class="board_name">이벤트 종료</div>
												<input id="modify_sec_input" class="sec_input" type="date"
													name="ev_edate">
											</div>
										</div>
									</div>
									<div class="board_sort">
										<div class="board_name">진행 상태</div>
										<input type="text" id="modify_ev_status" class="ev_status"
											name="ev_status">
									</div>
									<div class="board_sort">
										<div class="board_name">글 내용</div>
										<textarea style="resize: none;" id="modify_ev_content"
											cols="100" rows="10" name="ev_content"></textarea>
									</div>
									<input type="hidden" id="modify_ev_num" name="ev_num">
									<div class="modal_btn_box">
										<button class="modal_btn_ok modify_btn" type="submit">수정</button>
										<button class="modal_btn_ok delete_btn"
											id="delete_evboard_btn" type="button">삭제</button>
										<button class="confirm_btn close_modifyEv_board_modal"
											type="button">닫기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<!-- 쿠폰 관리 시작 -->
				<div id="pre_coupon" class="tab-content">
					<div class="dash_pre_coupon_box">
						<div class="dash_pre_coupon_top">
							<h1 class="dash_pre_coupon_title">쿠폰 정보 관리</h1>

							<div class="pre_coupon_add_btn_box">
								<button class="pre_coupon_add_btn" type="button">+ 쿠폰
									등록</button>
							</div>
						</div>
						<div class="dash_pre_coupon_list">
							<table>
								<thead>
									<tr>
										<th>만료날짜</th>
										<th>쿠폰이름</th>
										<th>쿠폰할인</th>
										<th>쿠폰관리</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
						<div class="dash_pre_coupon_paging paging_box"></div>

						<!-- 쿠폰 수정  -->
						<div class="coupon_modify_modal modal_common">
							<div class="coupon_modify_modal_body modal_body_common">
								<h2 class="coupon_modify_modal_title">쿠폰 수정</h2>
								<form id="modifyCouponForm" action="/updateCoupon.do">
									<div class="list_sort">
										<div class="list_name">쿠폰 번호</div>
										<input type="text" id="cup_num" name="cup_num" readonly>
									</div>

									<div class="list_sort">
										<div class="list_name">쿠폰 내용</div>
										<input type="text" id="cup_contents" name="cup_contents">
									</div>

									<div class="list_sort">
										<div class="list_name">만료일</div>
										<input type="date" id="cup_edate" name="cup_edate">
									</div>

									<div class="list_sort">
										<div class="list_name">종류</div>
										<input type="text" id="cup_type" name="cup_type">
									</div>

									<div class="list_sort">
										<div class="list_name">쿠폰 할인율</div>
										<input type="text" id="cup_dc" name="cup_dc">
									</div>

									<div class="modal_btn_box">
										<button type="submit" class="modify_btn coupon_modify_btn">수정</button>
										<button type="button"
											class="confirm_btn close_coupon_modify_modal">닫기</button>
									</div>
								</form>
							</div>
						</div>
					</div>

					<script>
 
            (function() {
                $.ajax({
                    type : 'POST',
                    url : 'getPreCouponList.do',
                    cache : false,
                    async : false,
                    success : function(cupList) {
                        console.log("데이터 반환 완료");
                        console.log(cupList);
                        var tableBody = $('#pre_coupon tbody'); // Select the tbody of the table
                        var pageSize = 7; // 페이지당 표시할 쿠폰 수
                        var pageCount = Math.ceil(cupList.length / pageSize); // 전체 페이지 수
                        var currentPage = 1; // 현재 페이지 번호
                        var pagination = $('.dash_pre_coupon_paging'); // 페이징을 표시할 요소
                        var maxPagesToShow = 3; // 표시할 최대 페이지 수

                        function displayCoupons() { // 쿠폰 목록을 표시하는 함수
                            var start = (currentPage - 1) * pageSize; // 표시할 쿠폰의 시작 인덱스
                            var end = start + pageSize; // 표시할 쿠폰의 끝 인덱스
                            var displayedCoupons = cupList.slice(start, end); // 현재 페이지에 표시할 쿠폰 목록

                            tableBody.empty(); // 테이블 목록을 비움

                            for (var i = 0; i < displayedCoupons.length; i++) { // 표시할 쿠폰 수만큼 반복
                                var coupon = displayedCoupons[i]; // 현재 쿠폰
                                var row = $(document.createElement("tr")); // 행 생성

                                // 각 쿠폰 정보를 행에 추가
                                row.append('<td>'+ coupon.cup_edate+ '</td>');
                                row.append('<td>'+ coupon.cup_contents+ '</td>');
                                row.append('<td>'+ coupon.cup_dc+ '%</td>');
                                row.append('<td><button class="dash_btn_1 coupon_modify_btn" data-coupon=\'' + JSON.stringify(coupon) + '\' >수정</button></td>');

                                tableBody.append(row); // 행을 테이블에 추가
                            }

                            generatePagination(); // 페이징 생성
                        }
                        
                        $(document).on('click', '.coupon_modify_btn', function() {
                            var coupon = $(this).data('coupon');
                            $('#cup_num').val(coupon.cup_num);
                            $('#cup_contents').val(coupon.cup_contents);
                            $('#cup_edate').val(coupon.cup_edate);
                            $('#cup_type').val(coupon.cup_type);
                            $('#cup_dc').val(coupon.cup_dc);
                            $('.coupon_modify_modal').show();
                        });

                        function generatePagination() {
                            pagination.empty(); // 페이징 요소 비움

                            if (pageCount > 0) { // 페이지가 존재하는 경우
                                var startPage, endPage; // 시작 페이지와 끝 페이지

                                // 현재 그룹의 시작 페이지와 끝 페이지 계산
                                var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                                startPage = groupIndex * maxPagesToShow + 1;
                                endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                                // "이전" 버튼 추가
                                if (startPage > 1) {
                                    pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                                }

                                // 페이지 번호 추가
                                for (var i = startPage; i <= endPage; i++) {
                                    var pageLink = $('<a>', {
                                        href: '#',
                                        text: i,
                                        class: 'page_link' + (i === currentPage ? ' current_page' : '')
                                    });
                                    pagination.append(pageLink);
                                }

                                // "다음" 버튼 추가
                                if (endPage < pageCount) {
                                    pagination.append('<a href="#" class="next_group">&raquo;</a>');
                                }
                            }
                        }

                        pagination.on('click', '.prev_group', function(event) {
                            event.preventDefault(); // 기본 동작 방지
                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                            if (groupIndex > 0) { // 현재 그룹이 첫 그룹이 아닌 경우
                                currentPage = (groupIndex - 1) * maxPagesToShow + 1; // 이전 그룹의 마지막 페이지로 이동
                                displayCoupons(); // 쿠폰 목록 다시 표시
                            }
                        });

                        pagination.on('click', '.next_group', function(event) {
                            event.preventDefault(); // 기본 동작 방지
                            var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                            var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                            if (groupIndex < totalGroups - 1) { // 현재 그룹이 마지막 그룹이 아닌 경우
                                currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1; // 다음 그룹의 첫 페이지로 이동
                                displayCoupons(); // 쿠폰 목록 다시 표시
                            }
                        });

                        pagination.on('click', '.page_link', function(event) {
                            event.preventDefault(); // 기본 동작 방지
                            var newPage = parseInt($(this).text()); // 클릭한 페이지 번호 가져오기
                            if (newPage !== currentPage) { // 현재 페이지와 클릭한 페이지가 다른 경우에만 처리
                                currentPage = newPage; // 현재 페이지 변경
                                displayCoupons(); // 쿠폰 목록 다시 표시
                            }
                        });

                        generatePagination(); // 페이지 생성
                        displayCoupons(); // 쿠폰 목록 표시
                    },
                    error : function(error) {
                        console.log(error);
                    }
                });
            })();

 </script>

					<!-- 쿠폰 등록 -->
					<div class="add_pre_coupon_modal modal_common">
						<div class="pre_coupon_modal_body modal_body_common ">
							<h2 class="pre_coupon_modal_title">쿠폰 등록</h2>
							<form id="addCouponForm" action="insertCoupon.do" method="POST">
								<!--                            method를 POST로 변경 -->
								<div class="list_sort">
									<div class="list_name">쿠폰 내용</div>
									<input type="text" id="cup_contents" name="cup_contents">
								</div>
								<div class="list_sort">
									<div class="list_name">지급일</div>
									<input type="date" id="cup_sdate" name="cup_sdate">
								</div>
								<div class="list_sort">
									<div class="list_name">만료일</div>
									<input type="date" id="cup_edate" name="cup_edate">
								</div>
								<div class="list_sort">
									<div class="list_name">종류</div>
									<input type="text" id="cup_type" name="cup_type">
								</div>

								<div class="list_sort">
									<div class="list_name">쿠폰 할인률</div>
									<input type="text" id="cup_dc" name="cup_dc">
								</div>

								<div class="modal_btn_box pre_coupon_btn_box">
									<button type="submit" class="add_btn" id="couponinsert">등록</button>
									<button type="button"
										class="confirm_btn close_add_pre_coupon_modal">닫기</button>
								</div>
							</form>
						</div>
					</div>


				</div>

				<!-- 쿠폰 관리 끝 -->


				<!--  쿠폰 사용자 관리 시작-->
				<div id="coupon" class="tab-content">
					<div class="dash_user_coupon_box">
						<div class="dash_user_coupon_top">
							<h1 class="dash_user_coupon_title">쿠폰 사용자 정보 관리</h1>
							<form id="searchForm">
								<span>사용 여부</span> <select name="searchCouponOption"
									id="searchCouponOption">
									<option value="전체">전체 보기</option>
									<option value="미사용">미사용</option>
									<option value="사용">사용</option>
								</select>
							</form>
						</div>
						<div class="dash_user_coupon_list">
							<table>
								<thead>
									<tr>
										<th>쿠폰이름</th>
										<th>사용여부</th>
										<th>유저</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
						<div class="dash_user_coupon_paging paging_box"></div>
					</div>

					<script>
            
                
 (function() {
    $.ajax({
        type : 'POST',
        url : 'getCouponUserList.do',
        cache : false,
        async : false,
        success : function(cupList) {
            console.log("데이터 반환 완료");
            console.log(cupList);
            var tableBody = $('#coupon tbody'); // Select the tbody of the table
            var pageSize = 7; // 페이지당 표시할 쿠폰 수
            var pageCount = Math.ceil(cupList.length / pageSize); // 전체 페이지 수
            var currentPage = 1; // 현재 페이지 번호
            var pagination = $('.dash_user_coupon_paging'); // 페이징을 표시할 요소
            var maxPagesToShow = 3; // 표시할 최대 페이지 수

            function displayCoupons() { // 쿠폰 목록을 표시하는 함수
                var start = (currentPage - 1) * pageSize; // 표시할 쿠폰의 시작 인덱스
                var end = start + pageSize; // 표시할 쿠폰의 끝 인덱스
                var displayedCoupons = cupList.slice(start, end); // 현재 페이지에 표시할 쿠폰 목록

                tableBody.empty(); // 테이블 목록을 비움

                for (var i = 0; i < displayedCoupons.length; i++) { // 표시할 쿠폰 수만큼 반복
                    var coupon = displayedCoupons[i]; // 현재 쿠폰
                    var row = $(document.createElement("tr")); // 행 생성

                    // 각 쿠폰 정보를 행에 추가
                    row.append('<td style="display: none;">'+ coupon.cup_num+ '</td>');
                    row.append('<td>'+ coupon.cup_contents+ '</td>');
                    row.append('<td>'+ coupon.cup_tf+ '</td>');
                    row.append('<td>'+ coupon.cup_user+ '</td>');
                    // Add a button for coupon detail
                    row.append('<td><button class="coupon_detail dash_btn_1">상세보기</button></td>');

                    tableBody.append(row); // 행을 테이블에 추가
                }

                generatePagination(); // 페이징 생성
                bindCouponDetailClickEvent(); // 쿠폰 상세 정보 버튼에 클릭 이벤트 바인딩
            }

            function generatePagination() {
                pagination.empty(); // 페이징 요소 비움

                if (pageCount > 0) { // 페이지가 존재하는 경우
                    var startPage, endPage; // 시작 페이지와 끝 페이지

                    // 현재 그룹의 시작 페이지와 끝 페이지 계산
                    var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                    startPage = groupIndex * maxPagesToShow + 1;
                    endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                    // "이전" 버튼 추가
                    if (startPage > 1) {
                        pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                    }

                    // 페이지 번호 추가
                    for (var i = startPage; i <= endPage; i++) {
                        var pageLink = $('<a>', {
                            href: '#',
                            text: i,
                            class: 'page_link' + (i === currentPage ? ' current_page' : '')
                        });
                        pagination.append(pageLink);
                    }

                    // "다음" 버튼 추가
                    if (endPage < pageCount) {
                        pagination.append('<a href="#" class="next_group">&raquo;</a>');
                    }
                }
            }

            pagination.on('click', '.prev_group', function(event) {
                event.preventDefault(); // 기본 동작 방지
                var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                if (groupIndex > 0) { // 현재 그룹이 첫 그룹이 아닌 경우
                    currentPage = (groupIndex - 1) * maxPagesToShow + 1; // 이전 그룹의 마지막 페이지로 이동
                    displayCoupons(); // 쿠폰 목록 다시 표시
                }
            });

            pagination.on('click', '.next_group', function(event) {
                event.preventDefault(); // 기본 동작 방지
                var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                if (groupIndex < totalGroups - 1) { // 현재 그룹이 마지막 그룹이 아닌 경우
                    currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1; // 다음 그룹의 첫 페이지로 이동
                    displayCoupons(); // 쿠폰 목록 다시 표시
                }
            });

            pagination.on('click', '.page_link', function(event) {
                event.preventDefault(); // 기본 동작 방지
                var newPage = parseInt($(this).text()); // 클릭한 페이지 번호 가져오기
                if (newPage !== currentPage) { // 현재 페이지와 클릭한 페이지가 다른 경우에만 처리
                    currentPage = newPage; // 현재 페이지 변경
                    displayCoupons(); // 쿠폰 목록 다시 표시
                }
            });

            generatePagination(); // 페이지 생성
            displayCoupons(); // 쿠폰 목록 표시
        },
        error : function(error) {
            console.log(error);
        }
    });
})();
 
 // JavaScript 코드
 $('#searchCouponOption').on('click', function() {
     var searchOption = $('#searchCouponOption').val();
     console.log("searchOption " + searchOption);
     $.ajax({
         type: 'POST',
         url: 'searchCoupon.do',
         data: { option: searchOption },
         success: function(couponInfo) {
             var tableBody = $('#coupon tbody');
             var pageSize = 7;
             var pageCount = Math.ceil(couponInfo.length / pageSize);
             var currentPage = 1;
             var pagination = $('.dash_coupon_paging');
             var maxPagesToShow = 3;
             console.log("couponInfo" + couponInfo);

             function displayCoupons() {
                 var start = (currentPage - 1) * pageSize;
                 var end = start + pageSize;
                 var displayedCoupons = couponInfo.slice(start, end);
                 console.log("displayedCoupons " + displayedCoupons);

                 tableBody.empty();

                 for (var i = 0; i < displayedCoupons.length; i++) {
                     var coupon = displayedCoupons[i];
                     var row = $('<tr>');

                     row.append('<td style="display: none;">'+ coupon.cup_num+ '</td>');
                     row.append('<td>'+ coupon.cup_contents+ '</td>');
                     row.append('<td>'+ coupon.cup_tf+ '</td>');
                     row.append('<td>'+ coupon.cup_user+ '</td>');
                     row.append('<td><button class="coupon_detail dash_btn_1">상세보기</button></td>');

                     tableBody.append(row);
                 }

                 generatePagination();
                 bindCouponDetailClickEvent();
             }

             function generatePagination() {
                 pagination.empty();

                 if (pageCount > 0) {
                     var startPage, endPage;

                     var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                     startPage = groupIndex * maxPagesToShow + 1;
                     endPage = Math.min(startPage + maxPagesToShow - 1, pageCount);

                     if (startPage > 1) {
                         pagination.append('<a href="#" class="prev_group">&laquo;</a>');
                     }

                     for (var i = startPage; i <= endPage; i++) {
                         var pageLink = $('<a>', {
                             href: '#',
                             text: i,
                             class: 'page_link' + (i === currentPage ? ' current_page' : '')
                         });
                         pagination.append(pageLink);
                     }

                     if (endPage < pageCount) {
                         pagination.append('<a href="#" class="next_group">&raquo;</a>');
                     }
                 }
             }

             pagination.on('click', '.prev_group', function(event) {
                 event.preventDefault();
                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                 if (groupIndex > 0) {
                     currentPage = (groupIndex - 1) * maxPagesToShow + 1;
                     displayCoupons();
                 }
             });

             pagination.on('click', '.next_group', function(event) {
                 var groupIndex = Math.ceil(currentPage / maxPagesToShow) - 1;
                 var totalGroups = Math.ceil(pageCount / maxPagesToShow);
                 if (groupIndex < totalGroups - 1) {
                     currentPage = groupIndex * maxPagesToShow + maxPagesToShow + 1;
                     displayCoupons();
                 }
             });

             pagination.on('click', '.page_link', function(event) {
                 event.preventDefault();
                 var newPage = parseInt($(this).text());
                 if (newPage !== currentPage) {
                     currentPage = newPage;
                     displayCoupons();
                 }
             });

             generatePagination();
             displayCoupons();
         },
         error: function(error) {
             console.log(error);
         }
     });
 });

 
 
 

 
 function bindCouponDetailClickEvent() {
     $('.coupon_detail').click(function() {
         var cup_num = $(this).closest('tr').find('td:first').text();
      console.log(cup_num);
         $.ajax({
             type: 'POST',
             url: 'getCouponInfo.do',
             data: { cup_num: cup_num },
             success: function(couponInfo) {
                console.log("couponInfo "+ couponInfo);
                $('#cup_sdate1').val(couponInfo.cup_sdate);
                $('#cup_edate1').val(couponInfo.cup_edate);
                $('#cup_type1').val(couponInfo.cup_type);
                $('#cup_user1').val(couponInfo.cup_user);
                $('#cup_tf1').val(couponInfo.cup_tf);

                 $('.user_coupon_info_modal').show();
             },
             error: function(error) {
                 console.log(error);
             }
         });
     });	
 }


                     
 </script>
					<!-- 쿠폰 상세보기  -->
					<div class="user_coupon_info_modal modal_common">
						<div class="user_coupon_info_modal_body modal_body_common">
							<h2 class="user_coupon_modal_title">쿠폰상세보기</h2>
							<form action="">
								<div class="list_sort">
									<div class="list_name">발급일</div>
									<input type="text" id="cup_sdate1" readonly>
								</div>
								<div class="list_sort">
									<div class="list_name">만료일</div>
									<input type="text" id="cup_edate1" readonly>
								</div>
								<div class="list_sort">
									<div class="list_name">쿠폰 종류</div>
									<input type="text" id="cup_type1" readonly>
								</div>
								<div class="list_sort">
									<div class="list_name">소유자</div>
									<input type="text" id="cup_user1" readonly>
								</div>
								<div class="list_sort">
									<div class="list_name">사용 여부</div>
									<input type="text" id="cup_tf1" readonly>
								</div>
							</form>
							<button type="button" class="confirm_btn close_coupon_modal"
								id="close_coupon_modal">확인</button>
						</div>
					</div>
				</div>
				<script>
         $('#close_coupon_modal').click(function() {
		     $('.user_coupon_info_modal').hide();
		 });
        </script>
				<!-- 쿠폰 사용자 관리 끝 -->
			</div>
</body>
</html>