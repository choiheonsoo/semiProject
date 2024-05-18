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
			<li class="board-num">번호</li>
			<li class="board-header-title">제목</li>
			<li class="board-writer">작성자</li>
			<li class="board-date">작성일</li>
			<li class="board-read">조회수</li>
		</ul>
		<%for(Bulletin b : bulletins){ %>
		<ul class="board-body">
			<li class="board-num"><%=b.getBullNo() %></li>
			<li class="board-body-title"><%=b.getTitle() %></li>
			<li class="board-writer"><%=b.getUserId() %></li>
			<li class="board-date"><%=b.getRDate() %></li>
			<li class="board-read"><%=b.getHits() %></li>
		</ul>
		<%} %>
	</div>
	<div class="visible-box" style="display: none">
		<p>제목</p>
		<p>내용</p>
		<p>닉네임</p>
	</div>
	<div id="freeboardFooter1">
		<form id="freeboardSearch" action="" method="get">
			<input style="width: 55px" type="button" value="제목"> <input
				style="width: 250px" type="text" name="freeboardSearch">
		</form>
		<button class="insert_board" onclick="location.assign('<%=request.getContextPath()%>/board/freeboardInsert.do');">글 작성</button>
	</div>
	<%=request.getAttribute("pageBar") %>
	<!-- <div id="freeboardFooter2">
		<a class="page1" href=""><<</a> <a class="page1" href=""><</a> <a
			class="page2" href="">1</a> <a class="page2" href="">2</a> <a
			class="page2" href="">3</a> <a class="page2" href="">4</a> <a
			class="page2" href="">5</a> <a class="page1" href="">></a> <a
			class="page1" href="">>></a>
	</div> -->
	
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
</script>