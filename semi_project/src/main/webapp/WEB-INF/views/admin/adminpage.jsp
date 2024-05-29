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

.resign-btn, .delete-board-btn, .report-btn{
	padding: 5px 10px;
	font-size: 12px;
	color: #fff;
	background-color: #c40000;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.check-board, .insert-board-btn{
	padding: 5px 10px;
	font-size: 12px;
	color: #fff;
	background-color: #00c46b;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.page-link{
	cursor: pointer;
}
//
.insert-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 400px;
}

#form-title {
    text-align: center;
    margin-bottom: 20px;
    color: #555;
}

div.form-group {
    margin-bottom: 15px;
}

div.form-group>label {
    display: block;
    margin-bottom: 5px;
    color: #555;
}

div.form-group>input[type="text"],
div.form-group>textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

div.form-group>textarea {
    resize: vertical;
}

div.form-group>button {
    width: 100%;
    padding: 10px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

div.form-group>button:hover {
    background-color: #555;
}

.back-link {
    text-align: center;
    margin-top: 20px;
}

.back-link>a {
    color: #333;
    text-decoration: none;
}

.back-link>a:hover {
    text-decoration: underline;
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
                    <li><p id="searchResignMember">탈퇴 및 차단한 회원 조회</p></li>
                    <li><p id="reportDetails">신고 내역 조회</p></li>
                </ul>
            </li>
            <li>
                <p>상품관리</p>
                <ul class="sub-nav">
                    <li><p id="insertProduct">상품 등록</p></li>
                    <li><p id="updateProduct">상품 수정</p></li>
                    <li><p id="deleteProduct">상품 삭제</p></li>
                    <li><p id="manageQnA">QnA 관리</p></li>
                </ul>
            </li>
            <li>
                <p>게시판 관리</p>
                <ul class="sub-nav">
                    <li><p id="freeBoard">자유게시판</p></li>
                    <li><p id="noticeBoard">공지사항게시판</p></li>
                    <li><p id="eventBoard">이벤트게시판</p></li>
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
        <button onclick="location.assign('<%=request.getContextPath()%>/')">산책하개 이동</button>
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
	// 실제 이용중인 회원 조회
	$("#searchMember").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchmember.do?status=N")
		.done(data=>{
			$("div.content").html(data);
		});
      	printLoading('div.content');
	})
	
	// 탈퇴 및 차단당한 회원 조회
	$("#searchResignMember").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchmember.do?status=Y")
		.done(data=>{
			$("div.content").html(data);
		});
      	printLoading('div.content');
	})
	
	// 신고내역 전체 조회
	$("#reportDetails").click(e=>{
		$.get("<%=request.getContextPath()%>/admin/searchreport.do")
		.done(data=>{
			$("div.content").html(data);
		});
		printLoading('div.content');
	})
	// 신고 대상자 아이디 검색 기능
	$(document).on("click", ".search-reported-btn", function(e){
		$.get("<%=request.getContextPath()%>/admin/searchreportbyid.do?userid="+$('#search-reported-id').val())
		.done(data=>{
			$("div.content").html(data);
		});
		printLoading('div.content');
	})
	// 신고 대상자 탈퇴 처리 기능
	$(document).on("click", ".report-btn", function(e){    	
    	const deleteTargetUserId = $(this).val();
    	$.get("<%=request.getContextPath()%>/admin/deleteuserbyid.do?userId="+deleteTargetUserId+"&status=N")
    	.done(data=>{
    		alert('회원 상태 변경에 성공했습니다.');
    		adminMain();
    	})
    	.fail(error=>{
    		alert('회원 상태 변경에 실패했습니다.');
    	})
    })
    
    // 신고 게시글 보러가기
    $(document).on("click",".check-board", function(e){
    	const bullNo = $(this).val();
    	window.open("<%=request.getContextPath()%>/board/boardview.do?no="+bullNo);
    })
	
	// 게시판 기능	
	// 자유 게시판 관리 기능 - 게시글 전체 조회 및 페이징 처리
	$(document).on("click", "#freeBoard", function(e){
		$.get("<%=request.getContextPath()%>/admin/manageboard.do?type="+3)
		.done(data => {
			$('div.content').html(data);
		});
		printLoading('div.content');
	})
	
	// 이벤트 게시판 관리 기능 - 이벤트 게시글 등록, 수정, 삭제
	$(document).on("click", "#eventBoard", function(e){
		$.get("<%=request.getContextPath()%>/admin/manageboard.do?type="+2)
		.done(data => {
			$('div.content').html(data);
		});
		printLoading('div.content');
	})
	
	// 공지 게시판 관리 기능 - 공지 게시글 등록, 수정, 삭제
	$(document).on("click", "#noticeBoard", function(e){
		$.get("<%=request.getContextPath()%>/admin/manageboard.do?type="+1)
		.done(data => {
			$('div.content').html(data);
		});
		printLoading('div.content');
	})
	
	// 멍스타그램 게시판 관리 기능 - 게시글 전체 조회 및 페이징 처리
	$(document).on("click", "#dogStargram", function(e){
		$.get("<%=request.getContextPath()%>/admin/manageboard.do?type="+4)
		.done(data => {
			$('div.content').html(data);
		});
		printLoading('div.content');
	})
	
	// 산책메이트 게시판 관리 기능 → 산책메이트에서 신고기능 추가 후 작성자, 신청자, 모집장소, 확정받은 인원, 날짜 출력해줄 예정
	$(document).on("click", "#walkingMateBoard", function(e){
		alert("산책메이트 신고기능 추가 후 조회 기능 업데이트 예정");
	})
	
	// 핫플레이스 게시판 관리 기능 → 핫플레이스 기능 미구현 상태
	$(document).on("click", "#hotPlaceBoard", function(e){
		alert("추후 업데이트 예정");
	})
	
	// 비동기적 절차에 따른 페이징 처리
    $(document).on("click",".page-link", function(p) {
    	let type = $(p.target).data("type"); // 게시글 관리에 관한 타입 설정
    	let status = $(p.target).data("status"); // 회원 상태(탈퇴 or 실사용 중)
    	let pageValue = $(p.target).data("page");
    	let url=$(p.target).data("url");
    	
    	if(typeof status!='undefined' && typeof type == 'undefined'){
	        $.get(url+"?cPage="+pageValue+"&status="+status)
	        .done(data => {
	            $("div.content").html(data);
	        })
    	} else if(typeof status =='undefined' && typeof type != 'undefined'){
    		$.get(url+"?cPage="+pageValue+"&type="+type)
    		.done(data=>{
    			$("div.content").html(data);
    		})
    	} else {
    		$.get(url+"?cPage="+pageValue)
    		.done(data=>{
    			$("div.content").html(data);
    		})
    	}
    });

	let currentButton = null;
    // 회원 정보 <tr> 클릭 시 회원 강퇴 버튼 등장
    $(document).on("click", ".user-info", function(e) {
    	const status = $("#search-user-status").val();
        if (currentButton) {
            currentButton.remove();
        }
        const $button = document.createElement("button");
        if(status=='N'){
        	$button.innerText = "삭제";
        } else {
        	$button.innerText = "복구";
        }
        $button.setAttribute("class", "resign-btn");

        const lastTd = $(this).find("td:last")[0];
        lastTd.appendChild($button);
        currentButton = $button;
    });

    // 회원 아이디 검색 기능
    $(document).on("click", ".search-user-btn", function(e){
    	 const userid = $("#search-user-id").val();
    	 const status = $("#search-user-status").val();
         $.get("<%=request.getContextPath()%>/admin/searchuserbyid.do?userId="+userid+"&status="+status)
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
	
    // 특정 row 클릭하여 해당 유저 가입상태 변경 처리
    $(document).on("click", ".resign-btn", function(e){    	
    	const deleteTargetUserId = $(this).parent().siblings()[0].innerText;
    	const status = $("#search-user-status").val();
    	$.get("<%=request.getContextPath()%>/admin/deleteuserbyid.do?userId="+deleteTargetUserId+"&status="+status)
    	.done(data=>{
    		alert('회원 상태 변경에 성공했습니다.');
    		adminMain();
    	})
    	.fail(error=>{
    		alert('회원 상태 변경에 실패했습니다.');
    	})
    })
    
    // 게시판 관리페이지에서 해당 게시글로 옮겨가기
    $(document).on("click", ".board-info", function(e){
    	const bullNo = $(this).siblings()[0].innerText;
    	window.open("<%=request.getContextPath()%>/board/boardview.do?no="+bullNo);
    })
    
    // 게시판 관리 기능 중 삭제 기능(게시글 고유 번호(PK)로 삭제하는  기능)
    $(document).on("click", ".delete-board-btn", function(e){
    	const bullNo = $(this).parent().siblings()[0].innerText
    	$.get("<%=request.getContextPath()%>/board/deletefreeboard.do?no="+bullNo)
    	.done(data=>{
    		alert('게시글 삭제에 성공했습니다.');
    		adminMain();
    	})
    	.fail(error=>{
    		alert('게시글 삭제에 실패했습니다.')
    	})
    })
    
    // 공지사항, 이벤트 게시글 등록버튼 기능
    $(document).on("click", '.insert-board-btn', function(e){
    	const type=$(this).val();
    	$.get("<%=request.getContextPath()%>/board/insertboard.do?type="+type)
    	.done(data=>{
    		// 요청 보낸 HTML 문서 띄우기
    		$('div.content').html(data);
    		 const type = document.querySelector("input#type").value;
             const formTitle = document.getElementById("form-title");
             if (type == "1") {
                 formTitle.innerText = "공지사항 등록";
             } else if (type == "2") {
                 formTitle.innerText = "이벤트 등록";
             }
         
    	})
    	
    })
    // 게시글 등록 창에서 입력받은 값 입력하기
    $(document).on("click","#write-board-btn", function(e){
    	const title = $("#title").val();
    	const description = $("#description").val();
		const type = $("#type").val();
		$.ajax({ 
			url : "<%=request.getContextPath()%>/admin/writeboard.do",
			type : "post",
			data : {
					 "type" : type,
					 "title" : title,
					 "description" : description	
				 },
			success : e=>{
					switch(e){
						case "1": alert("공지사항 등록 성공"); adminMain(); break;
						case "2": alert("이벤트 등록 성공"); adminMain(); break;
						default: alert("등록 실패"); adminMain(); break;
					}
				},
			error:(r,e)=>{
				console.log(r);
			}
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