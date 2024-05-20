<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.web.shoppingmall.model.dto.Product,java.util.Map,com.web.shoppingmall.model.dto.ProductImg" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Product p=(Product)request.getAttribute("product");
	String r=(String)request.getAttribute("r");
	String imgName=null;
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shoppingmall/shoppingmalldetail.css">
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<!-- 포트원 결제 -->
<section>
	<div class="detailContainer">
		<div>
			<div class="productImg">
				<img class="mainProductImg" alt="" src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=p.getProductImgs().get("thumbnail").getProductImg()%>">
				<%for (Map.Entry<String, ProductImg> entry : p.getProductImgs().entrySet()) {
					if(!entry.getKey().equals("description")){
						imgName=entry.getValue().getProductImg();%>
						<div class="imgbordercontainer">
							<img class="productImgs" alt="" src="<%=request.getContextPath()%>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=imgName%>">
							<i class="iborder"></i>
						</div>
					<%} %>
				<% }%>
			</div>
			<div class="purchase">
				<div>
					<div class="name">
						<span><%=p.getProductName() %></span>
					</div>
					<div class="price">
						<span class="discountRate"><%=p.getRateDiscount() %></span>
						<span class="cost"><%=p.getPrice() %></span>
						<span class="salePrices"><%=p.getPrice()*(100-p.getRateDiscount())/100 %>원</span>
					</div>
					<%if(p.getProductOption()!=null){
						if(!p.getProductOption().isEmpty()){%>
							<div class="option">
								<span>옵션선택 *</span>
								<%if(p.getProductOption().stream().anyMatch(e->e.getProductSize().getPSize()!=null)){ %>
									<select name="size">
										<option value="" selected disabled>사이즈 선택</option>
										<%p.getProductOption().stream().forEach(e->{
											try{%>
											<option value="<%=e.getProductSize().getPSize()%>"><%=e.getProductSize().getPSize()%></option>
											<%}catch(IOException i){ 
												
											}
										}); %>
										<!-- <option value="S">S</option>
										<option value="M">M</option>
										<option value="L">L</option> -->
									</select>
								<%} %>
								<%if(p.getProductOption().stream().anyMatch(e->e.getColor().getColor()!=null)){ %>
									<select name="color">
										<option value="" selected disabled>색상 선택</option>
										<%p.getProductOption().stream().forEach(e->{
											try{%>
											<option value="<%=e.getColor().getColor()%>"><%=e.getColor().getColor()%></option>
											<%}catch(IOException i){ 
												
											}
										}); %>
										<!-- <option value="red">빨강</option>
										<option value="black">검정</option>
										<option value="blue">파랑</option> -->
									</select>
								<%} %>
							</div>
						<%} %>
					<%} %>
					<div class="quantity">
						<button onclick='minus()'>-</button>
						<span class="purchaseQuantity" id="purchaseQuantity">1</span>
						<button onclick='plus()'>+</button>
					</div>
					<div class="totalPrice">
						<span>총 결제가격 : <span class="totalPrice" id="totalPrice"><%=p.getPrice()*(100-p.getRateDiscount())/100 %></span>원</span> 
					</div>
					<div class="purchaseButton">
						<button onclick="movePaypage()">구매</button> <!-- 구매버튼 누르면 구매 페이지로 가야함 -->
						<button onclick="">장바구니 담기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="starReviewContainer">
		<div class="starContainer">
			<div>
				<span>사용자 총 평점</span>
			</div>
			<div class="stars">
				<%for(int i=0;i<5;i++){ %>
					<%if(i<Math.floor(p.getAvgRating())){ %>
						<div class="star full-star"></div>
					<%}else if(i==Math.floor(p.getAvgRating())){ %>
						<%if(p.getAvgRating()-Math.floor(p.getAvgRating())>0.5){ %>
							<div class="star full-star"></div>
						<%}else if(p.getAvgRating()-Math.floor(p.getAvgRating())>0){ %>
							<div class="star half-star"></div>
						<%}else{ %>
	        				<div class="star empty-star"></div>
	        			<%} %>
	        		<%}else{ %>
	        			<div class="star empty-star"></div>
	        		<%} %>
        		<%} %>
			</div>
			<div>
				<span><%=p.getAvgRating() %></span>
			</div>
		</div>
		<div class="reviews">
			<span>전체 리뷰 수</span>
			<span class="reviewCount"><%=p.getTotalReviewCount() %></span>
		</div>
	</div>
	<div class="moveMenuContainer">
		<div class="moveMenuWidth">
			<ul class="moveMenu">
				<li id="moveDetail">상세설명</li>
				<li id="moveReview">리뷰</li>
				<li id="moveQna">Q&A</li>
			</ul>
		</div>
	</div>
	<div class="detailImgContainer">
		<div class="detailImg">
			<%if(p.getProductImgs().containsKey("description")){ %>
			<div class="imgborder">
			<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/<%=p.getProductCategory().getProductCategoryName() %>/<%=p.getProductImgs().get("description").getProductImg() %>" alt="상세설명이미지">
			</div>
			<%} %>
		</div>
	</div>
	<div class="reviewContainer">
		<div>
			<span>전체 리뷰</span>
			<div class="reviewSortMenu">
				<button>최신순</button>
				<div>|</div>
				<button>리뷰순</button>
			</div>
			<div class="reviewBox">
				<div class="reviewWriter">
					<div class="reviewWriterImg">
						<img src="<%=request.getContextPath() %>/images/user.png" alt="회원프로필사진">
					</div>
					<div>
						<span class="memberName">회원닉네임</span>
						<span class="reviewDate">2024.05.13</span>
						<div>
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
						</div>
					</div>
				</div>
				<div class="reviewImgs">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
				</div>
				<div class="reviewContent">
					<span>이거 내가 먹어봤는데 맛있음 ㅇㅇ</span>
				</div>
			</div>
			<div class="reviewBox">
				<div class="reviewWriter">
					<div class="reviewWriterImg">
						<img src="<%=request.getContextPath() %>/images/user.png" alt="회원프로필사진">
					</div>
					<div>
						<span class="memberName">회원닉네임</span>
						<span class="reviewDate">2024.05.13</span>
						<div>
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
						</div>
					</div>
				</div>
				<div class="reviewImgs">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
				</div>
				<div class="reviewContent">
					<span>이거 내가 먹어봤는데 맛있음 ㅇㅇ</span>
				</div>
			</div>
			<div class="reviewBox">
				<div class="reviewWriter">
					<div class="reviewWriterImg">
						<img src="<%=request.getContextPath() %>/images/user.png" alt="회원프로필사진">
					</div>
					<div>
						<span class="memberName">회원닉네임</span>
						<span class="reviewDate">2024.05.13</span>
						<div>
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
							<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="star">
						</div>
					</div>
				</div>
				<div class="reviewImgs">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/upload/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
				</div>
				<div class="reviewContent">
					<span>이거 내가 먹어봤는데 맛있음 ㅇㅇ</span>
				</div>
			</div>
		</div>
	</div>
	<div class="qnaContainer">
		<div>
			<span class="qnaText">Q&A</span>
		</div>
	</div>
