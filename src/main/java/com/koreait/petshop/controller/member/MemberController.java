package com.koreait.petshop.controller.member;

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

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.common.MessageData;
import com.koreait.petshop.model.domain.Admin;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.MemberType;
import com.koreait.petshop.model.member.service.AdminService;
import com.koreait.petshop.model.member.service.MemberService;
import com.koreait.petshop.model.member.service.MemberTypeService;

@Controller
public class MemberController {
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
   
   @Autowired
   private MemberTypeService memberTypeService;
   
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private AdminService adminService;
   
   //ȸ������ �� ��û
   @RequestMapping(value="/petshop/register")
   public ModelAndView getRegister(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("shop/member/register");
      
      return mav;
   }
   
   //���̵� �ߺ� üũ
   @RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
   @ResponseBody
   public int idCheck(@RequestParam(value="user_id") String user_id, HttpServletRequest request) {
      //logger.debug(user_id);

      return memberService.userIdCheck(user_id);
   }
   
   //ȸ������ ��û ó�� 
   @RequestMapping(value="/shop/member/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
   @ResponseBody
   public String regist(Member member) {
      logger.debug("���̵� "+member.getUser_id());
      logger.debug("�̸� "+member.getName());
      logger.debug("�̸� "+member.getPhone());
      logger.debug("��� "+member.getPassword());
      logger.debug("�̸���id "+member.getEmail_id());
      logger.debug("�̸���server "+member.getEmail_server());
      logger.debug("�����ȣ "+member.getZipcode());
      logger.debug("�ּ� "+member.getAddr());
      logger.debug("�ּ� "+member.getAddr_detail());
      
      memberService.regist(member);
      
      StringBuffer sb = new StringBuffer();
      sb.append("{");
      sb.append(" \"result\":1, ");
      sb.append(" \"msg\":\"ȸ������ ����\"");
      sb.append("}");
      
      return sb.toString();
   } 
   
   //�α��� �� ��û
   @RequestMapping(value="/petshop/login")
   public ModelAndView getLogin(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("shop/member/login");
      
      return mav;
   }
   
   //�α��� ��û ó��
   @RequestMapping(value="/petshop/loginRequest", method=RequestMethod.POST)
   public String login(Member member, Admin admin, HttpServletRequest request) {
	  List<MemberType> memberTypeList = memberTypeService.selectAll();
	  HttpSession session=request.getSession();
	  String view = "";
	  Admin admin_obj = null;
	  Member member_obj = null;
	  boolean loginCheck = false;
	  
	  logger.debug("admin val"+admin.getUser_id());
	  logger.debug("member val"+member.getUser_id());
	  
	  for(MemberType memberType : memberTypeList) {
		  if(memberType.getMember_type_id() == 1) {
			  for(int i = 0; i < memberType.getAdmin().size(); i++) {
				  admin_obj = memberType.getAdmin().get(i);
				  if(admin_obj.getUser_id().equals(admin.getUser_id())) {
					  if(admin_obj.getPassword().equals(admin.getPassword())) {
						  session.setAttribute("admin", admin_obj); //���� Ŭ���̾�Ʈ ��û�� ����� ���ǿ� ������ ���´�
						  loginCheck = true;
						  
						  view = "redirect:/admin";
					  }
				  }
			  }
		  }else if(memberType.getMember_type_id() == 2) {
			  for(int i = 0; i < memberType.getMember().size(); i++) {
				  member_obj = memberType.getMember().get(i);
				  if(member_obj.getUser_id().equals(member.getUser_id())) {
					  if(member_obj.getPassword().equals(member.getPassword())) {
						  session.setAttribute("member", member_obj); //���� Ŭ���̾�Ʈ ��û�� ����� ���ǿ� ������ ���´�
						  loginCheck = true;
						  
						  view = "redirect:/";
					  }
				  }
			  }
		  }
	  }
	  if(loginCheck) {
		  throw new MemberNotFoundException("�α��� ������ �˸��� �ʽ��ϴ�.");
	  }
      
	  return view;
   }
   
   //�α׾ƿ� ��û ó�� 
   @RequestMapping(value="/petshop/logoutRequest", method=RequestMethod.GET)
   public ModelAndView logout(HttpServletRequest request) {
      request.getSession().invalidate(); //���� ��ȿȭ, �̽������� ����� �����Ͱ� �� ��ȿ�� �ȴ�
      MessageData messageData = new MessageData();
      messageData.setResultCode(1);
      messageData.setMsg("�α׾ƿ� �Ǿ����ϴ�");
      messageData.setUrl("/");
      
      ModelAndView mav = new ModelAndView("shop/error/message");
      mav.addObject("messageData", messageData);
      return mav;
   }
   
   //����ó��------------------------------------------------------------------------------------------------------
   //ȸ������ ����
   @ExceptionHandler(MemberRegistException.class)
   @ResponseBody
   public String handleException(MemberRegistException e) {
      StringBuffer sb = new StringBuffer();
      sb.append("{");
      sb.append(" \"result\":0, ");
      sb.append(" \"msg\":\""+e.getMessage()+"\"");
      sb.append("}");
      
      return sb.toString();
   }
   
   //���Ϲ߼� ����
   @ExceptionHandler(MailSendException.class)
   public ModelAndView handleException(MailSendException e) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", e.getMessage()); //����ڰ� ���Ե� ���� �޽���
      mav.setViewName("shop/error/result");
      
      return mav;
   }

   //�α��� ����
   @ExceptionHandler(MemberNotFoundException.class)
   public ModelAndView handleException(MemberNotFoundException e) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", e.getMessage());
      mav.setViewName("shop/error/result");
      
      return mav;
   }
}