package com.koreait.petshop.model.member.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Admin;

public interface AdminDAO {
   public List selectAll();//��� ȸ����������
   public Admin select(Admin admin); //ȸ��1�� ��������
   public void insert(Admin admin);//ȸ�����
   public void update(Admin admin); //ȸ������ ����
   public void delete(Admin admin); //ȸ������ ���� 
   public int checkOverId(String user_id); //���̵� �ߺ� üũ
}