<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5195f24115fc28a6fae3a6191e0f7b0&libraries=services" type="text/javascript"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board/insertWalkingMate.css">
	<div id="wrap"></div>
<section class="content">
	<h3>산책메이트</h3>
	<h6>산책메이트</h6>
	<div class="br"></div>
	<div class="insertBoard1">
		<form action="<%=request.getContextPath()%>/board/insertwalkingmateend.do">
			<div class="menu1">
				<input type="text" name="title" placeholder="제목을 입력하세요.">
			</div>
			<div class="menu2">
				<div class="btn-container">
					<input type="hidden" name="id" value="<%=loginUser.getUserId()%>">
					<input type="submit" value="등록">
					<input type="button" value="취소">
					<input type="datetime-local" name="placeTime" placeholder="산책 일시">
					<label for="mateC">산책 인원</label><input type="number" name="mateC" min="1" max="10" value="1">
					<input onclick="daumPostcode();" type="button" value="장소">
					<input type="hidden" name="place" value="">
					<input type="hidden" name="latitude" value="">
					<input type="hidden" name="longitude" value="">
					<p></p>
				</div>
			<textarea name="content" rows="" cols="" placeholder="내용을 입력하세요."></textarea>
			</div>
		</form>
	</div>
</section>
<script>
  const daumPostcode = () => {
    new daum.Postcode({
      oncomplete: data => {
        $('.btn-container>p').text(data.roadAddress);
        $("input[type='hidden']").eq(1).val(data.roadAddress);
        console.log('도로명주소 : ' + data.roadAddress);
        console.log('지번주소 : ' + data.jibunAddress);
        console.log('우편번호 : ' + data.zonecode);

        // 위도 및 경도 좌푯값 구하기
        const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(data.roadAddress, (result, status) => {
          if (status === kakao.maps.services.Status.OK) {
        	  $("input[type='hidden']").eq(2).val(result[0].y);
        	  $("input[type='hidden']").eq(3).val(result[0].x);
          	  console.log('위도 : ' + result[0].y);
          	  console.log('경도 : ' + result[0].x);
          }
        });
      },
    }).open();
  }

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>