<%@ page import="com.web.user.model.dto.User"%>
<%@ page import="com.web.mypage.model.dto.CartList, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<CartList> list = (List<CartList>)request.getAttribute("cartlist");
%>
<style>
.content{
	padding-top: 1%;
}
.cart-page {
    max-width: 800px;
    margin: 2% auto;
    margin-bottom: 4%;
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
	font-weight: bolder;
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
    padding: 10px;
    position: fixed; 
    top: 180px; 
    right: 200px; 
    width: 250px;
    background-color: #fff; 
    box-shadow: 0 0 30px rgba(0, 0, 0, 0.3); 
    border: 1px solid #ccc; 
    border-radius: 10px;
    z-index: 1000; 
}

.order-summary h2 {
	font-weight: bolder;
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
        <%if(list!=null && list.size()>0) {%>
        	<%for(CartList c : list) {%>
        <div class="cart-items">
            <div class="cart-item">
                <img src="<%=request.getContextPath() %>/images/shoppingmall/product/<%=c.getProductImg() %>" alt="상품 이미지">
                <div class="product-details">
                    <h2><%=c.getProductName() %></h2>
                    <input type="hidden" value="<%=c.getOptionKey() %>">
                    <%if((c.getProductSize()==null && c.getProductColor()==null)||(c.getProductSize()==null && c.getProductColor()==null)) {%>
                    	<p>옵션 없음</p>
                    <%} else { %>
                    <p><%=c.getProductColor()!=null && c.getProductColor()!=null? "색상 : "+c.getProductColor():"" %></p>
                    <p><%=c.getProductSize()!=null && c.getProductSize()!=null? "사이즈 : "+c.getProductSize():"" %></p>
                    <%} %>
                    <div class="price">
                    <%if(c.getStock()>0){ %>
                    ₩ <%=(int)((100-c.getRateDiscount())/100*c.getPrice()) %>
                    <%} else {%>
                    	₩ 0
                    <%} %>
                    </div>
                    <input class="eachPrice" type="hidden" value="<%=(int)((100-c.getRateDiscount())/100*c.getPrice()) %>">
                    <div class="quantity-control"> 
                        <button class="decrease">-</button>
                        <span class="quantity"><%=c.getStock()>0?"1":"0" %></span>
                        <button class="increase" value="<%=c.getStock()%>">+</button>
                    </div>
                </div>
                <button class="remove" onclick="location.assign('<%=request.getContextPath()%>/user/cartlistdelete.do?cartkey=<%=c.getCartKey()%>')">삭제</button>
            </div> 
        </div>
        <%}
       }%>
    </div>
    <div class="order-summary">
        <h2 style="overflow:hidden;">주문 정보</h2>
        <div class="subtotal"></div>
        <div class="shipping">배송비: ₩ 0</div>
        <div class="total">총 결제 금액: ₩ <%=request.getAttribute("total") %></div>
        <div class="order-summary-btn">
            <button class="checkout" onclick="movePurchasePage();">결제하기</button>
            <button class="continue-shopping" onclick="location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=1')">쇼핑 계속하기</button>
        </div>
    </div>
</section>
<script>
	const $eachPrice = document.getElementsByClassName("eachPrice");
	const $quantity = document.getElementsByClassName("quantity");
	const $increase = document.getElementsByClassName("increase");
	const $buttons = document.getElementsByClassName("decrease");
	const $total = document.getElementsByClassName("total")[0];
	const $price = document.getElementsByClassName("price");	
	
	for(let i=0; i<$increase.length; i++){
		$increase[i].addEventListener("click", b=>{
			let sum = 0;
			if(+(b.target.value) > +(b.target.previousElementSibling.innerText)){
				b.target.previousElementSibling.innerText = +(b.target.previousElementSibling.innerText)+1;
				$price[i].innerText = "₩ "+(($eachPrice[i].value)*($quantity[i].innerText)).toLocaleString();
			} else {
				b.target.previousElementSibling.innerText = b.target.value;
				$price[i].innerText = "₩ "+(($eachPrice[i].value)*($quantity[i].innerText)).toLocaleString();
				alert("현재 "+b.target.value+"개의 재고가 남았습니다.");
			}
			for(let j=0; j<$increase.length; j++){
				sum = sum+parseInt($price[j].innerText.replace(/[^\d]/g, ""));
				// 정규 표현식을 이용하여 내부 숫자만 가져오기
			}
			$total.innerText = "총 결제 금액: ₩ "+sum.toLocaleString();
		})
	}
	
	for(let i=0; i<$buttons.length; i++){
		$buttons[i].addEventListener("click", b=>{
			let sum = 0;
			if(b.target.nextElementSibling.innerText>1){
				b.target.nextElementSibling.innerText = b.target.nextElementSibling.innerText-1;
				$price[i].innerText = "₩ "+(($eachPrice[i].value)*($quantity[i].innerText)).toLocaleString();
				
			} else {
				b.target.nextElementSibling.innerText=0;
				$price[i].innerText = "₩ "+(($eachPrice[i].value)*($quantity[i].innerText)).toLocaleString();
				alert("장바구니에는 최소 0개의 수량을 담아야합니다.");
			}
			for(let j=0; j<$increase.length; j++){
				sum = sum+parseInt($price[j].innerText.replace(/[^\d]/g, ""));
				// 정규 표현식을 이용하여 내부 숫자만 가져오기
			}
			$total.innerText = "총 결제 금액: ₩ "+sum.toLocaleString();
		})
	}  
	
	const movePurchasePage=()=>{
		//상품 키, 이름, 옵션, 구매수량, 할인율, 가격을 form태그로 넘기기
		let sum=0;
		for(let i=0;i<$(".quantity").length;i++){
			sum+=parseInt($(".quantity").eq(i).text());
		}
		if(sum>0){
		let color;
		let size;
		<%if(list!=null && list.size()>0) {%>
			const form = $("<form>").attr("method","POST").attr("action","<%=request.getContextPath()%>/shoppingmall/shoppingmallpay.do");
        	<%for(int i=0;i<list.size();i++) {%>
					$("<input>")
			        .attr("type", "hidden")
			        .attr("name", "products["+<%=i%>+"].productKey")
			        .val("<%=list.get(i).getProductKey()%>")
			        .appendTo(form);
		
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].productName")
				        .val("<%=list.get(i).getProductName()%>")
				        .appendTo(form);
				    
				    color = "<%=list.get(i).getProductColor()!=null && !list.get(i).getProductColor().equals("null")?list.get(i).getProductColor():"" %>";
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].color")
				        .val(color)
				        .appendTo(form);
				    
				    size = "<%=list.get(i).getProductSize()!=null && !list.get(i).getProductSize().equals("null")?list.get(i).getProductSize():"" %>";
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].size")
				        .val(size)
				        .appendTo(form);
		
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].quantity")
				        .val($(".quantity").eq(<%=i%>).text())
				        .appendTo(form);
				    
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].discount")
				        .val("<%=(int)list.get(i).getRateDiscount()%>")
				        .appendTo(form);
				    
				    $("<input>")
				        .attr("type", "hidden")
				        .attr("name", "products["+<%=i%>+"].price")
				        .val("<%=list.get(i).getPrice()%>")
				        .appendTo(form);
			<%}%>
			form.appendTo("body").submit();
		<%}%>
		}else{
			alert("최소 1개이상의 상품을 사야합니다!");
		}
	};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
