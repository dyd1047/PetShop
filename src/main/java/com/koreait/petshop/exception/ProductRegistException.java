package com.koreait.petshop.exception;

//CRUD ?��?��?�� 발생?��?�� ?��?��
public class ProductRegistException extends RuntimeException{
	
	public ProductRegistException(String msg) {
		super(msg);
	}
	public ProductRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}
