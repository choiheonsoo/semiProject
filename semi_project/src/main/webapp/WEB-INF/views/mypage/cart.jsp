<%@ page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.cart-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}

.cart-items {
    border-bottom: 1px solid #ccc;
    margin-bottom: 20px;
}

.cart-item {
    display: flex;
    align-items: center;
    padding: 10px 0;
    border-top: 1px solid #ccc;
}

.cart-item img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    margin-right: 20px;
}

.product-details {
    flex-grow: 1;
}

.product-details h2 {
    margin: 0 0 10px;
    font-size: 18px;
}

.product-details p {
    margin: 0 0 10px;
    color: #555;
}

.price {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
}

.quantity-control {
    display: flex;
    align-items: center;
}

.quantity-control button {
    width: 30px;
    height: 30px;
    border: 1px solid #ccc;
    border-radius: 20px;
    background-color: #fff;
    cursor: pointer;
}

.quantity-control .quantity {
    width: 40px;
    text-align: center;
}

.remove {
    background-color: #ff4d4d;
    color: #fff;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    margin-left: 20px;
    border-radius: 10px;
}

.order-summary {
    padding: 10px 0;
}

.order-summary h2 {
    margin-bottom: 20px;
    font-size: 20px;
    text-align: center;
}

.order-summary .subtotal,
.order-summary .shipping,
.order-summary .total {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-top: 1px solid #ccc;
}

.order-summary .total {
    font-weight: bold;
    font-size: 18px;
}
.order-summary-btn {
	display: flex;
	width: 95%;
	flex-direction: column;
    align-items: center;
}

.checkout,
.continue-shopping {
    width: 90%;
    padding: 10px;
    border: none;
    cursor: pointer;
    font-size: 16px;
    border-radius: 15px;
}

.checkout {
    background-color: #007bff;
    color: #fff;
    margin-bottom: 10px;
}

.continue-shopping {
    background-color: #28a745;
    color: #fff;
}
.remove:hover {
    background-color: #e60000;
}
.quantity-control button:hover {
    background-color: #007bff;
    color: #fff;
}
.continue-shopping:hover {
    background-color: #218838;
}
.checkout:hover {
    background-color: #0056b3;
}
</style>
<section class="content" style="background-color: rgba(186,186,186,0.3);">
 	<div class="cart-page" style="margin-top: 4%; border-radius: 10px;">
        <h1 style="overflow:hidden;">장바구니</h1>
        <div class="cart-items">
            <div class="cart-item">
                <img src="product-image.jpg" alt="상품 이미지">
                <div class="product-details">
                    <h2>상품 이름</h2>
                    <p>상품 설명</p>
                    <div class="price">₩ 가격</div>
                    <div class="quantity-control">
                        <button class="decrease">-</button>
                        <span class="quantity">1</span>
                        <button class="increase">+</button>
                    </div>
                </div>
                <button class="remove">삭제</button>
            </div>
            <!-- 반복되는 상품 아이템들 -->
        </div>
        <div class="order-summary">
            <h2 style="overflow:hidden;">주문 요약</h2>
            <div class="subtotal">상품 합계: ₩ 총 가격</div>
            <div class="shipping">배송비: ₩ 배송비</div>
            <div class="total">총 결제 금액: ₩ 총 결제 금액</div>
            <div class="order-summary-btn">
	            <button class="checkout">결제하기</button>
	            <button class="continue-shopping">쇼핑 계속하기</button>
            </div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>