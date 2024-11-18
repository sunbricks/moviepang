<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
    
    <meta content="yes" name="apple-mobile-web-app-capable" />  
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=no" name="viewport" />
    <title>Movie Pang</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/evboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.png">

    <script defer src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script defer src="${pageContext.request.contextPath}/resources/js/book.js"></script>
    <script defer src="${pageContext.request.contextPath}/resources/js/sub.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
function kakaoLogin() {
   location.href ='/getAuthUrl.do';
}

function kakaoLogout(){
   location.href ="/kakaoLogout.do";
   let ifr = document.createElement("iframe");
   ifr.setAttribute("src","https://accounts.kakao.com/logout?continue=https://accounts.kakao.com/weblogin/account");
   ifr.setAttribute("style","display:none");
   document.body.appendChild(ifr);   
}

function checkLoginAndRedirect(url) {
    var isLoggedIn = '<%= (session.getAttribute("mem_id") != null) ? "true" : "false" %>';
    if (isLoggedIn === "false") {
        alert("로그인이 필요한 페이지입니다.");
        window.location.href = "${pageContext.request.contextPath}/loginpage.do";
    } else {
        window.location.href = url;
    }
}
</script>
</head>
<body>
<header id="header">
    <div class="h_in">
        <div class="pc_header">
            <div class="h_top">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="무비팡 로고 이미지">
                </a>
                
                <div class="sub_menu">
                    <div>
                        <%
            String name = (String) session.getAttribute("mem_nm");
            String id = (String) session.getAttribute("mem_id");
            String status = (String) session.getAttribute("mem_st");
            String tel = (String) session.getAttribute("mem_tel");
            String loginType =(String) session.getAttribute("loginType");
            
//             String세션으로 가져오는 mp를 int형으로 바꿔주는데 null로 가져오면 0으로바꿔라
			            int mp = session.getAttribute("mem_mp") != null ? Integer.parseInt(session.getAttribute("mem_mp").toString()) : 0;
			            %>
			            <%
			            if (status == null) {
			            %>
			               <span>
			                 <a href="/loginpage.do">
			                    로그인/회원가입
			                 </a>
			               </span>
			            <%
			            } else if (status.equals("ACTIVE")) {
			            %>
			               <span style= "margin-right: 15px;">
			                  <a href="/getCartList.do">
			                     장바구니
			                  </a>
			               </span>
			               <span style= "margin-right: 15px;">
			                  <a href="/mypage.do">
			                     <%=name%>님 마이페이지 바로가기
			                  </a>
			               </span>
			               
			            <%
			            if (loginType.equals("kakao")) {
			            %>
			               <span>
			                  <a href="javascript: kakaoLogout()" id="logout" class='logout'>
			                     카카오 로그아웃
			                  </a>
			               </span>
			             <%
			            } else if(loginType.equals("naver")){%>
			            	<span>
			                  <a href="javascript: naverLogout();" id="logout" class='logout'>
			                     네이버 로그아웃
			                  </a>
			               </span>
			               <script>
			               let windowPopUP ;
			               	function naverLogout(){
			               		windowPopUP = window.open('https://nid.naver.com/nidlogin.logout?returl=https://www.naver.com/', 'naverLogout', '_blank');
			               		
			               		$.ajax({
			               			url : "/naverlogout.do",
			               			type : "GET",
			               			async : false,
			               			success : function(res){
			               				console.log("성공");
			               			    winClose();
			               			},
			               			error : function(err){
			               				console.log('에러메세지 : ', err);
			               			}
			               		});
			               		
			               	}
			               	
			               	function winClose(){
			               		windowPopUP.close();
			               		location.href = window.location.href;
			               	}
			               </script>
			            	
			           <% }else {
			            %>
			               <span>
			                  <a href="/logout.do" id="logout" class='logout'>
			                     로그아웃
			                  </a>
			               </span>
			            <%
			            }
			            %>
			            <%
			            } else {
			            %>
			            <a href="/loginpage.do">
			               <span>
			                  로그인/회원가입
			               </span>
			            </a>
			            <%
			            }
			            %>
                        
                    </div>
                </div>
            </div>
            <hr>
            <div class="h_bot">
                <ul class="main_menu">
                    <li>
                        <a href="/getMovieList.do">영화</a>
                    </li>
                    <li>
                        <a href="javascript:void(0);" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/bookmainpage.do');">예매</a>
                    </li>
                    <li>
                        <a href="/getEv_boardList.do">이벤트</a>
                    </li>
                    <li>
                        <a href="/getPrdList.do">스토어</a>
                    </li>
                    <li>
                        <a href="/getBoardList.do">고객센터</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="mo_header">
            <div class="mo_header_box">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="무비팡 로고 이미지">
                </a>
                
                <div class="burger_menu">
                    <input class="burger-check" type="checkbox" id="burger-check" />
                    <label class="burger-icon" for="burger-check">
                        <span class="burger-sticks"></span>
                    </label>

                    <div class="menu">
                        <nav>
                            <ul class="nav-menu-mo">
                                 <li class="nav-menu-btn-mo">
	                                 <a href="/getMovieList.do">영화</a>
	                             </li>
	                             <li class="nav-menu-btn-mo">
	                                 <a href="javascript:void(0);" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/bookmainpage.do');">예매</a>
	                             </li>
	                             <li class="nav-menu-btn-mo">
	                                 <a href="/getEv_boardList.do">이벤트</a>
	                             </li>
	                             <li class="nav-menu-btn-mo">
	                                 <a href="/getPrdList.do">스토어</a>
	                             </li>
	                             <li class="nav-menu-btn-mo">
	                                 <a href="/getBoardList.do">고객센터</a>
	                             </li>
                            </ul>
                        </nav>
                        <div class="login">
                            <%
							 name = (String) session.getAttribute("mem_nm");
							 id = (String) session.getAttribute("mem_id");
							 status = (String) session.getAttribute("mem_st");
							 tel = (String) session.getAttribute("mem_tel");
							 loginType =(String) session.getAttribute("loginType");
            
//             String세션으로 가져오는 mp를 int형으로 바꿔주는데 null로 가져오면 0으로바꿔라
			            mp = session.getAttribute("mem_mp") != null ? Integer.parseInt(session.getAttribute("mem_mp").toString()) : 0;
			            %>
			            <%
			            if (status == null) {
			            %>
			               <span>
			                 <a href="/loginpage.do">
			                    로그인/회원가입
			                 </a>
			               </span>
			            <%
			            } else if (status.equals("ACTIVE")) {
			            %>
			               <span style= "margin-right: 0px; display: block; margin-bottom: 15px;">
			                  <a href="/getCartList.do">
			                     장바구니
			                  </a>
			               </span>
			               <span style= "margin-right: 0px; display: block; margin-bottom: 15px;">
			                  <a href="/mypage.do">
			                     <%=name%>님 마이페이지 바로가기
			                  </a>
			               </span>
			               
			            <%
			            if (loginType.equals("kakao")) {
			            %>
			               <span>
			                  <a href="javascript: kakaoLogout()" id="logout" class='logout'>
			                     카카오 로그아웃
			                  </a>
			               </span>
			            <%
			            } else {
			            %>
			               <span>
			                  <a href="/logout.do" id="logout" class='logout'>
			                     로그아웃
			                  </a>
			               </span>
			            <%
			            }
			            %>
			            <%
			            } else {
			            %>
			            <a href="/loginpage.do">
			               <span>
			                  로그인/회원가입
			               </span>
			            </a>
			            <%
			            }
			            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>