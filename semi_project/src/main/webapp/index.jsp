<%@page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section class="content">
	<div id='main_image'>
		<img src="<%=request.getContextPath()%>/images/mainImage.gif">
	</div>
</section>

<script>
	var imageSrc=['<%=request.getContextPath()%>/images/mainImage.gif','<%=request.getContextPath()%>/images/backgroundGif.gif'];
	var currentIndex=0;
	function changeImage() {
	    // 현재 인덱스를 증가시키고, 배열의 길이로 나눈 나머지를 취하여 인덱스를 유지합니다.
	    currentIndex = (currentIndex + 1) % imageSrc.length;
	    // 이미지 요소를 가져와서 src를 변경합니다.
	    $('#main_image > img').attr('src', imageSrc[currentIndex]);
	    
	}
	//10초마다 실행
    setInterval(changeImage, 8000);

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>