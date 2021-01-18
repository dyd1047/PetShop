package com.koreait.petshop.model.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.exception.CartException;
import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.OrderSummary;
import com.koreait.petshop.model.domain.Receiver;
import com.koreait.petshop.model.payment.repository.CartDAO;
import com.koreait.petshop.model.payment.repository.OrderDetailDAO;
import com.koreait.petshop.model.payment.repository.OrderSummaryDAO;
import com.koreait.petshop.model.payment.repository.PaymethodDAO;
import com.koreait.petshop.model.payment.repository.ReceiverDAO;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private PaymethodDAO paymethodDAO;
	
	@Autowired
	private OrderSummaryDAO orderSummaryDAO;
	
	@Autowired
	private ReceiverDAO receiverDAO;
	
	@Autowired
	private OrderDetailDAO orderDetailDAO;
	
	
	@Override
	public List selectCartList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectCartList(int member_id) {
		return cartDAO.selectAll(member_id);
	}

	@Override
	public Cart selectCart(int cart_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Cart cart) throws CartException{
		cartDAO.duplicateCheck(cart);
		cartDAO.insert(cart);
	}

	@Override
	public void update(List<Cart> cartList) throws CartException{
		for(Cart cart : cartList) {
			cartDAO.update(cart);
		}
	}

	@Override
	public void delete(int cart_id) {
		cartDAO.delete(cart_id);
	}

	public void delete(Member member) throws CartException{
		cartDAO.delete(member);
	}
	
	@Override
	public List selectPaymethodList() {
		return paymethodDAO.selectAll();
	}
	
	@Override
	public void registOrder(OrderSummary orderSummary, Receiver receiver) {
		orderSummaryDAO.insert(orderSummary);
		
		receiver.setOrder_summary_id(orderSummary.getOrder_summary_id()); 
		receiverDAO.insert(receiver);
		
	}

}







