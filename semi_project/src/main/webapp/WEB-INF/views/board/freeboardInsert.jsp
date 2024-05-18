<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/freeboardInsert.css">
<section class="content">
	<h3>자유게시판</h3>
	<h6>게시글 등록하기</h6>
	<div class="br"></div>
	<div class="insertBoard1">
		<form action="<%=request.getContextPath()%>/board/insertfreeboard.do">
			<div class="menu1">
				<input type="text" name="inputTitle" placeholder="제목을 입력하세요.">
			</div>
			<div class="menu2">
				<div class="btn-container">
					<input type="button" value="등록">
					<input type="button" value="취소">
				</div>
			<textarea rows="" cols="" placeholder="내용을 입력하세요."></textarea>
			</div>
		</form>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>