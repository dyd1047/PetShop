package com.koreait.petshop.model.product.service;

import java.util.List;

import com.koreait.petshop.model.domain.SubCategory;


public interface SubCategoryService {
	//CRUD
	public List selectAll();//모든 레코드 가져오기
	public List selectAllById(int topcategory_id); //선택한 상위 카테고리에 소속된 하위카테고리 목록 가져오기
	public SubCategory select(int topcategory_id);
	public void insert(SubCategory topCategory);
	public void update(SubCategory topCategory);
	public void delete(int topcategory_id);
	
}
