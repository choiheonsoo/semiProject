<%@page import="com.web.board.model.dto.BulletinLike"%>
<%@page import="com.web.board.model.dto.BulletinImg"%>
<%@page import="com.web.board.model.dto.Bulletin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Bulletin> bulletins = (List<Bulletin>)request.getAttribute("bulletins");
	List<BulletinImg> imgs = (List<BulletinImg>)request.getAttribute("imgs");
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	String writerDogImg ="user.png";
	List<BulletinLike> bk = (List<BulletinLike>)request.getAttribute("bk");
%>
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
   		<%for(Bulletin b : bulletins){ %>
	   		<div class="post">
	   			<div class="postHeader">
	   				<div>
	   					<%if(dogs.stream().anyMatch(e->b.getUserId().equals(e.getUserId()))){
								String img=dogs.stream().filter(e->b.getUserId().equals(e.getUserId())).map(e->e.getDogImg()).toList().get(0);%>
								<img src="<%=request.getContextPath()%>/upload/user/<%=img %>" width="30" height="30">
							<%
							}else{%>
								<img src="<%=request.getContextPath()%>/upload/user/user.png" width="30" height="30">
							<%}%>
	   					<p><%=b.getUserId()%></p>
	   				</div>
	   				<p><%=b.getRDate() %></p>
	   			</div>
	   			<div class="postBody">
	   				<%if(imgs.size()>0){
						for(BulletinImg bi : imgs){
							if(bi.getBullNo()==b.getBullNo()){%>	   					
	   							<img src="<%=request.getContextPath() %>/upload/board/<%=bi.getBullImg() %>" alt="썸네일이미지">
	   						<%break;
	   						}
	   					} 
	   				}%>
	   				
	   			</div>
	   			<div class="postFooter">
	   				<div>
	   					<%boolean likeByUser = bk.stream().anyMatch(e->e.getBullNo()==b.getBullNo() && e.getUserId().equals(loginUser.getUserId()));
						if(likeByUser){%> 					
		   					<img onclick="post_like(event,<%=b.getBullNo() %>);" src="<%=request.getContextPath() %>/images/board/redheart.png" alt="좋아요">
		   				<%}else{%>
		   					<img onclick="post_like(event,<%=b.getBullNo() %>);" src="<%=request.getContextPath() %>/images/board/heart.png" alt="좋아요">
		   				<%} %>
		 				<p class='post_like<%= b.getBullNo() %>'><%= b.getLikeC() %></p>
		 				<img src="<%=request.getContextPath() %>/images/board/comment.png" alt="댓글">
		 				<p><%=b.getComments().size() %></p>
		 				<img class="post-view" src="<%=request.getContextPath() %>/images/board/board.png" alt="클립보드">
		 				<img src="<%=request.getContextPath() %>/images/board/menu.png" alt="메뉴">
		 			</div>
		 			<div>
	   					<p><%=b.getTitle() %></p>
	   				</div>	
	   			</div>
	   		</div>
	   		<div class="popup" id="popup">
			    <h2>개발중</h2>
		   		<div id="postInfo"></div>
			</div>
   		<%} %>
	</div>
	<div id="freeboardFooter1">
			<div id="freeboardSearch">
				<input style="width: 55px" name="type" type="button" value="제목">
				<input style="width: 250px" name="keyword" type="text">
			</div>
		<button class="insert_board" onclick="location.assign('<%=request.getContextPath()%>/board/mungstargraminsert.do');">글 작성</button>
	</div> 
	<%=request.getAttribute("pageBar") %>
</section>
<script>
	const post_like=function(event,$no){
		 $.ajax({
		        type: 'get',
		        url: '<%=request.getContextPath()%>/board/dogstargramview.do?no='+$no+'&id=<%=loginUser.getUserId()%>',
		        contentType: 'application/json',
		        success: function(response) {
		            let boolValue = response.boolValue;
		            let intValue = response.intValue;
		            console.log(event.target);
		            $(event.target).next().text(intValue);
		            if(!boolValue){
			            $(event.target).attr("src","<%=request.getContextPath()%>/images/board/redheart.png");
		            }else{
		            	 $(event.target).attr("src","<%=request.getContextPath()%>/images/board/heart.png");
		            }
		        }
		    });
	}
	$('.post-view').eq(2).click(e=>{
		$('.popup').toggle();
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>