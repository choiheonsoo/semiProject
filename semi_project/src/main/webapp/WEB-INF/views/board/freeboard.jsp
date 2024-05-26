<%@page import="com.web.board.model.dto.Bulletin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Bulletin> bulletins = (List<Bulletin>)request.getAttribute("bulletins");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/freeboardmain.css">
<section class="content">
	<div id="boardHeader">
		<h2>커뮤니티</h2>
	</div>
	<div id="boardmenu">
		<a href="<%=request.getContextPath() %>/board/freeboard.do">자유게시판</a>
		<a href="<%=request.getContextPath() %>/board/informationboard.do">공지게시판</a>
		<a href="<%=request.getContextPath() %>/board/dogstargram.do">멍스타그램</a>
	</div>
	<div class="board">
		<ul class=board-header>
			<!-- <li class="board-num">번호</li> -->
			<li class="board-header-title">제목</li>
			<li class="board-writer">작성자</li>
			<li class="board-date">작성일</li>
			<li class="board-read">조회수</li>
		</ul>
		<%for(Bulletin b : bulletins){ 
			if(b.getCategoryNo()==2){%>
				<ul class="board-body" style="background-color:black; color:red;">
					<%-- <li class="board-num"><%=count++%></li> --%>
					<li class="board-body-title"><a style="color:red" href="<%=request.getContextPath()%>/board/boardview.do?no=<%=b.getBullNo() %>"><%=b.getTitle() %></a></li>
					<li class="board-writer"><%=b.getUserId() %></li>
					<li class="board-date"><%=b.getRDate() %></li>
					<li class="board-read"><%=b.getHits() %></li>
				</ul>
		<%	}
		}%>
		<%for(Bulletin b : bulletins){ 
			if(b.getCategoryNo()==3){%>
				<ul class="board-body">
					<%-- <li class="board-num"><%=b.getBullNo() %></li> --%>
					<li class="board-body-title"><a href="<%=request.getContextPath()%>/board/boardview.do?no=<%=b.getBullNo() %>"><%=b.getTitle() %></a></li>
					<li class="board-writer"><%=b.getUserId() %></li>
					<li class="board-date"><%=b.getRDate() %></li>
					<li class="board-read"><%=b.getHits() %></li>
				</ul>
		<%	}
		}%>
	</div>
	<div class="visible-box" style="display: none">
		<p>제목</p>
		<p>내용</p>
		<p>닉네임</p>
	</div>
	<div id="freeboardFooter1">
		<div id="freeboardSearch">
			<input style="width: 55px" name="type" type="button" value="제목">
			<input style="width: 250px" name="keyword" type="text">
		</div>
		<button class="insert_board" onclick="location.assign('<%=request.getContextPath()%>/board/freeboardInsert.do');">글 작성</button>
	</div>
	<%=request.getAttribute("pageBar") %>
	
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
   $("#freeboardSearch input").eq(0).on("click",e=>{
      $('.visible-box').toggle();
   });
   $('.visible-box>p').eq(0).on('click',e=>{
	   $(".visible-box").hide();
	   $("#freeboardSearch input").eq(0).attr("value","제목");
   });
   $('.visible-box>p').eq(1).on('click',e=>{
	   $(".visible-box").hide();
	   $("#freeboardSearch input").eq(0).attr("value","내용");
   });
   $('.visible-box>p').eq(2).on('click',e=>{
	   $(".visible-box").hide();
	   $("#freeboardSearch input").eq(0).attr("value","닉네임");
   });
   $("#freeboardSearch input[type='text']").keyup(function(e) {
	   let type = $("#freeboardSearch input[name='type']").val();
	   let keyword = $(this).val();
	   switch (type) {
	   case '제목' : type='title'; break;
	   case '내용' : type='content'; break;
	   case '닉네임' : type='user_id'; break;
	 }
	   if (e.keyCode === 13) {
	   		let contextPath = "<%=request.getContextPath()%>";
		    let url = contextPath + "/board/freeboard.do?type=" + type+"&keyword="+keyword;
		    location.href = url;
	   }
	 });
</script>