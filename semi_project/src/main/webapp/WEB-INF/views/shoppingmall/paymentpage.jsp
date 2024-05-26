<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.user.model.dto.ShippingAddress" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>


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
					<button class="shippingAddressChangeBtn">배송지 변경</button>
				</div>
				<div>
					<%if(loginUser.getShippingAddress().get(0).getShippingAddressKey()==0){ %>
						<div class="receiverNameContainer">
							<div>이름<span class="asterisk">*</span></div>
							<div class="receiverName">
								<input type="text" name="receiverName">
							</div>
						</div>
						<div class="receiverAddressContainer">
							<div>배송주소<span class="asterisk">*</span></div>
							<div class="receiverAddress"><input type="text" name="receiverAddress"></div>
						</div>
						<div class="receiverPhoneContainer">
							<div>연락처<span class="asterisk">*</span></div>
							<div class="receiverPhone"><input type="text" name="receiverPhone"></div>
						</div>
						<div class="requestContainer">
							<div>배송 요청사항</div>
							<div class="receiverRequest"><input type="text" name="receiverRequest"></div>
						</div>
					<%}else{ %>
						<%for(ShippingAddress sa:loginUser.getShippingAddress()){ %>
							<%if(sa.getDefaultShippingAddress().equals("Y")){ %>
								<div class="receiverNameContainer">
									<div>이름<span class="asterisk">*</span></div>
									<div class="receiverName">
										<input type="text" name="receiverName"
										value="<%=sa.getRecipientName()%>">
									</div>
								</div>
								<div class="receiverAddressContainer">
									<div>배송주소<span class="asterisk">*</span></div>
									<div class="receiverAddress"><input type="text" name="receiverAddress" 
									value="<%=sa.getShippingAddress()%>"></div>
								</div>
								<div class="receiverPhoneContainer">
									<div>연락처<span class="asterisk">*</span></div>
									<div class="receiverPhone"><input type="text" name="receiverPhone"
									value="<%=sa.getShippingPhone()%>"></div>
								</div>
								<div class="requestContainer">
									<div>배송 요청사항</div>
									<div class="receiverRequest"><input type="text" name="receiverRequest"></div>
								</div>
							<%} %>
						<%} %>
					<%} %>
				</div>
			</div>
		</div>
		<div class="productsContainer">
			<div>
				<h2>상품 정보</h2>
				<div>
				
				</div>
			</div>
		</div>
		<div class="paymentContainer">
			
		</div>
		<div class="btnContainer">
			<button class="paymentBtn">결제하기</button>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>