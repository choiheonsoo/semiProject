<%@ page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
	section.myPage{
		background-color: rgba(230,230,250,0.65);
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	section.myPage>div{
		width: 80%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	div#myPageHeader{
		margin-top: 4%;
		width: 100%;
		display: flex;
		justify-content: space-around;
	}
	div#myPageHeader strong{
		font-size:30px;
	}
	section.myPage button{
	 	border-radius: 20px;
	 	width: 120px;
	 	height: 35px;
	 	background-color: #ffeda4;
	 	border-style: none;
	 	color: #000;
	 	font-weight: bolder;
	}
	section.myPage button:hover{
		background-color: #ffbb00;
	}
	div.userInfo{
		border-radius: 5px;
		background-color: #F8F8FF;
		margin-top: 2%;
		padding: 3%;
		width: 72%;
		display: flex;
		justify-content: space-around;
		text-align: center;
		font-weight: bolder;
		color: #343a40;
		font-size: 25px;
		align-items: center;
	}
	div.userInfo p{
		margin-top: 5%;
	}
	div#lastInfo{
		margin-bottom: 4%;
	    display: flex;
	    align-items: flex-start;
	    flex-direction: column;
	}
	div#bookmark{
		display: flex;
		width: 100%;
		justify-content: space-around;
		margin-top:2%;    
	}
	
</style>
<section class="myPage">
	<div>
		<div id="myPageHeader">
			<div>
				<%if(dogImg.contains(".")){ %>
               		<img style="border-radius: 100px" src="<%=request.getContextPath() %>/upload/user/<%=dogImg %>" alt="유저" width="50" height="50">
               	<%} else { %>
               		<img src="<%=request.getContextPath() %>/images/user.png" alt="유저" width="30" height="30">
               	<%} %> 
				&nbsp;<strong> <%=loginUser.getUserId() %>님</strong>
			</div>
			<div>
				<button id="updateUser" onclick="updateInfo();">회원 수정</button>
				<button id="updateDog" onclick="updateDog();">반려견 수정</button>
			</div>
		</div>
		<div class="userInfo">
			<div style="cursor: pointer;" onclick="location.assign('<%=request.getContextPath()%>/user/wishlist.do')">
				<img src="<%=request.getContextPath() %>/images/member/heartIcon.png" alt="찜" width="40" height="40">
				<p>찜 한 상품</p>
			</div>
			<div style="cursor: pointer;" onclick="location.assign('<%=request.getContextPath()%>/user/cart.do')">
				<img src="<%=request.getContextPath() %>/images/member/cart.png" alt="장바구니" width="40" height="40">
				<p>장바구니</p>
			</div>
			<div style="cursor: pointer;" onclick="location.assign('<%=request.getContextPath()%>/mypage/writen.do?id=<%=loginUser.getUserId()%>')">
				<img src="<%=request.getContextPath() %>/images/member/board.png" alt="내가 쓴 글" width="40" height="40">
				<p>내가 쓴 글</p>
			</div>
			<div style="cursor: pointer;" >
				<img src="<%=request.getContextPath() %>/images/member/receipt.png" alt="주문 내역" width="40" height="40">
				<p>주문 내역</p>
			</div>
		</div>
		<div class="userInfo">
			<div>
				<img src="<%=request.getContextPath()%>/images/member/dollar.png" alt="산책하개 적립금" width="25" height="25"> 내 적립금
				<p><%=loginUser.getPoint()%>원</p>
			</div>
			<div>
				<img src="<%=request.getContextPath()%>/images/member/address.png" alt="내 주소" width="25" height="25"> 주소 확인
				<p><%=loginUser.getAddress()%></p>
			</div>
		</div>
		<div class="userInfo">
			<span><img src="<%=request.getContextPath()%>/images/member/mate.png" alt="산책메이트" width="25" height="25">&nbsp; 산책메이트 참여횟수</span> 
			<span><%=loginUser.getMateCount() %>&nbsp;회</span>
		</div>
		<div id="lastInfo" class="userInfo">
			<div>
				<span><img src="<%=request.getContextPath()%>/images/member/bookmark.png" alt="북마크" width="25" height="25">&nbsp; 북마크한 장소</span>
			</div>
			<div id="bookmark">
				<div>
					<img src="<%=request.getContextPath()%>/images/member/place.png" alt="핫플레이스" width="50" height="50">
					<p>편의시설</p>
				</div>
				<div>
					<img src="<%=request.getContextPath()%>/images/member/pawprints.png" alt="핫플레이스" width="50" height="50">
					<p>산책로</p>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	const updateInfo=()=>{
		location.assign("<%=request.getContextPath()%>/user/update.do");
	}
	
	const updateDog=()=>{
		location.assign("<%=request.getContextPath()%>/user/dogupdate.do")
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>