<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./sub/header.jsp"%>    
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>

<script>
$(document).ready(function() {
    // giftCheckBtn() 함수 호출
    giftCheckBtn();
});

var code;
var telSent = false; // 문자 전송 여부를 추적하는 변수
function giftCheckBtn() {
    $('#gift-Check-Btn').click(function() {
        let tel = $('#rectel').val()
        let name = $('#senderName').val()
        let prdName= $('#prd_name').val()
        let prd_num = $('#prd_num').val()
        console.log('입력 전화번호 : ' + tel);

        // 이미  문자가 전송되었는지 확인
        if (telSent) {
            alert('이미 문자가 전송되었습니다. 인증번호를 확인해주세요.');
            return; // 함수 종료하여 문자를 여러 번 보내는 것을 방지
        }

        $.ajax({
            url: "gifttelCheck.do?tel=" + tel, 
            type: 'GET',
            data: { 
               tel: $('#rectel').val(),
               name: $('#senderName').val(),
               prdName: $('#prd_name').val(),
               prd_num: $('#prd_num').val()
               }, // 폰 번호 데이터 전송
            success: function(code1) {
                $('#prd_num').val(code1);
                console.log("code1 : " + code1);
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
      console.log("code: " + code);
      console.log("tel: " + tel);
    });
}

</script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const quantityField = document.getElementById('quantity');
    const decrementButton = document.getElementById('decrement');
    const incrementButton = document.getElementById('increment');
    const priceField = document.getElementById('price'); // 가격을 표시할 요소 추가

    // 수량 증가 이벤트 핸들러
    incrementButton.addEventListener('click', function() {
        let currentValue = parseInt(quantityField.value);
        if (currentValue < 10) {
            quantityField.value = currentValue + 1;
            updatePrice(); // 수량이 변경될 때마다 가격을 업데이트
        }
    });

    // 수량 감소 이벤트 핸들러
    decrementButton.addEventListener('click', function() {
        let currentValue = parseInt(quantityField.value);
        if (currentValue > 1) {
            quantityField.value = currentValue - 1;
            updatePrice(); // 수량이 변경될 때마다 가격을 업데이트
        }
    });

    // 수량 필드의 입력 제한 (최소 1, 최대 10)
    quantityField.addEventListener('change', function() {
        let currentValue = parseInt(quantityField.value);
        if (isNaN(currentValue) || currentValue < 1) {
            quantityField.value = 1;
        } else if (currentValue > 10) {
            quantityField.value = 10;
        }
        updatePrice(); // 수량이 변경될 때마다 가격을 업데이트
    });

    // 가격 업데이트 함수
    function updatePrice() {
        let quantity = parseInt(quantityField.value);
        let price = quantity * parseFloat("${prd.prd_price}"); // 가격 * 수량
        priceField.textContent = price; 
        document.getElementById("prd_price").value = price;
    }

    // 페이지 로드시 초기 가격 설정
    updatePrice();
});
</script>
</head>
<body>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<!-- <form action="giftInsert.do" method="post"> -->
<form action="pay.do">
   <input type="hidden" id="prd_num" name="prd_num" value="${prd.prd_num}"><!--  상품번호 -->
   
   <input type="text" id="prd_name" name="prd_name" value="${prd.prd_name}" readonly><br><!-- 상품 이름 -->
   
   <input type="hidden" id="prd_price" name="prd_price"  readonly><br><!-- 상품 가격 -->

    <span id="price">${prd.prd_price}</span> <!-- 가격을 표시할 요소 추가 -->
    
    <div class="quantity-container">
      <button class="quantity-button" type="button" id="decrement">-</button>
      <input type="text" class="quantity-field" id="quantity" value="1" name="prd_cnt">
      <button class="quantity-button" type="button" id="increment">+</button>
    </div>

   
    <label for="senderName">보내는 사람 이름:</label>
    <input type="text" id="senderName" name="gift_buyer" value="${sessionScope.mem_nm}" readonly><br> <!-- 구매자-->

    <label for="recipientName">받는 사람 이름:</label> <!-- 소유자 -->
    <input type="text" id="recName" name="gift_owner"><br>

    <label for="recipientPhoneNumber">받는 사람 전화번호:</label> <!-- 추가 -->
    <input type="text" id="rectel" name="gift_owntel" placeholder="-없이 입력해주세요"><br> <!-- 추가 -->

    <button>선물하기</button>
<!--     <button id="gift-Check-Btn">선물하기</button> -->
</form>

   

<%@include file="./sub/footer.jsp"%>