package com.koreait.petshop.model.payment.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;

public interface CartDAO {
	public List selectAll();//?šŒ?› êµ¬ë¶„?—†?´ ëª¨ë“  ?°?´?„° ê°?? ¸?˜¤ê¸? 
	public List selectAll(int member_id);//?Š¹? • ?šŒ?›?˜ ?¥ë°”êµ¬?‹ˆ ?‚´?—­
	public Cart select(int cart_id);
	public void duplicateCheck(Cart cart); //?¥ë°”êµ¬?‹ˆ ì¤‘ë³µ?ƒ?’ˆ ?—¬ë¶? ì²´í¬
	public void insert(Cart cart); 
	public void update(Cart cart);
	public void delete(int cart_id); //pkë¥? ?´?š©?•œ ?‚­? œ
	public void delete(Member member); //?šŒ?›?— ?†?•œ ?°?´?„° ?‚­? œ?• ?˜ˆ? •
	
}