</section>
<script>
//구매페이지 이동 함수
const movePaypage=()=>{
	location.assign('<%=request.getContextPath()%>/shoppingmall/shoppingmallpay.do?productKey=<%=p.getProductKey()%>');
}
//이미지 누르면 메인이미지 바뀌게하는 함수
$(".imgbordercontainer").mouseenter(e=>{
	console.log($(e.target));
	const newimg=$(e.target).siblings("img").attr("src");
	$(e.target).parent().parent().find("i").removeClass("selectedimg");
	$(e.target).eq(0).addClass("selectedimg");
	$(e.target).parent().parent().eq(0)
	$(e.target).parent().siblings("img").attr("src",newimg);
});
//상품개수 마이너스버튼 누를 시 실행되는 함수
const minus=()=>{
	let count=$("#purchaseQuantity").text();
	if(count>1){
		count=parseInt(count)-1;
		$("#purchaseQuantity").text(count);
		$("#totalPrice").text(count*<%=p.getPrice()*(100-p.getRateDiscount())/100%>);
	}
}
//상품개수 플러스버튼 누를 시 실행되는 함수
const plus=()=>{
	let count=$("#purchaseQuantity").text();
	count=parseInt(count)+1;
	$("#purchaseQuantity").text(count);
	$("#totalPrice").text(count*<%=p.getPrice()*(100-p.getRateDiscount())/100%>);
}
//메뉴 고정 함수
$(document).ready(()=>{
    const scrollDiv = $('.moveMenuContainer');
    const fixedOffset = scrollDiv.offset().top; // 고정되기 시작할 스크롤 위치

    $(window).scroll(()=>{
        let scrollPosition = $(window).scrollTop();
        
        if (scrollPosition >= fixedOffset) {
            scrollDiv.addClass('fixed');
        } else {
            scrollDiv.removeClass('fixed');
        }
    });
});

	$(window).on('load', ()=>{
		<%if(r!=null){%>
			const mmc=$('.reviewContainer').offset().top-$('.moveMenuContainer').outerHeight()*2;
			$('html, body').scrollTop(mmc);
		<%} %>
	});
//스크롤 이동메뉴 함수
$(document).ready(()=>{
	$('#moveDetail').click((e)=>{
		$('html, body').scrollTop($('.detailImgContainer').offset().top)
	});
	$('#moveReview').click((e)=>{
		$('html, body').scrollTop($('.reviewContainer').offset().top-$('.moveMenuContainer').outerHeight())
	});
	$('#moveQna').click((e)=>{
		$('html, body').scrollTop($('.qnaContainer').offset().top-$('.moveMenuContainer').outerHeight())
	});
	$(".productImgs").eq(0).addClass("selectedImg");
	$(".iborder").eq(0).addClass("selectedimg");
})


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