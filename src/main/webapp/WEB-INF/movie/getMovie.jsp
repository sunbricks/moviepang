<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../sub/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String sts = "";
String currentUserNick = (String) session.getAttribute("mem_id");
if (session.getAttribute("mem_id") == null) {
	sts = "disabled";
}
%>

<body>
	<div class="jumbotron">
		<h1>상세 보기</h1>
	</div>
	<form action="insertReview.do" method="post" id="reviewForm">
		<input type="hidden" name="mov_Num" value="${movie.mov_Num}">
		<table class="table">
			<tr>
				<th>상영제목</th>
				<td><input type="text" name="mov_Nm" value="${movie.mov_Nm}"
					readonly></td>
			</tr>
			<tr>
				<th>장르</th>
				<td><input type="text" class="form-control innm"
					name="mov_Con1" value="${movie.mov_Con1}" readonly></td>
			</tr>
			<tr>
				<th>개봉일</th>
				<td><input type="text" class="form-control innm"
					name="mov_Date" value="${movie.mov_Date}" readonly></td>
			</tr>
			<tr>
				<th>감독</th>
				<td><input type="text" class="form-control innm" name="mov_Pd"
					value="${movie.mov_Pd}" readonly></td>
			</tr>
			<tr>
				<th>배우</th>
				<td><input type="text" class="form-control innm" name="mov_Act"
					value="${movie.mov_Act}" readonly></td>
			</tr>
			<tr>
				<th>상영시간</th>
				<td><input type="text" class="form-control innm" name="mov_Rt"
					value="${movie.mov_Rt}" readonly></td>
			</tr>
			<tr>
				<th>주요언어</th>
				<td><input type="text" class="form-control innm"
					name="mov_Lang" value="${movie.mov_Lang}" readonly></td>
			</tr>
			<tr>
				<th>국가</th>
				<td><input type="text" class="form-control innm"
					name="mov_Nation" value="${movie.mov_Nation}" readonly></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea class="form-control innm" rows="10"
						id="mov_Detail" name="mov_Detail" readonly>${movie.mov_Detail}</textarea></td>
			</tr>
			<tr>
				<th>상영등급</th>
				<td><input class="form-control innm" id="mov_Rate"
					name="mov_Rate" value="${movie.mov_Rate}" readonly></td>
			</tr>
		</table>

		<c:choose>
			<c:when test="${mem_id != null}">
				<input type="hidden" name="mov_Num" value="${movie.mov_Num}">
				<div>
					<textarea name="review_review" placeholder="리뷰를 작성해주세요 (최대 100자)"></textarea>
					<select name="review_rerate" id="review_rerate" required>
						<option value="1">1</option>
						<option value="1.5">1.5</option>
						<option value="2">2</option>
						<option value="2.5">2.5</option>
						<option value="3">3</option>
						<option value="3.5">3.5</option>
						<option value="4">4</option>
						<option value="4.5">4.5</option>
						<option value="5">5</option>
					</select> <input name="review_name" value="${movie.mov_Nm}" type="hidden">
					<input name="review_nick" value="<%=sts%>" type="hidden"> <input
						name="review_paycheck" value="${review.review_paycheck}"
						type="hidden">
					<button type="submit" class="submitBtn">입력</button>
				</div>
			</c:when>
			<c:otherwise>
				<p>
					리뷰를 작성하려면 로그인이 필요합니다. <a href="/loginpage.do">로그인</a>
				</p>
			</c:otherwise>
		</c:choose>
	</form>
	<!-- 리뷰 글 모음 -->
    <table class="reviewTable">
        <c:forEach var="review" items="${reviews}">
            <tr>
                <td>${review.review_nick}</td>
                <td>${review.review_date}</td>
            </tr>
            <tr>
                <th>리뷰</th>
                <td>${review.review_review}</td>
                <th>평점</th>
                <td>${review.review_rerate}</td>
                <%= name %>
                <td>
                    <c:if test="${review.reviewid == session.getAttribute('mem_nm')}">
                            <button type="button" class="delete_btn btn btn-danger">삭제</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>

    <script>
    $(document).ready(function() {
        $('.submitBtn').click(function() {
            var reviewName = $('input[name="review_name"]').val();
            var reviewNick = $('input[name="review_nick"]').val();
            var movNum = $('input[name="mov_Num"]').val(); // mov_Num을 String으로 처리
            $.ajax({
                data: {
                    review_name: reviewName,
                    review_nick: reviewNick,
                    mov_Num: movNum // mov_Num을 추가
                },
                url: '/checkReview.do',
                type: 'POST',
                success: function(result) {
                    if(result === '1') {
                        alert("이미 등록된 리뷰가 존재합니다.");
                    } else if(result === '0') {
                        $('#reviewForm')[0].submit(); // 리뷰 폼을 다시 제출
                    }
                },
                error: function(error) {
                    alert("리뷰 등록 중 오류가 발생했습니다.");
                    console.log(error); // 오류 로그 출력
                }
            });
        });

        $('.delete_btn').click(function() {
            var confirmDelete = confirm("정말 삭제하시겠습니까?");
            if (confirmDelete) {
                var review_nick = $(this).siblings('input[name="review_nick"]').val();
                var review_name = $(this).siblings('input[name="review_name"]').val();
                $.ajax({
                    type: 'POST', // 또는 'DELETE' 메서드 사용 가능
                    url: 'delReview.do', // 리뷰 삭제를 처리하는 서버의 엔드포인트 URL
                    data: { review_nick: review_nick, review_name: review_name }, // 삭제할 리뷰의 ID를 서버에 전달
                    cache : false,
                    async : false,
                    success: function(data) {
                        // 삭제에 성공한 경우
                        alert("삭제되었습니다.");
                        location.reload(); // 삭제 후 페이지 새로고침
                    },
                    error: function(error) {
                        // 삭제에 실패한 경우
                        alert("리뷰 삭제 중 오류가 발생했습니다.");
                        console.log(error); // 오류 로그 출력
                    }
                });
            }
        });
    });
