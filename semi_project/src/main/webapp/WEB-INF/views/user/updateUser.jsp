<%@ page import="com.web.user.model.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
	section#updateContainer{
		font-family: Arial, sans-serif;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}
	div.container{
		padding: 20px;
		box-shadow: 0 0 20px 10px rgba(0,0,0,0.1);
		border-radius: 5px;
		width: 500px;
		margin-top: 4%;
	}
	
	div.container>h1{
		margin-bottom: 15px;
		font-size: 30px;
		text-align: center;
	}
	div.container>p{
		margin-bottom: 0px;
		font-weight: bold;
		font-style: italic;
		text-align: right;
	}
	
	form#signupForm{
		display: flex;
		flex-direction: column;
	}
	div.enrollTab{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-content: center; 
	}
	
	form#signupForm label{
		margin-top: 10px;
		margin-bottom: 3px;
		font-weight: bold;
	}
	form#signupForm button{
		padding: 10px;
		font-size: 16px;
		background-color: #FFB914;
		border-radius: 15px;
		cursor: pointer;
		margin-top: 5%;
		width: 100%;
		color: white;
		font-weight: bolder;
		border-style: none;
	}
	form#signupForm button:hover{
		background-color: #FF9100;
	}
	form#signupForm label[for="gender"]>span{
		font-weight: normal;
		margin-right: 20px;
	}
	form#signupForm label[for="ishavingdog"]>span{
		font-weight: normal;
		margin-right: 35px;
	}
	div#personInfo{
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		width: 300px;
	}
	div#dogInfo *{
		margin-left: 2%;
		display: none;
	}
	div#dogPrev{
		width: 250px;
		height: 250px;
		/* background-color: magenta; */
	}
</style>

<section id="updateContainer">
	 <div class="container">
        <h1>회원수정</h1>
        <p> * 표시는 필수 입력 값 입니다.</p>
        <form id="signupForm" action="<%=request.getContextPath() %>/user/updateend.do" method="POST">
        	<div class="enrollTab">
	        	<div id="personInfo">
		            <label for="userId">회원 아이디 *</label>
		            <input type="text" id="userId" name="userId" value=" <%=loginUser.getUserId() %>" readOnly style="background-color: #DCDCDC">
		
		            <label for="password">비밀번호 *</label>
		            <input type="password" id="password" name="password" placeholder=" 특수기호 포함 8글자 이상" minlength="8" required>
		
		            <label for="name">이름 *</label>
		            <input type="text" id="name" name="name" minlength="2" required>
		
		            <label for="email">이메일 *</label>
		            <input type="email" id="email" name="email" required>
		
		            <label for="phone">휴대전화 *</label>
		            <input type="tel" id="phone" name="phone" minlength="8" required>
		
		            <label for="address">주소</label>
		            <input type="text" id="address" name="address">
		
		            <label for="birthday">생일</label>
		            <input type="date" id="birthday" name="birthday">
	            </div>	            
            </div>
            <div class="enrollTab">
           		<button type="submit">수정하기</button>
            </div>
        </form>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>