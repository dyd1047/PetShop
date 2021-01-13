package com.koreait.petshop.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.domain.Admin;
import com.koreait.petshop.model.domain.Member;

@Repository
public class MybatisAdminDAO implements AdminDAO{

	@Autowired
	   private SqlSessionTemplate sqlSessionTemplate;

	   @Override
	   public List selectAll() {
	      return null;
	   }

	   //�α��� ����
	   @Override
	   public Admin select(Admin admin) throws MemberNotFoundException{
		  Admin admin_obj = sqlSessionTemplate.selectOne("Admin.select", admin);
	      if(admin_obj == null) { //�ùٸ��� ���� ������ ȸ���� ��ȸ�Ϸ��� �ϴ� ����..
    		 throw new MemberNotFoundException("�α��� ������ �ùٸ��� �ʽ��ϴ�.");
	      }
	      
	      return admin_obj;
	   }
	   @Override
	   public void insert(Admin admin) {
	      int result = sqlSessionTemplate.insert("Admin.insert", admin);
	      if (result == 0) {
	         throw new MemberRegistException("ȸ�����Կ� �����Ͽ����ϴ�.");
	      }
	   }

	   @Override
	   public void update(Admin admin) {
	      
	   }

	   @Override
	   public void delete(Admin admin) {
	      
	   }

	   @Override
	   public int checkOverId(String user_id) {
	      
	      return sqlSessionTemplate.selectOne("Admin.checkOverId", user_id);
	   }

}
