<%@page import="java.util.List"%>
<%@page import="com.web.board.model.dto.BulletinComment"%>
	<%@page import="com.web.board.model.dto.Bulletin"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%
		Bulletin b = (Bulletin)request.getAttribute("bulletin");
		List<BulletinComment> bcs = b.getComments(); 
		System.out.println(bcs);
	%>
	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/board/freeboardView.css">
	<h3>자유게시판</h3>
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
		<div id="editForm" style="display: none;">
		    <textarea id="editContent"><%= b.getContent() %></textarea>
		    <button id="saveButton">저장</button>
		    <button id="cancelButton">취소</button>
		</div>
		<div class="freeboard-user-container">
			<%if(b.getUserId().equals(loginUser.getUserId())){ %>
			 <button id="editButton">수정</button>
			 <button onclick="location.assign('<%=request.getContextPath()%>/board/deletefreeboard.do?no=<%=b.getBullNo()%>');">삭제</button>
			<%}else{ %>
			<button>정보보기</button>
			<button>신고</button>
			<%} %>
		</div>
	</div>
	<div class="freeboard-br"></div>
	<div class="freeboard-comment-container">
    <div class="freeboard-comment">
        <% if (bcs.get(0).getUserId()!=null) {
            for (BulletinComment bc : bcs) {
                if (bc.getCommentLevel() == 1) { %>
                    <div class="freeboard-comment-header">
                        <div>
                            <img src="<%=request.getContextPath()%>/images/user.png" width="30" height="30">
                            <p><%=bc.getUserId() %></p>
                        </div>
                        <div class="freeboard-comment-menu">
                            <img src="<%=request.getContextPath()%>/images/menu.png" width="20" height="20"
                            	onclick="menu(event,'<%=bc.getUserId()%>');">
                            <div>
                            	<% if(bc.getUserId().equals(loginUser.getUserId())){%>
	                                <button>수정</button>
    	                            <button>삭제</button>
                            	<%}else{%>
                            		<button>정보보기</button>
                              		<button>신고하기</button>
                            	<% }%>
                            </div>
                        </div>
                    </div>
                    <div class="freeboard-comment-body">
                        <p><%=bc.getContent()%></p>
                        <button>댓글</button>
                    </div>
                <% } else { %>
                    <div class="freeboard-comment-header sub-comment">
                        <div>
                            <img src="<%=request.getContextPath()%>/images/user.png" width="30" height="30">
                            <p><%=bc.getUserId() %></p>
                        </div>
                        <div class="freeboard-comment-menu">
                            <img src="<%=request.getContextPath()%>/images/menu.png" width="20" height="20"
                            onclick="menu(event,'<%=bc.getUserId()%>');">
                            <div>
                                <% if(bc.getUserId().equals(loginUser.getUserId())){%>
	                                <button>수정</button>
    	                            <button>삭제</button>
                            	<%}else{%>
                            		<button>정보보기</button>
                              		<button>신고하기</button>
                            	<% }%>
                            </div>
                        </div>
                    </div>
                    <div class="freeboard-comment-body-sub">
                        <p><%=bc.getContent() %></p>
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
			if("<%=loginUser.getUserId()%>"==k){
				$(e.target).next().toggle("visible-box");
			}else{
				$(e.target).next().toggle("visible-box");
			}
		};
		
		$(document).ready(function() {
			
			// 수정 버튼 클릭 시 수정 폼 표시
		    $('#editButton').click(function() {
		        $('#editForm').show();
		        $(".freeboard-user-container").slideToggle("visible-box");
		        $(".freeboard-view-body").hide();
		    });
		    // 취소 버튼 클릭 시 수정 폼 숨김
		    $('#cancelButton').click(function() {
		        $('#editForm').hide();
		    });

		    // 저장 버튼 클릭 시 AJAX 요청
		    $('#saveButton').click(function() {
		        var updatedContent = $('#editContent').val();
		        var postId = <%= b.getBullNo() %>;

		        $.ajax({
		            url: '<%= request.getContextPath() %>/board/freeobardupdate.do',
		            method: 'POST',
		            data: { id: postId, content: updatedContent},
		            success: function(data) {
		            	console.log(data);
		                if(data > 0) {
		                	 $('#editForm').hide();
		                	 alert('수정되었습니다.');
		                	 $('.freeboard-view-body').text(updatedContent);
		                } else {
		                    alert('수정에 실패했습니다.');
		                }
		            },
		            error: function() {
		                alert('수정에 실패했습니다.');
		            }
		        });
		    });
		});
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>