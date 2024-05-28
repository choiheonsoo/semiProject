<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.web.board.model.dto.MateApply"%>
<%@page import="com.web.board.model.dto.WalkingMate"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp" %>
<%@page import="com.web.dog.model.dto.Dog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	List<WalkingMate> boards = (List<WalkingMate>)request.getAttribute("boards");
	List<WalkingMate> boardAll = (List<WalkingMate>)request.getAttribute("boardAll");
	List<MateApply> apply = (List<MateApply>)request.getAttribute("apply");
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
%>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board/walkingMate.css">
	<div id="apply-list-button" onclick='apply_list_button(event,"<%=loginUser.getUserId()%>")'>
		<button>신청한 사람 목록</button>
	</div>
	<div class='apply-list'><!--  style="display:none" -->
		<p onclick="apply_list_close();">x</p>
		<ul>
			<li>회원아이디</li>
			<li>유저이름</li>
			<li>회원주소</li>
			<li>메이트횟수</li>
			<li>수락여부</li>
		</ul>
	</div>
	<script>
		//리스트 출력 닫기
		const apply_list_close=function(){
			$('.apply-list').hide();
		}
		
		//리스트 출력
		const apply_list_button = function(e, userId){
			$('.apply-list').show();
			$.ajax({
				url:"<%=request.getContextPath()%>/board/selectApply.do?userId="+userId,
				success:function(data){
					if(data.length==0){
						alert("조회된 결과가 없습니다.");
					}else{
						$('.apply-list').children().not(":first-child").hide();
						$.each(data,function(i,value){
							console.log(value);
							$ul = $("<ul>").addClass('apply_list_'+value.boardNo+value.userId);
							$ul.append($("<li>").text(value.userId));
							$ul.append($("<li>").text(value.userName));
							$ul.append($("<li>").text(value.address));
							$ul.append($("<li>").text(value.mateCount));
							//수락하면 MATE-APPLY에서 ACCEPT를 'Y'로 변경
							$ul.append($("<button>")
											.text("수락하기")
											.click(function(){
												$.ajax({
													url:'<%=request.getContextPath()%>/board/updateApply.do',
													type:'post',
													data:{
														totalMembers : value.totalMembers,
														boardNo : value.boardNo,
														userId :value.userId
													},
													success:function(data){
														console.log(data);
														alert("수락 완료!");
														$('.apply_list_'+value.boardNo+value.userId).hide();
													},
													error:function(){
														alert("수락하는 중 오류 발생");
													}
												});	
											})
										);
							//거절하면 MATE-APPLY에서 삭제
							$ul.append($("<button>")
											.text("거절하기")
											.click(function(){
												$.ajax({
													url:'<%=request.getContextPath()%>/board/deleteApply.do',
													type:'post',
													data:{
														boardNo : value.boardNo,
														userId :value.userId
													},
													success:function(data){
														console.log(data);
														alert("거절 완료!");
														$('.apply_list_'+value.boardNo+value.userId).hide();
													},
													error:function(){
														alert("수락하는 중 오류 발생");
													}	
												});	
											})
										);
							$('.apply-list').append($ul);
						});
					}
				},
				error:function(){
					alert("목록 불러오는 중 오류 발생");
				}	
			});
		}
	</script>
