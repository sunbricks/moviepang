<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../sub/header.jsp"%>
<div id="movielist_con">
   <div class="movielist_con pd_box inner">
      <div class="movie_list_top_box">
         <h1 class="movielist_title">무비 리스트</h1>
         <ul class="movie_list_tabs">
            <li class="tab-link on" data-tab="nit">상영중</li>
            <li class="tab-link" data-tab="stbs">상영예정</li>
         </ul>
      </div>
      <div id="nit" class="movie_list_content on">
         <div class="moviepage_list_box">
            <ul id="movie_list">
<%--                <c:forEach items="${MovieList}" var="movie" varStatus="status"> --%>
<%--                   <li onclick="selMov('${movie.mov_Num}')" style="cursor: pointer;"> --%>
<%--                      <img class="movie_thumbnail" src="${pageContext.request.contextPath}/resources/img/${movie.mov_Post}"> --%>
<%--                      <div style="display: none;">${movie.mov_Num}</div> --%>
<%--                      <div class="m_name">${movie.mov_Nm}</div> --%>
<%--                      <span class="m_genre">${movie.mov_Con1}</span> --%>
<!--                      <button class="go_book_btn">상세보기</button> -->
<!--                   </li> -->
<%--                </c:forEach> --%>
            </ul>
         </div>
      </div>
      <div id="stbs" class="movie_list_content">
         <div class="moviepage_list_box">
            <ul id="movie_list1">
<%--                <c:forEach items="${MovieList}" var="movie" varStatus="status"> --%>
<%--                   <li onclick="selMov('${movie.mov_Num}')" style="cursor: pointer;"> --%>
<%--                      <img class="movie_thumbnail" src="${pageContext.request.contextPath}/resources/img/${movie.mov_Post}"> --%>
<%--                      <div style="display: none;">${movie.mov_Num}</div> --%>
<%--                      <div class="m_name">${movie.mov_Nm}</div> --%>
<%--                      <span class="m_genre">${movie.mov_Con1}</span> --%>
<!--                      <button class="go_book_btn">상세보기</button> -->
<!--                   </li> -->
<%--                </c:forEach> --%>
            </ul>
         </div>
      </div>
   </div>
</div>

<script>
   function selMov(val) {
      location.href = "getMovie.do?mov_Num=" + val;
   }
   
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
            
                var nowScreenBox = document.querySelector("#movie_list");
                nowScreenBox.innerHTML = ''; // 기존 내용을 초기화
                
                if (screenInfo.length === 0) {
                    return ;
                } else {
                    screenInfo.forEach(function(screen) {
                    
                        console.log("현재 상영작");
                        console.log("screen",screen);
                        console.log("screen.mov_Nm ",screen.mov_Nm);
                    
                        var movieBox = document.createElement("li");
//                         movieBox.classList.add("swiper-slide");
                        movieBox.classList.add("movie_rate_list");
//                         console.log("screen.mov_Num " + screen.mov_Num);
                        
                        var movieA = document.createElement("a");
                        movieA.href = "getMovie.do?mov_Num=" + screen.mov_Num;                                     
                        
                        var movieImg = document.createElement("img");
                        movieImg.classList.add("movie_thumbnail");
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
                        
                        var m_ratebutton = document.createElement("button");
                        m_ratebutton.classList.add("go_book_btn");
                        m_ratebutton.textContent = "상세보기";
                        
                        movieA.appendChild(movieImg);
                        movieA.appendChild(m_nameDiv);
                        movieA.appendChild(m_genreSpan);
                        movieA.appendChild(m_rateSpan);
                        movieA.appendChild(m_ratebutton);
                        
                    
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
            
                var willScreenBox = document.querySelector("#movie_list1");
                willScreenBox.innerHTML = ''; // 기존 내용을 초기화
                
                if (screenInfo.length === 0) {
                    return ;
                } else {
                    screenInfo.forEach(function(screen) {
                    
                        var movieBox = document.createElement("li");
//                         movieBox.classList.add("swiper-slide");
                        movieBox.classList.add("movie_rate_list");
                        
                        var movieA = document.createElement("a");
                        movieA.href = "";
                        
                        var movieImg = document.createElement("img");
                        movieImg.classList.add("movie_thumbnail");
                        movieImg.src = "${pageContext.request.contextPath}/resources/img/" + screen.mov_Post;
                        movieImg.alt = screen.mov_Nm;
                        
                        var m_nameDiv = document.createElement("div");
                        m_nameDiv.classList.add("m_name");
                        m_nameDiv.textContent = screen.mov_Nm;
                        
                        var m_openSpan = document.createElement("span");
                        m_openSpan.classList.add("m_op_day");
                        m_openSpan.textContent = "개봉일 "+screen.mov_Date;
                     
                        const screenDate = new Date(screen.mov_Date);
                        const currentDate = new Date();
                        const timeDiff = screenDate.getTime() - currentDate.getTime();
                        const dayDiff = timeDiff / (1000*3600*24);
                        
                        var m_op_dateSpan = document.createElement("span");
                        m_op_dateSpan.classList.add("m_op_date");
                        m_op_dateSpan.textContent = "D-" + Math.ceil(dayDiff);
                        
                        
                        var m_ratebutton = document.createElement("button");
                        m_ratebutton.classList.add("go_book_btn");
                        m_ratebutton.textContent = "상세보기";
                        
                        
                        movieA.appendChild(movieImg);
                        movieA.appendChild(m_nameDiv);
                        movieA.appendChild(m_openSpan);
                        movieA.appendChild(m_op_dateSpan);
                        movieA.appendChild(m_ratebutton);

                        
                    
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
<%@include file="../sub/footer.jsp"%>