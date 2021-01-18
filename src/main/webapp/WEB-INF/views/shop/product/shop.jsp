<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<SubCategory> subList = (List)request.getAttribute("subList");
	List<Product> productList = (List)request.getAttribute("productList");
	String topCategory_id = request.getParameter("topcategory_id");
	String subCategory_id = request.getParameter("subcategory_id");
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
	<script type="text/javascript">
	$(function(){
		//product-quicview를 클릭했을때...
		$(".quick-view").on("click", function(e){
			var obj = e.target;
			var product_id=$("#product_id").val();
			var subcategory_name=$("#subcategory_name").val();
			var product_name=$("#product_name").val();
			var price=$("#price").val();
			var detail=$("#detail").val();
			var filename=$("#filename").val();
			
			console.log("product_id "+product_id);
			console.log("subcategory_name "+subcategory_name);
			console.log("product_name "+product_name);
			console.log("price "+price);
			console.log("detail "+detail);
			console.log("filename "+filename);

			//퀵뷰창의 상품 정보에 출력
			
			//이미지
			$(".quickview_pro_img img").attr({
				src:"/resources/pro/basic/"+product_id+"."+filename
			});
			
			$(".quickview_pro_des .title").html(product_name);//상품명
			$(".quickview_pro_des .price").html(price);//가격
			$(".quickview_pro_des p").html(detail);//상세내용
			
			$(".quickview_pro_des a").on("click", function(e){
				location.href="/shop/product/detail?product_id="+product_id;
			});
		});
		
	});
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

    <!-- Product Shop Section Begin -->
    <section class="product-shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-8 order-2 order-lg-1 produts-sidebar-filter">
                    <div class="filter-widget">
	                    <h4 class="fw-title">TopCategories</h4>
	                    <ul class="filter-catagories">
	                	<%for(TopCategory topCategory : topList) {%>
	                		<%if(subCategory_id==null) {%>
		                		<%if(topCategory.getTopcategory_id() == Integer.parseInt(topCategory_id)){ %>
		                       		<li style="border-bottom: 1px solid #EEEEEE; "><a id="top_getProduct" href="/shop/product/topList?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></a><span style="color:red;">V</span></li>
			                    <%}else{ %>
		                       		<li style="border-bottom: 1px solid #EEEEEE; "><a id="top_getProduct" href="/shop/product/topList?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></a></li>
			                    <%} %>
		                    <%}else{ %>
		                    	<%for(SubCategory subCategory : subList){ %>
			                		<%if(topCategory.getTopcategory_id() == subCategory.getTopcategory_id()){ %>
			                       		<li style="border-bottom: 1px solid #EEEEEE; "><a id="top_getProduct" href="/shop/product/topList?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></a><span style="color:red;">V</span></li>
				                    <%}else{ %>
			                       		<li style="border-bottom: 1px solid #EEEEEE; "><a id="top_getProduct" href="/shop/product/topList?topcategory_id=<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></a></li>
				                    <%} %>
			                    <%} %>
		                    <%} %>
	                    <%} %>
                        </ul>
                    </div>
                    <div class="filter-widget">
                        <h4 class="fw-title">SubCategories</h4>
                        <ul class="filter-catagories" id="subCategory">
                      	<%for(SubCategory subCategory : subList) {%>
                      		<%if(subCategory_id==null) {%>
                       			<%if(subCategory.getTopcategory_id() == Integer.parseInt(topCategory_id)) {%>
		                            <li><a href="/shop/product/subList?subcategory_id=<%=subCategory.getSubcategory_id()%>"><%=subCategory.getName() %></a></li>
	                            <%} %>
                            <%}else{ %>
                      			<%if(subCategory.getSubcategory_id() == Integer.parseInt(subCategory_id)) {%>
						        	<li><a href="/shop/product/subList?subcategory_id=<%=subCategory.getSubcategory_id()%>"><%=subCategory.getName() %></a><span style="color:red;">V</span></li>
	                            <%} %>
                            <%} %>
                        <%} %>
                        </ul>
                    </div>
                    <div class="filter-widget">
                        <h4 class="fw-title">Tags</h4>
                        <div class="fw-tags">
                            <a href="#">Towel</a>
                            <a href="#">Shoes</a>
                            <a href="#">Coat</a>
                            <a href="#">Dresses</a>
                            <a href="#">Trousers</a>
                            <a href="#">Men's hats</a>
                            <a href="#">Backpack</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 order-1 order-lg-2">
                    <div class="product-show-option">
                        <div class="row">
                            <div class="col-lg-7 col-md-7">
                                <div class="select-option">
                                    <select class="sorting">
                                        <option value="">Default Sorting</option>
                                    </select>
                                    <select class="p-show">
                                        <option value="">Show:</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 text-right">
                                <p>Show 01- 09 Of 36 Product</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="product-list">
                        <div class="row">
                        	<%for(Product product : productList){ %>
                            <div class="col-lg-4 col-sm-6">
                                <div class="product-item">
                                    <div class="pi-pic">
                                        <img id="product_image" src="/resources/pro/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" alt="">
                                        <div class="sale pp-sale">Sale</div>
                                        <div class="icon">
                                            <i class="icon_heart_alt"></i>
                                        </div>
                                        <ul>
                                            <li class="w-icon active"><a href="#"><i class="icon_bag_alt"></i></a></li>
                                            <li class="quick-view"><a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>">+ Quick View</a></li>
                                            <li class="w-icon"><a href="#"><i class="fa fa-random"></i></a></li>
                                        </ul>
                                    </div>
                                    <div class="pi-text">
                                    	<input type="hidden" id="product_id" value="<%=product.getProduct_id()%>">
                                    	<input type="hidden" id="subcategory_name" value="<%=product.getSubCategory().getName() %>">
                                    	<input type="hidden" id="product_name" value="<%=product.getProduct_name() %>">
                                    	<input type="hidden" id="price" value="<%=Formatter.getCurrency(product.getPrice())%>">
                                    	<input type="hidden" id="detail" value="<%=product.getDetail() %>">
                                    	<input type="hidden" id="filename" value="<%=product.getFilename() %>">
                                       	<div class="catagory-name"><%=product.getSubCategory().getName() %></div>
                                        <a href="#">
                                            <h5><%=product.getProduct_name() %></h5>
                                        </a>
                                        <div class="product-price">
                                            <%=Formatter.getCurrency(product.getPrice()) %>
                                            <span>$35.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                            
                        </div>
                    </div>
                    <div class="loading-more">
                        <i class="icon_loading"></i>
                        <a href="#">
                            Loading More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Shop Section End -->
    
    <%@ include file="../inc/footer.jsp" %>
    <%@ include file="../inc/footerscript.jsp" %>

</body>

</html>