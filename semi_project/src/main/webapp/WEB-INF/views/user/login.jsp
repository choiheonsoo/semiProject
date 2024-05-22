<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script> <!-- Kakao 전체 API를 가져오는 무거운 거? -->
<!-- <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js" integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script> -->
<style>
		section{
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
		}
        .login_container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        .login_container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .login_container input[type="text"],
        .login_container input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid gray;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        .login_container input[type="text"]:focus,
        .login_container input[type="password"]:focus {
            border-color: #ffeda4;
        }
        .login_container input[type="submit"] {
            width: 90%;
            padding: 12px;
            background-color: #ffeda4;
            color: #fff;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-bottom: 4%;
        }
        .login_container input[type="submit"]:hover {
            background-color: #ffbb00;
            color: #fff;
        }
        .login_container .login_inputs {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .login_container .login_submit {
            width: 100%;
            margin-top: 10px;
        }
        .login_container .login_links {
            display: flex;
            flex-direction: column;
    		align-items: center;
        }
        .login_container .login_links a {
            text-decoration: none;
            color: #007bff;
            transition: color 0.3s ease;
        }
        .login_container .login_links a:hover {
            color: #0056b3;
        }
        
        .login_container .message {
            color: red;
            margin-top: 10px;
        }
        
        #kakaobtn {
        	margin: 4%;
        	width: 339px;
        	height: 48px;
        	border-radius: 15px;
        	opacity: 0.5;
        	transition: opacity 0.3s;
        }
        #kakaobtn:hover{
        	opacity: 1;
        }
        .searchbtn {
        	height:24px;
        	background-color: white;
        	border: none;
        	color: #007bff;
        	transition: color 0.3s ease;
        }
        .searchbtn:hover{
         	color: #0056b3;
         }
         input.searchInfo{
         	width: calc(100% - 15px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid gray;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
         }
        input.searchInfo:focus{
            border-color: #ffeda4;
        }
        button.search{
        	width: 90%;
            padding: 12px;
            background-color: #ffeda4;
            color: #fff;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-bottom: 4%;
        }
        button.search:hover{
        	background-color: #ffbb00;
            color: #fff;
        }
        #searchResult{
        	display: flex;
        	flex-direction: column;	 
        	align-items: center;
        }
        
        div#emailCheckBox{
        	display: flex;
        	align-items: center;
        }
        div#emailCheckBox>input:first-child{
        	width: 269px;
        	margin-right: 15px;
        }
        div#emailCheckBox>button{
        	border: none;
        	color: #ffffff;
        	background-color: #9cd4f5;
        	border-radius: 15px;
        	width: 100px;
        	height: 40px;
        }
        button.checkBtn{
        	height:24px;
        	background-color: white;
        	border: none;
        	color: #007bff;
        	transition: color 0.3s ease;
        }
        .searchbtn:hover{
         	color: #0056b3;
         }
 </style>
<section class="content">
	<div class="login_container">
	 <div>
        <a href="javascript:kakaoLogin()"><img id="kakaobtn" src="<%=request.getContextPath()%>/images/kakaologin.png"></a>
     </div>
		<h2>어서오시개!</h2>
			<div id="searchResult"></div>
	        <form id="loginform" action="<%=request.getContextPath() %>/user/loginuser.do" method="post">
	            <input type="text" name="username" placeholder="아이디 입력" required>
	            <input type="password" name="password" placeholder="패스워드 입력" required>
	            <input type="submit" value="로그인">
	        </form>
	    <div class="login_links">
	    	<a href="<%=request.getContextPath()%>/user/new_user.do">회원가입</a>
		    <button class="searchbtn" onclick="searchId()">아이디 찾기</button>
		    <button class="searchbtn" onclick="changePw()">비밀번호 변경</button>
		</div>
	</div>