<section class="content">
	<div class="mateHeader">
		<h3>산책메이트</h3>
	</div>
	    <div class="mate_menu">
	        <p>내가 모집중인 메이트</p>
	    </div>
	<%for(WalkingMate b : boardAll){ %>
	    <%if(b.getUserId().equals(loginUser.getUserId()) && b.getDelC()!='Y'){ %>
		    <p class="placeTime" style="display:none"><%=b.getPlaceTime() %></p>
		    <div class="my_mate">
		        <p><%=b.getPlace().substring(0,2) %></p>
		        <p><%=b.getTitle() %></p>
		        <p>
		        	<%
		        		int accept = 0;
		        		for(MateApply a : apply){
		        			if(b.getWalkingMateNo()==a.getBoardNo()){
		        				if(a.getAccept()=='Y') ++accept;
		        			}
		        		}
		        		out.print(accept+"/"+b.getRecruitmentNumber());
		        	%>
		        	
		        </p>
		        <img onclick="menu_toggle('<%=b.getWalkingMateNo() %>')" class='my_mate_menu' id="my_mate_menu_<%=b.getWalkingMateNo() %>" src="<%=request.getContextPath() %>/images/board/menu.png" alt="">
		        <div>
		        	<button onclick="delete_board('<%=b.getWalkingMateNo()%>')">삭제하기</button>
		        </div>
		    </div>
		<%
			}
	    }%>
	    <div class="mate_menu">
	        <p>신청 가능한 메이트</p>
	    </div>
    
		<div class="table">
		<%for(WalkingMate b : boards){ %>
			<p class="table-date" style="display:none"><%=b.getPlaceTime() %></p>
	   		 <%if(!b.getUserId().equals(loginUser.getUserId())){ %>
				<div class="theader">
					<div>
						<p><%=b.getPlace().substring(0,2) %></p>
						<p><%=b.getUserId() %></p>
					</div>
					<div>
						<div>
							<p><%=b.getTitle() %></p>
							<p><img alt="" src="<%=request.getContextPath()%>/images/board/time.png">
							<%
								Timestamp timestamp = b.getPlaceTime();
								SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
								String formattedDate = dateFormat.format(timestamp);
							%>	
							<%=formattedDate %>
							</p>
						</div>
						<p class='distance distance_<%=b.getWalkingMateNo() %>'></p>
					</div>
					<div>
						<p>
					<%
			        		int accept = 0;
			        		for(MateApply a : apply){
			        			if(b.getWalkingMateNo()==a.getBoardNo()){
			        				if(a.getAccept()=='Y') ++accept;
			        			}
			        		}
			        		out.print(accept+"/"+b.getRecruitmentNumber());
			        		boolean check = accept>=b.getRecruitmentNumber();
			        %>
						</p>
					<%
					    boolean isAccepted = apply.stream()
					                             .anyMatch(e -> e.getBoardNo() == b.getWalkingMateNo() && e.getUserId().equals(loginUser.getUserId()) && e.getAccept() == 'Y');
					    boolean isPending = apply.stream()
					                            .anyMatch(e -> e.getBoardNo() == b.getWalkingMateNo() && e.getAccept() != 'Y');
					
					  	if(check){
					 %>
					 		<p>마감</p> 		
					 <%		
					  	}
					    else if (isAccepted) {
					%>
					        <p>확정</p>
					<%
					    } else if (isPending) {
					%>
					        <p>확인 중</p>
					<%
					    } else {
					%>
					        <button onclick="popup_open(<%=b.getWalkingMateNo() %>,<%=b.getLatitue()%>,<%=b.getLogitude()%>);">참석하기</button>
					<%
					    }
					%>
				    </div>
	    	</div>
		 	<div id="popup" class="popup_<%=b.getWalkingMateNo()%>">
				<div class="modal">
					<div class="modal_container">
						<div class="modal_1">
					<%
						if(dogs.stream().anyMatch(e->b.getUserId().equals(e.getUserId()))){
							String img=dogs.stream().filter(e->b.getUserId().equals(e.getUserId())).map(e->e.getDogImg()).toList().get(0);%>
						<img src="<%=request.getContextPath()%>/upload/user/<%=img %>" width="30" height="30">
					<%
						}else{
					%>
						<img src="<%=request.getContextPath()%>/upload/user/user.png" width="30" height="30">
					<%
						}
					%>
							<p><%=b.getUserId() %></p>
						</div>
						<div class="modal_2">
							<p>장소<p>
							<p><%=b.getPlace() %></p>
						</div>
						<div class="modal_3">
							<div>
								<p>모집인원</p>
								<p><%=b.getRecruitmentNumber() %></p>
							</div>
							<div>
								<p>시간</p>
								<p>
								<%=formattedDate %>
								</p>
							</div>
						</div>
						<div class="modal_4">
							<p>내용</p>
							<p><%=b.getContent() %></p>
						</div>
						<div class="modal_5" id="modal_5_id">
							<button onclick="apply(event,<%=b.getWalkingMateNo()%>,'<%=loginUser!=null?loginUser.getUserId():""%>')">참석하기</button>
							<button onclick="close_popup(event,<%=b.getWalkingMateNo()%>)">취소</button>
						</div>
					</div>
					<div class="modal_container" id="map_<%=b.getWalkingMateNo()%>">
						
					</div>
				</div>
		 	</div>
 <%		
    		}
	 	}
 %>
	    </div>
	    <div class="insert_button">
	    	<button onclick="location.assign('<%=request.getContextPath()%>/board/insertwalkingmate.do')">등록하기</button>
	    </div>
    	<%=request.getAttribute("pageBar") %>
    	<% for(WalkingMate post : boardAll){ %>
	    <div class="post" data-latitude="<%= post.getLatitue() %>" data-longitude="<%= post.getLogitude() %>" data-no="<%=post.getWalkingMateNo()%>">
	    </div>
<% } %>
</section>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5195f24115fc28a6fae3a6191e0f7b0"></script>
<script>
	// 사용자의 위치 좌표
	let userLat = 0;
	let userLon = 0;
	
	// 사용자의 위치 좌표 가져오기
	navigator.geolocation.getCurrentPosition(function(position) {
	    userLat = position.coords.latitude;
	    userLon = position.coords.longitude;
	
	    // 각 게시글의 위치와 사용자의 위치를 비교하여 거리를 계산하고 출력
	    calculateDistanceForAllPosts();
	});
	
	// 두 지점 간의 거리를 계산하는 함수
	function calculateDistance(latitude, longitude) {
	    // 각 게시글의 위도와 경도
	    const postLat = parseFloat(latitude);
	    const postLon = parseFloat(longitude);
	
	    // 사용자의 위도와 경도
	    const userLatRad = toRadians(userLat);
	    const userLonRad = toRadians(userLon);
	    const postLatRad = toRadians(postLat);
	    const postLonRad = toRadians(postLon);
	
	    // Haversine 공식을 사용하여 두 지점 간의 거리 계산
	    const radiusOfEarth = 6371; // 지구의 반지름 (단위: km)
	    const diffLat = postLatRad - userLatRad;
	    const diffLon = postLonRad - userLonRad;
	    const a = Math.sin(diffLat / 2) * Math.sin(diffLat / 2) +
	              Math.cos(userLatRad) * Math.cos(postLatRad) *
	              Math.sin(diffLon / 2) * Math.sin(diffLon / 2);
	    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	    const distance = radiusOfEarth * c;
	
	    return distance;
	}
	
	// 각도를 라디안으로 변환하는 함수
	function toRadians(degrees) {
	    return degrees * Math.PI / 180;
	}
	
	// 모든 게시글에 대해 거리를 계산하고 출력하는 함수
	function calculateDistanceForAllPosts() {
	    // 각 게시글의 위치 정보를 가져와서 거리를 계산하고 출력
	    const postElements = document.querySelectorAll('.post');
	    postElements.forEach(post => {
	        const latitude = post.dataset.latitude;
	        const longitude = post.dataset.longitude;
	        const no = post.dataset.no;
	        const distance = calculateDistance(latitude, longitude);
	        
	        const result = Math.round(distance * 10) / 10;
	        $('.distance_'+no).text(result+'km');
	    });
	}

	
	
	
	// 모달창 열기
	const popup_open = function(no,lat,lon) {
	   $(".popup_"+no).show();
	   setTimeout(function() {
	       map_open(no,lat,lon);
	       //map.relayout();
	   }, 1000); // 1000 밀리초(1초) 후에 맵을 생성
	}
	var map;
	// 맵 띄우기
	const map_open = function(no,lat,lon){
		kakao.maps.load(function() {
		    var mapContainer = document.getElementById("map_"+no);
		    var options = {
		        center: new kakao.maps.LatLng(lat, lon),
			level: 3
		    };
					
		   	map = new kakao.maps.Map(mapContainer, options);
		    function resizeMap() {
		        var mapContainer = document.getElementById('map_'+no);
		        mapContainer.style.width = '100%';
		        mapContainer.style.height = '100%'; 
		    }
		    var markerPosition  = new kakao.maps.LatLng(lat, lon); 

			 // 마커를 생성합니다
			 var marker = new kakao.maps.Marker({
			     position: markerPosition
			 });
	
			 // 마커가 지도 위에 표시되도록 설정합니다
			 marker.setMap(map);
			//map.relayout();
		     function relayout() {    
		        
		        // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		        // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		        // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		        map.relayout();
		    }
		});
	}

	// 모달창 닫기
	const close_popup = function(event, no) {
	    $(".popup_"+no).hide();
	};
	
	//작성자만 메뉴버튼
	const menu_toggle = function(no){
		$('#my_mate_menu_'+no).next().toggle();
	}
	
	//참석하기 기능
	const apply = function(e,no,id){
		location.assign('<%=request.getContextPath()%>/board/applywalkingmate.do?no='+no+'&id='+id);
	}
	
	//게시글 삭제하기
	const delete_board=function(no){
		location.assign('<%=request.getContextPath()%>/board/deletewalkingmate.do?no='+no);
	}
	
	//내 산책메이트에서 기간 지난 게시글들 안보이게 설정
	$('.placeTime').each((i,element)=>{
		var dbDateString = $(element).text();

		// DB에서 가져온 날짜와 시간을 공백을 기준으로 나누어 배열로 만듭니다.
		var dbDateTimeParts = dbDateString.split(" ");

		// 날짜 부분과 시간 부분을 나누어 가져옵니다.
		var dbDate = dbDateTimeParts[0]; // "2024-05-27"
		var dbTime = dbDateTimeParts[1]; // "15:30"

		// 날짜를 년, 월, 일로 나누어 배열로 만듭니다.
		var dbDateParts = dbDate.split("-");
		var year = parseInt(dbDateParts[0], 10);
		var month = parseInt(dbDateParts[1], 10) - 1; // 자바스크립트에서 월은 0부터 시작하므로 1을 빼줍니다.
		var day = parseInt(dbDateParts[2], 10);

		// 시간을 시간과 분으로 나누어 배열로 만듭니다.
		var dbTimeParts = dbTime.split(":");
		var hour = parseInt(dbTimeParts[0], 10);
		var minute = parseInt(dbTimeParts[1], 10);

		// DB에서 가져온 날짜와 시간으로 Date 객체 생성
		var dbDateTime = new Date(year, month, day, hour, minute);

		// 현재 날짜와 시간 객체 생성
		var now = new Date();

		// DB에서 가져온 날짜와 시간이 현재 날짜와 시간을 넘는지 확인
		if (dbDateTime > now) {
		} else {
		    $(element).next().css('display','none');
		}
		
	});
	
	//다른 사람의 메이트에서 기간이 지난 게시글은 가림
	$('.table-date').each((i,element)=>{
		var dbDateString = $(element).text();
		// DB에서 가져온 날짜와 시간을 공백을 기준으로 나누어 배열로 만듭니다.
		var dbDateTimeParts = dbDateString.split(" ");

		// 날짜 부분과 시간 부분을 나누어 가져옵니다.
		var dbDate = dbDateTimeParts[0]; // "2024-05-27"
		var dbTime = dbDateTimeParts[1]; // "15:30"

		// 날짜를 년, 월, 일로 나누어 배열로 만듭니다.
		var dbDateParts = dbDate.split("-");
		var year = parseInt(dbDateParts[0], 10);
		var month = parseInt(dbDateParts[1], 10) - 1; // 자바스크립트에서 월은 0부터 시작하므로 1을 빼줍니다.
		var day = parseInt(dbDateParts[2], 10);

		// 시간을 시간과 분으로 나누어 배열로 만듭니다.
		var dbTimeParts = dbTime.split(":");
		var hour = parseInt(dbTimeParts[0], 10);
		var minute = parseInt(dbTimeParts[1], 10);

		// DB에서 가져온 날짜와 시간으로 Date 객체 생성
		var dbDateTime = new Date(year, month, day, hour, minute);

		// 현재 날짜와 시간 객체 생성
		var now = new Date();

		// DB에서 가져온 날짜와 시간이 현재 날짜와 시간을 넘는지 확인
		if (dbDateTime > now) {
		} else {
		    $(element).next().css('display','none');
		}
		
	});
	
	
</script>
<!-- <script charset="UTF-8" class="daum_roughmap_loader_script" src="//ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script> -->

<%@ include file="/WEB-INF/views/common/footer.jsp"%>