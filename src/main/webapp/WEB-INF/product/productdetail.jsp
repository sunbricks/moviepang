<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../sub/header.jsp" %>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const quantityField = document.getElementById('quantity');
    const decrementButton = document.getElementById('decrement');
    const incrementButton = document.getElementById('increment');
    const priceField = document.getElementById('price'); // 가격을 표시할 요소 추가
    const priceField1 = document.getElementById('price1'); // 가격을 표시할 요소 추가

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
        let price = quantity * parseInt("${prd.prd_price}");
        let formattedPrice = formatPrice(price);
        priceField.textContent = formattedPrice; 
        priceField1.textContent = formattedPrice; 
    }

    // 가격을 콤마로 포맷팅하는 함수
    function formatPrice(price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // 페이지 로드시 초기 가격 설정
    updatePrice();
    
    
    // 장바구니 추가 버튼
    $(".add_basket").on("click", function(e){
       
       // 서버로 전송할 데이터
       const form = {
             mem_id : '<%= id %>',
             prd_num : '${prd.prd_num}',
             cart_count : $("#quantity").val()
       }
       
       $.ajax({
          url: 'insertCart.do',
          type: 'POST',
          data: form,
          success: function(result){
             alert("장바구니에 추가했습니다.");
          }
       })
    });
});
</script>
<% 
    if(session.getAttribute("mem_id") == null) {
%>
    <script type="text/javascript">
        alert("로그인이 필요한 페이지입니다.");
        window.location.href = 'loginpage.do';
    </script>
<% 
    } else { 
%>
<div id="product_detail_con">
    <div class="product_detail_con pd_box inner">
        <form action="payPrd.do" method ="post">
         <input type="hidden" name="prd_num" value="${prd.prd_num}">
            <h1 class="product_detail_name">${prd.prd_type}</h1>
         <input type="hidden" name="prd_name" value="${prd.prd_name}">
            <div class="product_info_box">
                <div class="product_left_con">
                    <img src="/resources/prdImg/${prd.prd_img}" alt="">
                </div>
                <div class="product_right_con">
                    <div class="product_detail_price">${prd.prd_name}</div>
                    <input type="hidden" id="prd_price" name="prd_price">
                    <div class="product_detail_info_box">
                        <span class="product_compo">설명 :</span>
                        <span class="product_compo_info">${prd.prd_desc}</span>
                        <input type="hidden" name="prd_desc" value="${prd.prd_desc}">
                        <div>
                            <button type="button" class="labeling">영양성분표시</button>
                        </div>
                    </div>
                    <div class="product_cnt_box">
                        <div>
                            <button class="quantity-button" type="button" id="decrement">-</button>
                            <input class="product_count quantity-field" type="text" id="quantity" value="1" name="prd_cnt">
                            <button class="quantity-button" type="button" id="increment">+</button>
                        </div>
                        <div class="product_cnt_price">
                            <span id="price1">${prd.prd_price}</span>원
                        </div>
                    </div>
                </div>
            </div>

            <div class="product_total_price_box">
                <span class="product_total_price_txt">총 구매금액</span>
                <span class="product_total_price"><span id="price">${prd.prd_price}</span>원
            </div>

            <div class="product_btn_list">
                <ul>
                    <li>
                        <button class="add_basket" type="button">
                            <img src="${pageContext.request.contextPath}/resources/img/add_cart_img.png" alt="">
                        </button>
                    </li>
                  <li>
                        <button type="submit">선물하기</button>
                    </li>
                    <li>
                        <button type="submit" name="purchase" value="구매하기">구매하기</button>
                    </li>
                    <li>
                        <button type="submit" name="purchase" value="장바구니">장바구니 가기</button>
                    </li>
                </ul>
            </div>
        </form>
    </div>
    
    <div class="labeling_detail" style="display: none;">
        <div class="labeling_detail_box">
            <div class="labeling_header">
                <h2 class="labeling_title">영양성분표시</h2>
                <button class="labeling_close_btn">닫기</button>
            </div>
            <div class="labeling_info">
                <img src="${pageContext.request.contextPath}/resources/img/labeling.png" alt="">
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector('.labeling').addEventListener('click', function() {
        document.querySelector('.labeling_detail').style.display = 'block';
    });

    document.querySelector('.labeling_close_btn').addEventListener('click', function() {
        document.querySelector('.labeling_detail').style.display = 'none';
    });
</script>
<%} %>
<%@include file ="../sub/footer.jsp" %>