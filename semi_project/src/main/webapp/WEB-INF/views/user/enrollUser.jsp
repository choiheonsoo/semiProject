<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
String[] breeds = new String[]{"그레이하운드","닥스훈트","달마시안","도베르만","리트리버","말라뮤트","말티즈","말티푸","미니핀","배들링턴 테리어","불독","비숑","사모예드","샤페이","세상에 하나뿐인 믹스","셰퍼드","쉽독","슈나우저","스피츠","시바","시츄","요크셔테리어","웰시코기","잭러셀테리어","진돗개","치와와","코커스페니얼","파피용","퍼그","포메라니안","푸들","허스키","기타"};
%>
<style>
	section#enrollContainer{
		font-family: Arial, sans-serif;
		display: flex;
		justify-content: center;
		align-items: center;
	    height: auto;
	}
	
	div.container{
		padding: 30px;
		box-shadow: 0 0 20px 10px rgba(0,0,0,0.1);
		border-radius: 5px;
		width: 500px;
		height: auto;
		margin-top: 4%;
		margin-bottom: 4%;
	}
	
	div.container>h1{
		margin-bottom: 15px;
		font-size: 30px;
		text-align: center;
		overflow: hidden;
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
	form#signupForm input{
		margin-bottom: 2%;
		border-color: lightgray;
		border-left-style: none;
		border-right-style: none;
		border-top-style: none;
		border-left-width: 1px;
	}
	
	div.enrollTab{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-content: center; 
	}
	
	div#dogInfo{
		margin-left: 30px;
	}
	
	form#signupForm label{
		margin-top: 10px;
		margin-bottom: 3px;
		font-weight: bold;
	}
	form#signupForm>div.enrollTab>button{
		display: none;
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
		transition: background-color 0.3s ease;
	}
	form#signupForm>div.enrollTab>button:hover{
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
	div#dogInfo>*{
		margin-left: 2%;
		display: none;
	}
	div#dogPrev{
		width: 250px;
		/* background-color: magenta; */
	}
	button#verifyBtn, button#checkMsgBtn, button#verifyId{
		padding: 5px;
		font-size: 16px;
		background-color: rgba(13,110,253,0.53);
		border-radius: 15px;
		cursor: pointer;
		color: white;
		font-weight: bolder;
		border-style: none;
		transition: background-color 0.3s ease;
	}
	button#verifyBtn:hover,
	button#checkMsgBtn:hover,
	button#verifyId:hover{
		background-color: rgba(13,110,253,0.84);
	}
	div#verifyBox{
		margin-top: 4%;
		display: none;
	}
</style>

<section id="enrollContainer">
	 <div class="container">
        <h1>회원가입</h1>
        <p> * 표시는 필수 입력 값 입니다.</p>
        <form id="signupForm" onsubmit="return checkInfo();" action="<%=request.getContextPath() %>/user/enrollend.find" method="POST" enctype="multipart/form-data">
        	<div class="enrollTab">
	        	<div id="personInfo">
		            <label for="userId">회원 아이디 *</label>
		            <div>
		            	<input type="text" id="userId" name="userId" placeholder=" 영문자, 숫자 6~14글자" minlength="6" required>
		            	<button onclick="checkId();" id="verifyId">중복확인</button>
					</div>
					
		            <label for="password">비밀번호 *</label>
		            <input type="password" id="password" name="password" placeholder=" 영문자,숫자 및 특수기호 포함 8~15글자" minlength="8" required>
		            <input type="password" id="passwordck" name="password" placeholder=" 비밀번호 확인" minlength="8" required>
		            <span id="pwresult"></span>
		
		            <label for="name">이름 *</label>
		            <input type="text" id="name" name="name" minlength="2" required>
		
		            <label for="email">이메일 *</label>
		            <div>
			            <input type="email" id="email" name="email" required>
			            <button onclick="verify();" id="verifyBtn">메일발송</button>
			        </div>
			         
			         <div id="verifyBox">
				        <input type="text" id="verifyText">
				        <button id="checkMsgBtn">인증하기</button>
			         </div>
			       
			    <label for="phone">휴대전화 *</label>
			    <input type="tel" id="phone" name="phone" placeholder="' - '을 제외하고 입력해주세요." minlength="8" required>
			
			    <label for="address">주소</label>
			    <input type="text" id="address" name="address">
			
			    <label for="birthday">생일</label>
			    <input type="date" id="birthday" name="birthday">
			                        
			    <label for="ishavingdog">반려견 유무<br>
			           	<input type="radio" name="ishavingdog" value="Y"><span> 예</span>
			          	<input type="radio" name="ishavingdog" value="N" checked><span> 아니오</span>
			    </label>
		            
	            </div>	            
	            <div id="dogInfo">
	            	<label for="dogName">반려견 이름 *</label>
	            	<input type="text" name="dogName">
	            	<label for="dogBreed">반려견 견종 *</label>
	            	<select name="dogBreedKey" id="dogBreed">
	            		<%for(String breed:breeds){ %>
					    <option value=<%=breed %>><%=breed %></option>
					    <%} %>
	            	</select>
	            	<label for="dogWeight">반려견 몸무게</label>
	            	<input type="text" name="dogWeight">
	            	<label for="dogImg">대표 반려견 사진</label>
	            	<input id="dogImg" type="file" name="dogImg" accept="image/*">
	            	<div id="dogPrev">
	            	</div>
	            </div>
            </div>
            <div class="enrollTab">
           		<button type="submit">가입하기</button>
            </div>
        </form>
    </div>
