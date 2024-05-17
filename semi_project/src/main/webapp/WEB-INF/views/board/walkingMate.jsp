<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board/walkingMate.css">
<section class="content">
	<div class="mateHeader">
		<h3>산책메이트</h3>
	</div>
	<div class="table">
		<div class="theader">
			<p>내가 모집중인 메이트</p>
			<div>
				<div>
					<p>지역시</p>
					<p>닉네임</p>
				</div>
				<div>
					<p>제목제목제목</p>
					<p><img alt="" src="">20분전</p>
				</div>
				<div>
					<img alt="" src="">
				</div>
			</div>
		</div>
		<div class="tbody">
			<ul>
				<li></li>
			</ul>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>