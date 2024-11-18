<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file ="../sub/header.jsp" %>
<div id="product_basket_con">
    <div class="product_basket_con pd_box inner">
        <h1 class="product_basket_title">장바구니</h1>
        <form action="payCart.do" class="buy_btn_box">
            <table>
                <thead>
                    <tr>
<!--                         <th><label for="all_check">전체 선택</label> -->
<!--                         <input type="checkbox" id="all_check" checked="checked" class="all_check_input"></th> -->
                        <th>상품명</th>
                        <th>금액</th>
                        <th>수량</th>
                        <th>구매금액</th>
                        <th>취소</th>
                    </tr>
                </thead>
                <tbody>
                   <c:forEach items="${CartList}" var="cart">
                    <tr>
                       <td class="td_width_1 cart_info_td" style="display:none;">
<!--                            <input type="checkbox" class="cart_checkbox input_size_20" checked="checked"> -->
                           <input type="hidden" class="cartPrice_input" value="${cart.prd_price}">
                           <input type="hidden" class="cartCount_input" value="${cart.cart_count}">
                           <input type="hidden" class="totalPrice_input" value="${cart.prd_price * cart.cart_count}">
                           <input type="hidden" class="prdNum_input" value="${cart.prd_num}">  
                        </td>
                          
                        <td class="sel_pro_box">
                            <div>
                                <img class="sel_pro_img" src="${pageContext.request.contextPath}/resources/prdImg/${cart.prd_img}" alt="사진 없음">
                            </div>
                            <div>
                                <div class="sel_pro_name">${cart.prd_name}</div>
                            </div>
                        </td>
                        <td class="sel_price">
                           <fmt:formatNumber value="${cart.prd_price}" pattern="#,### 원" />
                        </td>
                        <td>
                            <div class="count_sort">
                                <button type="button" class="quantity_btn subtraction">-</button>
                               <input type="text" value="${cart.cart_count}" class="quantity_input">
<!--                                 <input class="sel_count" type="text" name="" readonly> -->
                                <button type="button" class="quantity_btn addtion">+</button>
                            </div>
                            <a style="display:none;" class="quantity_modify_btn" data-prd_num="${cart.prd_num}">변경</a>
                        </td>
                        <td class="sel_total_price">
                           <fmt:formatNumber value="${cart.prd_price * cart.cart_count}" pattern="#,### 원" />
                        </td>
                         <td>
                            <button class="select_product_del" data-cartid="${cart.cart_id}">
                                <img src="${pageContext.request.contextPath}/resources/img/close_ico.png" alt="">
                            </button>
                         </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="all_add_price_box">
                <div class="price_txt">총 결제 금액</div>
                <div class="total_all_price"><span class="totalPrice_span"></span> 원</div>
            </div>

            <div class="buy_btn_box">
                <button id="buyButton">구매하기</button>
            </div>
        </form>
        
        
<!--         수량 조정 form -->
        <form action="updateCart.do" method="post" class="quantity_update_form">
            <input type="hidden" name="prd_num" class="update_prd_num">
            <input type="hidden" name="cart_count" class="update_cartCount">
            <input type="hidden" name="mem_id" value="<%= id%>">
         </form>   
         
         <!-- 삭제 form -->
         <form action="deleteCart.do" method="post" class="quantity_delete_form">
            <input type="hidden" name="cart_id" class="delete_cartId">
            <input type="hidden" name="mem_id" value="<%= id%>">
         </form>      
         <!-- 주문 form -->
         <form action="/order/$<%= id%>" method="get" class="order_form">

         </form>
    </div>
        <script>
        $("#buyButton").on("click", function(e) {
            e.preventDefault(); // 기본 폼 제출 막기
            console.log("실행은 되나");

            let updates = $(".quantity_modify_btn").map(function() {
                let prd_num = $(this).data("prd_num");
                let cart_count = $(this).parent().find(".quantity_input").val();

                return $.ajax({
                    url: "updateCart.do",
                    type: "post",
                    data: {
                        prd_num: prd_num,
                        cart_count: cart_count,
                        mem_id: "<%= id %>"
                    }
                });
            }).get();

            // updates 배열이 비어있지 않은 경우에만 $.when을 실행합니다.
            if (updates.length > 0) {
                $.when(...updates).then(function() {
                    // 모든 AJAX 요청이 성공적으로 완료되면 폼 제출
                    $("form.buy_btn_box").submit();
                }, function() {
                    // 하나라도 실패한 요청이 있다면, 사용자에게 알림
                    alert("카트 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.");
                });
            } else {
                // AJAX 요청이 필요 없는 경우(수정 버튼이 없는 경우) 바로 폼 제출
                $("form.buy_btn_box").submit();
            }
        });

        
