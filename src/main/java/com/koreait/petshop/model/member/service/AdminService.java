package com.koreait.petshop.model.member.service;

import java.util.List;

import com.koreait.petshop.model.domain.Admin;

public interface AdminService {
   public List selectAll();//��� ȸ����������
   public Admin select(Admin admin); //ȸ��1�� ��������
   public void regist(Admin admin);//ȸ����� �� ��Ÿ�ʿ���� ó��..
   public int userIdCheck(String user_id); //���̵� �ߺ� üũ
   public void update(Admin admin); //ȸ������ ����
   public void delete(Admin admin); //ȸ������ ����
}