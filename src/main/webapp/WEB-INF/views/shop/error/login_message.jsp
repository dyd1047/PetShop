<%@page import="com.koreait.petshop.model.common.MessageData"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
   MessageData messageData = (MessageData)request.getAttribute("messageData");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
   alert("로그인 이후 이용 가능한 페이지입니다.");
   history.back();
</script>
</head>
<body>
</body>
</html>