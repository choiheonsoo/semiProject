<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board/informationBoardMain.css">
  
<section class="content">
   <div id="boardHeader">
      <h2>정보게시판</h2>
   </div>
   <div id="boardmenu">
      <a href="<%=request.getContextPath() %>/board/freeboard.do">자유게시판</a>
      <a href="<%=request.getContextPath() %>/board/informationboard.do">정보게시판</a>
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
   	<%for(int i = 0; i < 10; i++){ %>
   	<ul class="board-body">
   		<li class="board-num">1212</li>
   		<li class="board-body-title">요약</li>
   		<li class="board-writer">MJ</li>
   		<li class="board-date">24.04.28</li>
   		<li class="board-read">211</li>
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
         <input style="width:55px" type="button" value="제목">
         <input style="width:250px"type="text" name="freeboardSearch">
      </form>
   </div>
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
 