<%@page import="java.util.List"%>
<%@page import="com.web.board.model.dto.BulletinComment"%>
<%@page import="com.web.board.model.dto.Bulletin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
		Bulletin b = (Bulletin)request.getAttribute("bulletin");
		List<BulletinComment> bcs = b.getComments(); 
		List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
		String writerDogImg ="user.png";
		if(dogs!=null){
			for(Dog d : dogs){
				if(b.getUserId().equals(d.getUserId())){
					writerDogImg=d.getDogImg();
				}
			}
		}
	%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/freeboardView.css">
<h3>자유게시판</h3>
<div class="freeboard-br"></div>
<div id="editForm_button_container">
	<button id="saveButton">저장</button>
	<button id="cancelButton">취소</button>
</div>


<div id="report-container">
    <span class="close-modal">&times;</span>
    <div class="category">신고 카테고리</div>
    <button class="report-button">욕설</button>
    <button class="report-button">음란물</button>
    <button class="report-button">도배</button>
    <textarea id="report-textarea" placeholder="신고 내용을 입력해주세요"></textarea>
    <button class="submit-button">신고하기</button>
    <p id='report-id' style="display:none"></p>
    <p id='report-no' style="display:none"></p>
    <p id="reported-id" style="display:none"></p>
</div>


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
				<img
					src="<%=request.getContextPath() %>/upload/user/<%=writerDogImg%>">
				<p><%=b.getUserId() %></p>
			</div>
		</div>
	</div>
	<div class="freeboard-view-body">
		<%=b.getContent() %>
	</div>
	<div id="editForm" style="display: none;">
		<textarea id="editContent"><%= b.getContent() %></textarea>
	</div>
	<div class="freeboard-user-container">
		<%if(b.getUserId().equals(loginUser==null?"":loginUser.getUserId())){ %>
		<button id="editButton">수정</button>
		<button
			onclick="location.assign('<%=request.getContextPath()%>/board/deletefreeboard.do?no=<%=b.getBullNo()%>');">삭제</button>
		<%}else{ %>
		<button>정보보기</button>
		<button onclick="report_container_show('<%=b.getUserId() %>',<%=b.getBullNo()%>,'<%=loginUser.getUserId()%>');">신고하기</button>
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
					<%if(dogs.stream().anyMatch(e->bc.getUserId().equals(e.getUserId()))){
						String img=dogs.stream().filter(e->bc.getUserId().equals(e.getUserId())).map(e->e.getDogImg()).toList().get(0);%>
						<img src="<%=request.getContextPath()%>/upload/user/<%=img %>" width="30" height="30">
					<%}else{%>
						<img src="<%=request.getContextPath()%>/upload/user/user.png" width="30" height="30">
					<%}%>
							<p><%=bc.getUserId() %></p>
						</div>
					<div class="freeboard-comment-menu">
						<img src="<%=request.getContextPath()%>/images/menu.png" width="20"
							height="20" onclick="menu(event,'<%=bc.getUserId()%>');">
						<div>
							<% if(bc.getUserId().equals(loginUser==null?"":loginUser.getUserId())){%>
								<button onclick="location.assign('<%=request.getContextPath()%>/board/deletecomment.do?bcNo=<%=bc.getMainComment()%>&bNo=<%=bc.getBullNo()%>')">삭제</button>
							<%}else{%>
								<button>정보보기</button>
								<button onclick="report_container_show('<%=b.getUserId() %>',<%=b.getBullNo()%>,'<%=loginUser.getUserId()%>');">신고하기</button>
							<%}%>
						</div>
					</div>
				</div>
				<div class="freeboard-comment-body">
					<p><%=bc.getContent()%></p>
					<button onclick="btn_reply(event,<%=bc.getMainComment()%>);">댓글</button>
				</div>
		<% } else { %>
					<div class="freeboard-comment-header sub-comment">
						<div>
							<%if(dogs.stream().anyMatch(e->bc.getUserId().equals(e.getUserId()))){
								String img=dogs.stream().filter(e->bc.getUserId().equals(e.getUserId())).map(e->e.getDogImg()).toList().get(0);%>
								<img src="<%=request.getContextPath()%>/upload/user/<%=img %>" width="30" height="30">
							<%}else{%>
								<img src="<%=request.getContextPath()%>/upload/user/user.png" width="30" height="30">
							<%}%>
							<p><%=bc.getUserId() %></p>
						</div>
						<div class="freeboard-comment-menu">
							<img src="<%=request.getContextPath()%>/images/menu.png" width="20"
								height="20" onclick="menu(event,'<%=bc.getUserId()%>');">
							<div>
								<% if(bc.getUserId().equals(loginUser==null?"":loginUser.getUserId())){%>
								<button onclick="location.assign('<%=request.getContextPath()%>/board/deletecomment.do?bcNo=<%=bc.getMainComment()%>&bNo=<%=bc.getBullNo()%>')">삭제</button>
								<%}else{%>
								<button>정보보기</button>
								<button onclick="report_container_show('<%=b.getUserId() %>',<%=b.getBullNo()%>,'<%=loginUser.getUserId()%>');">신고하기</button>
								<% }%>
							</div>
						</div>
					</div>
					<div class="freeboard-comment-body-sub">
						<p><%=bc.getContent() %></p>
					</div>
		<% 		}
            }
        } 
        %>
	</div>
	<form class="freeboard-comment-insert" action="<%=request.getContextPath() %>/board/insertboardcomment.do">
		<input type="hidden" name="user_id" value=<%=loginUser!=null?loginUser.getUserId():"" %>>
		<input type="hidden" name="comment_level" value="1">
		<input type="hidden" name="bull_no" value="<%=b.getBullNo() %>">
		<input type="hidden" name="sub_comment" value="0">
		<input type="text" name="content" placeholder="댓글을 입력하세요.">
		<input type="submit" value="등록">
	</form>
