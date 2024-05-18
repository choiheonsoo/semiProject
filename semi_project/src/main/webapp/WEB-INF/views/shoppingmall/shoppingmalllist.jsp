<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shoppingmall/shoppingmalllist.css">
<section>
	<div class="title">
		<h1>쇼핑하개</h1>
	</div>
	<div class="menu">
		<ul>
			<li><a href="" class="menuButton currentMenu">사료</a></li>
			<li><a href="" class="menuButton otherMenu">간식</a></li>
			<li><a href="" class="menuButton otherMenu">배변패드</a></li>
			<li><a href="" class="menuButton otherMenu">의류</a></li>
			<li><a href="" class="menuButton otherMenu">목욕용품</a></li>
			<li><a href="" class="menuButton otherMenu">미용기구</a></li>
			<li><a href="" class="menuButton otherMenu">하네스/리드줄</a></li>
			<li><a href="" class="menuButton otherMenu">기타</a></li>
		</ul>
	</div>
	<div class="sortMenuContainer">
		<div>
			<div class="sortMenu">최신순</div>
			<div class="sortMenu">리뷰순</div>
			<div class="sortMenu">높은가격</div>
			<div class="sortMenu">낮은가격</div>
		</div>
	</div>
	<div class="productList">
		<div>
			<ul>
				<li>
					<div>
						<div class="thumbnail">
							<div class="imagearea">
								<a href="<%=request.getContextPath()%>/shoppingmall/shoppingmalldetail.do">
									<img src="<%=request.getContextPath()%>/images/shoppingmall/product/feed/royal_canin.jpg" alt="royalcanin">
								</a>
							</div>
							<div class="iconarea">
								<div class="heartIcon">
									<img src="<%=request.getContextPath()%>/images/shoppingmall/normalheart.png" alt="찜하기">
								</div>
								<div class="cartIcon">
									<img src="<%=request.getContextPath()%>/images/shoppingmall/cart.png" alt="장바구니">
								</div>
							</div>
						</div>
						<div class="itemDescription">
							<div class="name">
								<a href="<%=request.getContextPath()%>/shoppingmall/shoppingmalldetail.do"><span>로얄캐닌 강아지사료 미니 인도어 어덜트 8.7KG</span></a>
							</div>
							<div class="price">
								<span class="discountRate">10%</span>
								<span class="cost">30000</span>
								<span class="salePrices">27000</span>
							</div>
							<div class="starReview">
								<div class="star"><img src="<%=request.getContextPath()%>/images/shoppingmall/star.png" alt="star"></div>
								<div class="rated"><span>4.9</span></div>
								<div class="review"><span>2024개 리뷰보기</span></div>
							</div>
						</div>
					</div>
				</li>
			</ul>			
		</div>
	</div>
	<div id="pagebar">
	
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>