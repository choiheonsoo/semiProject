<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.user.model.dto.User, com.web.dog.model.dto.Dog, java.util.List"%>
<%
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	List<User> users = (List<User>)request.getAttribute("users");
%>
<h2>산책하개 회원관리</h2>
<div class="adminpage-container user-container">
	<table>
		<tr>
			<th>아이디</th>
			<th>성함</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>생일</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>산책메이트 참여횟수</th>
			<th>적립금</th>
			<th>반려견</th>				
		</tr>
		<%if(!users.isEmpty()){ 
			for(User user:users) {%>
			<input type='hidden' id="search-user-status" value="<%=user.getStatus() %>">
			<tr class="user-info">
				<td><%=user.getUserId() %></td>
				<td><%=user.getUserName() %></td>
				<td><%=user.getPhone()==null || user.getPhone().equals("null")?"등록 안함":user.getPhone() %></td>
				<td><%=user.getEmail() %></td>
				<td><%=user.getBirthDay()==null || user.getBirthDay().equals("null")?"등록 안함":user.getBirthDay() %></td>
				<td><%=user.getZipCode()==null || user.getZipCode().equals("null")?"등록 안함":user.getZipCode() %></td>
				<td><%=user.getAddress()==null || user.getAddress().equals("null")?"등록 안함":user.getAddress() %></td>
				<td><%=user.getMateCount() %></td>
				<td><%=user.getPoint() %></td>
				<td>
					<ul>
					<%if(!dogs.isEmpty()) {
						for(Dog dog : dogs){ 
							if(dog.getUserId().equals(user.getUserId())){%>
							<li><%=dog.getDogName() %></li>
						<%}
						} 
					}%>
					</ul>
				</td>
			</tr>
			
			<%}%>
		<%}%>
	</table>
	<div class="search-container">
		<input id="search-user-id" type="text" placeholder="회원 아이디">
		<!-- <button class="search-user-btn">검색</button> -->
		<button class="search-user-btn" value='<%=((List<User>)request.getAttribute("users")).get(0).getStatus()%>'>검색</button>
	</div>
	<div>
		<%=request.getAttribute("pageBar") %>
	</div>
</div>

