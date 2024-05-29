<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="insert-container">
	<h1 id="form-title"></h1>
		<input type="hidden" id="type" name="type"
			value="<%= request.getParameter("type") %>">
		<div class="form-group">
			<label for="title">제목</label> 
			<input type="text" id="title" name="title" required>
		</div>
		<div class="form-group">
			<label for="description">내용</label>
			<textarea id="description" name="description" rows="10" required></textarea>
		</div>
		<div class="form-group">
			<button id="write-board-btn">등록하기</button>
		</div>
	</form>
	<div class="back-link">
		<a style="cursor:pointer;" onclick="adminMain()">메인 관리자 페이지로 돌아가기</a>
	</div>
</div>