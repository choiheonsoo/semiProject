<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
section#changePwSection {
	font-family: Arial, sans-serif;
	background-color: white;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

div#changePwContainer {
	display: flex;
	flex-direction: column; align-items : center;
	justify-content: center;
	background-color: white;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	text-align: center;
	align-items: center;
}

div#changePwContainer>h2 {
	margin-bottom: 20px;
	color: #00409d;
	font-weight: bolder;
}

#contactForm {
	display: flex;
	flex-direction: column;
	background-color: white;
	padding: 40px;
	width: 400px;
	text-align: center;
	justify-content: center;
}
#contactForm>input {
	height: 30px;
	margin: 3%;
	border: 1px solid gray;
    border-radius: 5px;
}

input#changePw {
	margin-top: 4%;
	padding: 10px;
	background-color: #76acfc;
	color: #dfdffd;
	border: none;
	border-radius: 15px;
	cursor: pointer;
	margin-bottom: 4%;
	transition: background-color 0.3s ease;
}
input#changePw:hover{
	background-color: #1e67d2;
}
</style>
<section id=changePwSection>
	<div id="changePwContainer">
		<h2>비밀번호 변경하기</h2>
		<form action="<%=request.getContextPath()%>/user/sendpw.find" onsubmit="return checkForm()" method="post" id="contactForm" name="changePwForm" >
			<input type="hidden" name="m_id" value="${m_id}"> 
			
			<input type="password" class="" id="authenCode" name="authenCode" placeholder=" 메일로 받으신 인증번호를 입력하세요" 
			onfocus="this.placeholder = ''"	onblur="this.placeholder = ' 메일로 받으신 인증번호를 입력하세요'"> 
			
			<input type="submit" id="changePw" value='변경하기'>
		</form>
	</div>
</section>
<script>
	const checkForm = function(e){
		const reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		const authenCode = $('#authenCode').val();
		const newPw = $('#newPw').val();
		const checkPw = $('#checkPw').val();
		console.log(reg.test(newPw));
		if(authenCode==null||authenCode===''||newPw==null||newPw===''||checkPw==null||checkPw===''){
			alert("모든 입력란을 작성해주세요.");
			return false;
		} else if(newPw !== checkPw){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		} else if(!reg.test(newPw)){
			alert("비밀번호는 특수기호와 숫자 및 영문자를 포함하여 8~15글자로 설정해주세요.");
			return false;
		} else {
			return true;
		}
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>