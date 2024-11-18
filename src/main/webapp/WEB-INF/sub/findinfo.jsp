<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>
<!-- 핸드폰 인증 스크립트 -->
<script>
	// 인증번호 요청 함수
	var timer;
	var isRunning = false;
	var code;
	var telSent = false; // 문자 전송 여부를 추적하는 변수

    // 인증번호 요청 함수
    function telCheckBtn() {
        $('#tel-Check-Btn').click(function() {
            let tel = $('#userTel1').val();
            console.log('입력 전화번호 : ' + tel);
            let checkInput = $('.tel-check-input');

            // 유효성 검사
            if (!tel) {
                alert('휴대폰 번호를 입력해주세요.');
                return; // 함수 종료
            }

            if (!tel.match(/^(010)[0-9]{4}[0-9]{4}$/)) {
                alert('유효하지 않은 휴대폰 번호입니다. -없이 010으로 시작하는 11자리 번호를 입력해주세요.');
                return; // 함수 종료
            }

            // 이미  문자가 전송되었는지 확인
            if (telSent) {
                alert('이미 문자가 전송되었습니다. 인증번호를 확인해주세요.');
                return; // 함수 종료하여 문자를 여러 번 보내는 것을 방지
            }

            $.ajax({
                url: 'isValidTel.do',
                method: 'POST',
                data: {
                    mem_id: $('#mem_id').val(), // 입력된 아이디
                    mem_name: $('#mem_name').val(), // 입력된 이름
                    mem_tel: $('#userTel1').val() // 입력된 휴대폰 번호
                },
                success: function(response) {
                    console.log("서버 응답:", response);
                    
                    // 서버 응답이 JSON 형식이므로 isValid 속성 값을 확인합니다.
                    if (response.isValid === true) {
                    	$.ajax({
				            url: "telCheck.do?tel=" + tel,
				            type: 'GET',
				            data: { tel: $('#userTel1').val() }, // 폰 번호 데이터 전송
				            success: function(code1) {
				                console.log("code1 : " + code1);
				                checkInput.prop('disabled', false);
				                code = code1;
				                alert('인증번호가 전송되었습니다.');
				                sendAuthNum(); // 인증번호 발송 및 타이머 시작 함수 호출
				                telSent = true; // 문자 전송 상태 업데이트
				            },
				            error: function(xhr, status, error) {
				                console.error(xhr.responseText);
				            }
			       		});
			            checkInput.prop('disabled', false);
// 			            code = '12345'; // 테스트용으로 고정된 인증번호 설정
			            sendAuthNum();
			            telSent = true;
			            console.log("code: " + code);
			            console.log("tel: " + tel);
                    } else {
                        alert('입력하신 정보와 일치하는 회원이 없습니다.');
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Ajax 요청 에러:', errorThrown);
                }
            });
        });
    }

    //인증번호 발송하고 타이머 함수 실행
    function sendAuthNum() {
        // 남은 시간
        var leftSec = 180, display = document.querySelector('#timer1');
        // 이미 타이머가 작동중이면 중지
        if (isRunning) {
            clearInterval(timer);
        } else {
            isRunning = true;
        }
        startTimer1(leftSec, display);
    }

    function startTimer1(count, display) {
        var minutes, seconds;
        timer1 = setInterval(function() {
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
    // 비밀번호 찾기 버튼을 초기에 비활성화
    $(document).ready(function() {
        $('#find_pwd_btn').prop('disabled', true);
    });

    function compareCode1() {
        $('.tel-check-input').blur(
                function() {
                    const inputCode = $(this).val();
                    const $resultMsg = $('#tel-check-warn');
                    console.log(inputCode);
                    console.log(code);

                    if (code === null) { // 인증 시간이 만료되었는지 확인
                        $resultMsg.html('*인증 시간이 만료되었습니다. 다시 인증해주세요.');
                        $resultMsg.css('color', 'red');
                        return; // 함수 종료
                    }

                    if (inputCode === code) {
                        $resultMsg.html('*인증번호가 일치합니다.');
                        $resultMsg.css('color', 'green');
                        $('#tel-Check-Btn').attr('disabled', true);
                        $('#userTel1').attr('readonly', true);
                        $('#userTel2').attr('readonly', true);
                        $('#userTel2').attr('onFocus',
                                'this.initialSelect = this.selectedIndex');
                        $('#userTel2').attr('onChange',
                                'this.selectedIndex = this.initialSelect');
                        clearTimeout(timer); // 타이머 초기화
                        $('#timer1').hide();
                        $('.tel-check-input').attr('readonly', true);

                        // 인증번호가 일치할 때 비밀번호 찾기 버튼 활성화
                        $('#find_pwd_btn').attr('disabled', false);
                    } else {
                        $resultMsg.html('*인증번호가 불일치 합니다. 다시 확인해주세요!.');
                        $resultMsg.css('color', 'red');
                    }
                });
    }

    $(document).ready(function() {
        telCheckBtn();
        compareCode1();
    });
</script>
<script>
        // 일치하는 아이디를 찾을 수 없는 경우, 알림 창을 표시하는 함수
        function displayAlert(message) {
            alert(message);
        }

        // 서버에서 전달된 메시지가 존재하는 경우에만 알림 창을 표시
        var notFoundMessage = "${notFoundMessage}";
        if (notFoundMessage) {
            displayAlert(notFoundMessage);
        }
    </script>

<div id="find_myinfo_con">
	<div class="find_myinfo_mainbox pd_box">
		<h1 class="find_myinfo_title">아이디/비밀번호 찾기</h1>
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="find_id">아이디 찾기</li>
				<li class="tab-link" data-tab="find_pwd">비밀번호 찾기</li>
			</ul>

			<div id="find_id" class="tab-content current">
				<form action="findId.do" class="find_form">
					<div class="form_group">
						<div class="label">이름</div>
						<input class="mem_nm" type="text" name="mem_nm" id="mem_nm"
							pattern="[가-힣a-zA-Z\s]+" maxlength="6" placeholder="이름을 입력해주세요">
					</div>

					<div class="form_group">
						<div class="label">생년월일</div>
						<input class="birth" type="text" name="mem_bir" id="mem_bir"
							placeholder="생년월일을 입력해주세요" minlength="8" maxlength="8"
							pattern=[0-9]+>
					</div>

					<div class="form_group">
						<div class="label">휴대폰번호</div>
						<input type="text" name="mem_tel" id="userTel" value=""
							placeholder=" '-' 없이 입력 " minlength="10" maxlength="11"
							pattern="(010)[0-9]{4}[0-9]{4}" />
					</div>

					<div class="form_group">
						<button type="submit" class="btn2 submit_btn">아이디 찾기</button>
					</div>
				</form>
			</div>
			<div id="find_pwd" class="tab-content">
				<form action="findPwd.do" class="find_form">
					<div class="form_group">
						<div class="label">아이디</div>
						<input type="text" name="mem_id" id="mem_id"
							placeholder="아이디를 입력해주세요" pattern="[a-zA-Z0-9]+" minlength="6"
							maxlength="20" onblur="validateField(this)"
							onfocus="hideIdentify(this)">
					</div>

					<div class="form_group">
						<div class="label">이름</div>
						<input type="text" name="mem_name" id="mem_name"
							pattern="[가-힣a-zA-Z\s]+" maxlength="6" placeholder="이름을 입력해주세요"
							onblur="validateField(this)" onfocus="hideIdentify(this)">
					</div>

					<div class="form_group">
						<div class="label">휴대폰 번호</div>	
						<input type="text" name="mem_tel" id="userTel1" value=""
							placeholder="-없이 입력하세요" minlength="10" maxlength="11"
							pattern="(010)[0-9]{4}[0-9]{4}" onblur="validateField(this)"
							onfocus="hideIdentify(this)">
						<button type="button" class="btn1 confirm_btn" id="tel-Check-Btn">인증요청</button>
					</div>

					<div class="form_group">
						<div class="label">인증 번호</div>
						<input type="text" class="tel-check-input" name="" id=""
							placeholder="인증번호 입력" onblur="validateField(this)"
							onfocus="hideIdentify(this)"><span id="timer1"></span>
						<button type="button" onclick="" class="btn1 confirm_btn">인증확인</button>
					</div>

					<div class="form_group">
						<button type="submit" class="btn2 submit_btn" id="find_pwd_btn">비밀번호 찾기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@include file="./footer.jsp"%>