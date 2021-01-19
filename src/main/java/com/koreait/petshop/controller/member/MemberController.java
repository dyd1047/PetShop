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
import com.koreait.petshop.model.common.SecureManager;
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
   
   //암호화 객체 
   @Autowired
   private SecureManager secureManager;
   
   //마이페이지 폼 요청
   @RequestMapping(value="/petshop/mypage")
   public ModelAndView getMypage(HttpServletRequest request) {
	   ModelAndView mav = new ModelAndView();
	   mav.setViewName("shop/member/mypage");
	   
	   return mav;
   }
   
   //클라이언트 회원가입 폼 요청
   @RequestMapping(value="/petshop/register")
   public ModelAndView getClientRegister(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("shop/member/register");
      
      return mav;
   }
   
   //관리자 회원가입 폼 요청
   @RequestMapping(value="/admin/register")
   public ModelAndView getAdminRegister(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("admin/member/register");
      
      return mav;
   }
   
   //회원아이디 중복 체크
   @RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
   @ResponseBody
   public int idCheck(@RequestParam(value="user_id") String user_id, HttpServletRequest request) {
      //logger.debug(user_id);

      return memberService.userIdCheck(user_id);
   }
   
   //관리자아이디 중복 체크
   @RequestMapping(value = "/admin/idCheck", method = RequestMethod.GET)
   @ResponseBody
   public int adminIdCheck(@RequestParam(value="user_id") String user_id, HttpServletRequest request) {
	   logger.debug(user_id);
	   int result = adminService.userIdCheck(user_id);
	   logger.debug("result = "+result);
	   
	   return result;
   }
   
   //클라이언트 회원가입 요청 처리 
   @RequestMapping(value="/shop/member/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
   @ResponseBody
   public String regist(Member member,HttpServletRequest request) {
      logger.debug("아이디 "+member.getUser_id());
      logger.debug("이름 "+member.getName());
      logger.debug("이름 "+member.getPhone());
      logger.debug("비번 "+member.getPassword());
      logger.debug("이메일id "+member.getEmail_id());
      logger.debug("이메일server "+member.getEmail_server());
      logger.debug("우편번호 "+member.getZipcode());
      logger.debug("주소 "+member.getAddr());
      logger.debug("주소 "+member.getAddr_detail());
      
      memberService.regist(member);
      
      StringBuffer sb = new StringBuffer();
      sb.append("{");
      sb.append(" \"result\":1, ");
      sb.append(" \"msg\":\"회원가입 성공\"");
      sb.append("}");
      
      return sb.toString();
   }
   
   //관리자 회원가입 요청 처리 
   @RequestMapping(value="/shop/admin/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
   @ResponseBody
   public String regist(Admin admin,HttpServletRequest request) {
      logger.debug("아이디 "+admin.getEmp_id());
      logger.debug("아이디 "+admin.getUser_id());
      logger.debug("비번 "+admin.getPassword());
      
      adminService.regist(admin);
      
      StringBuffer sb = new StringBuffer();
      sb.append("{");
      sb.append(" \"result\":1, ");
      sb.append(" \"msg\":\"회원가입 성공\"");
      sb.append("}");
      
      return sb.toString();
   } 
   
   //로그인 폼 요청
   @RequestMapping(value="/petshop/login")
   public ModelAndView getLogin(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("shop/member/login");
      
      return mav;
   }
   
   //로그인 요청 처리
   @RequestMapping(value="/petshop/loginRequest", method=RequestMethod.POST)
   public ModelAndView login(Member member, Admin admin, HttpServletRequest request) {
     ModelAndView mav = new ModelAndView();
     List<MemberType> memberTypeList = memberTypeService.selectAll();
     HttpSession session=request.getSession();
     String view = "";
     Admin admin_obj = null;
     Member member_obj = null;
     boolean loginCheck = false;
     
     //관리자 로그인 요청
     for(MemberType memberType : memberTypeList) {
        if(memberType.getMember_type_id() == 1) {
           for(int i = 0; i < memberType.getAdmin().size(); i++) {
              admin_obj = memberType.getAdmin().get(i);
              if(admin_obj.getUser_id().equals(admin.getUser_id())) {
                 logger.debug("admin Id OK");
                String hash = secureManager.getSecureData(admin.getPassword());
                admin.setPassword(hash); //VO에 해쉬값 대입
                 if(admin_obj.getPassword().equals(admin.getPassword())) {
                    logger.debug("admin Pass OK");
                    session.setAttribute("admin", admin_obj); //현재 클라이언트 요청과 연계된 세션에 보관해 놓는다
                    loginCheck = true;
                    
                    mav.setViewName("redirect:/");
                 }
              }
           }
        //고객 로그인 요청
        }else if(memberType.getMember_type_id() == 2) {
           for(int i = 0; i < memberType.getMember().size(); i++) {
              member_obj = memberType.getMember().get(i);
              if(member_obj.getUser_id().equals(member.getUser_id())) {
                 logger.debug("member Id OK");
                 String hash = secureManager.getSecureData(member.getPassword());
                 member.setPassword(hash); //VO에 해쉬값 대입
                 if(member_obj.getPassword().equals(member.getPassword())) {
                    logger.debug("member Pass OK");
                    session.setAttribute("member", member_obj); //현재 클라이언트 요청과 연계된 세션에 보관해 놓는다
                    loginCheck = true;
                    
                    mav.setViewName("redirect:/");
                 }
              }
           }
        }
     }
     if(!loginCheck) {
        throw new MemberNotFoundException("로그인 정보가 알맞지 않습니다.");
     }
      
     return mav;
   }
   
   //로그아웃 요청 처리 
   @RequestMapping(value="/petshop/logoutRequest", method=RequestMethod.GET)
   public ModelAndView logout(HttpServletRequest request) {
      request.getSession().invalidate(); //세션 무효화, 이시점부터 담겨진 데이터가 다 무효가 된다
      MessageData messageData = new MessageData();
      messageData.setResultCode(1);
      messageData.setMsg("로그아웃 되었습니다");
      messageData.setUrl("/");
      
      ModelAndView mav = new ModelAndView("shop/error/message");
      mav.addObject("messageData", messageData);
      return mav;
   }
   
   
   //회원목록 가져오기
   @RequestMapping(value="/admin/member/list", method=RequestMethod.GET )
   public ModelAndView getMemberList(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView("admin/member/member_list");
      List memberList = memberService.selectAll();
      mav.addObject("memberList", memberList);
      return mav;
   }
   
   //예외처리------------------------------------------------------------------------------------------------------
   //회원가입 예외
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
   
   //메일발송 예외
   @ExceptionHandler(MailSendException.class)
   public ModelAndView handleException(MailSendException e) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", e.getMessage()); //사용자가 보게될 에러 메시지
      mav.setViewName("shop/error/result");
      
      return mav;
   }

   //로그인 예외
   @ExceptionHandler(MemberNotFoundException.class)
   public ModelAndView handleException(MemberNotFoundException e) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", e.getMessage());
      mav.setViewName("shop/error/result");
      
      return mav;
   }
}