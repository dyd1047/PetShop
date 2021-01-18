package com.koreait.petshop.model.payment.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.ReceiverRegistException;
import com.koreait.petshop.model.domain.Receiver;

@Repository
public class MybatisReceiverDAO implements ReceiverDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(Receiver receiver) throws ReceiverRegistException{
		int result = sqlSessionTemplate.insert("Receiver.insert", receiver);
		if(result==0) {
			throw new ReceiverRegistException("받는사람 등록실패");
		}
	}
	
}
