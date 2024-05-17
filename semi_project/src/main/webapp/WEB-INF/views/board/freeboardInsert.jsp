<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/freeboardInsert.css">
<section class="content">
	<h3>자유게시판</h3>
	<h6>게시글 등록하기</h6>
	<div class="br"></div>
	<form class="insertBoard1" action="" >
		<input type="text" name="inputTitle" placeholder="제목을 입력하세요.">
		<input type="checkbox" name="checkComment" value="check" checked>
		<label for="checkComment">댓글 허용 여부</label>
	</form>
	<form class="insertBoard2" action="">
		<div>
			<div class="menu1">
				<div id="inputImg">
					<img name= "picture"src="<%=request.getContextPath() %>/images/board/freeboard/picture.png" src="picture">사진
				</div>
				<select name="fontFamily">
					<option value="바탕체">바탕체</option>
					<option value="궁서체">궁서체</option>
					<option value="돋움체">돋움체</option>
				</select>
				<select name="fontSize">
					<option value="12">12</option>
					<option value="14">14</option>
					<option value="16">16</option>
					<option value="18">18</option>
				</select>
			</div>		
			<div class="menu2">
				<input type="button" value="등록">
				<input type="button" value="취소">
			</div>
		</div>
		<textarea rows="" cols="" placeholder="내용을 입력하세요."></textarea>
	</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>