<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style>
</style>
<script>
$.ajax({
    url:"/board/regist",
    type:"get",
    success:function(responseData){
    	alert("전송 성공!");
    }
 });
</script>
</head>
<body>
	
</body>
</html>