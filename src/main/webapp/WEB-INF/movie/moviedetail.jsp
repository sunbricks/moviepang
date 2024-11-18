<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../sub/header.jsp"%>


<script>
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

<div id="moviedetail_con">
   <div class="moviedetail_con_box pd_box inner">
      <div class="mov_detail_info_box">
         <div class="mov_detail_top">
            <div class="mov_detail_left">
               <img class="mov_detail_thumnail"
                  src="${pageContext.request.contextPath}/resources/img/${movie.mov_Post}"
                  alt="">
            </div>
            <div class="mov_detail_right">
               <div class="mov_detail_title">${movie.mov_Nm}</div>
               <div class="mov_detail_rate_box">
                  <span class="mov_detail_rate_txt">예매율</span> 
                  <span class="mov_detail_rate">16.5%</span>
               </div>
               <div class="mov_detail_ac_box">
                  <div class="mov_detail_line">
                     <span>감독 : ${movie.mov_Pd} / </span> <span>배우 :
                        ${movie.mov_Act}</span>
                  </div>
                  <div class="mov_detail_line">
                     <span>장르 : ${movie.mov_Con1},${movie.mov_Con2},
                        ${movie.mov_Con3} / </span> <span>기본 정보 : ${movie.mov_Rate}세 이상
                        관람가, ${movie.mov_Rt}분, ${movie.mov_Nation}</span>
                  </div>
                  <div class="mov_detail_line">
                     <span>개봉 :${movie.mov_Date}</span>
                  </div>
               </div>

               <div class="detail_go_book_btn">
                  <a onclick="checkLoginAndRedirect('/getMovieShoot.do?mov_name=${movie.mov_Nm}&mov_Post=${movie.mov_Post}')" style="cursor:pointer;">예매하기</a>
               </div>
            </div>
         </div>
         <div class="mov_detail_bot">
            <div class="mov_detaile_summary">${movie.mov_Detail}</div>
         </div>
      </div>
      <c:choose>
         <c:when test="${mem_id != null}">
            <div class="mov_review_box">
               <form>
<!--                action="insertReview.do" method="post" id="reviewForm" -->
                  <div class="review_txt_box">
                     <textarea class="review_text" rows="2" cols="100"
                        name="review_review" id="review_review"
                        placeholder="영화에 대한 감상평을 남겨주세요"></textarea>
                     <div class="str_cnt">
                        <span>0</span>/100
                     </div>
                  </div>
                  <div class="review_bot_box">
                     <div class="review_point_box">
                        <div class="star-rating">
                           <span class="star">&#9733;</span> <span class="star">&#9733;</span>
                           <span class="star">&#9733;</span> <span class="star">&#9733;</span>
                           <span class="star">&#9733;</span>
                        </div>
                        <input type="text" id="rating-value" name="review_rerate"
                           value="0" readonly>점
                     </div>
                     <input id="mov_Num" name="mov_Num" value="${movie.mov_Num}"
                        type="hidden"> <input name="mov_Nm"
                        value="${movie.mov_Nm}" type="hidden"> <input
                        name="review_nick" value="<%=session.getAttribute("mem_nm")%>"
                        type="hidden"> <input name="review_id"
                        value="<%=session.getAttribute("mem_id")%>" type="hidden">
                     <input name="review_paycheck" value="${review.review_paycheck}"
                        type="hidden">
                     <div class="review_confirm_btn_box">
                        <button type="button" class="review_confirm_btn">등록</button>
                     </div>
                  </div>
               </form>
            </div>
         </c:when>
         <c:otherwise>
            <p class="non_login_alert">
               리뷰를 작성하려면 로그인이 필요합니다. <a href="/loginpage.do">로그인</a>
            </p>
         </c:otherwise>
      </c:choose>
      <div class="user_review_box">
      <!-- 값 출력하기 -->
            <ul id="review-list">
            <c:forEach var="review" items="${reviews}" >
               <li class="review-item">
                  <div class="review_real_box">
                     <div class="user_review_info_left">
                        <span class="user_name">${review.review_nick}</span> <input
                           type="text" name="review_rerate"
                           value="${review.review_rerate}" readonly>
                        <div class="write_date">${review.review_date}</div>
                     </div>
                     <div class="user_review_info_right">
                        <div class="user_review_txt">${review.review_review}</div>
                     </div>
                  </div> 

                  <c:if test="${review.review_id eq sessionScope.mem_id}">
                     <div class="review_del_box">
                        <a href="" class="delete_btn"><img src="${pageContext.request.contextPath}/resources/img/cancle_ico.png" alt=""></a>
                     </div>
                  </c:if>
               </li>
               
            </c:forEach>
         </ul>
           <div class="pagination mov_detail_paging">
            <button id="prev-page" style="display: none;">이전</button>
            <button id="next-page" style="display: none;">다음</button>
         </div>
      </div>
   </div>
</div>
   
