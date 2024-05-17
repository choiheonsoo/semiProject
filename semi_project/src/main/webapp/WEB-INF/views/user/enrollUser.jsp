<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
	section#enrollContainer{
		font-family: Arial, sans-serif;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	    margin: 0;
	}
	div.container{
		padding: 20px;
		box-shadow: 0 0 20px 10px rgba(0,0,0,0.1);
		border-radius: 5px;
		width: 300px;
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
	}
	form#signupForm{
		display: flex;
		flex-direction: column;
	}
	
	form#signupForm>label{
		margin-top: 10px;
		margin-bottom: 3px;
		font-weight: bold;
	}
	form#signupForm>button{
		padding: 10px;
		font-size: 16px;
		background-color: rgb(255, 237, 164);
		border-radius: 3px;
		cursor: pointer;
		margin-top: 5%;
	}
	form#signupForm>button:hover{
		background-color: #FFBF30;
	}
	form#signupForm>label[for="gender"]>span{
		font-weight: normal;
		margin-right: 20px;
	}
	form#signupForm>label[for="ishavingdog"]>span{
		font-weight: normal;
		margin-right: 35px;
	}
	
</style>

<section id="enrollContainer">
	
	 <div class="container">
        <h1>회원가입</h1>
        <p> * 표시는 필수 입력 값 입니다.</p>
        <form id="signupForm" action="/user/enrollend.do" method="POST">
            <label for="userId">회원 아이디 *</label>
            <input type="text" id="userId" name="userId" placeholder="아이디는 6글자 이상으로 설정" minlength="6" required>

            <label for="password">비밀번호 *</label>
            <input type="password" id="password" name="password" placeholder="특수기호 포함 8글자 이상으로 설정" minlength="8" required>

            <label for="name">이름 *</label>
            <input type="text" id="name" name="name" minlength="2" required>

            <label for="email">이메일 *</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">휴대전화 *</label>
            <input type="tel" id="phone" name="phone" minlength="8" required>

            <label for="address">주소</label>
            <input type="text" id="address" name="address">

            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" name="nickname">

            <label for="birthday">생일</label>
            <input type="date" id="birthday" name="birthday">

            <label for="gender">성별 <br>
	            <input type="radio" name="gender" value="M"><span>남성</span>
	            <input type="radio" name="gender" value="F"><span>여성</span>
            </label>
            
            <label for="ishavingdog">반려견 유무<br>
            	<input type="radio" name="ishavingdog" value="Y"><span>예</span>
            	<input type="radio" name="ishavingdog" value="N"><span>아니오</span>
            </label>
            
            <button type="submit">가입하기</button>
        </form>
    </div>
    <div id="dogInfo" class="container" style="display:none"></div>
</section>
<script>
	// ishavingdog를 Y 체크하면 dogInfo 두둥등장 해서 강아지 정보 입력받기(Ajax)
	// 가입하기 버튼 클릭 시 eventListener로 DB에 회원 정보 및 강아지 정보 저장 후 메인 페이지로 이동
</script>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>