<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/hotplace/hospital.css">
<body>
	<section class="content">
		<div class="container">
			<h2>핫 플레이스</h2>
			<div>
				<span class="menu" onclick="location.assign('<%=request.getContextPath()%>/hotplace/walking.do')">우리동네 산책명소</span> 
				<span class="menu" onclick="location.assign('<%=request.getContextPath()%>/hotplace/hospital.do')">우리동네 동물병원</span>
			</div>
		</div>
		<div class="context" onclick="">
			<div>
				<img src="" alt="동물병원사진">
			</div>
			<div>
				<h3>24시 웨스턴 동물의료센터</h3>
				<h6>서울특별시 마포구 노고산동 신촌로 110</h6>
			</div>
			<div>
				<h3>산책하개 평균 별점</h3>
				<h3>4.81<img src="" alt="별점"></h3>
			</div>
		</div>
		<hr>
		<div class="context">
			<div>
				<img src="" alt="동물병원사진">
			</div>
			<div>
				<h3>24시 웨스턴 동물의료센터</h3>
				<h6>서울특별시 마포구 노고산동 신촌로 110</h6>
			</div>
			<div>
				<h3>산책하개 평균 별점</h3>
				<h3>4.81<img src="" alt="별점"></h3>
			</div>
		</div>
		<hr>
		<div class="context">
			<div>
				<img src="" alt="동물병원사진">
			</div>
			<div>
				<h3>24시 웨스턴 동물의료센터</h3>
				<h6>서울특별시 마포구 노고산동 신촌로 110</h6>
			</div>
			<div>
				<h3>산책하개 평균 별점</h3>
				<h3>4.81<img src="" alt="별점"></h3>
			</div>
		</div>
		<hr>
		<div class="context">
			<div>
				<img src="" alt="동물병원사진">
			</div>
			<div>
				<h3>24시 웨스턴 동물의료센터</h3>
				<h6>서울특별시 마포구 노고산동 신촌로 110</h6>
			</div>
			<div>
				<h3>산책하개 평균 별점</h3>
				<h3>4.81<img src="" alt="별점"></h3>
			</div>
		</div>
		<hr>
		<div id="hospitalFooter">
		      <a class="page1" href=""><<</a>
		      <a class="page1" href=""><</a>
		      <a class="page2" href="">1</a>
		      <a class="page2" href="">2</a>
		      <a class="page2" href="">3</a>
		      <a class="page2" href="">4</a>
		      <a class="page2" href="">5</a>
		      <a class="page1" href="">></a>
		      <a class="page1" href="">>></a>
	   </div>
	</section>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>