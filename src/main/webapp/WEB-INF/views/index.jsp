<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
List<Product> hitList =(List)request.getAttribute("hitList");
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

   <%@ include file="./shop/inc/header.jsp" %>
</head>
<script>


</script>


<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <!-- Header Section Begin -->
   <%@include file="./shop/inc/top.jsp" %>
    <!-- Header End -->

    <!-- Hero Section Begin -->
    <section class="hero-section">
        <div class="hero-items owl-carousel">
            <div class="single-hero-items set-bg" data-setbg="/resources/img/hero-4.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>Toy,puppys</span>
                            <h1>Black friday</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore</p>
                            <a href="#" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                    <div class="off-card">
                        <h2>Sale <span>50%</span></h2>
                    </div>
                </div>
            </div>
            <div class="single-hero-items set-bg" data-setbg="/resources/img/hero-5.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>Toy,cats</span>
                            <h1>Black friday</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore</p>
                            <a href="#" class="primary-btn">Shop Now</a>
                        </div>
                    </div>
                    <div class="off-card">
                        <h2>Sale <span>50%</span></h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Banner Section Begin -->
    <div class="banner-section spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-4 col-md-2">
                    <div class="single-banner">
                        <img src="/resources/img/dogimg.png" alt="" width="50px" height="400px">
                        <div class="inner-text">
                            <h4>DOG</h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-2">
                    <div class="single-banner">
                        <img src="/resources/img/catimg.png" alt="" width="50px" height="400px">
                        <div class="inner-text">
                            <h4>CAT</h4>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-2">
                    <div class="single-banner">
                        <img src="/resources/img/dogcatimg.png" alt="" width="50px" height="400px">
                        <div class="inner-text">
                            <h4>Reservation</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner Section End -->

    <!-- Women Banner Section Begin -->
    <section class="women-banner spad">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3">
                    <div class="product-large set-bg" data-setbg="/resources/img/homeimg.PNG">
                        <h2>Hot Item</h2>
                       
                    </div>
                </div>
                <div class="col-lg-8 offset-lg-1">
                    <div class="filter-control">
                        <ul>
                            <li class="active">Best Product</li>
                        </ul>
                    </div>
                    <div class="product-slider owl-carousel">
                    
                    <%for(int i=0;i<hitList.size();i++){ %>
                    <%Product product = hitList.get(i); %>
                        <div class="product-item">
                            <div class="pi-pic">
                                <img src="/resources/pro/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" width="50px" height="230px">
                                <div class="sale">BEST</div>
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
                                <div class="catagory-name">GOOD</div>
                                <a href="#">
                                    <h5><%=product.getProduct_name() %></h5>
                                </a>
                                <div class="product-price">
                                <%=Formatter.getCurrency(product.getPrice()) %>
                                </div>
                            </div>
                        </div>
                        
                        <%} %>
                        
                        
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Women Banner Section End -->

   <!-- Instagram Section Begin -->
    <div class="instagram-photo">
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-7.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">colorlib_Collection</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-8.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="https://www.instagram.com/skuukzky/?hl=ko">colorlib_Collection</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-9.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">colorlib_Collection</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-10.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">colorlib_Collection</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-11.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">colorlib_Collection</a></h5>
            </div>
        </div>
        <div class="insta-item set-bg" data-setbg="/resources/img/insta-12.jpg">
            <div class="inside-text">
                <i class="ti-instagram"></i>
                <h5><a href="#">colorlib_Collection</a></h5>
            </div>
        </div>
    </div>
    <!-- Instagram Section End -->
    

    
    <!-- Partner Logo Section End -->
    <%@ include file="./shop/inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
   <%@ include file="./shop/inc/footerscript.jsp" %>
</body>

</html>