<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.user.model.dto.ShippingAddress, com.web.shoppingmall.model.dto.Product" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Product> products=(List<Product>)request.getAttribute("products");
	List<Integer> quantitys=(List<Integer>)request.getAttribute("quantitys");
%>
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<!-- 포트원 결제 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shoppingmall/paymentpage.css">
<section>
	<div class="paymentpageContainer">
		<div class="paymentpageTitle">
			<h3 class="title">주문/결제</h3>
		</div>
		<div class="buyerContainer">
			<div>
				<h2>구매자 정보</h2>
				<div>
					<div class="buyerNameContainer">
						<div>이름</div>
						<div class="buyerName"><%=loginUser.getUserName() %></div>
					</div>
					<div class="buyerEmailContainer">
						<div>이메일</div>
						<div class="buyerEmail"><%=loginUser.getEmail() %></div>
					</div>
					<div class="buyerPhoneContainer">
						<div>휴대폰 번호</div>
						<div class="buyerPhone"><%=loginUser.getPhone() %></div>
					</div>
				</div>
			</div>
		</div>
		<div class="receiverContainer">
			<div>
				<div class="receiverTitle">
					<h2>받는사람 정보</h2>
					<!-- <button class="shippingAddressChangeBtn">배송지 변경</button> -->
				</div>
				<div>
					<div class="receiverNameContainer">
						<div>이름<span class="asterisk">*</span></div>
						<div class="receiverName">
							<input type="text" name="receiverName" required>
						</div>
					</div>
					<div class="receiverAddressContainer">
						<div>배송주소<span class="asterisk">*</span></div>
						<div class="receiverAddress">
							<input type="text" name="receiverAddress" required>
						</div>
					</div>
					<div class="receiverPhoneContainer">
						<div>연락처<span class="asterisk">*</span></div>
						<div class="receiverPhone">
							<input type="text" name="receiverPhone" required>
						</div>
					</div>
					<div class="requestContainer">
						<div>배송 요청사항</div>
						<div class="receiverRequest">
							<input type="text" name="receiverRequest">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="productsContainer">
			<div>
				<h2>상품 정보</h2>
				<div class="products">
					<%if(!products.isEmpty()){ %>
					<%for(int i=0;i<products.size();i++){ %>
					<div>
						<div class="productName">
							<%=products.get(i).getProductName() %>
						</div>
						<div class="productOption">
							<%=products.get(i).getProductOption().get(0).getColor().getColor() %>, <%=products.get(i).getProductOption().get(0).getProductSize().getPSize() %>
						</div>
						<div class="productQuantity">
							수량 <%=quantitys.get(i) %>개
						</div>
					</div>
					<%} %>
					<%} %>
				</div>
			</div>
		</div>
		<div class="paymentContainer">
			<div>
				<h2>결제정보</h2>
				<div>
				
				</div>
			</div>
		</div>
		<div class="btnContainer">
			<button class="paymentBtn">결제하기</button>
		</div>
	</div>
</section>
<script>








//결제테스트 코드
/* function kakaopay(){
IMP.init("imp74680205");
IMP.request_pay({
    pg : 'kakaopay.TC0ONETIME',
    pay_method : 'card',
    merchant_uid: "order_no_0004", // 상점에서 관리하는 주문 번호 랜덤값 줘야함
    name : '주문명:결제테스트',
    amount : 1,
    buyer_email : 'dpdlxj12@naver.com',
    buyer_name : '구매자이름',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
}, function(rsp) {
    if ( rsp.success ) {
    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
    	jQuery.ajax({
    		url: "/payments/complete", //결제 서블릿으로 넘어가면 될듯.
    		type: 'POST',
    		dataType: 'json',
    		data: {
	    		imp_uid : rsp.imp_uid
	    		//기타 필요한 데이터가 있으면 추가 전달
    		}
    	}).done(function(data) {
    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
    		if ( everythings_fine ) {
    			var msg = '결제가 완료되었습니다.';
    			msg += '\n고유ID : ' + rsp.imp_uid;
    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
    			msg += '\결제 금액 : ' + rsp.paid_amount;
    			msg += '카드 승인번호 : ' + rsp.apply_num;
    			
    			alert(msg);
    		} else {
    			//[3] 아직 제대로 결제가 되지 않았습니다.
    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
    		}
    	});
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        
        alert(msg);
    }
});
}; */
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>