</div>


<script>
		$('h3').eq(0).click(e=>{
			location.assign("<%=request.getContextPath()%>/board/freeboard.do");
		});
		$(".freeboard-view-header>div:last-child>div").click(e=>{
			$(".freeboard-user-container").slideToggle("visible-box");
		});
		const menu=(e,k)=>{
			if("<%=loginUser==null?"":loginUser.getUserId()%>"==k){
				$(e.target).next().toggle("visible-box");
			}else{
				$(e.target).next().toggle("visible-box");
			}
		};
		//신고버튼 누를 때 신고 폼 나오게하기
		const report_container_show= function(reportedId,no,id){
			$('#report-container').css('display','block');
			$('#report-id').text(id);
			$('#report-no').text(no);
			$('#reported-id').text(reportedId);
			$('.report-button').css('backgroundColor','red');
			$('#report-textarea').val('');
		}
		
		//신고버튼 모달창 닫기
		$('.close-modal').click(e=>{
			$('#report-container').css('display','none');
			$('#report-id').text('');
			$('#report-no').text('');
			$('#reported-id').text('');
		});
		
		//신고 카타고리를 누르면 색상 변경
		var reportButtons = document.querySelectorAll(".report-button");
		   reportButtons.forEach(function(button) {
		       button.addEventListener("click", function() {
	           // 모든 버튼의 배경색을 초기화
	           reportButtons.forEach(function(btn) {
	               btn.style.backgroundColor = "";
	           });
	            // 클릭한 버튼의 배경색 변경
	            button.style.backgroundColor = "lightgray";
	            var selectedCategory = button.textContent;
	            console.log("사용자가 선택한 신고 카테고리:", selectedCategory);
	        });
	    });
		
		// AJAX로 신고 정보 전송
		    $('.submit-button').click(function() {
		        var selectedCategory = $('.report-button[style="background-color: lightgray;"]').text();
		        var reportContent = $('#report-textarea').val();
		        
		        if( $('#reported-id').text()!='admin'){
		        	if(selectedCategory!=''){
			        	// 선택된 카테고리와 신고 내용을 서버로 전송
				        $.ajax({
				            url: '<%=request.getContextPath()%>/board/boardreport.do',
				            type: 'POST',
				            data: {
				                category: selectedCategory,
				                content: reportContent,
				                id: $('#report-id').text(),
				                reportedId:$('#reported-id').text(),
				                no: $('#report-no').text()
				            },
				            success: function(response) {
				                // 성공 시 처리
				                alert('신고가 성공적으로 전송되었습니다.');
						        $('#report-container').css('display','none');
				                // 추가로 원하는 처리 가능
				            },
				            error: function(xhr, status, error) {
				                // 실패 시 처리
				                alert('신고 전송 중 오류 발생:');
				                // 추가로 원하는 처리 가능
				            }
				        });
			        }else{
			        	alert('신고 종류를 선택해주세요');
			        }
		        }else{
		        	alert("관리자를 신고하면 안돼요~");
		        }
		        
		    });
		   
		$(document).ready(function() {
			// 수정 버튼 클릭 시 수정 폼 표시
		    $('#editButton').click(function() {
		        $('#editForm').show();
		        $(".freeboard-user-container").slideToggle("visible-box");
		        $(".freeboard-view-body").hide();
		        $('#editForm_button_container').css('display','block');
		    });
		    // 취소 버튼 클릭 시 수정 폼 숨김
		    $('#cancelButton').click(function() {
		        $('#editForm').hide();
		        $('#editForm_button_container').css('display','none');
		    });

		    // 저장 버튼 클릭 시 AJAX 요청
		    $('#saveButton').click(function() {
		        var updatedContent = $('#editContent').val();
		        var postId = <%= b.getBullNo() %>;
		        $('#editForm_button_container').css('display','none');
		        $.ajax({
		            url: '<%= request.getContextPath() %>/board/freeobardupdate.do',
		            method: 'POST',
		            data: { id: postId, content: updatedContent},
		            success: function(data) {
		                if(data > 0)	 {
		                	 $('#editForm').hide();
		                	 $('.freeboard-view-body').css("display","block").text(updatedContent);
		                	 alert("수정 성공하였습니다.");
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
		
		$(".freeboard-comment-insert>input[type='text']").click(e=>{
			<%if(loginUser==null){%>
				alert("로그인 후 이용하세요.");
				location.assign('<%=request.getContextPath()%>/user/login.do');
			<%}%>			
		});
		
		$(".freeboard-comment-insert>input[type='submit']").click(e=>{
			if($(".freeboard-comment-insert>input[type='text']").val()==""){
				<%if(loginUser==null){%>
					alert("로그인 후 이용하세요.");
					location.assign('<%=request.getContextPath()%>/user/login.do');
				<%}else{%>
					alert("댓글을 입력하세요.");
					$(".freeboard-comment-insert>input[type='text']").focus();
					e.preventDefault();
				<%}%>
			}
		});
		
		const btn_reply=(e,no)=>{
			$form=$(".freeboard-comment-insert").clone();
			$form.find('input[name=comment_level]').val('2');
			$form.find('input[name=sub_comment]').val(no);
			$form.find('input[type=submit]').css('display','none');
			$form.addClass('sub_comment');
			$(e.target).parent().append($form);
		}
		 $(document).on('focusout', '.sub_comment', function() {
		        $(this).hide(); // 해당 요소 숨기기
		    });
		
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>