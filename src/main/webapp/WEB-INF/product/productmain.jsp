<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@include file ="../sub/header.jsp" %>
<script> 
function giftFunction(val, event) {
    console.log("val:", val); // val 값 확인
    location.href = "/getPrd.do?prd_num=" + val;
}
</script>
<div id="product_con">
    <div class="product_con pd_box inner">
        <h1 class="product_title">STORE</h1>

        <div class="product_snack_list product_list">
            <h2 class="category_name">스낵</h2> 
            <ul>
            <c:forEach var="product" items="${prd_List}">
	            <c:if test="${product.prd_type eq '스낵'}">
	            <li class="product_item">
                     <a href="#" onclick="giftFunction('${product.prd_num}')">
                         <div class="snack_item_info product_item_info">
                             <!-- 상품 이미지는 데이터에 있는 경로를 지정하셔야 합니다. -->
                             <img class="item_img" src="/resources/prdImg/${product.prd_img}" alt="">
                             <div class="prd_infotxt_box">
                              <!-- 상품 이름과 가격은 받아온 데이터에서 가져옵니다. -->
                               <div class="prd_info_box">
                               <p class="item_name">${product.prd_name}</p>
                               <p class="item_price"><fmt:formatNumber value="${product.prd_price}" type="number" groupingUsed="true"/>원</p>
                               </div>
                               <span class="item_buy_btn">구매</span>
                             </div>
                         </div>
                      </a>
                   </li>
				</c:if>
            </c:forEach>
            </ul>
        </div>

        <div class="product_giftcard_list product_list">
            <h2 class="category_name">기프트카드</h2> 
            <ul>
             <c:forEach var="product" items="${prd_List}">
	            <c:if test="${product.prd_type eq '기프트카드'}">
	            <li class="product_item">
	                 <a href="#" onclick="giftFunction('${product.prd_num}')">
	                     <div class="snack_item_info product_item_info">
	                         <img class="item_img" src="/resources/prdImg/${product.prd_img}" alt="">  
	                         <p class="item_name">${product.prd_name}</p>
	                         <p class="item_sub_name">충전형 기프트카드</p>
	                         <div class="prd_infotxt_box">
	                         	<p class="item_price"><fmt:formatNumber value="${product.prd_price}" type="number" groupingUsed="true"/>원</p>
	                         	<span class="item_buy_btn">구매</span>
	                         </div>
	                     </div>
	                 </a>
	             </li>
				</c:if>
              </c:forEach>
            </ul>
        </div>
    </div>
</div>
<%@include file ="../sub/footer.jsp" %>