<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List" %>
<%
	User user = (User)session.getAttribute("loginUser");
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	request.setAttribute("userId", user.getUserId());
%>
<style>
	section.updateDog{
		background-color: rgba(230,230,250,0.65);
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 90vh;
	}
	div#dogUpdateOption{
		margin-top: 4%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}
	
	div#updateDog div{
		display: flex;
		flex-direction: column;
		justify-content: space-around;
	}
	div#insertDog div{
		display: flex;
		flex-direction: column;
		justify-content: space-around;
	}
</style>
	<section class=updateDog>
		<div id="dogUpdateOption">
			<h3 style="overflow:hidden;">강아지 정보 수정</h3>
			<div id="userChoice">
				<input type="radio" name="option" value="수정" checked> 기존 반려견 정보 수정 &nbsp; &nbsp;
				<input type="radio" name="option" value="추가"> 반려견 추가 
			</div>
		</div>
		<% if(dogs.size()>0){%> 
		<div id="updateDog">
			<form action="<%=request.getContextPath() %>/dog/updatedogend.do" method="post" enctype="multipart/form-data">
				<input type="text" name="userId" value="<%=user.getUserId()%>" style="display:none">
				<div class="dogInfo">
					<select id="dogNameOption">
					<%for(Dog dog : dogs){%>
							<option value="<%=dog.getDogName()%>"><%=dog.getDogName() %></option>
					<%}%>
					</select>
					<label for="dogName">반려견 이름 *</label>
				    <input id="dogName" type="text" name="dogName" readOnly>
				    <label for="dogBreed">반려견 견종 *</label>
				    <select name="dogBreedKey" class="dogBreed">
				    	<option value="진도">진도</option>
				    	<option value="믹스">세상에 하나뿐인 믹스</option>
				    	<option value="치와와">치와와</option>
				    </select>
				    <label for="dogWeight">반려견 몸무게 *</label>
				    <input type="text" name="dogWeight">
				    <label for="dogImg">대표 반려견 사진 *</label>
				    <input class="dogImg" type="file" name="dogImg" accept="image/*">
				    <div class="dogPrev">
				    </div>
					<button>수정하기</button>
				</div>
			</form>
		</div>
		<%}%>
		<div id="insertDog" style="display:none;">
			<form action="<%=request.getContextPath() %>/dog/insertdogend.do" method="post" enctype="multipart/form-data">
				<div class="dogInfo">
					<label for="dogName">반려견 이름 *</label>
				    <input type="text" name="dogName">
				    <label for="dogBreed">반려견 견종 *</label>
				    <select name="dogBreedKey" class="dogBreed">
				    	<option value="진도">진도</option>
				    	<option value="믹스">세상에 하나뿐인 믹스</option>
				    	<option value="치와와">치와와</option>
				    </select>
				    <label for="dogWeight">반려견 몸무게 *</label>
				    <input type="text" name="dogWeight">
				    <label for="dogImg">대표 반려견 사진 *</label>
				    <input class="dogImg" type="file" name="dogImg" accept="image/*">
				    <div class="dogPrev">
				    </div>
				    <button>가족 추가하기</button>
				</div>
			</form>
		</div>
		
	</section>
<script>
	if(<%=dogs.size()>0%>){
		const $option = document.querySelectorAll("input[type=radio]");
		console.log($option);
		$option.forEach(o =>{
			o.addEventListener("change", e=>{
				if(e.target.value=="수정"){
					document.getElementById("updateDog").style.display="flex";
					document.getElementById("insertDog").style.display="none";
				} else {
					document.getElementById("updateDog").style.display="none";
					document.getElementById("insertDog").style.display="flex";
				}
			})
		})
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
		document.getElementById("userChoice").innerHTML = "<h4 style='overflow: hidden;'>반려견 추가 등록</h4>";
		document.getElementById("insertDog").style.display="flex";
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>