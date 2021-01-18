<%@page import="com.koreait.petshop.model.domain.Image"%>
<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
   Product product = (Product)request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="zxx">
<script type="text/javascript">
//비동기 방식으로 장바구니에 담자!!

//비동기 방식으로 장바구니에 담자!!
function addCart(){
   var formData=$("#cart_form").serialize();//파라미터를 전송할 수 있는 상태의 문자열로 나열해줌
   
   $.ajax({
      url:"/async/shop/cart/regist",
      type:"post", 
      data:formData,
      async:false,
      success:function(responseData){
         var json = responseData;
         if(responseData != null){
            console.log("진입했어요"+json);
            if(confirm("상품이 담겼습니다!\n장바구니에 담긴 상품을 보러갈까요?")){
               location.href="/shop/cart/list";                     
            }
         }
      }
   });
}
</script>

<style>

   #can{
      color:red;
      font-weight: bold;
   }
</style>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Template</title>
   <%@ include file="../inc/header.jsp" %>
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
    <section class="product-shop spad page-details">
        <div class="container">
            <div class="row">

                <div class="col-lg-13">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="product-pic-zoom">
                                <img class="product-big-img" src="/resources/pro/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" alt="">
                                <div class="zoom-icon">
                                    <i class="fa fa-search-plus"></i>
                                </div>
                            </div>

                        </div>
                        <div class="col-lg-6">
                            <div class="product-details">
                                <div class="pd-title">
                                   <!-- name -->
                                    <h3><%=product.getProduct_name() %></h3>
                                    <a href="#" class="heart-icon"><i class="icon_heart_alt"></i></a>
                                </div>
                                <div class="pd-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-o"></i>
                                    <span>(5)</span>
                                </div>
                                <div class="pd-desc">
                                   <!-- detail -->
                                   <div style="border: 1px solid #EEEEEE; height:400px;"><%=product.getDetail() %></div>
                                   <!-- price -->
                                    <h4><%=Formatter.getCurrency(product.getPrice()) %> <span><%=Formatter.getCurrency(product.getPrice()+1000000) %></span></h4>
                                </div>
                              
                                <form id="cart_form">
                                   <input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
                                   <div class="quantity">
                                       <div class="pro-qty">
                                           <input type="number" id="qty" name="quantity" value="1">
                                       </div>
                                       <button type="button" class="primary-btn pd-cart" onclick="addCart()">Add To Cart</button>
                                   </div>
                                </form>
                              
                            </div>
                        </div>
                    </div>
                    <div class="product-tab">
                        <div class="tab-item">
                            <ul class="nav" role="tablist">
                                <li>
                                    <a class="active" data-toggle="tab" href="#tab-1" role="tab">상품정보</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#tab-2" role="tab">취소/교환/반품 안내</a>
                                </li>
                                <li>
                                    <a data-toggle="tab" href="#tab-3" role="tab">구매후기</a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-item-content">
                            <div class="tab-content">
                             
                               <div class="tab-pane fade-in active" id="tab-1" role="tabpanel" class="col-lg-4">
                                    <div class="product-content">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                 <div>
                                               <%for(Image image : product.getImageList()){ %>
                                                   <img  src="/resources/pro/addon/<%=image.getImage_id()%>.<%=image.getFilename()%>" alt="" width="100%" height="100%">
                                                   <%} %>
                                            </div>       
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="tab-pane fade" id="tab-2" role="tabpanel">
                                    <div class="specification-table">
                              <a id="can">취소</a>
                                 <ul>
                                    <li>입금하신 상품은 '입금대기, 입금완료' 단계에서만 취소가 가능합니다.</li>
                                    <li>전체 주문 중 일부 상품의 부분취소는 불가능합니다.</li>
                                 </ul>   
                              <br>
                                 
                              <a id="can">교환/반품</a>
                                 <ul>
                                    <li>교환 및 반품은 배송완료일 기준으로 7일 이내 가능합니다.</li>
                                    <li>교환하려는 상품은 처음 배송한 택배사에서 수거하므로 다른 택배사 이용은 불가능합니다.</li>
                                    <li>업체배송 상품은 제공 업체와 상품에 따라 배송비가 다르고, 상품의 도착지가 처음 발송한 주소와 다를 수 있으므로 고객센터(1588-2469)로 먼저 연락주시기 바랍니다.</li>
                                 </ul>
                                 <br>
                                 
                              <a id="can">교환/반품이 불가능한 경우</a>
                                 <ul>
                                    <li>   반품 요청기간이 지난 경우</li>
                                    <li>   주문/제작 상품의 경우, 상품의 제작이 이미 진행된 경우</li>
                                    <li>   상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 현저히 감소한 경우</li>
                                    <li>   시간의 경과에 의하여 재판매가 곤란할 정도로 상품의 가치가 현저히 감소한 경우</li>
                                    <li>   구성품을 분실하였거나 고객님의 취급 부주의로 인한 파손/고장/오염으로 재판매 불가한 경우</li>
                                 </ul>
                                 <br>
                                 
                              <a id="can">교환/반품 배송비</a>
                                 <ul>
                                    <li>   단순변심으로 인한 교환/반품은 고객님께서 배송비를 부담하셔야 합니다.</li>
                                    <li>   상품의 불량 또는 파손, 오배송의 경우에는 배송비를 강아지대통령에서 부담합니다.</li>
                                    <li>   업체배송 상품은 제공업체에 따라 교환/반품 배송비가 다를 수 있으므로 고객센터로 문의하시기 바랍니다.</li>
                                    <li>   제주, 산간지역은 추가 배송비가 발생할 수 있습니다.</li>
                                 </ul>
                                 
                                 
                                 
                                 
                                    </div>
                                </div>
                                
                                
                                
                                
                                <div class="tab-pane fade" id="tab-3" role="tabpanel">
                                    <div class="customer-review-option">
                                        <h4>2 Comments</h4>
                                        <div class="comment-option">
                                            <div class="co-item">
                                                <div class="avatar-pic">
                                                    <img src="/resources/img/product-single/avatar-1.png" alt="">
                                                </div>
                                                <div class="avatar-text">
                                                    <div class="at-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <h5>Brandon Kelley <span>27 Aug 2019</span></h5>
                                                    <div class="at-reply">Nice !</div>
                                                </div>
                                            </div>
                                            <div class="co-item">
                                                <div class="avatar-pic">
                                                    <img src="/resources/img/product-single/avatar-2.png" alt="">
                                                </div>
                                                <div class="avatar-text">
                                                    <div class="at-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <h5>Roy Banks <span>27 Aug 2019</span></h5>
                                                    <div class="at-reply">Nice !</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="personal-rating">
                                            <h6>Your Ratind</h6>
                                            <div class="rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                        </div>
                                        <div class="leave-comment">
                                            <h4>Leave A Comment</h4>
                                            <form action="#" class="comment-form">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <input type="text" placeholder="Name">
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <input type="text" placeholder="Email">
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <textarea placeholder="Messages"></textarea>
                                                        <button type="submit" class="site-btn">Send message</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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