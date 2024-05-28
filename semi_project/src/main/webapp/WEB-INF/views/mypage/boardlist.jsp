<%@page import="com.web.board.model.dto.Bulletin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Bulletin> b = (List<Bulletin>)request.getAttribute("bulletins");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/boardlist.css">
<section class="content">
	<div class='header_p'><p>내가 쓴 글 확인하기</p></div>
	<div class="table">
		<ul class='table_header'>
			<li style="width:70%">제목</li>
			<li style="width:10%">작성일</li>
			<li style="width:10%">조회수</li>
			<li style="width:10%"></li>
		</ul>
		<%for(Bulletin bo : b){ %>
		<ul class="table_body">
			<li style="width:10%"><%=bo.getCategoryNo() %></li>
			<li style="width:60%"><%=bo.getTitle() %></li>
			<li style="width:10%"><%=bo.getRDate() %></li>
			<li style="width:10%"><%=bo.getHits() %></li>
			<li style="width:10%"><button>삭제</button></li>
		</ul>
		<%} %>
	</div>
	<%=request.getAttribute("pageBar") %>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>