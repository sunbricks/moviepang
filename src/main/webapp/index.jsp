<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file ="./WEB-INF/sub/header.jsp" %>
<% if (session.getAttribute("success") != null) { %>
        <script>
            alert("<%= session.getAttribute("success") %>");
            <% session.removeAttribute("success"); %>
        </script>
    <% } %>

    <% if (session.getAttribute("error") != null) { %>
        <script>
            alert("<%= session.getAttribute("error") %>");
            <% session.removeAttribute("error"); %>
        </script>
    <% } %>
<main id="container">
    <section id="home" class="main1">
        <!-- Slider main container -->
        <div class="swiper main_v_swiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <a href="">
                        <img class="pc_main_view" src="${pageContext.request.contextPath}/resources/img/main_v01_pc.png" alt="">
                        <img class="ta_main_view" src="${pageContext.request.contextPath}/resources/img/main_v01_ta.png" alt="">
                        <img class="mo_main_view" src="${pageContext.request.contextPath}/resources/img/main_v01_mo.png" alt="">
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="">
                        <img class="pc_main_view" src="${pageContext.request.contextPath}/resources/img/main_v02_pc.png" alt="">
                        <img class="ta_main_view" src="${pageContext.request.contextPath}/resources/img/main_v02_ta.png" alt="">
                        <img class="mo_main_view" src="${pageContext.request.contextPath}/resources/img/main_v02_mo.png" alt="">
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="">
                        <img class="pc_main_view" src="${pageContext.request.contextPath}/resources/img/main_v03_pc.png" alt="">
                        <img class="ta_main_view" src="${pageContext.request.contextPath}/resources/img/main_v03_ta.png" alt="">
                        <img class="mo_main_view" src="${pageContext.request.contextPath}/resources/img/main_v03_mo.png" alt="">
                    </a>
                </div>
                <div class="swiper-slide">
                    <a href="">
                        <img class="pc_main_view" src="${pageContext.request.contextPath}/resources/img/main_v04_pc.png" alt="">
                        <img class="ta_main_view" src="${pageContext.request.contextPath}/resources/img/main_v04_ta.png" alt="">
                        <img class="mo_main_view" src="${pageContext.request.contextPath}/resources/img/main_v04_mo.png" alt="">
                    </a>
                </div>
            </div>
        </div>
    </section>

   <!-- index.jsp -->

    <section id="movie" class="main2 section">
            <div class="inner">
                <div class="main_title_box">
                    <h1 class="section_title">무비 차트</h1>
                    <div class="movie_more_box">
                        <a class="movie_more_btn" href="/getMovieList.do">더 보기</a>
                    </div>
                </div>
                <ul class="movie_tabs">
                    <li class="tab-link list" data-tab="showing">현재 상영작</li>
                    <li class="tab-link" data-tab="sfr">상영 예정작</li>
                </ul>

                <div id="showing" class="tab-content list">
                    <div class="swiper nowfreeswiper showing_movie">
                        <ul class="movie_rate_list_box swiper-wrapper" id="swiper-wrapper-show">
                            
                        </ul>
                    </div>
                </div>

                <div id="sfr" class="tab-content">
                    <div class="swiper sfrfreeswiper sfr_movie">
                        <ul class="movie_rate_list_box swiper-wrapper" id="swiper-wrapper-will">

                        </ul>
                    </div>
                </div>
            </div>
            <script>
                function nowScreened(){
                    $.ajax({
                        type: 'POST',
                        url: 'nowScreened.do',
                        cache: false,
                        async: false,
                        success: function(screenInfo) {
                        	
                        	var sumTotal = 0;
                        	for(let i=0;i < screenInfo.length;i++){
                        		sumTotal += screenInfo[i].total;
                        	}
                        	if(sumTotal === 0){
                        		sumTotal = 1;
                        	}
                        
                            var nowScreenBox = document.querySelector("#swiper-wrapper-show");
                            nowScreenBox.innerHTML = ''; // 기존 내용을 초기화
                            
                            if (screenInfo.length === 0) {
                                return ;
                            } else {
                                var screenPart = (screenInfo.length > 10 ? screenInfo.slice(0,10) : screenInfo);
                                
                                
                                
                                screenPart.forEach(function(screen) {
                                
                                    console.log("현재 상영작");
                                    console.log("screen",screen);
                                    console.log("screen.mov_Nm",screen.mov_Nm);
                                
                                    var movieBox = document.createElement("li");
                                    movieBox.classList.add("swiper-slide");
                                    movieBox.classList.add("movie_rate_list");
                                    
                                    var movieA = document.createElement("a");
                                    movieA.href = "getMovie.do?mov_Num=" + screen.mov_Num; 
                                    
                                    var movieImg = document.createElement("img");
                                    movieImg.src = "${pageContext.request.contextPath}/resources/img/" + screen.mov_Post;
                                    movieImg.alt = screen.mov_Nm;

                                    
                                    var m_nameDiv = document.createElement("div");
                                    m_nameDiv.classList.add("m_name");
                                    m_nameDiv.textContent = screen.mov_Nm;
                                    
                                    var m_genreSpan = document.createElement("span");
                                    m_genreSpan.classList.add("m_genre");
                                    m_genreSpan.textContent = screen.mov_Con1;

                                    var m_rateSpan = document.createElement("span");
                                    m_rateSpan.classList.add("m_rate");
                                    m_rateSpan.textContent = "예매율 " + Math.round((screen.total / sumTotal) * 1000) / 10 + "%";
                                    
                                    movieA.appendChild(movieImg);
                                    movieA.appendChild(m_nameDiv);
                                    movieA.appendChild(m_genreSpan);
                                    movieA.appendChild(m_rateSpan);
                                    
                                
                                    movieBox.appendChild(movieA);
                                    
                                    // 생성된 요소를 컨테이너에 추가합니다.
                                    nowScreenBox.appendChild(movieBox);
                                  
                                })
                            }// else 닫기
                            
                        },error: function(error) {
                            console.log(error);
                        }
                    });
                }
                function willScreen(){
                    $.ajax({
                        type: 'POST',
                        url: 'willScreened.do',
                        cache: false,	
                        async: false,
                        success: function(screenInfo) {
                        
                            var willScreenBox = document.querySelector("#swiper-wrapper-will");
                            willScreenBox.innerHTML = ''; // 기존 내용을 초기화
                            
                            if (screenInfo.length === 0) {
                                return ;
                            } else {
                                var screenPart = (screenInfo.length > 10 ? screenInfo.slice(0,10) : screenInfo);
                                
                                screenPart.forEach(function(screen) {
                                
                                
                                    var movieBox = document.createElement("li");
                                    movieBox.classList.add("swiper-slide");
                                    movieBox.classList.add("movie_rate_list");
                                    
                                    var movieA = document.createElement("a");
                                    movieA.href = "";
                                    
                                    var movieImg = document.createElement("img");
                                    movieImg.src = "${pageContext.request.contextPath}/resources/img/" + screen.mov_Post;
                                    movieImg.alt = screen.mov_Nm;
                                    
                                    var m_nameDiv = document.createElement("div");
                                    m_nameDiv.classList.add("m_name");
                                    m_nameDiv.textContent = screen.mov_Nm;
                                    
                                    var m_openSpan = document.createElement("span");
                                    m_openSpan.classList.add("m_open");
                                    m_openSpan.textContent = "개봉일 "+screen.mov_Date;
										
                                    const screenDate = new Date(screen.mov_Date);
                                    const currentDate = new Date();
                                    const timeDiff = screenDate.getTime() - currentDate.getTime();
                                    const dayDiff = timeDiff / (1000*3600*24);
                                    
                                    var m_op_dateSpan = document.createElement("span");
                                    m_op_dateSpan.classList.add("m_op_date");
                                    m_op_dateSpan.textContent = "D - " + Math.ceil(dayDiff);
                                    
                                    
                                    movieA.appendChild(movieImg);
                                    movieA.appendChild(m_nameDiv);
                                    movieA.appendChild(m_openSpan);
                                    movieA.appendChild(m_op_dateSpan);
                                    
                                
                                    movieBox.appendChild(movieA);
                                    
                                    // 생성된 요소를 컨테이너에 추가합니다.
                                    willScreenBox.appendChild(movieBox);
                                  
                                })
                            }// else 닫기
                            
                        },error: function(error) {
                            console.log(error);
                        }
                    });
                }
                
                (function(){
                	nowScreened();
                	willScreen();
                })();
                
              
                </script>
        </section>


    <!-- 이벤트 게시판 불러오기 시작 -->
