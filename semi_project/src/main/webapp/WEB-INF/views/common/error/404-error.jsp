<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 Error</title>
   <style>
    	body{
	    	background-size:50%;
	    	display: flex;
	    	flex-direction:column;
		    justify-content: center;
		    align-items: center;
		    height: 100vh;
		    margin: 0;
    	}
    	#countdown {
   			 background-color: black; /* 박스 배경색 지정 */
  			 padding: 20px;
   			 border-radius: 10px; /* 박스 모서리 둥글게 만듦 */
   			 color:white;
   			 font-weight: 900;
 	 	}
    </style>
</head>
<body>
    <h1>404 - Not Found</h1>
    <p>The page you requested does not exist.</p>
    <div id="countdown">이전 페이지로 이동합니다...</div>

	<script>
		// 5초 후에 이전 페이지로 리디렉션
		setTimeout(function() {
		    window.history.back();
		}, 5000);
	</script>
</body>
</html>
