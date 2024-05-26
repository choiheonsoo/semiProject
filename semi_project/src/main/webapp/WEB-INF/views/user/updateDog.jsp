<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List" %>
<%
	User user = (User)session.getAttribute("loginUser");
	String oriDogFileName = (String)session.getAttribute("dogImg");
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	request.setAttribute("userId", user.getUserId());
	String[] breeds = new String[]{"그레이하운드","닥스훈트","달마시안","도베르만","리트리버","말라뮤트","말티즈","말티푸","미니핀","배들링턴 테리어","불독","비숑","사모예드","샤페이","세상에 하나뿐인 믹스","셰퍼드","쉽독","슈나우저","스피츠","시바","시츄","요크셔테리어","웰시코기","잭러셀테리어","진돗개","치와와","코커스페니얼","파피용","퍼그","포메라니안","푸들","허스키","기타"};
%>
<style>

section.updateDog {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    margin: 30px auto;
    height: auto;
}

#dogUpdateOption h3 {
    font-size: 24px;
    color: #333333;
    margin-bottom: 20px;
    text-align: center;
}


#userChoice {
    text-align: center;
    margin-bottom: 20px;
}

#userChoice input[type="radio"] {
    margin: 0 10px;
}


.dogInfo {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
}

.dogInfo label {
    font-weight: bold;
    margin-bottom: 5px;
}

.dogInfo input[type="text"],
.dogInfo select,
.dogInfo input[type="file"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.dogInfoBtn {
    background-color: #FFB914;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    transition: background-color 0.3s;
    margin-top: 10%;
}

.dogInfo button:hover {
    background-color: #FF9100;
}


#dogPrev img {
    max-width: 100%;
    border-radius: 10px;
}

.updateForm {
	display: flex;
	flex-direction: column;
	align-items: center;
}
	
</style>
	<section class="updateDog">
		<div id="dogUpdateOption">
			<h3 style="overflow:hidden;">강아지 정보 수정</h3>
			<div id="userChoice">
				<input type="radio" name="option" value="수정" checked> 기존 반려견 정보 수정 &nbsp; &nbsp;
				<input type="radio" name="option" value="추가"> 반려견 추가 
			</div>
		</div>
		<div id="updatePage">
			<% if(dogs.size()>0){%> 
			<div id="updateDog">
				<form class="updateForm" action="<%=request.getContextPath() %>/dog/updatedogend.do" method="post" enctype="multipart/form-data">
					<input type="text" name="userId" value="<%=user.getUserId()%>" style="display:none">
					<div class="dogInfo">
						<label for="dogNameOption">수정하실 반려견</label>
						<select name="dogNameOption" id="dogNameOption">
						<%for(Dog dog : dogs){%>
								<option value="<%=dog.getDogName()%>"><%=dog.getDogName() %></option>	
						<%}%>
						</select>
						<input type="hidden" name="orifilename" value="<%=oriDogFileName%>">
						<label for="dogName">반려견 이름 *</label>
					    <input id="dogName" type="text" name="dogName" readOnly>
					    <label for="dogBreed">반려견 견종 *</label>
					    <select name="dogBreedKey" class="dogBreed">
					    	<%for(String breed:breeds){ %>
					    	<option value=<%=breed %>><%=breed %></option>
					    	<%} %>
					    </select>
					    <label for="dogWeight">반려견 몸무게 *</label>
					    <input type="text" name="dogWeight">
					    <label for="dogImg">대표 반려견 사진 *</label>
					    <input class="dogImg" type="file" name="dogImg" accept="image/*">
					</div>
					<div>
						<button class="dogInfoBtn">수정하기</button>
					</div>
				</form>
			</div>
			<%}%>
			<div id="insertDog" style="display:none;">
				<form class="updateForm" action="<%=request.getContextPath() %>/dog/insertdogend.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="userId" value="<%=user.getUserId()%>">
					<div class="dogInfo">
						<label for="dogName">반려견 이름 *</label>
					    <input type="text" name="addDogName">
					    <label for="dogBreed">반려견 견종 *</label>
					    <select name="addDogBreedKey" class="dogBreed">
					    	<%for(String breed:breeds){ %>
					    	<option value=<%=breed %>><%=breed %></option>
					    	<%} %>
					    </select>
					    <label for="addDogWeight">반려견 몸무게 *</label>
					    <input type="text" name="addDogWeight">
					    <label for="dogImg">대표 반려견 사진 *</label>
					    <input type="hidden" name="oriDogFileName" value="<%=oriDogFileName %>">
					    <input id="addDogImg" class="dogImg" type="file" name="addDogImg" accept="image/*">
					</div>
					<div>
						<button class="dogInfoBtn">가족 추가하기</button>
					</div>
				</form>
			</div>
		</div>
	</section>
	
<script>
	const $dogPrev = document.querySelectorAll("div[class='dogPrev']");
	const $dogImg = document.querySelectorAll("input[class='dogImg']");
	
	const $option = document.querySelectorAll("input[type=radio]");
	// 기존에 등록된 강아지가 있는 회원의 경우 강아지 수정 항목 클릭 가능
	if(<%=dogs.size()>0%>){
		// 사용할 항목 선택
		$option.forEach(o => {
			o.addEventListener("change", e => {
				if(e.target.value == "수정"){
					// 수정 버튼 클릭 시
					document.getElementById("updateDog").style.cssText = "display: flex; justify-content: center;";
					document.getElementById("insertDog").style.display = "none";
					
				} else {
					// 추가 버튼 클릭 시
					document.getElementById("updateDog").style.display = "none";
					document.getElementById("insertDog").style.cssText = "display: flex; justify-content: center;";
				}
			});
		});
		
		// 강아지 이름 수정은 불가능 따라서, select 태그에서 수정할 강아지 클릭 시 해당 강아지 이름 input[readonly] 태그에 출력
		document.addEventListener("DOMContentLoaded", () => {
			const $options = document.getElementById("dogNameOption");
			$options.addEventListener("change", e => {
				console.log(e.target.value);
				let dogName = e.target.value;
				document.getElementById("dogName").value = dogName;
			});

			document.getElementById("dogName").value = $options.value;
		});
	} else {
		// 기존에 등록된 강아지가 없는 회원의 경우 수정 항목 클릭 불가능 오직 추가등록만 가능
		document.getElementById("userChoice").innerHTML = "<h4 style='overflow: hidden;'>반려견 추가 등록</h4>";
		document.getElementById("insertDog").style.cssText = "display: flex; justify-content: center;";
	}
</script>	

<%@ include file="/WEB-INF/views/common/footer.jsp" %>