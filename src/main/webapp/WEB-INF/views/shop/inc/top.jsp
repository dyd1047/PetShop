<%@page import="com.koreait.petshop.model.domain.Admin"%>
<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Cart"%>
<%@page import="com.koreait.petshop.model.domain.SubCategory"%>
<%@page import="com.koreait.petshop.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<TopCategory> topList = (List)request.getAttribute("topList");
	String topcategory_id = "";
	List<Cart> cartList = (List)request.getAttribute("cartList");
	if(request.getParameter("topcategory_id") != null){
		topcategory_id = request.getParameter("topcategory_id");
	}
	Member members = (Member)request.getAttribute("member");
	Admin admin = (Admin)request.getAttribute("admin");
%>
<style>
#logo3{
	text-align: center;
	
}
</style>
<script type="text/javascript">
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
</script>
 <header class="header-section">
        <div class="header-top">
            <div class="container">
                <div class="ht-left">
                    <div class="mail-service">
                        <i class=" fa fa-envelope"></i>
                        qowoeo948@gmail.com
                    </div>
                    <div class="phone-service">
                        <i class=" fa fa-phone"></i>
                        010.3377.7086
                    </div>
                </div>
                <div class="ht-right">
                    <div class="top-social">
                        <a href="#"><i class="ti-facebook"></i></a>
                        <a href="#"><i class="ti-twitter-alt"></i></a>
                        <a href="#"><i class="ti-linkedin"></i></a>
                        <a href="#"><i class="ti-pinterest"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-12 text-right col-md-3">
                        <ul class="nav-right">
                      		<li class="cart-icon">
	                            <a href="/">
	                                <img src="/resources/img/topLogo.png" alt="">
	                            </a>
                            </li>
                            <li class="cart-price">
                               	<%if(members != null){ %>
	                                <a href="/petshop/mypage" style="color: black;">
                                    	<span><%=members.getUser_id() %>님</span>
                             		</a>
                                <%}else if(admin != null){ %>
	                                <a href="#" style="color: black;">
                                    	<span><%=admin.getUser_id() %>관리자님</span>
                             		</a>
                                <%}else{ %>
                                	<a href="/petshop/login" style="color: black;">
                                    	<span>로그인</span>
                                	</a>
                                <%} %>
                            </li>
                            <li class="cart-icon">
                                <a href="/shop/cart/list">
                                    <i class="icon_bag_alt"></i>
                                    <%if(cartList.size() > 0){ %>
                                    	<span><%=cartList.size() %></span>
                                    <%} %>
                                </a>
                                <div class="cart-hover">
                                    <div class="select-items">
                                        <table>
                                            <tbody>
                                            	<%int sum = 0; %>
				                            	<%for(Cart cart : cartList){ %>
				                                <%int total =  cart.getPrice()*cart.getQuantity();%>
				                            	<%sum += total; %>
	                                                <tr>
	                                                    <td class="si-pic"><img src="/resources/pro/basic/<%=cart.getProduct_id()%>.<%=cart.getFilename()%>" alt=""></td>
	                                                    <td class="si-text">
	                                                        <div class="product-selected">
	                                                            <p><%=Formatter.getCurrency(cart.getPrice()) %> x <%=cart.getQuantity()%></p>
	                                                            <h6><%=cart.getProduct_name() %></h6>
	                                                        </div>
	                                                    </td>
	                                                    <td class="si-close">
	                                                        <i class="ti-close" onclick="delCart(<%=cart.getCart_id()%>)"></i>
	                                                    </td>
	                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="select-total">
                                        <span>total:</span>
                                        <h5><%=Formatter.getCurrency(sum) %></h5>
                                    </div>
                                    <div class="select-button">
                                        <a href="/shop/cart/list" class="primary-btn view-card">VIEW CARD</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <div class="nav-depart">
                    <div class="depart-btn">
                        <i class="ti-menu"></i>
                        <span>All departments</span>
                        <!-- ------------------------------------------------ -->
                        <ul class="depart-hover">
                        	<%for(TopCategory topCategory : topList) {%>
                        		<%if(topcategory_id != "") {%>
                        		<input id="topcategory_id" type="hidden" value="<%=topcategory_id%>">
                        		<%} %>
                            	<li style="border-bottom: 1px solid #EEEEEE;"><a id="top_getProduct" href="/shop/product/topList?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></a></li>
                            <%} %>
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="/">Home</a></li>
                        <li><a href="/shop/product/topList?topcategory_id=1">Shop</a></li>
                        <li><a href="/shop/contact">Contact</a></li>
                        <li><a href="/shop/qna/list">QNA</a></li>
                        <li><a href="#">Management</a>
                           <ul class="dropdown">
                               	<%if(session.getAttribute("admin")!=null) {%>
                               	    <li><a href="/admin/product/list">Product</a></li>
                                	<li><a href="/admin/member/list">Member</a></li>
                                	<li><a href="#">Order</a></li>
	                                <li><a href="/admin/register">Register</a></li>
                               	<%}else{ %>
	                                <li><a href="/petshop/register">Register</a></li>
                               	<%} %>
                                <%if(session.getAttribute("member")==null && session.getAttribute("admin")==null){ //세션에 담겨진 데이터가 없다면%>
                                   <li><a href="/petshop/login">Login</a></li>
                                <%}else{ %>
                                   <li><a href="/petshop/logoutRequest">LogOut</a></li>
                                   <%if(session.getAttribute("admin")==null) {%>
                                   	<li><a href="/shop/cart/list">Cart</a></li>
	                                <li><a href="/petshop/mypage">Mypage</a></li>
                                   <%} %>
                                <%} %>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>