<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.user.model.dto.User, com.web.dog.model.dto.Dog, java.util.List"%>
<%
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	List<User> users = (List<User>)request.getAttribute("users");
%>
<style>
    .adminpage-container {
        margin-top: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:hover {
    	cursor:pointer;
        background-color: #f5f5f5;
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    li {
        margin-bottom: 5px;
    }
    .justify-content-center {
    	margin-top: 3%;
    }
    .search-container {
        margin: 20px 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .search-container input[type="text"] {
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-right: 10px;
        width: 200px;
    }
    .search-container button {
        padding: 10px 20px;
        font-size: 14px;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .resign-td{
    	display: none;
    }
    .resign-btn{
    	padding: 5px 10px;
        font-size: 12px;
        color: #fff;
        background-color: #c40000;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
</style>
<h2>산책하개 회원관리</h2>
<div class="adminpage-container">
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
		<button class="search-user-btn">검색</button>
	</div>
	<div>
		<%=request.getAttribute("pageBar") %>
	</div>
</div>

