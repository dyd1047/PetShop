package com.koreait.petshop.model.domain;

import lombok.Data;

@Data
public class Admin {
   private int admin_id;
   private int member_type_id;
   private String emp_id;
   private String user_id;
   private String password; 
   private String regdate;
}