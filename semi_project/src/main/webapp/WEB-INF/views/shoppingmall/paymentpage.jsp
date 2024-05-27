<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.web.user.model.dto.ShippingAddress, com.web.shoppingmall.model.dto.Product" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Product> products=(List<Product>)request.getAttribute("products");
	List<Integer> quantitys=(List<Integer>)request.getAttribute("quantitys");
	int totalPrice=0;
	for(Product p:products){
		totalPrice+=p.getPrice()*(100-p.getRateDiscount())/100;
	}
%>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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
							<input type="text" name="receiverName">
						</div>
					</div>
					<div class="receiverAddressContainer">
						<div>배송주소<span class="asterisk">*</span></div>
						<div class="receiverAddress">
							<div>
								<input type="text" id="sample6_postcode" placeholder="우편번호" readonly>
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
							</div>
							<input type="text" id="sample6_address" placeholder="주소" readonly>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소">
						</div>
					</div>
					<div class="receiverPhoneContainer">
						<div>연락처<span class="asterisk">*</span></div>
						<div class="receiverPhone">
							<input type="text" name="receiverPhone" placeholder="-없이 입력">
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
				<div class="paymentdiv">
					<div class="paymentInfoContainer">
						<div>총상품가격</div>
						<div class="totalPrice"><%=totalPrice%>원</div>
					</div>
					<div class="paymentInfoContainer">
						<div>배송비</div>
						<div class="shippingPrice">0원</div>
					</div>
					<div class="paymentInfoContainer">
						<div>포인트사용</div>
						<div class="point"><input type="text" id="usePoint" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
							POINT
							<div>/ 잔여 포인트 : <%=loginUser.getPoint()%></div>
						</div>
					</div>
					<div class="paymentInfoContainer">
						<div>총결제금액</div>
						<div class="totalpay"><%=totalPrice%>원</div>
					</div>
					<div class="paymentInfoContainer">
						<div>결제방법</div>
						<div class="payment">
							<label>
								<input type="radio" name="payment" value="kakao">카카오페이
							</label>
							<label>
								<input type="radio" name="payment" value="card">
							</label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="btnContainer">
			<button class="paymentBtn" onclick="pay()">결제하기</button>
		</div>
	</div>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>

	const pay=()=>{
		const name=$("input[name=receiverName]").val(); //받는사람 이름
		const zipcode=$("#sample6_postcode").val();	//우편번호
		const address=$("#sample6_address").val();	//주소
		const detailAddress=$("#sample6_detailAddress").val();	//상세주소
		const phone=$("input[name=receiverPhone]").val();	//받는사람 폰번호
		const request=$("input[name=receiverRequest]").val();	//배송요구사항
		const namePattern=/^[가-힣]{2,4}$/;	//이름정규표현식
		const phonePattern=/^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/;	//휴대폰번호 정규표현식
		if(!namePattern.test(name)){ //이름 이상하게 입력
			alert("올바르지 않은 이름입니다.")
			return;
		}
		if(!phonePattern.test(phone)){ //휴대폰번호 이상하게 입력
			alert("올바르지 않은 휴대폰 번호 형식입니다.")
			return;
		}
		
		if(!name||!zipcode||!phone){
			alert("필요한 정보를 모두 입력해주세요");
			return;
		}
		const selectedValue = $("input[name='payment']:checked").val();
		if(selectedValue=="kakao"){
			kakaopay();
		}
	};
	$("#usePoint").keyup(e=>{
		let points=parseInt($(e.target).val());
		const pointsLeft=parseInt(<%=loginUser.getPoint()%>);
		if (isNaN(points) || points <= 0) {
			points = 0;
		}
		if(points>pointsLeft){
			$("#usePoint").val(pointsLeft);
			points=pointsLeft;
		}
		const total=parseInt(<%=totalPrice%>);
		const endPrice=total-points;
		$(".totalpay").text(endPrice+"원");
	});
	







//결제테스트 코드
<%-- function kakaopay(){
	IMP.init("imp74680205");
	IMP.request_pay({ //카카오 결제 보내기
	    pg : 'kakaopay.TC0ONETIME',
	    pay_method : 'card',
	    merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호 랜덤값 줘야함
	    name : '주문명:결제테스트',
	    amount : 1,
	    buyer_email : '<%=loginUser.getEmail()%>',
	    buyer_name : '<%=loginUser.getUserName()%>',
	    buyer_tel : '<%=loginUser.getPhone()%>',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	},async (response) => {
	    if (response.error_code != null) {
	        return alert(`결제에 실패하였습니다. 에러 내용: ${response.error_msg}`);
	    }
	    const notified = await fetch("<%=request.getContextPath()%>/shoppingmall/payment.do", {
	        method: "POST",
	        headers: { "Content-Type": "application/json" },
	        // imp_uid와 merchant_uid, 주문 정보를 서버에 전달합니다
	        body: JSON.stringify({
	          imp_uid: response.imp_uid,
	          merchant_uid: response.merchant_uid
	        })
	    });
	};
}; --%>

//카카오가 제공하는 API
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>