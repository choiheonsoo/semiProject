<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.web.shoppingmall.model.dto.Product" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Product> products=(List<Product>)request.getAttribute("products");
	String pagebar=(String)request.getAttribute("pagebar");
	int category=(int)request.getAttribute("category");
	int s=(int)request.getAttribute("sort");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shoppingmall/shoppingmalllist.css">

<section>
	<div class="title">
		<h1>쇼핑하개</h1>
	</div>
	<div class="menu">
		<ul>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=1" class="menuButton">사료</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=2" class="menuButton">간식</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=3" class="menuButton">배변패드</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=4" class="menuButton">의류</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=5" class="menuButton">목욕용품</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=6" class="menuButton">미용기구</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=7" class="menuButton">하네스/리드줄</a></li>
			<li><a href="<%=request.getContextPath() %>/shoppingmall/shoppingmalllist.do?category=8" class="menuButton">기타</a></li>
		</ul>
	</div>
	<div class="sortMenuContainer">
		<div>
			<div class="sortMenu" onclick="sort(1)">최신순</div>
			<div class="sortMenu" onclick="sort(2)">리뷰순</div>
			<div class="sortMenu" onclick="sort(3)">높은가격</div>
			<div class="sortMenu" onclick="sort(4)">낮은가격</div>
		</div>
	</div>
	<div class="productList">
		<div>
			<%if(!products.isEmpty()){ %>
				<ul>
					<%for(Product p:products){  %>
						<li>
							<div>
								<div class="thumbnail">
									<div class="imagearea">
										<a href="<%=request.getContextPath()%>/shoppingmall/shoppingmalldetail.do?productKey=<%=p.getProductKey()%>">
											<img src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName()%>/<%=p.getProductImgs().get("thumbnail").getProductImg() %>" alt="productImg">
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
										<a href="<%=request.getContextPath()%>/shoppingmall/shoppingmalldetail.do?productKey=<%=p.getProductKey()%>"><span><%=p.getProductName() %></span></a>
									</div>
									<div class="price">
										<span class="discountRate"><%=p.getRateDiscount() %>%</span>
										<span class="cost"><%=p.getPrice() %></span>
										<span class="salePrices"><%=p.getPrice()*(100-p.getRateDiscount())/100 %></span>
									</div>
									<div class="starReview">
										<div class="star"><img src="<%=request.getContextPath()%>/images/shoppingmall/star.png" alt="star"></div>
										<div class="rated"><span><%=Math.round(p.getAvgRating() * 10.0) / 10.0 %></span></div>
										<div class="review" onclick='location.assign("<%=request.getContextPath()%>/shoppingmall/shoppingmalldetail.do?productKey=<%=p.getProductKey()%>&r=1")'><span><%=p.getTotalReviewCount() %>개 리뷰보기</span></div>
									</div>
								</div>
							</div>
						</li>
					<%} %>
				</ul>
			<%}else{ %>			
				<h1>상품이 없습니다 ㅎㅎ;;</h1>
			<%} %>
		</div>
	</div>
	<div id="pagebar">
		<%=pagebar %>
	</div>
</section>
<script>
	// 카테고리 메뉴 스타일, 정렬메뉴 스타일 입히는 함수
	(()=>{
	    <%for(int i=0;i<8;i++){ %>
	    	<%if(i==category-1){%>
	    		$(".menu>ul").children().eq(<%=i%>).children().eq(0).addClass("currentMenu");
	    	<%}else{ %>
	    		$(".menu>ul").children().eq(<%=i%>).children().eq(0).addClass("otherMenu");
	    	<%} %>
	    <%} %>
	    <%-- <%switch(s){
	    	case "1":%>$(".") <%break;
	    	case "2":%> <%break;
	    	case "3":%> <%break;
	    	case "4":%> <%break;
	    }%> --%>
	    $(".sortMenu").eq(<%=s-1%>).addClass("selectedSortMenu");
	})();
	
	// 상품이미지 위에 마우스 올려놓으면 찜하기, 장바구니 버튼 나오게 하기
	$(".imagearea").mouseenter((e)=>{
		$(e.target).parent().parent().next().css("display","flex");
	});
	$(".iconarea").mouseenter((e)=>{
		$(e.target).parent().css("display","flex");
	});
	// 상품이미지 위에서 마우스가 떠났을 때 찜하기, 장바구니 버튼 사라지게 하기
	$(".imagearea").mouseleave((e)=>{
		$(e.target).parent().parent().next().css("display","none");
	});
	$(".iconarea").mouseleave((e)=>{
		$(e.target).parent().css("display","none");
	});
	
	const sort=(s)=>{
		switch(s){
			case 1: location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=<%=category%>&sort=1'); break;
			case 2: location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=<%=category%>&sort=2'); break;
			case 3: location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=<%=category%>&sort=3'); break;
			case 4: location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmalllist.do?category=<%=category%>&sort=4'); break;
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>