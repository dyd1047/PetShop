package com.koreait.petshop.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CommonController {
	//메세지 폼 요청
	@RequestMapping(value="/shop/message", method=RequestMethod.GET)
	public ModelAndView getMessage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("shop/error/message");
		
		return mav;
	}
}
