package com.koreait.petshop.aop;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.domain.Admin;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.service.MemberTypeService;
import com.koreait.petshop.model.payment.service.PaymentService;
import com.koreait.petshop.model.product.service.TopCategoryService;

/*
 * 쇼핑몰 이용시 전반적으로 사용할 카테고리 메뉴 목록
 * */
public class GlobalDataAspect {
   @Autowired
   private TopCategoryService topCategoryService;
   
   @Autowired
   private MemberTypeService memberTypeService;
   
   @Autowired
   private PaymentService paymentService;
   
   public Object getGlobalData(ProceedingJoinPoint joinPoint) throws Throwable{
      Object result=null;
      HttpServletRequest request=null;
      
      //매개변수로부터 요청 객체 추출!!
      for(Object arg : joinPoint.getArgs()) {
         if(arg instanceof HttpServletRequest) {
            request = (HttpServletRequest)arg;
         }
      }
      
      String uri = request.getRequestURI(); //클라이언트의 요청 URI 스트링 정보
      HttpSession session = request.getSession();
      
      //topList를 저장해야 하는 경우와 그렇지 않은 경우를 나누어서 처리
      if(   uri.equals("/shop/member/login") || 
    	         uri.equals("/shop/member/regist") ||
    	         uri.equals("/shop/admin/regist") ||
    	         uri.equals("/user/idCheck") ||
    	         uri.equals("/admin/idCheck") ||
    	         uri.equals("/admin/product/excel/registform") ||
    	         uri.equals("/admin/product/sublist") ||
    	         uri.equals("/shop/qna/comments/list")||
    	         uri.equals("/shop/qna/comment/regist")
    	      ) {
         result=joinPoint.proceed(); //원래 호출하려 했던 메서드 호출!! go ahead
      }else {//필요한 경우
         //topList 가져오기
         List topList = topCategoryService.selectAll();
         List memberTypeList = memberTypeService.selectAll();
         List cartList = new ArrayList();
         Member member = (Member)session.getAttribute("member");
         Admin admin = (Admin)session.getAttribute("admin");
         if(session != null && member != null) {
        	 cartList = paymentService.selectCartList(member.getMember_id());
         }
         Object returnObj = joinPoint.proceed();//원래 호출하려 했던 메서드호출
         ModelAndView mav = null;
         if( returnObj instanceof ModelAndView) {
            mav =(ModelAndView)returnObj;
            mav.addObject("topList",topList);
            mav.addObject("cartList",cartList);
            mav.addObject("memberType",memberTypeList);
            mav.addObject("member",member);
            mav.addObject("admin",admin);
            result=mav;
         }
      }
      return result;
   }
}