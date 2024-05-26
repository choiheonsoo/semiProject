<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.user.model.dto.User"%>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/logo.png">
<!DOCTYPE html>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
}
.sidebar {
    width: 250px;
    background-color: #333;
    color: #fff;
    height: 100vh;
    position: fixed;
    overflow-y: auto;
}

.sidebar h2 {
    text-align: center;
    padding: 0.3em;
    margin: 0;
    background-color: #444;
    cursor: pointer;
}
.sidebar button{
	background-color: #444;
	font-size: 15px;
    color: #fff;
    border: none;
    padding: 1em;
    cursor: pointer;
    width: 100%;
    text-align: center;
    position: absolute;
    bottom: 0;
    left: 0;
    transition: background-color 0.3s ease;
}
.sidebar button:hover{
	background-color: #b5258b;
}
.nav {
	display: flex;
	flex-direction: column;
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.nav li {
    border-bottom: 1px solid #444;
    position: relative;
}

.nav p {
    color: #fff;
    text-decoration: none;
    display: block;
    padding: 0.75em 1em;
    margin-bottom: 5px; 
    cursor: pointer;
}
.nav p:hover {
    background-color: #575757;
}
.sub-nav {
    max-height: 0;
    overflow: hidden;
    list-style-type: none;
    padding-left: 20px;
    transition: max-height 0.3s ease-out, padding 0.3s ease-out;
}
.nav li:hover .sub-nav {
    max-height: 500px;
    padding: 10px 0;
    transition: max-height 0.5s ease-in, padding 0.5s ease-in;
}
.sub-nav li {
    border: none;
}
.sub-nav p {
    padding: 0.5em 1em;
    background-color: #444;
    margin: 0;
    cursor: pointer;
}
.sub-nav p:hover {
    background-color: #575757;
}
.content {
    margin-left: 250px;
    padding: 2em;
    background-color: #bcbcbc;
    flex-grow: 1;
}
.content h1 {
    margin-top: 0;
}
</style>
<body>
    <div class="sidebar">
        <h2 onclick="location.assign('#')">산책하개 <br> Admin Page</h2>
        <ul class="nav">
            <li>
                <p>회원관리</p>
                <ul class="sub-nav">
                    <li><p id="searchMember">회원 조회</p></li>
                    <li><p>회원 퇴출</p></li>
                </ul>
            </li>
            <li>
                <p>상품관리</p>
                <ul class="sub-nav">
                    <li><p>상품 등록</p></li>
                    <li><p>상품 수정</p></li>
                    <li><p>상품 삭제</p></li>
                    <li><p>QnA 관리</p></li>
                </ul>
            </li>
            <li>
                <p>게시판 관리</p>
                <ul class="sub-nav">
                    <li><p>자유게시판</p></li>
                    <li><p>공지사항게시판</p></li>
                    <li><p>멍스타그램 게시판</p></li>
                    <li><p>산책메이트 게시판</p></li>
                    <li><p>핫플레이스 게시판</p></li>
                </ul>
            </li>
            <li>
                <p>주문관리</p>
                <ul class="sub-nav">
                    <li><p>배송상태 변경</p></li>
                    <li><p>환불/취소 관리</p></li>
                </ul>
            </li>
        </ul>
        <button>로그아웃</button>
    </div>
    <div class="content">
        <img src="<%=request.getContextPath() %>/images/admin/adminpage.jpg" style="width:100%; height:93vh; opacity:0.3;">
    </div>
</body>
<script>
	// 회원 조회
	$("#searchMember").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchmember.do")
		.done(data=>{
			$("div.content").html(data);
		})
	})
</script>
</html>