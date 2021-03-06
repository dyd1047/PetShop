package com.koreait.petshop.model.payment.service;

import java.util.List;

import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.OrderSummary;
import com.koreait.petshop.model.domain.Receiver;


public interface PaymentService {
	//?₯λ°κ΅¬? κ΄?? ¨ ?λ¬?
	public List selectCartList();//?? κ΅¬λΆ??΄ λͺ¨λ  ?°?΄?° κ°?? Έ?€κΈ? 
	public List selectCartList(int member_id);//?Ή?  ??? ?₯λ°κ΅¬? ?΄?­
	public Cart selectCart(int cart_id);
	public void insert(Cart cart);
	public void update(List<Cart> cartList); //?Όκ΄? ?? 
	public void delete(int cart_id); //pk? ?? ?°?΄?° ?­? ? ?? 
	public void delete(Member member); //??? ?? ?°?΄?° ?­? ? ?? 
	
	//κ²°μ  ?λ¬?
	public List selectPaymethodList();
	public void registOrder(OrderSummary orderSummary, Receiver receiver);//?Έ??­? μ²λ¦¬κ°? ?κ΅¬λ? λ©μ?...
}




