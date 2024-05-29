<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 Error</title>
    <style>
    	body{
	    	background-image:url("https://i.namu.wiki/i/2v1DcCLskboCuex0fKwt482U7F1dJ5LQnw68McjP02WAFQ7f9dek1hWcbY8_RtKtdOzyneHncZ88wktJGqorwQ.webp");
	    	background-size:50%;
	    	display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 100vh;
		    margin: 0;
    	}
    	#countdown {
   			 background-color: white; /* 박스 배경색 지정 */
  			 padding: 20px;
   			 border-radius: 10px; /* 박스 모서리 둥글게 만듦 */
 	 	}
    </style>
</head>
<body>
    <h1>500 - Internal Server Error</h1>
    <p>An unexpected error occurred on the server.</p>
    <div id="countdown">이전 페이지로 이동합니다...</div>

	<script>
		// 5초 후에 이전 페이지로 리디렉션
		setTimeout(function() {
		    window.history.back();
		}, 5000);
	</script>
</body>
</html>
