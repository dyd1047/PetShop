package com.koreait.petshop.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.member.service.MemberTypeService;
import com.koreait.petshop.model.product.service.TopCategoryService;

/*
 * ���θ� �̿�� ���������� ����� ī�װ� �޴� ���
 * */
public class GlobalDataAspect {
	@Autowired
	private TopCategoryService topCategoryService;
	
	@Autowired
	private MemberTypeService memberTypeService;
	
	public Object getGlobalData(ProceedingJoinPoint joinPoint) throws Throwable{
		Object result=null;
		HttpServletRequest request=null;
		
		//�Ű������κ��� ��û ��ü ����!!
		for(Object arg : joinPoint.getArgs()) {
			if(arg instanceof HttpServletRequest) {
				request = (HttpServletRequest)arg;
			}
		}
		
		String uri = request.getRequestURI(); //Ŭ���̾�Ʈ�� ��û URI ��Ʈ�� ����
		
		//topList�� �����ؾ� �ϴ� ���� �׷��� ���� ��츦 ����� ó��
		if(	uri.equals("/shop/member/login") || 
			uri.equals("/shop/member/regist") ||
			uri.equals("/user/idCheck") ||
			uri.equals("/admin") ||
			uri.equals("/admin/product/regist") ||
			uri.equals("/admin/product/excel/registform") 
		) {
			result=joinPoint.proceed(); //���� ȣ���Ϸ� �ߴ� �޼��� ȣ��!! go ahead
		}else {//�ʿ��� ���
			//topList ��������
			List topList = topCategoryService.selectAll();
			List memberTypeList = memberTypeService.selectAll();
			Object returnObj = joinPoint.proceed();//���� ȣ���Ϸ� �ߴ� �޼���ȣ��
			ModelAndView mav = null;
			if( returnObj instanceof ModelAndView) {
				mav =(ModelAndView)returnObj;
				mav.addObject("topList",topList);
				mav.addObject("memberType",memberTypeList);
				result=mav;
			}
		}
		return result;
	}
}
