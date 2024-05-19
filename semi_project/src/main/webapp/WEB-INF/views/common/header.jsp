<%@page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//UserLoginCheckServlet.do에서 session에 담은 값 불러오기
	User loginUser = (User)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<style>
	button#logOutbtn{
		border-style: none;
		background-color: #5b9dff;
		color: #dfdffd;
		padding: 2px;
	}
</style>
</head>
<body>
   <header>
        <div id="event">회원가입 이벤트</div>
        <nav id="mainMenu">
            <div id="menu1">
                <a href="<%=request.getContextPath()%>/">
                    <img src="<%=request.getContextPath() %>/images/logo.png" alt="로고" id="menu" width="100%" height="100%">
                </a>
                <span><img src="<%=request.getContextPath() %>/images/menu.png" alt="메뉴바" id="logo" width="100%" height="100%"></span>
            </div>
            <div id="menu2">
                <a href="<%=request.getContextPath()%>/board/freeboard.do">커뮤니티</a>
                <a href="<%=request.getContextPath()%>/shoppingmall/shoppingmallfeed.do">쇼핑하개</a>
                <a href="<%=request.getContextPath()%>/board/walkingmate.do">산책메이트</a>
                <a href="<%=request.getContextPath()%>/hotplace/walking.do">핫플레이스</a>
            </div>
            <div id="menu3">
                <a href=""><img src="<%=request.getContextPath() %>/images/alram.png" alt="알람" width="30" height="30"></a>
                <%if(loginUser==null){ %>
                	<a href="<%=request.getContextPath()%>/user/login.do">
                		<img src="<%=request.getContextPath() %>/images/user.png" alt="유저" width="30" height="30">
                	</a>
                <%} else { %>
               		<a href="<%=request.getContextPath()%>/user/myPage.do">
               			<img src="<%=request.getContextPath() %>/images/user.png" alt="유저" width="30" height="30">
               		</a>
                <%} %>
            </div>
            <!-- 로그인 안했을 때 class에 noLogin 추가 / 했을땐 Login 추가 안에 내용은 jsp로 구현 -->
            <div class="menu4 noLogin">
                <!-- <p>로그인 후</p>
                <p>이용할 수 있습니다.</p> -->
                <%if(loginUser==null){ %>
                	<p style="font-weight:600">로그인 후 <br>이용할 수 있습니다.</p>
                <%}else{ %>
                	<p><strong><%=loginUser.getUserId() %></strong>님</p><p>환영합니다. <button id="logOutbtn" onclick="location.assign('<%=request.getContextPath()%>/logout.do');">로그아웃</button></p>
                <%} %>
            </div>
        </nav>
        
    </header>
    <div class="menubar">
		<div class="menubar-container">
			<ul>
				<li>커뮤니티</li>
				<a href=""><li>자유게시판</li></a>
				<a href=""><li>정보게시판</li></a>
				<a href=""><li>멍스타그램</li></a>
			</ul>
			<ul>
				<li>쇼핑하개</li>
				<a href=""><li>신상품</li></a>
				<a href=""><li>사료</li></a>
				<a href=""><li>간식</li></a>
				<a href=""><li>용품</li></a>
			</ul>
			<ul>
				<li>산책메이트</li>
				<a href=""><li>모집하개</li></a>
				<a href=""><li>참석하개</li></a>
			</ul>
			<ul>
				<li>핫플레이스</li>
				<a href=""><li>산책로 추천</li></a>
				<a href=""><li>병원 추천</li></a>
			</ul>
		</div>
	</div>
 <script>
        $('#menu1 span').click(e=>{
            let src=$('#menu1 span img').attr("src");
            if(src=="<%=request.getContextPath() %>/images/menu.png"){
                $('#menu1 span img').attr("src","<%=request.getContextPath() %>/images/x.png").css({"width":"100%","height":"100%"});
            }else{
                $('#menu1 span img').attr("src","<%=request.getContextPath() %>/images/menu.png").css({"width":"100%","height":"100%"});
            }
            $('.menubar').slideToggle("visible-box");
        });
        
</script>