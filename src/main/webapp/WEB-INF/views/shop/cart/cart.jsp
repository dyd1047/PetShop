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
	<script>
	function delCart(cart_id){
		if(confirm("장바구니에서 상품을 제거하시겠습니까?")){
			console.log("cart_id = "+cart_id);
			$.ajax({
				url:"/async/shop/cart/delete?cart_id="+cart_id,
				type:"get",
				success:function(responseData){
					location.href="/shop/cart/list";
				}
			});			
		}	
	}
	
	function editCart(){
		var formData=$("#cart_form").serialize();//파라미터를 전송할 수 있는 상태의 문자열로 나열해줌
		console.log("cart_id = "+formData.cart_id);
		if(confirm("주문 수량을 변경하시겠어요?")){
			$.ajax({
				url:"/async/shop/cart/edit",
				type:"post", 
				data:formData,
				success:function(responseData){
					location.href="/shop/cart/list";
				}
			});
		}	
		
	}
	
	function checkoutForm(){
		location.href="/shop/payment/form";	
	}
	</script>
</head>

<body>
	<%@ include file="../inc/top.jsp" %>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->
	<!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
        	<form id="cart_form">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th class="p-name">Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th><i class="ti-close"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                            	<%sum = 0; %>
                            	<%for(Cart cart : cartList){ %>
                                <%int total =  cart.getPrice()*cart.getQuantity();%>
                            	<%sum += total; %>
                                <tr>
                                    <td class="cart-pic first-row"><img src="/resources/pro/basic/<%=cart.getProduct_id()%>.<%=cart.getFilename()%>" alt=""></td>
                                    <td class="cart-title first-row">
		                               	<input type="hidden" id="cart_id" name="cart_id" value="<%=cart.getCart_id()%>">
                                        <h5><%=cart.getProduct_name() %></h5>
                                    </td>
                                    <td class="p-price first-row"><%=Formatter.getCurrency(cart.getPrice()) %></td>
                                    <td class="qua-col first-row">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <input type="text" name="quantity" value="<%=cart.getQuantity()%>">
                                            </div>
                                        </div>
                                    </td>
                                    <td class="total-price first-row"><%=Formatter.getCurrency(total) %></td>
                                    <!-- 한건 삭제하기 -->
                                    <td class="close-td first-row"><i class="ti-close" onclick="delCart(<%=cart.getCart_id()%>)"></i></td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="cart-buttons">
                                <a href="/shop/product/topList?topcategory_id=1" class="primary-btn continue-shop">Continue shopping</a>
                                <!-- 수정하기 -->
                                <button type="button" class="primary-btn up-cart" onclick="editCart()">Update cart</button>
                            </div>
                            <div class="discount-coupon">
                                <h6>Discount Codes</h6>
                                   <input type="text" placeholder="Enter your codes">
                                   <button type="submit" class="site-btn coupon-btn">Apply</button>
                            </div>
                        </div>
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <li class="subtotal">Subtotal <span><%=Formatter.getCurrency(sum) %></span></li>
                                    <li class="cart-total">Total <span><%=Formatter.getCurrency(sum) %></span></li>
                                </ul>
                                <a href="javascript:checkoutForm()"  class="proceed-btn">PROCEED TO CHECK OUT</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
    
    <%@ include file="../inc/footer.jsp" %>
    <%@ include file="../inc/footerscript.jsp" %>

</body>

</html>