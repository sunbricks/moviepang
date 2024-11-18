<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>
</head>
<body>



<div class="container-fluid">
  <form action="updateMovie.do" method="post" enctype="multipart/form-data">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
<!--       <input type="hidden" name="mov_Num" value="$!{detail.MOV_NUM}" /> 새로 추가한부분(오류) -->
        <span class="input-group-text">제목</span>
      </div>
      <input type="text" class="form-control" name="mov_Nm" value="${movie.mov_Nm}" required>      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">장르1</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Con1" value="${movie.mov_Con1}" required>      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">장르2</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Con2" value="${movie.mov_Con2}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-preped">
        <span class="input-group-text">장르3</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Con3" value="${movie.mov_Con3}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">개봉일자</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Date" required value="${movie.mov_Date}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">감독</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Pd" required value="${movie.mov_Pd}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">배우</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Act" required value="${movie.mov_Act}" >      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">상영시간</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Rt" required value="${movie.mov_Rt}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">주요언어</span>
      </div>
      <input type="text" class="form-control innm" name="mov_Lang" required value="${movie.mov_Lang}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">더빙(1)/자막(2)</span>
      </div>
<!--       <input type="text" class="form-control innm" name="mov_Sub">       -->
      <select class="form-control innm" name="mov_Sub" required">
      	<option value="1">더빙</option>
      	<option value="2">자막</option>
      </select>    
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">배급국가</span>
      </div>
      <input type="text" class="form-control innm" name="MOV_NATION" value="${movie.mov_Nation}">      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">파일선택</span>
      </div>
      <input type="file" class="form-control innm" name="uploadFile" value="${movie.mov_Post}">      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">내용</span>
      </div>
      <textarea class="form-control" rows="10" id="mov_Detail" name="mov_Detail" >${movie.mov_Detail}</textarea>
      <div class="input-group-prepend">
        <span class="input-group-text">상영등급</span>
      </div>
      <input class="form-control" id="mov_Rate" name="mov_Rate" value="${movie.mov_Rate}"></input>            
    </div>  
    <div id="footer">
	  	<button id="conComplete" type="submit" class="btn btn-primary">수정</button>
<!-- 	  	<a href="/getMovieList.do">글목록</a> -->
	 </div>
  </form>  
</div>
	
</body>
</html>