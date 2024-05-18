	<%@page import="java.util.List"%>
<%@page import="com.web.board.model.dto.BulletinComment"%>
	<%@page import="com.web.board.model.dto.Bulletin"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%
		Bulletin b = (Bulletin)request.getAttribute("bulletin");
		List<BulletinComment> bcs = b.getComments(); 
	%>
	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/board/freeboardView.css">
	<h3>자유게시판</h3>
	<%=bcs %>
	<div class="freeboard-br"></div>
	<div class="freeboard-view-container">
		<div class="freeboard-view-header">
			<div>
				<p><%=b.getTitle() %></p>
			</div>
			<div>
				<p>
					조회수
					<%=b.getHits() %></p>
				<p>
					등록날짜
					<%=b.getRDate() %></p>
				<div>
					<img src="" width="20" height="20">
					<p><%=b.getUserId() %></p>
				</div>
			</div>
		</div>
		<div class="freeboard-view-body">
			<%=b.getContent() %>
		</div>
		<div class="freeboard-user-container">
			<%if(b.getUserId().equals(loginUser.getUserId())){ %>
			<button onclick="location">수정</button>
			<button>삭제</button>
			<%}else{ %>
			<button>신고</button>
			<%} %>
		</div>
	</div>
	<div class="freeboard-br"></div>
	<div class="freeboard-comment-container">
    <div class="freeboard-comment">
        <% if (b.getComments() != null) {
            for (BulletinComment bc : bcs) {
                if (bc.getCommentLevel() == 1) { %>
                    <div class="freeboard-comment-header">
                        <div>
                            <img src="<%=request.getContextPath()%>/images/user.png" width="30" height="30">
                            <p><%=b.getUserId() %></p>
                        </div>
                        <div class="freeboard-comment-menu">
                            <img src="<%=request.getContextPath()%>/images/menu.png" width="20" height="20"
                            	onclick="menu(event,'<%=bc.getUserId()%>');">
                            <div>
                                <button>수정</button>
                                <button>삭제</button>
                            </div>
                        </div>
                    </div>
                    <div class="freeboard-comment-body">
                        <p><%=bc.getContent()%></p>
                        <button>댓글</button>
                    </div>
                <% } else { %>
                    <div class="freeboard-comment-header">
                        <div>
                            <img src="<%=request.getContextPath()%>/images/user.png" width="30" height="30">
                            <p><%=bc.getUserId() %></p>
                        </div>
                        <div class="freeboard-comment-menu">
                            <img src="<%=request.getContextPath()%>/images/menu.png" width="20" height="20"
                            onclick="menu(event,'<%=bc.getUserId()%>');">
                            <div>
                                <button>수정</button>
                                <button>삭제</button>
                            </div>
                        </div>
                    </div>
                    <div class="freeboard-comment-body">
                        <p><%=bc.getContent() %></p>
                        <button>댓글</button>
                    </div>
                <% }
            }
        } %>
    </div>
    <form class="freeboard-comment-insert" action="">
        <input type="text" placeholder="댓글을 입력하세요.">
        <input type="submit" value="등록">
    </form>
</div>

	
	<script>
		$(".freeboard-view-header>div:last-child>div").click(e=>{
			$(".freeboard-user-container").slideToggle("visible-box");
		});
		const menu=(e,k)=>{
			if("<%=loginUser.getUserId()%>"==e){
				console.log(e.target.next());
				$(e.target).next().toggle("visible-box");
			}
		};
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>