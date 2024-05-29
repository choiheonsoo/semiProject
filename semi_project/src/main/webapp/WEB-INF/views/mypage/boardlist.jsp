<%@page import="com.web.mypage.model.dto.CusttomBoardList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<CusttomBoardList> b = (List<CusttomBoardList>)request.getAttribute("bulletins");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/boardlist.css">
<section class="content">
	<div class='header_p'><p>내가 쓴 글 확인하기</p></div>
	<div class="table">
		<ul class='table_header'>
			<li style="width:10%">카테고리</li>
			<li style="width:50%">제목</li>
			<li style="width:20%">작성일</li>
			<li style="width:10%">조회수</li>
			<li style="width:10%"></li>
		</ul>
		<%if(b.size()==0){ %>
			<script>
				var noData = true;
			</script>
		<%} %>
		<%for(CusttomBoardList bo : b){ %>
		<ul class="table_body">
			<li style="width:10%">
				<%
				String cate = "";
				switch(bo.getCateNo()){
					case 3: cate = "자유게시판"; break;
					case 4: cate = "멍스타그램"; break;
				}
				%>
				<%=cate %>
			</li>
			<li style="width:50%"><%=bo.getTitle() %></li>
			<li style="width:20%"><%=bo.getRDate() %></li>
			<li style="width:10%"><%=bo.getHits() %></li>
			<li style="width:10%"><button onclick="deleteBoard(<%=bo.getBullNo()%>)">삭제</button></li>
		</ul>
		<%} %>
	</div>
	<%=b.size()>0? request.getAttribute("pageBar") :"" %>
</section>
<script>
	if(noData){
		alert("조회된 결과가 없습니다.");
	}
	const deleteBoard= function(no){
		$.ajax({
			url : "<%=request.getContextPath()%>/board/deletefreeboard.do?no="+no,
			success:function(data){
				alert('삭제 성공');
				location.reload();
			},
			error:function(){
				alert('삭제 실패');
			}
		});
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>