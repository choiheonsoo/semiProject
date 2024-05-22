<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<form  action="<%=request.getContextPath() %>/user/loginuser.do" method="post">
	 <input type="text" name="searchemail" placeholder="이메일 입력" required>
	 <input type="text" name="searchname" placeholder="이름 입력" required>
</form>