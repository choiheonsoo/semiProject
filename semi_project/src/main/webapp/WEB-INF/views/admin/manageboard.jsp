<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.board.model.dto.Bulletin, java.util.List"%>
<%
	List<Bulletin> bulletins = (List<Bulletin>)request.getAttribute("bulletins");
	String category = "";
	switch(bulletins.get(0).getCategoryNo()){
		case 1: category = "공지"; break;
		case 2: category = "이벤트"; break;
		case 3: category = "자유"; break;
		case 4: category = "멍스타그램"; break;
		default: category = "왜안돼 뿌에에엥 ㅠㅠ"; break;
	}
%>
<h2>산책하개 <%=category %> 게시판 관리<small style="font-size: 14px; font-style:italic;"><%=category.equals("공지") || category.equals("이벤트")?"게시글 수정 및 삭제는 클릭하여 이동하신 후 프로필을 선택하세요.":"" %></small></h2>
<%if(category.equals("공지")) {%>
<button class="insert-board-btn" value="1">공지글 등록</button>
<%} else if(category.equals("이벤트")){ %>
<button class="insert-board-btn" value="2">이벤트글 등록</button>
<%} %>
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
				<tr>
					<td class="board-info"><%=b.getBullNo() %></td>
					<td class="board-info"><%=b.getUserId() %></td>
					<td class="board-info"><%=b.getTitle()%></td>
					<td class="board-info"><%=b.getContent()%></td>
					<td class="board-info"><%=b.getRDate()%></td>
					<td class="board-info"><%=b.getHits()%></td>
					<td class="board-info"><%=b.getLikeC()%></td>
					<td><button class="delete-board-btn">삭제</button></td>
				</tr>	
				<%}%>
			<%}%>
	</table>
	<div>
		<%=request.getAttribute("pageBar") %>
	</div>
</div>