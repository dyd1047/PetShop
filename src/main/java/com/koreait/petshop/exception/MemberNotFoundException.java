package com.koreait.petshop.exception;

//CRUD ?��?��?�� 발생?��?�� ?��?��
public class MemberNotFoundException extends RuntimeException{
	
	public MemberNotFoundException(String msg) {
		super(msg);
	}
	public MemberNotFoundException(String msg, Throwable e) {
		super(msg, e);
	}
}
