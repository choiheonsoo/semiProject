<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.board.model.dto.Bulletin, java.util.List"%>
<%
	List<Bulletin> bulletins = (List<Bulletin>)request.getAttribute("bulletins");
%>
<h2>산책하개 자유게시판 관리</h2>
<div class="adminpage-container">
	<table>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>내용</th>
				<th>등록일</th>
				<th>조회수</th>
				<th>좋아요수</th>
				<th>삭제</th>
			</tr>
			<%if(!bulletins.isEmpty()){ 
				for(Bulletin b:bulletins) {%>
				<tr class="user-info">
					<td><%=b.getBullNo() %></td>
					<td><%=b.getUserId() %></td>
					<td><%=b.getTitle()%></td>
					<td><%=b.getContent()%></td>
					<td><%=b.getRDate()%></td>
					<td><%=b.getHits()%></td>
					<td><%=b.getLikeC()%></td>
					<td><button class="resign-btn">삭제</button></td>
				</tr>	
				<%}%>
			<%}%>
	</table>
	<div>
		<%=request.getAttribute("pageBar") %>
	</div>
</div>