document.addEventListener('DOMContentLoaded', function() {
    // 더하기 버튼 클릭 이벤트
    document.querySelectorAll('.quantity_btn.addtion').forEach(button => {
        button.addEventListener('click', function() {
            updateQuantity(this, 1);
        });
    });

    // 빼기 버튼 클릭 이벤트
    document.querySelectorAll('.quantity_btn.subtraction').forEach(button => {
        button.addEventListener('click', function() {
            updateQuantity(this, -1);
        });
    });

    function updateQuantity(button, change) {
        var quantityInput = button.closest('.count_sort').querySelector('.quantity_input');
        var currentQuantity = parseInt(quantityInput.value);
        var newQuantity = currentQuantity + change;

        // 수량이 0보다 작아지지 않도록 검사
        if(newQuantity < 1){
            alert("0은 입력하실 수 없습니다.");
            return;
        }else if(newQuantity > 10){
            alert("주문 10개 이상은 불가능합니다.");
            return;
        }

        // 수량 업데이트
        quantityInput.value = newQuantity;

        // 상품 가격 가져오기 및 총 가격 계산
        var price = parseInt(button.closest('tr').querySelector('.sel_price').textContent.replace(/,/g, '').replace(' 원', ''));
        var totalPrice = newQuantity * price;
        
        // 개별 상품의 총 가격 업데이트
        button.closest('tr').querySelector('.sel_total_price').textContent = totalPrice.toLocaleString() + ' 원';

        // 모든 상품의 총 결제 금액 업데이트
        updateTotalPrice();
    }

    function updateTotalPrice() {
        var allPrices = document.querySelectorAll('.sel_total_price');
        var totalAllPrice = 0;

        allPrices.forEach(function(price) {
            var priceValue = parseInt(price.textContent.replace(/,/g, '').replace(' 원', ''));
            totalAllPrice += priceValue;
        });

        document.querySelector('.totalPrice_span').textContent = totalAllPrice.toLocaleString();
    }
});

        
$(document).ready(function(){
   /* 종합 정보 섹션 정보 삽입 */
   setTotalInfo();   
   
});   

/* 체크여부에따른 종합 정보 변화 */
// $(".cart_checkbox").on("change", function(){
//    /* 총 주문 정보 세팅(총 가격, 물품 수, 종류) */
//    setTotalInfo($(".cart_info_td"));
// //    checkAllCheckbox(); //체크 박스 확인
// });

//  체크박스 전체 선택 
// $(".all_check_input").on("click", function(){

// //     체크박스 체크/해제 
//    if($(".all_check_input").prop("checked")){
//       $(".cart_checkbox").prop("checked", true);
//    } else{
//       $(".cart_checkbox").prop("checked", false);
//    }
   

   
//    /* 총 주문 정보 세팅(총 가격, 물품 수, 종류) */
//    setTotalInfo($(".cart_info_td"));   
   
// });

// 체크박스 전체가 체크되어있는지
// function checkAllCheckbox() {
//     var allChecked = true;
//     $(".cart_checkbox").each(function() {
//         if (!$(this).prop("checked")) {
//             allChecked = false;
//             return false; // loop 종료
//         }
//     });

//     $(".all_check_input").prop("checked", allChecked);
// }



/* 총 주문 정보 세팅(총 가격, 물품 수, 종류) */
function setTotalInfo(){
   let totalPrice = 0;            // 총 가격
   let totalCount = 0;            // 총 갯수
   let totalKind = 0;            // 총 종류

   
   $(".cart_info_td").each(function(index, element){
      
//       if($(element).find(".cart_checkbox").is(":checked") === true){   //체크여부
         // 총 가격
         totalPrice += parseInt($(element).find(".totalPrice_input").val());
         // 총 갯수
         totalCount += parseInt($(element).find(".cartCount_input").val());
         // 총 종류
         totalKind += 1;
//       }

   });
   
   
   /* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
   
   // 총 가격
   $(".totalPrice_span").text(totalPrice.toLocaleString());
   // 총 갯수
   $(".totalCount_span").text(totalCount);
   // 총 종류
   $(".totalKind_span").text(totalKind);
}


/* 수량 수정 버튼 */
$(".quantity_modify_btn").on("click", function(){
   let prd_num = $(this).data("prd_num");
   let cart_count = $(this).parent("td").find("input").val();
   $(".update_prd_num").val(prd_num);
   $(".update_cartCount").val(cart_count);
   $(".quantity_update_form").submit();
   
});

/* 장바구니 삭제 버튼 */
$(".select_product_del").on("click", function(e){
   e.preventDefault();
   const cartId = $(this).data("cartid");
   $(".delete_cartId").val(cartId);
   $(".quantity_delete_form").submit();
});
</script>
</div>
<%@include file ="../sub/footer.jsp" %>