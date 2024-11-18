document.addEventListener('DOMContentLoaded', function() {
    // 비밀번호 및 비밀번호 확인 입력칸에 대한 blur 이벤트 리스너 추가
    const passwordInput = document.querySelector('.pwd_part input[type="password"]');
    const passwordConfirmInput = document.querySelector('.pwd_confirm_part input[type="password"]');

    if (passwordInput && passwordConfirmInput) {
        passwordInput.addEventListener('blur', function() {
            validatePasswordInput(passwordInput);
            // 비밀번호 확인 입력칸의 유효성도 함께 검사
            validatePasswordConfirmation(passwordInput, passwordConfirmInput);
        });

        passwordConfirmInput.addEventListener('blur', function() {
            validatePasswordConfirmation(passwordInput, passwordConfirmInput);
        });
    }
});

// 비밀번호 확인 검사 함수
function validatePasswordConfirmation(passwordInput, passwordConfirmInput) {
    const identifyElement = passwordConfirmInput.closest('.mem_joinform > .form_group').querySelector('.identify');
    if (passwordInput.value === passwordConfirmInput.value) {
        // 비밀번호와 비밀번호 확인 입력칸의 값이 동일하면 identify 요소를 숨깁니다.
        if (identifyElement) {
            identifyElement.style.display = 'none';
        }
    } else {
        // 값이 다르면 identify 요소를 보이게 하고 메시지를 표시합니다.
        if (identifyElement) {
            identifyElement.textContent = '* 비밀번호가 일치하지 않습니다.';
            identifyElement.style.display = 'inline';
        }
    }
}

// 개별 필드 검사 함수
function validateField(input) {
    const identifyElement = input.closest('.mem_joinform > .form_group').querySelector('.identify');
    const result_ckeckId = input.closest('.mem_joinform > .form_group').querySelector('#result_checkId');
    const telck = input.closest('.mem_joinform > .form_group').querySelector('#tel-check-warn');
    const mailck = input.closest('.mem_joinform > .form_group').querySelector('#mail-check-warn');
    if (input.value.trim() ) {
        // 입력값이 있으면 identify 요소를 숨깁니다.
        if (identifyElement  && idCheckPassed == true) {
            identifyElement.style.display = 'none';
            result_ckeckId.style.display = 'inline';
            telck.style.display = 'inline';
            mailck.style.display = 'inline';
        }
    } else {
        // 입력값이 없으면 identify 요소를 보이게 합니다.
        if (identifyElement) {
            identifyElement.style.display = 'inline';
        }
    }
}


// 비밀번호 조건 검사 함수
function validatePasswordInput(input) {
    const identifyElement = input.closest('.mem_joinform > .form_group').querySelector('.identify');
    if (validatePassword(input.value)) {
        // 비밀번호 조건을 만족하면 identify 요소를 숨깁니다.
        if (identifyElement) {
            identifyElement.style.display = 'none';
        }
    } else {
        // 비밀번호 조건을 만족하지 않으면 identify 요소를 보이게 합니다.
        if (identifyElement) {
            identifyElement.textContent = '* 비밀번호 조건을 만족하지 않습니다.';
            identifyElement.style.display = 'inline';
        }
    }
}

// 비밀번호 검사 로직
function validatePassword(password) {
    const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{10,16}$/;
    // 이 라인을 수정하여 비밀번호 조건을 올바르게 검사합니다.
    // 영문 대소문자, 숫자, 특수문자 중 2가지 이상 조합을 감지하는 정확한 정규식으로 변경해야 합니다.
    return regex.test(password);
}

// 회원가입폼  유효성 검사

$(document).ready(function(){ 
	$('ul.tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
    })

	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#conWrite").click(function(){
		location.href = "insertBoard.jsp";
	});
	
	$("#conDel").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			let v = document.fm.bn_num.value;
			location.href = "deleteBoard.do?bn_num="+v;
		}else{
		}
	});
	
	$("#conList").click(function(){
		location.href = "getBoardList.do";
	});
	
	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#conWrite1").click(function(){
		location.href = "insertEv_Board.jsp";
	});
	
	$("#conDel1").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			let v = document.fm.ev_num.value;
			location.href = "deleteEv_Board.do?ev_num="+v;
		}else{
		}
	});
	
	$("#conList1").click(function(){
		location.href = "/getEv_boardList.do";
	});
	
	$('ul.movie_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.movie_tabs li').removeClass('list');
        $('.tab-content').removeClass('list');

        $(this).addClass('list');
        $("#"+tab_id).addClass('list');
    })
});

function selTr(val){
	location.href = "/getBoard.do?bn_num="+val;
}

function selTrr(val){
	location.href = "/getEv_Board.do?ev_num="+val;
}


document.addEventListener('DOMContentLoaded', function() {
    var banners = document.querySelectorAll('#ev_banner a');
    var randomIndex = Math.floor(Math.random() * banners.length);
    banners[randomIndex].style.display = 'block';
});

$('.go_top').click(function(){
    $('html,body').animate({
        scrollTop : 0
    });
});
$('.go_top').hide();
$(window).scroll(function(){
    var s = $(window).scrollTop();
    if(s>=400){
        $('.go_top').show();
    } else {
        $('.go_top').hide();
    }
}); 