<section id="event" class="main3 section">
    <div class="inner">
        <div class="main_title_box">
            <h1 class="section_title">이벤트</h1>
            <div class="movie_more_box">
                <a class="movie_more_btn" href="/getEv_boardList.do">더 보기</a>
            </div>
        </div>
        <div class="event_list_box">
            <ul id="eventList">
                <!-- 이벤트 목록이 여기에 동적으로 추가될 것입니다. -->
            </ul>
        </div>
    </div>
</section>

<script>
$(document).ready(function() {
    // 최신 이벤트 3개를 가져오는 함수
    function loadRecentEvents() {
        $.ajax({
            type: 'GET',
            url: '/getRecentEvents.do',
            success: function(response) {
                console.log(response); // 응답 데이터 구조 확인
                displayRecentEvents(response);
            },
            error: function(error) {
                console.log("이벤트 목록 로드 실패:", error);
            }
        });
    }

    // 가져온 이벤트를 화면에 표시하는 함수
    function displayRecentEvents(eventList) {
        var eventListBox = $('#eventList');
        eventListBox.empty();

        for (var i = 0; i < eventList.length; i++) {
            var event = eventList[i];
            console.log(event); // 각 이벤트 객체의 구조 확인
            var listItem = $('<li>');
            listItem.append('<a href="getEv_Board.do?ev_num=' + event.ev_num + '"><img class="ev_thumnail" src="/resources/evImg/' + event.ev_img + '" alt=""><p class="ev_title">' + event.ev_title + '</p><p class="ev_date">' + event.ev_sdate + ' ~ ' + event.ev_edate + '</p></a>');
            eventListBox.append(listItem);
        }
    }

    // 페이지 로드 시 최신 이벤트 3개를 가져옴
    loadRecentEvents();
});
</script>
    
    <!-- 이벤트 게시판 불러오기 끝 -->

    <section id="ev_banner" class="main4">
        <a href="">
            <img src="${pageContext.request.contextPath}/resources/img/banner_1.jpg" alt="">
        </a>

        <a href="">
            <img src="${pageContext.request.contextPath}/resources/img/banner_2.jpg" alt="">
        </a>
    </section>
    
