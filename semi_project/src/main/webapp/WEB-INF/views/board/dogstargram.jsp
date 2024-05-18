<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board/dogstargram.css">
<section class="content">
	<div id="boardHeader">
      <h2>커뮤니티</h2>
   </div>
   <div id="boardmenu">
      <a href="<%=request.getContextPath() %>/board/freeboard.do">자유게시판</a>
      <a href="<%=request.getContextPath() %>/board/informationboard.do">공지게시판</a>
      <a href="<%=request.getContextPath() %>/board/dogstargram.do">멍스타그램</a>
   </div>
   <div class="mainview">
   		<%for(int i=0; i < 8; i++){ %>
   		<div class="post">
   			<div class="postHeader">
   				<div>
   					<img src="<%=request.getContextPath() %>/images/board/user.png" alt="사용자이미지">
   					<p>닉네임</p>
   				</div>
   				<p>등록 날짜</p>
   			</div>
   			<div class="postBody">
   				<img src="https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg" alt="">
   			</div>
   			<div class="postFooter">
   				<div>
	   				<img src="<%=request.getContextPath() %>/images/board/heart.png" alt="좋아요">
	 				<p>좋아요수</p>
	 				<img src="<%=request.getContextPath() %>/images/board/comment.png" alt="댓글">
	 				<p>댓글수</p>
	 				<img src="<%=request.getContextPath() %>/images/board/board.png" alt="클립보드">
	 				<img src="<%=request.getContextPath() %>/images/board/menu.png" alt="메뉴">
	 			</div>
	 			<div>
   					<p>제목만 보여줌</p>
   				</div>	
   			</div>
   		</div>
   		<div class="popup" id="popup">
	    <h2>개발중</h2>
   		<div id="postInfo"></div>
</div>
   		<%} %>
   </div>
   <div class="sectionFooter">
	   <div id="freeboardFooter2">
	      <a class="page1" href=""><<</a>
	      <a class="page1" href=""><</a>
	      <a class="page2" href="">1</a>
	      <a class="page2" href="">2</a>
	      <a class="page2" href="">3</a>
	      <a class="page2" href="">4</a>
	      <a class="page2" href="">5</a>
	      <a class="page1" href="">></a>
	      <a class="page1" href="">>></a>
	   </div>
	      
   </div>
</section>
<script>
	$('.post').click(e=>{
		$('.popup').toggle();
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>