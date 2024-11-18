<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>

<!-- 이메일 인증 스크립트 -->
<script>
var timer;
var isRunning = false;
var code;
var emailSent = false; // 이메일 전송 여부를 추적하는 변수

function mailCheckBtn() {
    $('#mail-Check-Btn').click(function() {
        let email = $('#userEmail1').val()
        console.log('완성된 이메일 : ' + email);
        let checkInput = $('.mail-check-input');
      
        if (!email.trim()) {
            alert('이메일을 입력해주세요.');
            return;
        }
        
        // 이미 이메일이 전송되었는지 확인
        if (emailSent) {
            alert('이미 이메일이 전송되었습니다. 인증번호를 확인해주세요.');
            return; // 함수 종료하여 이메일을 여러 번 보내는 것을 방지
        }

        $.ajax({
            type: 'get',
            url: "mailCheck.do?email=" + email,
            success: function(data) {
                console.log("data : " + data);
                checkInput.prop('disabled', false);
                code = data;
                alert('인증번호가 전송되었습니다.');
                sendAuthNum(); // 인증번호 발송 및 타이머 시작 함수 호출
                emailSent = true; // 이메일 전송 상태 업데이트
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });
}

//인증번호 발송하고 타이머 함수 실행
function sendAuthNum(){
       // 남은 시간
   var leftSec = 180,
   display = document.querySelector('#timer');
   // 이미 타이머가 작동중이면 중지
   if (isRunning){
      clearInterval(timer);
   } else {
       isRunning = true;
    }
     startTimer(leftSec, display);}

function startTimer(count, display) {
    var minutes, seconds;
    timer = setInterval(function () {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        // 타이머 끝
        if (--count < 0) {
            clearInterval(timer);
            display.textContent = "";
            isRunning = false;
            code = null; // 발급받은 코드를 null로 설정
            emailSent = false; // 이메일 전송 상태 초기화
        }
    }, 1000);
}

function compareCode() {
    $('.mail-check-input').blur(function() {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-check-warn');

        if (code === null) { // 인증 시간이 만료되었는지 확인
            $resultMsg.html('*인증 시간이 만료되었습니다. 다시 인증해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

            return; // 함수 종료
        }

        if (inputCode === code) {
            $resultMsg.html('*인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $resultMsg.css('display', 'inline');

            $('#mail-Check-Btn').attr('disabled', true);
            $('#userEamil1').attr('readonly', true);
            $('#userEamil2').attr('readonly', true);
            $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
            clearTimeout(timer); // 타이머 초기화
            $('#timer').hide();
            $('.mail-check-input').attr('readonly', true);

        } else {
            $resultMsg.html('*인증번호가 불일치 합니다. 다시 확인해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');
        }
    });
}

$(document).ready(function() {
    mailCheckBtn();
    compareCode();
});

</script>

<!-- 아이디 중복 스크립트 -->
<script>
var idCheckPassed = false;

$(function(){

    $("#idchkbtn").click(function(){
    
        let mem_id = $("#mem_id").val();
        let pattern= /^[A-za-z0-9]{6,20}$/;
         
        $.ajax({
            type:'post', //post 형식으로 controller 에 보내기위함!!
            url:"/checkId.do", // 컨트롤러로 가는 mapping 입력
            data: {"mem_id":mem_id}, // 원하는 값을 중복확인하기위해서  JSON 형태로 DATA 전송
            success: function(data){ 
                if(data == "N"){ // 만약 성공할시
                   if(pattern.test(mem_id) == true ){
//                    alert("사용가능한 아이디입니다.");
                    result = "사용 가능한 아이디입니다.";
                    $("#result_checkId").html(result);
                    $("#result_checkId").css("color", "green");
                    $("#result_checkId").css("display", "inline");
                    idCheckPassed = true; // idCheckPassed를 true로 설정
//                     $('#mem_id').attr('readonly', true);
                    console.log("idCheckPassed" + idCheckPassed);



                }else{
                   result = "*형식이 맞지 않는 아이디입니다.";
                    $("#result_checkId").html(result);
                    $("#result_checkId").css("color", "red");
                    idCheckPassed = false; // idCheckPassed를 false로 설정

}                   
                
                 
             }else if(data == "Y"){ // 만약 실패할시
//                    alert("사용 불가능한 아이디입니다.");
                 result="이미 사용중인 아이디입니다.";
                     $("#result_checkId").html(result).css("color","red");
                     $("#mem_id").val("").trigger("focus");
             }
                 
         },
         error: function(xhr, status, error) {
               alert("에러 발생: " + error);
           }
        });
        
    });
    
});
</script>

<!-- 핸드폰 인증 스크립트 -->
<script>
// 인증번호 요청 함수
var timer;
var isRunning = false;
var code;
var telSent = false; // 문자 전송 여부를 추적하는 변수

function telCheckBtn() {
    $('#tel-Check-Btn').click(function() {
        let tel = $('#userTel1').val()
        console.log('입력 전화번호 : ' + tel);
        let checkInput = $('.tel-check-input');

        // 이미  문자가 전송되었는지 확인
        if (telSent) {
            alert('이미 문자가 전송되었습니다. 인증번호를 확인해주세요.');
            return; // 함수 종료하여 문자를 여러 번 보내는 것을 방지
        }

        $.ajax({
            url: "telCheck.do?tel=" + tel,
            type: 'GET',
            data: { tel: $('#userTel1').val() }, // 폰 번호 데이터 전송
            success: function(code1) {
                checkInput.prop('disabled', false);
                code = code1;
                alert('인증번호가 전송되었습니다.');
                sendAuthNum1(); // 인증번호 발송 및 타이머 시작 함수 호출
                telSent = true; // 문자 전송 상태 업데이트
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
                checkInput.prop('disabled', false);

      telSent = true;
      sendAuthNum1();
    });
}

//인증번호 발송하고 타이머 함수 실행
function sendAuthNum1(){
       // 남은 시간
   var leftSec = 180,
   display = document.querySelector('#timer1');
   // 이미 타이머가 작동중이면 중지
   if (isRunning){
      clearInterval(timer);
   } else {
       isRunning = true;
    }
     startTimer1(leftSec, display);}

function startTimer1(count, display) {
    var minutes, seconds;
    timer1 = setInterval(function () {
        minutes = parseInt(count / 60, 10);
        seconds = parseInt(count % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        // 타이머 끝
        if (--count < 0) {
            clearInterval(timer);
            display.textContent = "";
            isRunning = false;
            code = null; // 발급받은 코드를 null로 설정
            telSent = false; // 이메일 전송 상태 초기화
        }
    }, 1000);
}

function compareCode1() {
    $('.tel-check-input').blur(function() {
        const inputCode = $(this).val();
        const $resultMsg = $('#tel-check-warn');
        console.log(inputCode);
        console.log(code);

        if (code === null) { // 인증 시간이 만료되었는지 확인
            $resultMsg.html('*인증 시간이 만료되었습니다. 다시 인증해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

            return; // 함수 종료
        }

        if (inputCode === code) {
            $resultMsg.html('*인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $resultMsg.css('display', 'inline');

            $('#userTel1').attr('readonly', true);
            $('#userTel2').attr('readonly', true);
            $('#userTel2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userTel2').attr('onChange', 'this.selectedIndex = this.initialSelect');
            clearTimeout(timer); // 타이머 초기화
            $('#timer1').hide();
            $('.tel-check-input').attr('readonly', true);
        } else {
            $resultMsg.html('*인증번호가 불일치 합니다. 다시 확인해주세요.');
            $resultMsg.css('color', 'red');
            $resultMsg.css('display', 'inline');

        }
    });
}

$(document).ready(function() {
    telCheckBtn();
    compareCode1();
});

    </script>
    
<!--     유효성 검사 -->
    <script>
    
  //유효성 검사 통과 유무 변수
    var idCheck = false;
    var pwCheck = false;            // 비번
    var pwckCheck = false;          // 비번 확인
    var nameCheck = false;          // 이름
    var birCheck = false;          // 생년월일
    var genCheck = false;          // 성별
    var telCheck = false;       // 전화번호
    var mailCheck = false;          // 이메일
    


    $(document).ready(function(){
           $("#idchkbtn, #tel-Check-Btn, #mail-Check-Btn").click(function(event) {
               event.preventDefault();
           });
       $(".btn2").click(function(){
          
            // 중복 확인 및 인증 요청 버튼 클릭 시 폼이 자동으로 제출되는 기능을 비활성화
          
           // 폼 제출 이벤트 리스너
            $("form.mem_joinform").submit(function(event) {
                   // 폼 제출 기본 동작 막기
                   event.preventDefault();
                   
                       
                   // 모든 유효성 검사 통과 여부 확인
                   if (idCheck && pwCheck && pwckCheck && nameCheck && birCheck && genCheck && telCheck && mailCheck && idCheckPassed) {
                       // 모든 필드가 유효하면 폼 제출
                       console.log("모든필드 유효")
                       this.submit();
                   } else {
                      
                      console.log("id" + idCheck)
                      console.log("pw" + pwCheck)
                      console.log("pwck" + pwckCheck)
                      console.log("name" + nameCheck)
                      console.log("bir" + birCheck)
                      console.log("gen" + genCheck)
                      console.log("tel" + telCheck)
                      console.log("mail" + mailCheck)
                      console.log("idCheckPassed" + idCheckPassed)
                       // 유효하지 않은 필드가 있을 경우 알림
                       alert(" 입력을 하지 않은 곳이 있는 지 다시 확인해주세요.");
                   }
               });
          
          /* 입력값 변수 */
          var id = $('#mem_id').val();            // id입력란
          var pw = $('#mem_pwd').val();            // 비밀번호 입력란
          var pwck = $('#mem_pwd1').val();         // 비밀번호 확인 입력란
          var name = $('#mem_nm').val();         // 이름 입력란
          var bir = $('#mem_bir').val();      // 생년월일 입력란
          var tel = $('#userTel1').val();         //전화번호 입력란
          var mail = $('#userEmail1').val();         // 이메일 입력란
          
          var gen1 = document.getElementById("gender_m");
           var gen2 = document.getElementById("gender_g");
           

          
          /* 아이디 유효성 검사 */
          if (id == "") {
                $('#result_checkId').css('display','inline');
             $('#result_checkId').css('color', 'red');
             $('#result_checkId').html("아이디를 입력해주세요");
             idCheck = false;
          } else if(idCheckPassed == false){
             $('#result_checkId').css('color', 'red');
                $('#result_checkId').css('display','inline');
             $('#result_checkId').html("*중복 검사를 해주세요");
             idCheck = false;
          } else {
             $('#result_checkId').css('color', 'green');
             $('#result_checkId').html("체크 완료");
             idCheck = true;
          }
          
          /* 비밀번호 유효성 검사 */
          if (pw.trim() == "") {
             $('#result_checkPw').css('display', 'inline');
             pwCheck = false;
          } else {
             $('#result_checkPw').css('display', 'none');
             pwCheck = true;
          }
          
            /* 비밀번호 확인 유효성 검사 */
            if(pwck.trim() == ""){
                $('#result_checkPwck').css('display','inline');
                pwckCheck = false;
            }else{
                $('#result_checkPwck').css('display', 'none');
                pwckCheck = true;
            }
            
            /* 이름 유효성 검사 */
            if(name == ""){
                $('#result_checkNm').css('display','inline');
                $('#result_checkNm').css('color', 'red');
                nameCheck = false;
            }else{
                $('#result_checkNm').css('display', 'none');
                nameCheck = true;
            }
            
            /* 생년월일 유효성 검사 */
            if(bir == ""){
                $('#result_checkBir').css('display','inline');
                $('#result_checkBir').css('color', 'red');
                birCheck = false;
            }else{
                $('#result_checkBir').css('display', 'none');
                birCheck = true;
            }
            /* 성별 유효성 검사 */
            if(gen1.checked){
               $('#result_checkGen').css('display','none');
               genCheck = true;          // 성별
            }else if(gen2.checked){
               $('#result_checkGen').css('display','none');
               genCheck = true;          // 성별
            }else{
               $('#result_checkGen').css('display', 'inline');
               $('#result_checkGen').css('color', 'red');
             $('#result_checkGen').html("성별을 입력해주세요");
             genCheck = false;          // 성별
            }
            
            /* 전화번호 유효성 검사 */
            if(tel == "" ){
                $('#result_checkTel').css('display','inline');
                $('#result_checkTel').css('color', 'red');
             $('#result_checkTel').html("전화번호를 입력해주세요");
                telCheck = false;
            }else{
                $('#result_checkTel').css('display', 'none');
                telCheck = true;
            }
            
            
            /* 이메일 유효성 검사 */
            if(mail.trim() == ""){
                $('#result_checkEm').css('display','inline');
                $('#result_checkEm').css('color', 'red');
             $('#result_checkEm').html("이메일을 입력해주세요");
                mailCheck = false;
            }else{
                $('#result_checkEm').css('display', 'none');
                mailCheck = true;
            }
            
          
          
       });
    });
    
    
    </script>


<div id="mem_joinform_con">
   <div class="mem_joinform_mainbox pd_box">
      <h1 class="mem_joinform_title">무비팡 회원가입</h1>
      <form action="joinMember.do" class="mem_joinform" method="post">
         <div class="form_group">
            <div class="label_tag">
               아이디 <span id="result_checkId" class="identify">* 아이디를 입력해주세요</span>
<!--                아이디 <span id="result_checkId" class="identify">* 아이디를 입력해주세요</span> -->
            </div>
            <div class="sort">
               <input type="text" name="mem_id" id="mem_id" placeholder="아이디를 입력해주세요"
                pattern="[a-zA-Z0-9]+" minlength="6" maxlength="20"
                  onblur="validateField(this)" onfocus="hideIdentify(this)" >
               <button id="idchkbtn" class="btn1 confirm_btn">중복 확인</button>
<!--                <span id="result_checkId"></span> -->
            </div>
         </div>

         <div class="form_group pwd_part">
            <div class="label_tag">
               비밀번호 <span id="result_checkPw" class="identify">* 비밀번호를 입력해주세요</span>
            </div>
            <div>
               <input type="password" name="mem_pwd" id="mem_pwd"
               pattern="[a-zA-Z0-9!_\-!@#$%^&*]+" minlength="10" maxlength="16"
                  placeholder="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)" >
            </div>
<!--                 <span id="result_checkPw"></span> -->
         </div>

         <div class="form_group pwd_confirm_part">
            <div class="label_tag">
               비밀번호 확인 <span id="result_checkPwck" class="identify">* 비밀번호를 입력해주세요</span>
            </div>
            <div>
               <input type="password" name="mem_pwd1" id="mem_pwd1" pattern="[a-zA-Z0-9!_\-!@#$%^&*]+" minlength="8" maxlength="15" placeholder="비밀번호와 같이 입력해주세요" >
            </div>
<!--                <span id="result_checkPwck"></span> -->
         </div>

         <div class="form_group">
            <div class="label_tag">
               이름 <span id="result_checkNm" class="identify">* 이름을 입력해주세요</span>
            </div>
            <div>
               <input class="mem_name" type="text" name="mem_nm" id="mem_nm"
               pattern="[가-힣a-zA-Z\s]+" maxlength="6"
                  placeholder="이름을 입력해주세요" onblur="validateField(this)"
                  onfocus="hideIdentify(this)" >
            </div>
<!--                <span id="result_checkNm"></span> -->
         </div>

         <div class="form_group part_flex">
            <div class="birth_part">
               <div class="label_tag">
                  생년월일 <span id="result_checkBir" class="identify">* 생년월일을 입력해주세요</span>
               </div>
               <div>
                  <input class="birth" type="text" name="mem_bir" id="mem_bir"
                     placeholder="생년월일을 입력해주세요" onblur="validateField(this)"
                        minlength="8" maxlength="8" pattern = [0-9]+
                     onfocus="hideIdentify(this)" >
               </div>
<!--                   <span id="result_checkBir"></span> -->
            </div>

            <div class="gender_part">
               <div class="label_tag">성별</div>
                 <span id="result_checkGen"></span>
               <div class="select_gender">
                  <div>
                     <label for="gender_m">남</label> <input class="" type="radio"
                        name="mem_gen" id="gender_m" value="남">
                  </div>
                  <div>
                     <label for="gender_g">여</label> <input class="" type="radio"
                        name="mem_gen" id="gender_g" value="여">
                  </div>
               </div>
            </div>
         </div>

        <div class="form_group">
            <div class="tel_part">
               <div class="label_tag">
                  휴대전화 <span id="result_checkTel" class="identify">* 전화번호를 입력해주세요</span>
               </div>
               <div>
                  <input type="text" name="mem_tel" id="userTel1" value="" placeholder="-없이 입력하세요"
                  minlength="10" maxlength="11" pattern="(010)[0-9]{4}[0-9]{4}"
                     onblur="validateField(this)" onfocus="hideIdentify(this)" >
                  <button onclick="" class="btn1 confirm_btn" id="tel-Check-Btn">인증 요청</button>
               </div>
<!--                   <span id="result_checkTel"></span> -->
            </div>
         </div>

         <div class="form_group">
            <div class="tel_part">
               <div class="label_tag">
                  휴대폰 인증번호 <span id="tel-check-warn" class="identify">* 휴대폰 인증번호를 입력해주세요</span>
               </div>
               <div>
                  <input type="text" class="tel-check-input" name="" id="" placeholder="인증번호 입력"
                     onblur="validateField(this)" onfocus="hideIdentify(this)" ><span id="timer1"></span>
                  <button type="button" onclick="" id="tel-Check-Btn" class="btn1 confirm_btn" >인증 확인</button>
<!--                <span id="tel-check-warn"></span> -->
                  
               </div>
            </div>
         </div>

         <div class="form_group">
            <div class="email_part">
               <div class="label_tag">
                  이메일 <span id="result_checkEm" class="identify">* 이메일을 입력해주세요</span>
               </div>

               <div class="email_box">
                  <input type="text" name="mem_em" id="userEmail1" placeholder="이메일을 입력해주세요"
                  pattern="[a-zA-Z0-9_]+[@][a-zA-Z]+[.][a-zA-Z]+[.]*[a-zA-Z]*"
                     onblur="validateField(this)" onfocus="hideIdentify(this)" >
                  
                  <button onclick="" class="btn1 confirm_btn" id="mail-Check-Btn" type="button">인증 요청</button>
               </div>
<!--                  <span id="result_checkEm"></span> -->
            </div>
         </div>

         <div class="form_group">
            <div class="email_part">
               <div class="label_tag">
                  이메일 인증번호 <span id="mail-check-warn" class="identify">* 이메일 인증번호를 입력해주세요</span>
               </div>

               <div class="email_box">
                  <input type="text" class="mail-check-input" name="" id="" placeholder="인증번호 입력"     
                     onblur="validateField(this)" onfocus="hideIdentify(this)" 
                     ><span id="timer"></span>
                  <button onclick="verifyCode()" class="btn1 confirm_btn" type="button">인증 확인</button>
<!--                   <span id="mail-check-warn"></span> -->
               </div>
            </div>
         </div>

         <div class="form_group">
            <button type="submit" class="btn2 submit_btn">회원가입</button>
         </div>
      </form>
   </div>
</div>
<%@include file="./footer.jsp"%>