</script>
    
    <script>
//         $(document).ready(function() {
//             $('.delete_btn').click(function() {
//                 var confirmDelete = confirm("정말 삭제하시겠습니까?");
//                 if (confirmDelete) {
//                     $.ajax({
//                         type: 'POST', // 또는 'DELETE' 메서드 사용 가능
//                         url: 'delReview.do', // 리뷰 삭제를 처리하는 서버의 엔드포인트 URL
//                         data: { review_nick: reviewNick, review_name: reviewName }, // 삭제할 리뷰의 ID를 서버에 전달
//                         success: function(data) {
//                             alert("삭제되었습니다.");
//                             location.reload(); // 삭제 후 페이지 새로고침
//                         },
//                         error: function(error) {
//                             alert("리뷰 삭제 중 오류가 발생했습니다.");
//                             console.log(error); // 오류 로그 출력
//                         }
//                     });
//                 }
//             });

//             $('#reviewForm').submit(function(event) {
//                 event.preventDefault(); // 폼 기본 제출을 방지
//                 var reviewName = $('input[name="review_name"]').val();
//                 var reviewNick = $('input[name="review_nick"]').val();
//                 var movNum = $('input[name="mov_Num"]').val(); // mov_Num을 String으로 처리
//                 $.ajax({
//                     data: {
//                         review_name: reviewName,
//                         review_nick: reviewNick
//                     },
//                     url: '/checkReview.do',
//                     type: 'POST',
//                     success: function(result) {
//                         if(result === '1') {
//                             alert("이미 등록된 리뷰가 존재합니다.");
//                         } else if(result === '0') {
//                             $('#reviewForm')[0].submit(); // 리뷰 폼을 다시 제출
//                         }
//                     }
//                 });
//             });
//         });
    </script>
</body>
