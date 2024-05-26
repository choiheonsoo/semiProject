<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.web.board.model.dto.MateApply"%>
<%@page import="com.web.board.model.dto.WalkingMate"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp" %>
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

<section class="content">
	<div class="mateHeader">
		<h3>산책메이트</h3>
	</div>
	    <div class="mate_menu">
	        <p>내가 모집중인 메이트</p>
	    </div>
	<%for(WalkingMate b : boardAll){ %>
	    <%if(b.getUserId().equals(loginUser.getUserId()) && b.getDelC()!='Y'){ %>
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
			        		int total = 0;
			        		int accept = 0;
			        		for(MateApply a : apply){
			        			if(b.getWalkingMateNo()==a.getBoardNo()){
			        				++total;
			        				if(a.getAccept()=='Y') ++accept;
			        			}
			        		}
			        		out.print(accept+"/"+total);
			        %>
						</p>
					<%
					    boolean isAccepted = apply.stream()
					                             .anyMatch(e -> e.getBoardNo() == b.getWalkingMateNo() && e.getAccept() == 'Y');
					    boolean isPending = apply.stream()
					                            .anyMatch(e -> e.getBoardNo() == b.getWalkingMateNo() && e.getAccept() != 'Y');
					
					    if (isAccepted) {
					%>
					        <p>확정</p>
					<%
					    } else if (isPending) {
					%>
					        <p>확인 중</p>
					<%
					    } else {
					%>
					        <button onclick="popup_open('<%=b.getWalkingMateNo() %>')">참석하기</button>
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
							<button onclick="apply(event,<%=b.getWalkingMateNo()%>,'<%=loginUser.getUserId()%>')">참석하기</button>
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
	const popup_open = function(no) {
	   $(".popup_"+no).show();
	   setTimeout(function() {
	       map_open(no);
	   }, 1000); // 1000 밀리초(1초) 후에 맵을 생성
	}

	// 맵 띄우기
	const map_open = function(no){
		kakao.maps.load(function() {
		    var mapContainer = document.getElementById("map_"+no);
		    console.log(mapContainer);
		    var options = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		    };
					
		   	var map = new kakao.maps.Map(mapContainer, options);
		    function resizeMap() {
		        var mapContainer = document.getElementById('map_'+no);
		        mapContainer.style.width = '100%';
		        mapContainer.style.height = '100%'; 
		    }
	
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
</script>
<script charset="UTF-8" class="daum_roughmap_loader_script" src="//ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5195f24115fc28a6fae3a6191e0f7b0"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>