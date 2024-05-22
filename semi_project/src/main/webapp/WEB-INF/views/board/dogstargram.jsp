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
	   			<div class="postBody" onclick="board_view(event,<%=b.getBullNo()%>);">
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
	   					<div>
	   					<%boolean likeByUser = bk.stream().anyMatch(e->e.getBullNo()==b.getBullNo() && e.getUserId().equals(loginUser!=null?loginUser.getUserId():""));
						if(likeByUser){%> 					
		   					<img onclick="post_like(event,<%=b.getBullNo() %>);" src="<%=request.getContextPath() %>/images/board/redheart.png" alt="좋아요">
		   				<%}else{%>
		   					<img onclick="post_like(event,<%=b.getBullNo() %>);" src="<%=request.getContextPath() %>/images/board/heart.png" alt="좋아요">
		   				<%} %>
		 				<p class='post_like<%= b.getBullNo() %>'><%= b.getLikeC() %></p>
		 				</div>
		 				<img  onclick="board_view(event,<%=b.getBullNo()%>);" src="<%=request.getContextPath() %>/images/board/comment.png" alt="댓글">
		 				<p></p>
		 				<img class="post-view"  onclick="board_view(event,<%=b.getBullNo()%>);" src="<%=request.getContextPath() %>/images/board/board.png" alt="클립보드">
		 			</div>
		 			<div>
	   					<p><%=b.getTitle() %></p>
	   				</div>	
	   			</div>
	   		</div>
   		<%} %>
	</div>
	
	<div class="popup" id="popup">
		<img id="close_popup" src="<%=request.getContextPath()%>/images/x.png">
		<div id="post_view_info">
		   		<div id="post_view_left" class="carousel slide">
				  <div class="carousel-inner" style="width:100%; height:100%;">
				  	<!-- <div class="carousel-item active" style="display:none">
				      <img src="..." class="d-block w-100" alt="..." style="display:none">
				    </div> -->
				  </div>
				 	 <button class="carousel-control-prev" type="button" data-bs-target="#post_view_left" data-bs-slide="prev">
		   				 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		   				 <span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#post_view_left" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					</button>
				</div>
		   	<div id="post_view_right">
		   		<div id="post_view_header">
		   			<div>
		   				<div>
			   				<img src="<%=request.getContextPath()%>/images/user/user.png">
			   				<p></p>
		   				</div>
		   				<p></p>
		   			</div>
		   			<p></p>
		   		</div>
		   		<hr>
		   		<div id="post_comment">
		   		</div>
		   		<div id="post_footer">
		   			<div id="post_footer_icon">
		   				<img src="<%=request.getContextPath()%>/images/board/heart.png"> 
		   				<img src="<%=request.getContextPath()%>/images/board/comment.png">
		   				<img class="post_menu" src="<%=request.getContextPath() %>/images/board/menu.png" alt="메뉴">
		   				<div class="post_footer_menu">
		   					<button id="post_update">수정하기</button>
		   					<button id="post_delete">삭제하기</button>
		   				</div>
		   			</div>
		   			<div id="post_footer_insert_comment">
		   				<form action="">
		   					<input id="post_comment_reply" type="text" placeholder="댓글 달기">
		   					<input type="submit" style="display:none">
		   				</form>
		   			</div>
		   		</div>
			</div>
		</div>
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

	//모달 창 닫기
	$('#close_popup').click(e=>{
	    $('.popup').hide();
	    $('#post_comment').empty();
	    $('.post_info *').empty();
	    $('.carousel-inner').empty();
	    currentAjaxRequest = null; // Ajax 요청 변수 초기화
	});
	/* 좋아요 ajax 처리  */
	const post_like=function(event,$no){
		 $.ajax({
		        type: 'get',
		        url: '<%=request.getContextPath()%>/board/boardlike.do?no='+$no+'&id=<%=loginUser.getUserId()%>',
		        contentType: 'application/json',
		        success: function(response) {
		            let boolValue = response.boolValue;
		            let intValue = response.intValue;
		            $(event.target).next().text(intValue);
		            if(!boolValue){
			            $(event.target).attr("src","<%=request.getContextPath()%>/images/board/redheart.png");
		            }else{
		            	 $(event.target).attr("src","<%=request.getContextPath()%>/images/board/heart.png");
		            }
		        }
		    });
	}
			
			//게시글 클릭시 모달창 로직
			const board_view=function(event,no){
			$.ajax({
				type:'get',
				url:'<%=request.getContextPath()%>/board/dogstargramview.do?no='+no,
				contentType : 'application/json',
				success:function(data){
					/* 메인 사진 슬라이드 */
					var activeExists = false;
					//메뉴 버튼 눌렀을 때
					$(".post_menu").click(function(no){
						$('.post_footer_menu').toggleClass('visible');
					});
					//삭제 버튼 눌렀을 때
					$("#post_delete").click(e=>{
						if(data.b.userId=="<%=loginUser.getUserId()%>"){
							location.assign("<%=request.getContextPath()%>/board/deletefreeboard.do?no="+data.b.bullNo+"&bull=멍스타그램");							
						}
					});
					    $.each(data.boardImg, function(i, value) {
					     if (value.bullNo == data.b.bullNo) {
					         var $carouselItem = $('<div id="post_view_left" class="carousel-item"></div>').css({"width":"100%","height":"100%"});
					         var $image = $('<img class="d-block w-100">').css({"width":"100%","height":"100%"}).attr("src", "<%=request.getContextPath()%>/upload/board/"+value.bullImg);
					         $carouselItem.append($image);
					         $('.carousel-inner').append($carouselItem);
					         if (!activeExists) {
					             $carouselItem.addClass('active');
					             activeExists = true;
					         }
					    }
					});
					
					//모달창에서 좋아요 눌렀을 때 
					$('#post_footer_icon>img').eq(0).click(e=>{
						post_like(e,data.b.bullNo);
					});
		   			
					//헤더 정보 넣기
					$.each(data.dog,function(i,value){
						$('#post_view_header img').attr("src","<%=request.getContextPath()%>/upload/user/user.png");
						if(data.b.userId==value.userId){
							$('#post_view_header img').attr("src","<%=request.getContextPath()%>/upload/user/"+value.dogImg);
						}
					});
					$('#post_view_header>div>div>p').text(data.b.userId);
					$('#post_view_header>div>p').text(data.b.rDate);
					$('#post_view_header>p').text(data.b.content);
					$.each(data.like,function(i,value){
						if(value.userId=='<%=loginUser.getUserId()%>' && value.bullNo== data.b.bullNo){
							$('#post_footer_icon>img').eq(0).attr("src","<%=request.getContextPath()%>/images/board/redheart.png");
						}
					});
					//<!--ajax로 댓글 조회 하는 ...-->
					$.each(data.b.comments,function(i,value){
						if(value.commentLevel==1){
							let $div = $('<div id="main_comment">');
					   		let $img = $('<img>').attr("scr","<%=request.getContextPath()%>/images/user/user.png").addClass('main_comment_img');
					   		$.each(data.dog,function(i,value1){
								if(value.userId==value1.userId){
							   		$img.attr("src","<%=request.getContextPath()%>/upload/user/"+value1.dogImg);
							   		return false;
								}
							});
					   		$div.append($img);
					   		$div.append($('<p>').addClass('main_comment_id').text('<%=loginUser.getUserId()%>'));
					   		$div.append($('<p>').addClass('main_comment_content').text(value.content));
					   		$("#post_comment").append($div);
					   		$("#post_comment").append($('<button>').text('댓글달기'));
						}else if(value.commentLevel==2){
							let $div = $('<div id="sub_comment">');
					   		let $img = $('<img>').attr("scr","<%=request.getContextPath()%>/images/user/user.png").addClass('sub_comment_img');
					   		$.each(data.dog,function(i,value1){
								if(value.userId==value1.userId){
							   		$img.attr("src","<%=request.getContextPath()%>/upload/user/"+value1.dogImg);
							   		return false;
								}
							});
					   		$div.append($img);
					   		$div.append($('<p>').addClass('sub_comment_id').text('<%=loginUser.getUserId()%>'));
					   		$div.append($('<p>').addClass('sub_comment_content').text(value.content));
					   		$("#post_comment").append($div);
						}
						
					});
					
					//댓글 동록
					$('#post_footer_insert_comment>form').submit(e=>{
						e.preventDefault();
						var replyContent = $('#post_comment_reply').val();
						$.ajax({  //댓글 등록 ajax
							type:"POST",
							url:"<%=request.getContextPath() %>/board/insertboardcomment.do",
							data:{
								user_id:'<%=loginUser.getUserId()%>',
								comment_level:1,
								bull_no:data.b.bullNo,
								sub_comment:'0',
								content:replyContent,
							},
							success:function(response){
								alert("댓글 등록 성공");
								$('#post_comment_reply').val('');
						   		let $div = $('<div id="main_comment">');
						   		let $img = $('<img>').attr("scr","<%=request.getContextPath()%>/upload/user/user.png").addClass('main_comment_img');
						   		$.each(data.dog,function(i,value){
									if(value.userId=="<%=loginUser.getUserId()%>"){
								   		$img.attr("src","<%=request.getContextPath()%>/upload/user/"+value.dogImg);
								   		return false;
									}
								});
						   		$div.append($img);
						   		$div.append($('<p>').addClass('main_comment_id').text('<%=loginUser.getUserId()%>'));
						   		$div.append($('<p>').addClass('main_comment_content').text(replyContent));
						   		$("#post_comment").append($div);
						   		$("#post_comment").append($('<button>').text('댓글달기'));
							}
						});
					});
					
				},
				error:function(){
					alert('실패했습니다.');
				}
			});
			$('.popup').toggle();
		}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>