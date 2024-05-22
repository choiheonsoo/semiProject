<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/board/insertMungStargram.css">
<section class="content">
	 <h3>멍스타그램</h3>
    <h6>게시글 등록하기</h6>
    <div class="br"></div>
    <div class="insertBoard1">
        <form id="insertForm" action="<%=request.getContextPath()%>/board/insertmungstargramend.do" method="post" enctype="multipart/form-data">
            <div class="menu1">
                <input type="text" name="title" placeholder="제목을 입력하세요.">
            </div>
            <div class="menu2">
                <div class="btn-container">
                    <input type="hidden" name="id" value="<%=loginUser.getUserId()%>">
                    <input type="submit" value="등록">
                    <input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/board/freeboard.do';">
                    <input type="file" name="upfile1" class="img-input" accept="image/*">
                    <input type="file" name="upfile2" class="img-input" accept="image/*">
                </div>
                <textarea name="content" rows="" cols="" placeholder="내용을 입력하세요."></textarea>
            </div>
        </form>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
    $(document).ready(function() {
        $('#insertForm').submit(function(event) {
            var imageInputs = $('.img-input');
            var imageSelected = false;
            imageInputs.each(function() {
                if ($(this).val() !== '') {
                    imageSelected = true;
                    return false; // 이미지가 선택된 경우 각 이미지 반복문을 종료합니다.
                }
            });
            if($("input[name=title]").val()==""){
            	alert('제목을 입력하세요.');
            	return false;
            }
            if (!imageSelected) {
                alert('한 개 이상의 이미지를 선택해주세요.');
                event.preventDefault();
            }
        });
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>