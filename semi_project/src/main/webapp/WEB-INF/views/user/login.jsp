<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	<img id="kakaologinbtn" src="<%=request.getContextPath()%>/images/kakaologin.png">
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

 <script>
 	document.getElementById("kakaologinbtn").addEventListener("click", () =>{
 		Kakao.Auth.authorize();
 	})
 
 </script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>