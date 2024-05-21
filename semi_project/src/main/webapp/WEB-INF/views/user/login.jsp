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
            width: 350px;
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
            margin-top: 20px;
        }
        .login_container .login_links a {
            text-decoration: none;
            color: #007bff;
            margin-right: 10px;
            transition: color 0.3s ease;
        }
        .login_container .login_links a:hover {
            color: #0056b3;
        }
        
        .login_container .message {
            color: red;
            margin-top: 10px;
        }
        
        #kakaologinbtn {
        	margin-bottom: 4%;
        	width: 339px;
        	height: 48px;
        	border-radius: 15px;
        	opacity: 0.5;
        	transition: opacity 0.3s;
        }
        #kakaologinbtn:hover{
        	opacity: 1;
        }
 </style>
<section class="content">
	<div class="login_container">
	<div>
        <a href="javascript:kakaoLogin()"><img id="kakaologinbtn" src="<%=request.getContextPath()%>/images/kakaologin.png"></a>
     </div>
		<h2>어서오시개!</h2>
	        <form action="<%=request.getContextPath() %>/user/loginuser.do" method="post">
	            <input type="text" name="username" placeholder="아이디 입력" required>
	            <input type="password" name="password" placeholder="패스워드 입력" required>
	            <input type="submit" value="로그인">
		            <div class="login_links">
		                <a href="<%=request.getContextPath()%>/user/new_user.do">회원가입</a><br>
		                <a href="<%=request.getContextPath()%>/user/finduserinfo.do">아이디/비밀번호 찾기</a><br>
		            </div>
	        </form>
	</div>
</section>
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