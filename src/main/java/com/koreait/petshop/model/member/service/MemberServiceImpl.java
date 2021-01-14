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
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   @Autowired
   private MemberDAO memberDAO;
   
   //���Ϲ߼� ��ü
   @Autowired
   private MailSender mailSender;
   
   //��ȣȭ ��ü 
   @Autowired
   private SecureManager secureManager;

   @Override
   public List selectAll() {
      return memberDAO.selectAll();
   }

   //�α���
   @Override
   public Member select(Member member) throws MemberNotFoundException{
      //������ ������ �Ķ���� ��й�ȣ�� �ؽð����� ��ȯ�Ͽ� �Ʒ��� �޼��� ȣ��
      String hash = secureManager.getSecureData(member.getPassword());
      member.setPassword(hash); //VO�� �ؽ��� ����
      
      Member obj = memberDAO.select(member);
      
      return obj;
   }

   //ȸ������
   @Override
   public void regist(Member member) throws MemberRegistException, MailSendException{
      //��ȣȭ ó�� 
      String secureData = secureManager.getSecureData(member.getPassword());
      member.setPassword(secureData); //��ȯ���� �ٽ� VO�� ����
      
      //DB�� �ֱ�
      memberDAO.insert(member);
      
      //���Ϲ߼�
      String name=member.getName();
      String addr=member.getAddr();
      String email = member.getEmail_id()+"@"+member.getEmail_server();
      
      mailSender.send(email , name+"�� [�����Ǿ�]�������ϵ����", addr+"�� �����ϼ���? �����մϴ�");
   }

   //ID �ߺ�üũ
   @Override
   public int userIdCheck(String user_id) {

      return memberDAO.checkOverId(user_id);
   }
   
   @Override
   public void update(Member member) {
      
   }

   @Override
   public void delete(Member member) {
      
   }

}