</section>

<script>
	//이메일 인증 로직
	const verify = () => {
		$.post("<%=request.getContextPath()%>/user/sendemail.do",{
			"email":$("#email").val()	// 입력한 이메일을 서블릿으로 넘김(이메일로 메일 발신 및 session에 코드 저장)
		})
		.done((user)=>{	// user? 해당 서블릿에서 DB에 접속해서 가져온 입력한 email 값을 가진 유저
			if(user==null){	// 사용중인 이메일이 아니라면,
				alert("인증코드가 발송되었습니다.");
				$("#verifyBox").css("display", "block");	// 인증번호 입력 박스 등장
				$("#checkMsgBtn").off('click').on('click', e => {	// 챗 지피티의 도움... 재귀호출...
			    	$.post("<%=request.getContextPath()%>/user/verifyemail.do", 
			    		{"inputCode": $("#verifyText").val()})
			        .done((data)=> {	// data ? Servlet에서 입력한 값.equals(session에 저장한 인증코드)
			            if(data==true){	// 인증코드가 같을 경우
			            	alert("인증이 완료되었습니다.")
			               	$("div.enrollTab>button[type=submit]").css("display", "block");
			            } else {
			            	alert("올바른 인증코드가 아닙니다. 다시 시도해주세요.");
			            }
			         });
			    });
			} else {
				alert("이미 사용 중인 이메일입니다.");
			}
		});
	}
	
	const $dogImg = document.querySelector("#dogImg");
	// 이벤트가 선택됐을 때 발생하는 이벤트
	$dogImg.addEventListener("change", (e) => {
		document.getElementById("dogPrev").innerHTML="";
		const reader = new FileReader();
		reader.readAsDataURL(e.target.files[0])
				
		// FileReader 가 이미지를 모두 읽어왔을 때(로딩 됐을 때) 발생하는 이벤트
		reader.onload = function(event){
			const $img = document.createElement("img");
			// base64 인코드 된 정보를 img태그에 담음
			$img.setAttribute("style", "width:98%");
			$img.setAttribute("src", event.target.result);
			document.getElementById("dogPrev").appendChild($img);
		} 
	});
	
	document.querySelector("label[for=ishavingdog]").addEventListener("change",e=>{
		const $inputs = document.querySelectorAll("label[for=ishavingdog]>input");
		if($inputs[0].checked){
			document.querySelectorAll("div#dogInfo *").forEach(e=>{
				e.style.display="block";
			})
		} else {
			document.querySelectorAll("div#dogInfo *").forEach(e=>{
				e.style.display="none";
			})
		}
	});
	
	// 비밀번호 유효 검사
	const checkInfo=()=>{
		const pw = document.getElementById("password").value;
		const reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		const regid = /^[a-z]+[a-z0-9]{5,13}$/g;
		const regphone = /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/;
		if(!reg.test(pw)){
			$("#password").val("");
			$("#passwordck").val("");
			alert("비밀번호는 특수기호와 숫자 및 영문자를 포함하여 8~15글자로 설정해주세요.");
			$("#password").focus();
			return false;
		} else if($("#password").val()!==$("#passwordck").val()){
			$("#password").val("");
			$("#passwordck").val("");
			alert('비밀번호가 일치하지 않습니다.');
			$("#password").focus();
			return false;
		} else if(!regid.test($("#userId").val())){
			$("#userId").val("").attr("readonly",false);
			alert("아이디는 영문자로 시작하여 숫자를 포함하여 6~14글자로 설정해주세요.");
			$("#userId").focus();
			return false;
		} else if(!regphone.test($("#phone").val())){
			$("#phone").val("");
			alert("올바른 핸드폰 번호를 입력해주세요.");
			$("#phone").focus();
			return false;
		} else {
			alert("산책하개의 회원이 되신 것을 환영합니다");
			return true;
		}
		
	}
	
	// 비밀번호 일치 검사
	$("#passwordck").keyup(e=>{
		$("#pwresult").html("");
		if($("#password").val()===$("#passwordck").val()){
			$("<p>").text('비밀번호가 일치합니다.').css('color','green').appendTo($("#pwresult"));
		} else {
			$("<p>").text('비밀번호가 불일치합니다.').css('color','red').appendTo($("#pwresult"));
		}
	})
	
	// 아이디 유효 검사
	const checkId = () =>{
		$.post("<%=request.getContextPath()%>/user/searchId.do",
				{"userId":$("#userId").val()}
		)
		.done(id=>{
			if(id.length>0){
				alert('이미 사용 중인 아이디 입니다.');
				document.getElementById("userId").value = "";
			} else {
				alert('사용 가능한 아이디 입니다.');
				$("#userId").attr("readonly", true).css("fontWeight", "bolder");
			}
		})
	}

</script>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>