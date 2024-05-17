<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
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
				<img alt="" src="<%=request.getContextPath()%>/images/shoppingmall/product/feed/royal_canin.jpg">
			</div>
			<div class="purchase">
				<div>
					<div class="name">
						<span>로얄캐닌 강아지사료 미니 인도어 어덜트 8.7KG</span>
					</div>
					<div class="price">
						<span class="discountRate">10%</span>
						<span class="cost">30000</span>
						<span class="salePrices">27000</span>
					</div>
					<div class="option">
						<span>옵션선택 *</span>
						<select name="size">
							<option value="" selected disabled>사이즈 선택</option>
							<option value="S">S</option>
							<option value="M">M</option>
							<option value="L">L</option>
						</select>
						<select name="color">
							<option value="" selected disabled>색상 선택</option>
							<option value="red">빨강</option>
							<option value="black">검정</option>
							<option value="blue">파랑</option>
						</select>
					</div>
					<div class="quantity">
						<button>-</button>
						<span class="purchaseQuantity" id="purchaseQuantity">1</span>
						<button>+</button>
					</div>
					<div class="totalPrice">
						<span>총 결제가격 : <span class="totalPrice" id="totalPrice">27000</span>원</span> 
					</div>
					<div class="purchaseButton">
						<button onclick="kakaopay()">구매</button> <!-- 구매버튼 누르면 구매 페이지로 가야함 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="starReviewContainer">
		<div class="star">
			<div>
				<span>사용자 총 평점</span>
			</div>
			<div class="stars">
				<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="별">
				<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="별">
				<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="별">
				<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="별">
				<img src="<%=request.getContextPath() %>/images/shoppingmall/star.png" alt="별">
			</div>
			<div>
				<span>4.9</span>
			</div>
		</div>
		<div class="reviews">
			<span>전체 리뷰 수</span>
			<span class="reviewCount">2014</span>
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
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
			<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="">
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
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
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
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
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
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
					<img src="<%=request.getContextPath() %>/images/shoppingmall/product/feed/royal_canin.jpg" alt="리뷰이미지">
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

//스크롤 이동메뉴 함수
$(document).ready(()=>{
	$('#moveDetail').click((e)=>{
		$('html, body').scrollTop($('.detailImgContainer').offset().top)
	});
	$('#moveReview').click((e)=>{
		$('html, body').scrollTop($('.reviewContainer').offset().top)
	});
	$('#moveQna').click((e)=>{
		$('html, body').scrollTop($('.qnaContainer').offset().top)
	});
})

//결제테스트 코드
function kakaopay(){
IMP.init("imp74680205");
IMP.request_pay({
    pg : 'kakaopay.TC0ONETIME',
    pay_method : 'card',
    merchant_uid: "order_no_0003", // 상점에서 관리하는 주문 번호
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
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>