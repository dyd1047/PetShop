package com.koreait.petshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
	//������ ��� ���� ��û
	@RequestMapping(value="/petshop/admin")
	public ModelAndView adminMain() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/main");	
		
		return mav;

}
}