</section>
<script>
	const $targetDiv = $("#searchResult");
	const searchId=(e)=>{
		$targetDiv.html("");
		$("#loginform").css("display","none");
		$(".login_links").css("display","none");
		$("img[id=kakaobtn]").css("display", "none");
		
		const $searchEmail = $("<input class='searchInfo' placeholder='이메일 입력'>")
		const $searchName = $("<input class='searchInfo' placeholder='이름 입력'>")
		const $searchBtn = $("<button class='search'>아이디 찾기</button>");
		$targetDiv.append($searchEmail).append($searchName).append($searchBtn);
		
		$searchBtn.click(e=>{
			$.get(`<%=request.getContextPath()%>/user/finduserid.do?userEmail=\${$searchEmail.val()}&userName=\${$searchName.val()}`)
			.done(data=>{
				if(data!="") {
					const $resultId = $("<input class='searchInfo' readOnly>");
					$resultId.attr("value",`찾으시는 아이디는 \"\${data}\" 입니다.`);
					$("div[id='searchResult']").css("display","none");
					$("div[class='login_container']").append($resultId);
					const $loginTryBtn = $("<button class='search'>로그인 하러가기</button>");
					$loginTryBtn.appendTo("div[class='login_container']");
					$loginTryBtn.click(e=>{
						location.assign('<%=request.getContextPath()%>/user/login.do');
					})
				} else {
					alert("존재하지 않는 회원 정보입니다.");
					location.assign('<%=request.getContextPath()%>/user/login.do');
				}
			})	
		})
	}
	// 비밀번호 변경
	const changePw =(e)=>{
		$targetDiv.html("");
		$("#loginform").css("display","none");
		$(".login_links").css("display","none");
		$("img[id=kakaobtn]").css("display", "none");
		const $searchId = $("<input name='m_id' class='searchInfo' placeholder='아이디 입력'>");
		const $searchEmailBox = $("<div id='emailCheckBox'>");
		const $searchEmail = $("<input name='m_email' class='searchInfo' placeholder='찾으실 계정 이메일 입력'>");
		const $searchBtn = $("<button class='checkBtn'>이메일 인증</button></div>");
		$searchEmailBox.append($searchEmail).append($searchBtn);
		$targetDiv.append($searchId).append($searchEmailBox);
		
		
		// ID, email 입력 시 일치하는 회원이 있다면 메일 보내는 버튼 및 함수 설정
		let userInfoAdded = false;
		$searchBtn.click(e=>{
			location.assign("<%=request.getContextPath()%>/user/findpw.find?m_email="+$searchEmail.val()+"&m_id="+$searchId.val());
		})
	}
			
			
			
			
			// DB에 등록된 이메일이 있는지 확인하는 로직
			<%-- $.post("<%=request.getContextPath()%>/user/findpw.find",
					{"m_email":$searchEmail.val(),
					 "m_id":$searchId.val()})
			.done(send=>{
				console.log(1);
				alert(send.message);
				window.location.href = sned.redirect;
		        // window.location.href = data.redirect;
		        // UserChangePw 30번째 코드에서 설정한 changePwForm.jsp의 html 코드들을 적용해서 ajax 통신으로 처리하고 싶어하는 중...ㅠㅠ 
		        // https://persimmon-ary-stepbystep.tistory.com/47 → action 클래스 보는 중
			})
			.done(data=>{
				console.log(2);
				$.post("<%=request.getContextPath()%>/user/changepw.find",
						{
							"authenticationCode":(String)(request.getSession().getAttribute("authenticationCode")),
							"m_id":(String)(request.getSession().getAttribute("m_id"))
						})
				.done(pw=>{
					console.log(3);
					console.log(pw);
				})
			}) --%>
			
			
			// 입력한 인증번호가 같다면 실행해야할 로직
			/*
			if(!userInfoAdded){
				const $changeBtn = $("<button class='checkBtn'>변경하실 비밀번호 입력</button>");
				$targetDiv.append($changeBtn);
				userInfoAdded=true;
				let clickChange = false;
				$changeBtn.click(e=>{
					if(!clickChange){
						clickChange=true;
						// 이름 맞는지 확인 후 맞다면,
						const $ckResult = $("<p>");
						
						const $newPw = $("<input class='searchInfo' type=password placeholder='변경하실 비밀번호'>")
						const $newPwCk = $("<input class='searchInfo' type=password placeholder='비밀번호 확인'>")
						const $sendChange = $("<button id='kakaobtn'>변경하기</button>");
						$sendChange.css({"background-color":"#ffeda4", "border":"none", "margin-top":"0"});
						$newPwCk.keyup(e=>{
							if($newPw.val()==$newPwCk.val()){
								$ckResult.css("color","green").text("비밀번호가 일치합니다.")
							} else {
								$ckResult.css("color","red").text("비밀번호가 불일치합니다.")
							}
						})
						$targetDiv.append($newPw).append($newPwCk);
						$targetDiv.append($ckResult).append($sendChange);
						
						// 이름이 없다면
					}
				})
			}
			*/
		
</script>
<!-- <script>
카카오톡의 입장에서 개발자들이 만든 그룹을 Client가 어떠한 그룹을 보는 건지 확인하기 위하여 JavaScript 키를 가져온다.
초기화의 기능이 아님.
	Kakao.init('a5195f24115fc28a6fae3a6191e0f7b0');
	console.log(Kakao.isInitialized());
</script> -->
<script type="text/javascript">
    // Kakao SDK 초기화(JavaScript 키를 사용하여 초기화)
    Kakao.init('a5195f24115fc28a6fae3a6191e0f7b0');
    // 카카오 로그인을 실행
    function kakaoLogin() {
        Kakao.Auth.login({
            // 로그인 성공 시 실행되는 콜백 함수
            success: function (response) {
                // 사용자 정보 요청을 위해 Kakao API를 호출
                Kakao.API.request({
                    url: '/v2/user/me', // 사용자 정보 요청 URL
                    // 사용자 정보 요청이 성공했을 때 실행되는 콜백 함수
                    success: function (response) {
                        console.log(response); 
                        const id = response.id; 
                        const email = response.kakao_account.email.split('@')[0]; 
                        const userInfo = {
                            id: id,
                            email: email
                        };
                        // Ajax를 사용하여 JSON 데이터를 서버로 전송
                        fetch("<%=request.getContextPath()%>/user/enrollbykakao.do",{
                        	method:"POST",
                        	headers: {
                        		"Content-Type" : "application/json"
                        	},
                        	body: JSON.stringify(userInfo)
                        })
                        .then(response=>response.json())
                        .then(data=>{
                        	console.log(data);
                        })
                        .catch(error =>{
                        	console.error("Error-", error);
                        });
                    },
                    // 사용자 정보 요청이 실패했을 때 실행되는 콜백 함수
                    fail: function (error) {
                        alert(JSON.stringify(error)); 
                    },
            });
    	},
            // 로그인 실패 시 실행되는 콜백 함수
            fail: function (error) {
                alert(JSON.stringify(error));
            },
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>