<!-- 추천영화 시작 -->
<section id="recommend" class="main5 section">
    <div class="inner">
        <div class="main_title_box">
            <h1 class="section_title">추천 영화</h1>
            <div class="movie_more_box">
                <a class="movie_more_btn" href="/getMovieList.do">더 보기</a>
            </div>
        </div>
        <div class="recommend_list_box recommendfreeswiper swiper">
            <ul class="swiper-wrapper" id="swiper-wrapper-stars">
           
            </ul>
        </div>
    </div>
    <script>
        function recommendedMov() {
            $.ajax({
                type: 'POST',
                url: 'recommendedMov.do',
                cache: false,
                async: false,
                success: function(starsInfo) {
                    console.log("starsInfo : ", starsInfo);
                    var sumTotal = 0;
                    for (let i = 0; i < starsInfo.length; i++) {
                        sumTotal += starsInfo[i].total;
                    }
                    if (sumTotal === 0) {
                        sumTotal = 1;
                    }

                    var rMovieBox = document.querySelector("#swiper-wrapper-stars");
                    rMovieBox.innerHTML = '';

                    if (starsInfo.length === 0) {
                        return;
                    } else {
                        var screenPart = (starsInfo.length > 5 ? starsInfo.slice(0, 5) : starsInfo);
                        screenPart.forEach(function(screen) {
                            var movieBox = document.createElement("li");
                            movieBox.classList.add("swiper-slide", "movie_rate_list");

                            var movieA = document.createElement("a");
                            movieA.href = "/getMovie.do?mov_Num=" + screen.mov_Num;

                            var movieImg = document.createElement("img");
                            movieImg.src = "${pageContext.request.contextPath}/resources/img/" + screen.mov_Post;
                            movieImg.alt = screen.mov_Nm;

                            var m_nameDiv = document.createElement("div");
                            m_nameDiv.classList.add("m_name");
                            m_nameDiv.textContent = screen.mov_Nm;

                            var m_genreSpan = document.createElement("span");
                            m_genreSpan.classList.add("m_genre");
                            m_genreSpan.textContent = screen.mov_Con1;

                            var m_rateSpan = document.createElement("span");
                            m_rateSpan.classList.add("m_rate");
                            m_rateSpan.textContent = "예매율 " + Math.round((screen.total / sumTotal) * 1000) / 10 + "%";

                            movieA.appendChild(movieImg);
                            movieA.appendChild(m_nameDiv);
                            movieA.appendChild(m_genreSpan);
                            movieA.appendChild(m_rateSpan);

                            movieBox.appendChild(movieA);
                            rMovieBox.appendChild(movieBox);
                        });
                    }
                },
                error: function(error) {
                    console.log(error);
                }
            });
        }

        (function() {
            recommendedMov();
        })();	
    </script>
