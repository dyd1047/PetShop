<%@page import="com.koreait.petshop.model.domain.Cart"%>
<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<%@ include file="../inc/header.jsp" %>
	<style>
* {
  box-sizing:border-box;
}

body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.container {
}

.row:after {
  content: "";
  display: table;
  clear: both
}

.column-66 {
  float: left;
  width: 66.66666%;
  padding: 20px;
}

.column-33 {
  float: left;
  width: 33.33333%;
  padding: 20px;
}

.large-font {
  font-size: 48px;
}

.xlarge-font {
  font-size: 64px
}

.button {
  border: none;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  background-color: #4CAF50;
}

img {
  display: block;
  height: auto;
  max-width: 100%;
}

@media screen and (max-width: 1000px) {
  .column-66,
  .column-33 {
    width: 100%;
    text-align: center;
  }
  img {
    margin: auto;
  }
}
	</style>
	<script>
	</script>
</head>

<body>
	<%@ include file="../inc/top.jsp" %>
<!-- The App Section -->
<div class="container">
  <div class="row">
    <div class="column-66">
      <h1 class="xlarge-font"><b>주문 시간</b></h1>
      <h1 class="large-font" style="color:MediumSeaGreen;"><b>주문 상태</b></h1>
      <p><span style="font-size:36px">결제 금액</span></p>
      <p><span>주문내역</span></p>
      <button class="button">Order Detail</button>
    </div>
    <div class="column-33">
        <img src="/resources/img/products/product-1.jpg" width="335" height="471">
    </div>
  </div>
</div>

<!-- Clarity Section -->
<div class="container" style="background-color:#f1f1f1">
  <div class="row">
    <div class="column-33">
      <img src="/resources/img/products/product-2.jpg" alt="App" width="335" height="471">
    </div>
    <div class="column-66">
      <h1 class="xlarge-font"><b>주문 시간</b></h1>
      <h1 class="large-font" style="color:red;"><b>주문 상태</b></h1>
      <p><span style="font-size:24px">결제 금액</span></p>
      <p><span>주문내역</span></p>
      <button class="button" style="background-color:red">Order Detail</button>
    </div>
  </div>
</div>
    <%@ include file="../inc/footer.jsp" %>
    <%@ include file="../inc/footerscript.jsp" %>

</body>

</html>