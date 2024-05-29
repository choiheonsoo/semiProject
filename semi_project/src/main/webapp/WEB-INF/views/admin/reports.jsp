<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.web.board.model.dto.Report, com.web.dog.model.dto.Dog, java.util.List"%>
<%
	List<Report> reports = (List<Report>)request.getAttribute("reports");
	StringBuffer pageBar = (StringBuffer)request.getAttribute("pageBar");
%>
<div class="adminpage-container">
	<table>
		<tr>
			<th>해당 게시글 번호</th>
			<th>신고 유형</th>
			<th>신고자</th>
			<th>신고대상</th>
			<th>신고내용</th>
			<th>게시글 이동</th>
			<th>대상 탈퇴처리</th>				
		</tr>
		<%if(!reports.isEmpty()){ 
			for(Report report:reports) {%>
			<tr class="reports-info">
				<td><%=report.getBullNo() %></td>
				<td><%=report.getReportType() %></td>
				<td><%=report.getReporterId() %></td>
				<td><%=report.getReportedId() %></td>
				<td><%=report.getReportContent() %></td>
				<td><button class="check-board" value="<%=report.getBullNo()%>">이동</button></td>
				<td><button class="report-btn" value="<%=report.getReportedId()%>">탈퇴</button></td>
			</tr>
			<%}%>
		<%}%>
	</table>
	<div class="search-container">
		<input id="search-reported-id" type="text" placeholder="신고대상 아이디">
		<button class="search-reported-btn">검색</button>
	</div>
	<div>
		<%=pageBar==null||pageBar.length()<5?"":pageBar %>
	</div>
</div>