<script>
//Function to mask middle character with '*'
function maskMiddleCharacter(str) {
    // Check if the string length is odd
    if (str.length % 2 !== 0) {
        // Calculate the index of the middle character
        const middleIndex = Math.floor(str.length / 2);
        // Replace the middle character with '*'
        return str.substring(0, middleIndex) + '*' + str.substring(middleIndex + 1);
    } else {
        // If the string length is even, mask the two middle characters
        const middleIndex = str.length / 2;
        return str.substring(0, middleIndex - 1) + '**' + str.substring(middleIndex + 1);
    }
}

$(document).ready(function() {
    // Iterate through each review item to mask the middle character of review_nick
    $('.review-item .user_name').each(function() {
        const originalName = $(this).text();
        const maskedName = maskMiddleCharacter(originalName);
        $(this).text(maskedName);
    });
});

//별점 시스템 로직
$(document).ready(function() {
    let selectedRating = 0;

    $('.star').on('click', function() {
        selectedRating = $(this).index() + 1;
        // input 태그의 value를 업데이트합니다.
        $('#rating-value').val(selectedRating);
        // '평가: x점' 형태의 문자열을 표시하는 부분을 업데이트합니다.
        $('#rating-value').next().text('평가: ' + selectedRating + '점');
        updateStars(selectedRating);
    });

    function updateStars(rating) {
        $('.star').each(function(index) {
        if (index < rating) {
            $(this).addClass('selected');
        } else {
            $(this).removeClass('selected');
        }
        });
    }
});

$(document).ready(function() {   
   // Function to show the specified page
    function showPage(page) {
        const reviews = $('.review-item');
        const totalPages = Math.ceil(reviews.length / reviewsPerPage);

        reviews.hide();
        reviews.slice((page - 1) * reviewsPerPage, page * reviewsPerPage).show();

        // Hide or show prev/next buttons
        $('#prev-page').toggle(page > 1);
        $('#next-page').toggle(page < totalPages);

        // Generate page numbers
        generatePageNumbers(page, totalPages);
    }

 // Function to generate page numbers
    function generatePageNumbers(currentPage, totalPages) {
        const pagination = $('.pagination');
        pagination.empty();

        // Add previous button
        if (currentPage > 1) {
            pagination.append('<button class="page-number" data-page="' + (currentPage - 1) + '">이전</button>');
        }

        // Calculate start and end page numbers for the current group
        let startPage = Math.max(1, currentPage - 1);
        let endPage = Math.min(totalPages, startPage + 2);

        // Add page numbers
        for (let i = startPage; i <= endPage; i++) {
            pagination.append('<button class="page-number ' + (currentPage === i ? 'current-page' : '') + '" data-page="' + i + '">' + i + '</button>');
        }

        // Add next button
        if (currentPage < totalPages) {
            pagination.append('<button class="page-number" data-page="' + (currentPage + 1) + '">다음</button>');
        }
    }


    // Event listener for page number buttons
    $(document).on('click', '.page-number', function() {
        const page = parseInt($(this).attr('data-page'));
        showPage(page);
    });

    const reviewsPerPage = 5;
    let currentPage = 1;

    // Initial pagination
    showPage(currentPage);
});

$(document).ready(function() {
   $('.review_confirm_btn').click(function() {
        var reviewName = $('input[name="mov_Nm"]').val();
        var reviewNick = $('input[name="review_nick"]').val();
        var reviewId = $('input[name="review_id"]').val();
        var movNum = $('input[name="mov_Num"]').val(); 
        var reviewRerate = $('input[name="review_rerate"]').val(); 
        var reviewReview = $('textarea[name="review_review"]').val(); 
        
        console.log("reviewName " + reviewName);
        console.log("reviewNick " + reviewNick);
        console.log("reviewId " + reviewId);
        console.log("reviewRerate " + reviewRerate);

        $.ajax({
            data: {
                review_name: reviewName,
               review_nick:reviewNick,
                review_id: reviewId,
                review_rerate: reviewRerate,
                review_review: reviewReview,
                mov_Num : movNum
            },
            url: '/insertReview.do',
            type: 'POST',
            success: function(result) {
               console.log("result " + result);
               
                if(result == 1) {
                    alert("이미 등록된 리뷰가 존재합니다");
                }else if(result == 2){
                    alert("결제한 영화만 리뷰 작성이 가능합니다");
                }else{
                     location.reload(); 
                    alert("성공");
                }
//                 alert("등록되었습니다.");
            },
            error: function(error) {
                alert("에러가 발생했습니다.");
                console.log(error); 
            }
        });
    });

    $('.delete_btn').click(function() {
        var confirmDelete = confirm("정말 삭제하시겠습니까?");
        if (confirmDelete) {
            var review_name = $('input[name="mov_Nm"]').val(); 
            var review_id = $('input[name="review_id"]').val();
            var movNum = $('input[name="mov_Num"]').val(); 
            $.ajax({
                type: 'POST', 
                url: '/delReview.do', 
                data: {
                   review_name: review_name,
                   review_id: review_id,
                   mov_Num: movNum 
                   }, 
                cache: false,
                async: false,
                success: function(data) {
                    alert("삭제되었습니다.");
                    location.reload(); 
                },
                error: function(error) {
                    alert("리뷰 삭제 중 오류가 발생했습니다.");
                    console.log(error); 
                }
            });
        }
    });
    
    
});
</script>

<%@ include file="../sub/footer.jsp"%>