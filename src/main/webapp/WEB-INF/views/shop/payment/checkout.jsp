<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.domain.Paymethod"%>
<%@page import="com.koreait.petshop.model.domain.Cart"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
   List<Cart> cartLists = (List)request.getAttribute("cartList");
   List<Paymethod> paymethodList = (List)request.getAttribute("paymethodList");
   Member member=(Member)session.getAttribute("member");
   
   //장바구니로부터, 상품 가액 계싼
   int totalPrice=0;
   for(Cart cart:cartLists){
      totalPrice += (cart.getQuantity()*cart.getPrice());
      
   }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>Karl - Fashion Ecommerce Template | Home</title>
   <%@ include file="../inc/header.jsp" %>
   <script>
   function setData(ch){
      var form=document.querySelector("#checkout-form");
      
      if(ch.checked){//체크를 했다면, 주문자 정보를 받는자 정보에 대입
         form.receiver_name.value=form.member_name.value;
         form.receiver_phone.value=form.member_phone.value;
         form.receiver_addr.value=form.member_addr.value;
      }else{
         //받는 사람 정보를 다시 원상 복구(초기화)
         form.receiver_name.value="";
         form.receiver_phone.value="";
         form.receiver_addr.value="";
      }
   }
   
   function order(){
      $("#checkout-form").attr({
         action:"/shop/payment/regist",
         method:"post"
      });
      $("#checkout-form").submit();
      
   }
   </script>
</head>

<body>
       <%@include file="../inc/top.jsp" %>
        <!-- ****** Top Discount Area End ****** -->
      
       
    <!-- Shopping Cart Section Begin -->
    <section class="checkout-section spad">
        <div class="container">
            <form action="#" class="checkout-form" id="checkout-form">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="checkout-content">
                            <a href="/petshop/login" class="content-btn">Click Here To Login</a>
                        </div>
                        
                        <h4>결제/배송</h4>
                        
                               <input type="hidden" name="total_price" value="<%=totalPrice%>">
                               <input type="hidden" name="total_pay" value="<%=totalPrice%>">
                               <input type="hidden" name="sum">
                           <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="member_name">주문고객 명<span>*</span></label>
                                        <input type="text" class="form-control" id="member_name"  value="<%=member.getName() %>" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="member_phone">연락처 <span>*</span></label>
                                        <input type="text" class="form-control" id="member_phone" value="<%=member.getPhone() %>" required>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label for="member_addr">주소</label>
                                        <input type="text" class="form-control" id="member_addr" value="<%=member.getAddr()%>">
                                    </div>
                                    
                           <div class="col-12 mb-3">
                                       <div class="custom-control custom-checkbox d-block mb-2">
                                               <input type="checkbox" class="custom-control-input" id="customCheck1" onClick="setData(this)">
                                               <label class="custom-control-label" for="customCheck1">주문자와 동일</label>
                                       </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="first_name">받으실분 이름<span>*</span></label>
                                        <input type="text" class="form-control" id="first_name" name="receiver_name" value="" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="last_name">연락처 <span>*</span></label>
                                        <input type="text" class="form-control" id="last_name" name="receiver_phone" value="" required>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label for="company">받으실 주소</label>
                                        <input type="text" class="form-control" id="company" name="receiver_addr" value="">
                                    </div>
                                    
                                    <div class="col-12 mb-3">
                                        <label for="country">결제방법 선택<span>*</span></label>
                                        <select class="custom-select d-block w-100" id="country" name="paymethod_id">
                                        <%for(Paymethod paymethod : paymethodList){ %>
                                        <option value="<%=paymethod.getPaymethod_id()%>"><%=paymethod.getMethod() %></option>
                              <%} %>
                                    </select>
                                    </div>


                                </div>
                        
                        
                    </div>
                    <div class="col-lg-6">
                        <div class="checkout-content">
                            <input type="text" placeholder="Enter Your Coupon Code">
                        </div>
                        <div class="place-order">
                            <h4>주문 확인</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                    <li>Product <span>Total</span></li>
                                    <%sum = 0; %>
                                    <%for(Cart cart : cartLists){ %>
                                    <%int total =  cart.getPrice()*cart.getQuantity();%>
                                    <%sum += total; %>
                                    <li><input type="hidden" name="product_id" value="<%=cart.getProduct_id()%>"/></li>
                                    <li class="fw-normal"><%=cart.getProduct_name() %> X <%=cart.getQuantity() %> <span><%=Formatter.getCurrency(total) %></span></li>
                              		<%} %>
                                    <li class="total-price">Total <span><%=Formatter.getCurrency(sum) %></span></li>
                                    
                                </ul>
 
                                <div class="order-btn">
                                	<img src="/resources/img/kakaopay.png" onclick="order()" style="cursor:pointer;"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
        <!-- ****** Checkout Area End ****** -->      
           
        <!-- ****** Footer Area Start ****** -->
        <%@ include file="../inc/footer.jsp" %>
        <%@ include file="../inc/footerscript.jsp" %>
        <!-- ****** Footer Area End ****** -->
    </div>
    <!-- /.wrapper end -->
</body>

</html>