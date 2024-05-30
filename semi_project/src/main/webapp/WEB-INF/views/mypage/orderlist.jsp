<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.shoppingmall.model.dto.Orders, com.web.shoppingmall.model.dto.Product,
				 java.util.Map, com.web.shoppingmall.model.dto.Review" %>
<%
	List<Orders> orders=(List<Orders>)request.getAttribute("orders");
	Map<String, Product> products=(Map<String, Product>)request.getAttribute("products");
	List<Review> reviews=(List<Review>)request.getAttribute("reviews");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/orderlist.css">
<section class="orderlistSection content">
	<div class="orderlist">
		<%if(!orders.isEmpty()){ %>
			<%for(Orders o: orders){ %>
		<div class="orderContainer">
			<div class="orderDate">
				<span><%=o.getShippingDate() %></span> 주문
			</div>
			<div class="pcontent">
				<div class="productDiv">
					<div class="status">
					<%=o.getShippingStatus() %>
					</div>
					<div class="productcontent">
						<div class="pimg">
							<img src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductCategory().getProductCategoryName() %>/<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductImgs().get("thumbnail").getProductImg()%>">
						</div>
						<div>
							<div class="pname">
								<%=products.get(String.valueOf(o.getOrderDetails().get(0).getProductKey())).getProductName() %>
								<%if(o.getOrderDetails().size()>1){ %>
									, 외 <%=o.getOrderDetails().size() %>건
								<%} %>
							</div>
							<div class="pprice"><%=o.getShippingPrice() %>원</div>
						</div>
					</div>
				</div>
				<div class="btnDiv">
					<button class="reviewBtn">리뷰 작성하기</button>
				</div>
			</div>
		</div>
			<%} %>
		<%}else{ %>
			주문한 상품이 없습니다.
		<%} %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>