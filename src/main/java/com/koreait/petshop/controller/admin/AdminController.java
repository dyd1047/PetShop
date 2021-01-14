package com.koreait.petshop.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
   //������ ��� ���� ��û
   @RequestMapping(value="/admin")
   public ModelAndView adminMain(HttpServletRequest request) {
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/main");   
      
      return mav;

}
}