</section>
<!-- 추천영화 끝 -->
    

    <section id="etc" class="main6 section">
        <div class="inner">
             <!-- 공지사항 게시판 불러오기 시작 -->
        
            <div class="annoboard_view_box">
		        <div class="annoboard_title">
		            <h1>공지사항</h1>
		        </div>
		        <div class="annoboard_list">
		            <div class="swiper anno_list">
		                <div class="swiper-wrapper" id="annoList">
		                    <!-- 공지사항 목록이 여기에 동적으로 추가될 것입니다. -->
		                </div>
		            </div>
		        </div>
		        <div class="annoboard_more">
		            <a href="/getBoardList.do">더 보기</a>
		        </div>
    		</div>
    <script>
        $(document).ready(function() {
            // 최신 공지사항 4개를 가져오는 함수
            function loadRecentAnnouncements() {
                $.ajax({
                    type: 'GET',
                    url: '/getRecentAnnouncements.do',
                    success: function(response) {
                        displayRecentAnnouncements(response);
                    },
                    error: function(error) {
                        console.log("공지사항 목록 로드 실패:", error);
                    }
                });
            }

            // 가져온 공지사항을 화면에 표시하는 함수
            function displayRecentAnnouncements(announcementList) {
                var annoListBox = $('#annoList');
                annoListBox.empty();

                for (var i = 0; i < Math.min(4, announcementList.length); i++) {  // 최대 4개의 공지사항 표시
                    var announcement = announcementList[i];
                    var slideItem = $('<div class="swiper-slide">');
                    slideItem.append('<a href="getannounBoard.do?bn_num=' + announcement.bn_num + '"><div class="anno_title">' + announcement.bn_title + '</div><div class="anno_date">' + announcement.bn_date + '</div></a>');
                    annoListBox.append(slideItem);
                }
            }

            // 페이지 로드 시 최신 공지사항 4개를 가져옴
            loadRecentAnnouncements();
        });
    </script>

            <div class="ico_btn_box">
                <div class="cs_btn_list_box">
                    <div class="cs_btn_list">
                        <a href="/getBoardList.do">
                            <img src="${pageContext.request.contextPath}/resources/img/cscenter_ico.png" alt="">
                            <p>고객 센터</p>
                        </a>
                    </div>
                    <div class="cs_btn_list">
                        <a href="/getBoardList.do#faq">
                            <img src="${pageContext.request.contextPath}/resources/img/faq_ico.png" alt="">
                            <p>자주 묻는 질문</p>
                        </a>
                    </div>
                    <div class="cs_btn_list">
                        <a href="/getBoardList.do#tou">
                            <img src="${pageContext.request.contextPath}/resources/img/tou_ico.png" alt="">
                            <p>이용 약관</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
        	$(document).ready(function(){
        		var hash = window.location.hash;
        		
        		if(hash {
        			$('.tab-content').removeClass('add');
        			$(hash).addClass('add');
        		})
        	})
        </script>
    </section>
</main>

<script>
	var swiper = new Swiper(".main_v_swiper", {
	    loop: true,
	    spaceBetween: 500,
	    slidesPerView: '1',
	    centeredSlides: true,
	    autoplay: {
	    delay: 2000,
	    disableOnInteraction: false,
	    },
	        breakpoints: {
	
	        525: {
	            slidesPerView: 1,  //브라우저가 525보다 클 때
	            spaceBetween: 50,
	        },
	
	        768: {
	            slidesPerView: 1,  //브라우저가 768보다 클 때
	            spaceBetween: 50,
	        },
	
	        1024: {
	            slidesPerView: 1,  //브라우저가 1024보다 클 때
	            spaceBetween: 50,
	        },
	        
	        1300: {
	            slidesPerView: 2,  //브라우저가 1300보다 클 때
	            spaceBetween: 500,
	        },
	    },
	});
	
	var swiper = new Swiper(".recommendfreeswiper", {
        slidesPerView: 1.7,
        spaceBetween: 30,
        freeMode: true,

        breakpoints: {

            375: {
                slidesPerView: 2,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            525: {
                slidesPerView: 3,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            768: {
                slidesPerView: 5,  //브라우저가 768보다 클 때
                spaceBetween: 30,
                
            },
        },
    });

    var swiper = new Swiper(".sfrfreeswiper", {
        slidesPerView: 1.7,
        spaceBetween: 30,
        freeMode: true,
        breakpoints: {

            375: {
                slidesPerView: 2,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            525: {
                slidesPerView: 3,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            768: {
                slidesPerView: 5,  //브라우저가 768보다 클 때
                spaceBetween: 30,
            },
        },
    });

    var swiper = new Swiper(".nowfreeswiper", {
        slidesPerView: 1.7,
        spaceBetween: 30,
        freeMode: true,

        breakpoints: {

            375: {
                slidesPerView: 2,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            525: {
                slidesPerView: 3,  //브라우저가 525보다 클 때
                spaceBetween: 30,
            },

            768: {
                slidesPerView: 5,  //브라우저가 768보다 클 때
                spaceBetween: 30,
            },
        },
    });

    var swiper = new Swiper(".anno_list", {
        direction: "vertical",
        loop: true,
        autoplay: {
        delay: 3000,
        disableOnInteraction: false,
        },
        pagination: {
            clickable: true,
        },
    });
</script>
<%@include file ="./WEB-INF/sub/footer.jsp"%>
