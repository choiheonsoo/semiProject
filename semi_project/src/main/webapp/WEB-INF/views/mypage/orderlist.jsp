<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/orderlist.css">
<section class="orderlistSection content">
	<div class="orderlist">
		<div class="orderContainer">
			<div class="orderDate">
				<span>2024-05-13</span>주문
			</div>
			<div class="pcontent">
				<div class="productDiv">
					<div class="status">
					배송준비중
					</div>
					<div class="productcontent">
						<div class="pimg">
							<img src="<%=request.getContextPath()%>/upload/shoppingmall/product/feed/gungang.jpg">
						</div>
						<div>
							<div class="pname">상품이름ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ,<span class="quantity">5</span>개</div>
							<div class="pprice">900원</div>
						</div>
					</div>
				</div>
				<div class="btnDiv">
					<button class="reviewBtn">리뷰 작성하기</button>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>