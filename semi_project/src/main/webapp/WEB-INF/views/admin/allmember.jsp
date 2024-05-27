<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.user.model.dto.User, com.web.dog.model.dto.Dog, java.util.List"%>
<%
	List<Dog> dogs = (List<Dog>)request.getAttribute("dogs");
	List<User> users = (List<User>)request.getAttribute("users");
%>
<style>
    .user-container {
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
<div class="user-container">
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

<script>
    // 비동기적 절차에 따른 페이징 처리
    $(document).on("click",".page-link", function(p) {
    	let pageValue = $(p.target).data("page");
        $.get("<%=request.getContextPath()%>/admin/searchmember.do?cPage=" + pageValue)
        .done(data => {
            $("div.content").html(data);
        });
    })

    let currentButton = null;
    // 회원 정보 <tr> 클릭 시 회원 강퇴 버튼 등장
    $(document).on("click", ".user-info", function(e) {
        if (currentButton) {
            currentButton.remove();
        }
        const $button = document.createElement("button");
        $button.innerText = "삭제";
        $button.setAttribute("class", "resign-btn");

        const lastTd = $(this).find("td:last")[0];
        lastTd.appendChild($button);
        currentButton = $button;
    });

    // 회원 아이디 검색 기능
    $(document).on("click", ".search-user-btn", function(e){
    	 const userid = $("#search-user-id").val();
         $.get("<%=request.getContextPath()%>/admin/searchuserbyid.do?userId="+userid)
         .done(data => {
             $("tr.user-info").remove();
             const $targetTbody = $(".user-container>table>tbody");
             const $searchUserTh = $targetTbody.append($("<tr>").append($("<th>").text("아이디")).append($("<th>").text("성함")).append($("<th>").text("전화번호"))
             .append($("<th>").text("이메일")).append($("<th>").text("생일")).append($("<th>").text("우편번호")).append($("<th>").text("주소"))
             .append($("<th>").text("산책 참여횟수")).append($("<th>").text("적립금")))
             const $searchUserTr = $targetTbody.append($("<tr class='user-info'>").append($("<td>").text(data.userId)).append($("<td>").text(data.userName)).append($("<td>").text(data.phone)).append($("<td>").text(data.email))
             .append($("<td>").text(data.birthDay)).append($("<td>").text(data.zipCode)).append($("<td>").text(data.address)).append($("<td>").text(data.mateCount))
             .append($("<td>").text(data.point)));
             
             $("div.spinner-border").remove();
    	})
    	printLoading('.user-container>table>tbody');        
    });
	
    // 특정 row 클릭하여 해당 유저 탈퇴 처리
    $(document).on("click", ".resign-btn", function(e){    	
    	const deleteTargetUserId = $(this).parent().siblings()[0].innerText;
    	$.get("<%=request.getContextPath()%>/admin/deleteuserbyid.do?userId="+deleteTargetUserId)
    	.done(data=>{
    		alert('회원 삭제에 성공했습니다.');
    		adminMain();
    	})
    	.fail(error=>{
    		alert('회원 삭제에 실패했습니다.');
    	})
    })
</script>

