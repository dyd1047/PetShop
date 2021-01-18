package com.koreait.petshop.controller.payment;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.exception.CartException;
import com.koreait.petshop.exception.LoginRequiredException;
import com.koreait.petshop.model.common.MessageData;
import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.payment.service.PaymentService;


@Controller
@RequestMapping(value="/async")
public class RestPaymentController {
   private static final Logger logger=LoggerFactory.getLogger(RestPaymentController.class);
   
   @Autowired
   private PaymentService paymentService;
   
   //장바구니에 상품 담기 요청 
   @RequestMapping(value="/shop/cart/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
   @ResponseBody
   public MessageData registCart(Cart cart, HttpServletRequest request) {
      HttpSession session = request.getSession();
      Member member = (Member)session.getAttribute("member");
      
      if(session.getAttribute("member")==null) {
         throw new LoginRequiredException("로그인이 필요한 서비스입니다.");
      }
      
      logger.debug("product_id "+cart.getProduct_id());
      logger.debug("quantity "+cart.getQuantity());
      cart.setMember_id(member.getMember_id());
      paymentService.insert(cart);
      
      //MessageConverter 에 의해 VO는 JSON형태로 응답되어질 수 있다!!
      MessageData messageData = new MessageData();
      messageData.setResultCode(1);
      messageData.setMsg("장바구니에 상품이 담겼습니다");
      messageData.setUrl("/shop/cart/list");
      
      return messageData;
   }
   
   //장바구니 수정
   @RequestMapping(value="/shop/cart/edit", method=RequestMethod.POST)
   public ModelAndView editCart(HttpServletRequest request, @RequestParam("cart_id") int[] cartArray, @RequestParam("quantity") int[] qArray) {
      //넘겨받은 파라미터 출력하기!!  cart_id,  quantity 
      logger.debug("cartArray length "+cartArray.length);
      
      List cartList = new ArrayList();
      for(int i=0;i<cartArray.length;i++) {
         logger.debug("cartArray cart_id = "+cartArray[i]);
         logger.debug("qArray quantity = "+qArray[i]);
         Cart cart  = new Cart();
         cart.setCart_id(cartArray[i]);
         cart.setQuantity(qArray[i]);
         cartList.add(cart);
      }
      paymentService.update(cartList);
      
      //수정되었다는 메시지를 보고싶다면.. message.jsp로 응답하자
      MessageData messageData = new MessageData();
      messageData.setResultCode(1);
      messageData.setMsg("장바구니가 수정되었습니다");
      messageData.setUrl("/shop/cart/list");
      ModelAndView mav = new ModelAndView();
      mav.addObject("messageData", messageData);
      mav.setViewName("shop/error/message");
      
      return mav;
   }
   
    //장바구니 1건 삭제
      @RequestMapping(value="/shop/cart/delete", method=RequestMethod.GET)
      @ResponseBody
      public String editCart(HttpServletRequest request, @RequestParam(value="cart_id") int cart_id) {
         paymentService.delete(cart_id);
         
         return "/shop/cart/list";
      }

   
   
   //장바구니와 관련된 예외처리 핸들러
   @ExceptionHandler(CartException.class)
   @ResponseBody
   public MessageData handleException(CartException e) {
      logger.debug("핸들러 동작함 ", e.getMessage());
      MessageData messageData = new MessageData();
      messageData.setResultCode(0);
      messageData.setMsg(e.getMessage());
      
      return messageData;
   }
   

}