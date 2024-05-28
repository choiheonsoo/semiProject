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

.sidebar button {
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

.sidebar button:hover {
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

.adminpage-container {
	margin-top: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
}

tr:hover {
	cursor: pointer;
	background-color: #f5f5f5;
}

ul {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

li {
	margin-bottom: 5px;
}

.justify-content-center {
	margin-top: 3%;
}

.search-container {
	margin: 20px 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.search-container input[type="text"] {
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-right: 10px;
	width: 200px;
}

.search-container button {
	padding: 10px 20px;
	font-size: 14px;
	color: #fff;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.resign-td {
	display: none;
}

.resign-btn {
	padding: 5px 10px;
	font-size: 12px;
	color: #fff;
	background-color: #c40000;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
.page-link{
	cursor: pointer;
}
</style>
<body>
    <div class="sidebar">
        <h2 onclick="adminMain();">산책하개 <br> Admin Page</h2>
        <ul class="nav">
            <li>
                <p>회원관리</p>
                <ul class="sub-nav">
                    <li><p id="searchMember">회원 조회</p></li>
                    <li><p id="reportDetails">신고 내역 조회</p></li>
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
                    <li><p id="freeBoard">자유게시판</p></li>
                    <li><p id="noticeBoard">공지사항게시판</p></li>
                    <li><p id="dogStargram">멍스타그램 게시판</p></li>
                    <li><p id="walkingMateBoard">산책메이트 게시판</p></li>
                    <li><p id="hotPlaceBoard">핫플레이스 게시판</p></li>
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
        <img id="adminMainPage" src="<%=request.getContextPath() %>/images/admin/adminpage.jpg" style="width:100%; height:93vh; opacity:0.2;">
    </div>
</body>
<script>
	// 산책하개 클릭 시 메인 페이지로 이동
	const adminMain = () =>{
		$("div.content").html("");
		const $adminMainPage = $("<img src='<%=request.getContextPath() %>/images/admin/adminpage.jpg' style='width:100%; height:93vh; opacity:0.2;'>");
		$("div.content").append($adminMainPage);
	}
	
	// 회원 관리 기능
	// 회원 조회
	$("#searchMember").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchmember.do")
		.done(data=>{
			$("div.content").html(data);
		});
      	printLoading('div.content');
	})
	// 신고내역 조회 → 헌수 Dto 수정 끝나면 다시 시작
	$("reportDetails").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchreport.do")
		.done(data=>{
			$("div.content").html(data);
		});
		printLoading('div.content');
	})
	
	// 게시판 기능
	// 자유 게시판 관리 기능 : 게시글 전체 조회 후 삭제 기능
	$("#freeBoard").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/managefreeboard.do")
		.done(data=>{
			$("div.content").html(data);
		});
		printLoading('div.content');
	})
	
	// 비동기적 절차에 따른 페이징 처리
    $(document).on("click",".page-link", function(p) {
    	let pageValue = $(p.target).data("page");
    	let url=$(p.target).data("url");
        $.get(url+"?cPage=" + pageValue)
        .done(data => {
            $("div.content").html(data);
        });
    });

    let currentButton = null;
    // 회원 정보 <tr> 클릭 시 회원 강퇴 버튼 등장
    $(document).on("click", ".user-info", function(e) {
        if (currentButton) {
            currentButton.remove();
        }
        const $button = document.createElement("button");
        $button.innerText = "삭제";
        $button.setAttribute("class", "resign-btn");

        const lastTd = $(this).find("td:last")[0];
        lastTd.appendChild($button);
        currentButton = $button;
    });

    // 회원 아이디 검색 기능
    $(document).on("click", ".search-user-btn", function(e){
    	 const userid = $("#search-user-id").val();
         $.get("<%=request.getContextPath()%>/admin/searchuserbyid.do?userId="+userid)
         .done(data => {
             $("tr.user-info").remove();
             const $targetTbody = $(".user-container>table>tbody");
             const $searchUserTh = $targetTbody.append($("<tr>").append($("<th>").text("아이디")).append($("<th>").text("성함")).append($("<th>").text("전화번호"))
             .append($("<th>").text("이메일")).append($("<th>").text("생일")).append($("<th>").text("우편번호")).append($("<th>").text("주소"))
             .append($("<th>").text("산책 참여횟수")).append($("<th>").text("적립금")))
             const $searchUserTr = $targetTbody.append($("<tr class='user-info'>").append($("<td>").text(data.userId)).append($("<td>").text(data.userName)).append($("<td>").text(data.phone)).append($("<td>").text(data.email))
             .append($("<td>").text(data.birthDay)).append($("<td>").text(data.zipCode)).append($("<td>").text(data.address)).append($("<td>").text(data.mateCount))
             .append($("<td>").text(data.point)));
             
             $("div.spinner-border").remove();
    	})
    	printLoading('.user-container>table>tbody');        
    });
	
    // 특정 row 클릭하여 해당 유저 탈퇴 처리
    $(document).on("click", ".resign-btn", function(e){    	
    	const deleteTargetUserId = $(this).parent().siblings()[0].innerText;
    	$.get("<%=request.getContextPath()%>/admin/deleteuserbyid.do?userId="+deleteTargetUserId)
    	.done(data=>{
    		alert('회원 삭제에 성공했습니다.');
    		adminMain();
    	})
    	.fail(error=>{
    		alert('회원 삭제에 실패했습니다.');
    	})
    })
    
    	// 로딩 표현 by BootStrap
	function printLoading(target){
		  const $container=$("<div>").attr({"class":"spinner-border text-primary","role":"status"});
	        $(target).html("");
	        $(target).append($container);
	}
</script>
</html>