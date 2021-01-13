package com.koreait.petshop.model.member.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.common.MailSender;
import com.koreait.petshop.model.common.SecureManager;
import com.koreait.petshop.model.domain.Admin;
import com.koreait.petshop.model.member.repository.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService{

	  @Autowired
	   private SqlSessionTemplate sqlSessionTemplate;
	   
	   @Autowired
	   private AdminDAO adminDAO;
	   
	   //���Ϲ߼� ��ü
	   @Autowired
	   private MailSender mailSender;
	   
	   //��ȣȭ ��ü 
	   @Autowired
	   private SecureManager secureManager;

	   @Override
	   public List selectAll() {
	      return null;
	   }

	   //�α���
	   @Override
	   public Admin select(Admin admin) throws MemberNotFoundException{
	      //������ ������ �Ķ���� ��й�ȣ�� �ؽð����� ��ȯ�Ͽ� �Ʒ��� �޼��� ȣ��
	      String hash = secureManager.getSecureData(admin.getPassword());
	      admin.setPassword(hash); //VO�� �ؽ��� ����
	      
	      Admin obj = adminDAO.select(admin);
	      
	      return obj;
	   }

	   //ȸ������
	   @Override
	   public void regist(Admin admin) throws MemberRegistException, MailSendException{
	      //��ȣȭ ó�� 
	      String secureData = secureManager.getSecureData(admin.getPassword());
	      admin.setPassword(secureData); //��ȯ���� �ٽ� VO�� ����
	      
	      //DB�� �ֱ�
	      adminDAO.insert(admin);
	      
	      //���Ϲ߼�
	      //mailSender.send(email , name+"�� [�����Ǿ�]�������ϵ����", addr+"�� �����ϼ���? �����մϴ�");
	   }

	   //ID �ߺ�üũ
	   @Override
	   public int userIdCheck(String user_id) {

	      return adminDAO.checkOverId(user_id);
	   }
	   
	   @Override
	   public void update(Admin admin) {
	      
	   }

	   @Override
	   public void delete(Admin admin) {
	      
	   }


}
