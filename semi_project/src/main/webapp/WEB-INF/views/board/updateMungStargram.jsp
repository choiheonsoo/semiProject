<%@page import="java.util.List"%>
<%@page import="com.web.board.model.dto.BulletinImg"%>
<%@page import="com.web.board.model.dto.Bulletin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Bulletin b = (Bulletin)request.getAttribute("b");
	List<BulletinImg> imgs = (List<BulletinImg>)request.getAttribute("img");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/insertMungStargram.css">
<section class="content">
	 <h3>멍스타그램</h3>
    <h6>게시글 등록하기</h6>
    <div class="br"></div>
    <div class="insertBoard1">
        <form id="insertForm" action="<%=request.getContextPath()%>/board/updatemungstargramend.do" method="post" enctype="multipart/form-data">
            <div class="menu1">
                <input type="text" name="title" placeholder="제목을 입력하세요." value=<%=b.getTitle() %>>
            </div>
            <div class="menu2">
                <div class="btn-container">
                    <input type="hidden" name="id" value="<%=loginUser.getUserId()%>">
                    <%
                    int i = 0;
                    for(BulletinImg img : imgs){ 
                    	if(img.getBullNo()==b.getBullNo()){
                    %>
                    		<input type="hidden" name="oriName<%=i++ %>" value="<%=img.getBullImg()%>">
                    <%	
	                    	if(i>=1){%>
							<input type="hidden" name="oriName<%=i++ %>" value="<%=img.getBullImg()%>">	                    		
	                    	<%}		
                    	}
                    }
                    %>
                    <input type="hidden" name="no" value="<%=b.getBullNo()%>">
                    <input type="submit" value="등록">
                    <input type="button" value="취소" onclick="location.href('<%=request.getContextPath()%>/board/mungstargram.do');">
                    <input type="file" name="upfile1" class="img-input" accept="image/*">
                    <input type="file" name="upfile2" class="img-input" accept="image/*">
                </div>
                <textarea name="content" rows="" cols="" placeholder="내용을 입력하세요."><%=b.getContent() %></textarea>
            </div>
        </form>
    </div>
    <p>*사진 등록 안하면 원래 있던 사진으로 저장됩니다.</p>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
    $(document).ready(function() {
            if($("input[name=title]").val()==""){
            	alert('제목을 입력하세요.');
            	return false;
            }
        });
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>