package com.koreait.petshop.model.product.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.koreait.petshop.exception.ProductRegistException;
import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.domain.Image;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.product.repository.ImageDAO;
import com.koreait.petshop.model.product.repository.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService{
	private static final Logger logger=LoggerFactory.getLogger(ProductServiceImpl.class);
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ImageDAO imageDAO;
	
	
	
	@Override
	public List selectAll() {
		return productDAO.selectAll();
	}

	@Override
	public List selectById(int subcategory_id) {

		return productDAO.selectById(subcategory_id);
	}

	@Override
	public Product select(int product_id) {
		
		return productDAO.select(product_id);
	}

	@Override
	public void regist(FileManager fileManager, Product product) throws ProductRegistException{
		
		String ext = fileManager.getExtend(product.getRepImg().getOriginalFilename());
		product.setFilename(ext);
		
		//db�� �ִ� ���� DAO���� ��Ű��
		 productDAO.insert(product);
		
		//���Ͼ��ε����! FileManager���� �� ��Ű��. service�� ���簡 �ֱ� ������ ����. dao�� db�� ��! ����
		//���� ��ǥ�̹��� ���ε�
		 String basicImg = product.getProduct_id()+"."+ext;//��ǰ�� product_id�� �̿��Ͽ� ��ǥ�̹������� ��������!!
		 fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg, product.getRepImg());
		 
		 //�߰� �̹��� ���ε� (FileManager���� �߰��̹��� ������ŭ ���ε� ������ ��Ű�� �ȴ�)
		 for(int i=0;i<product.getAddImg().length;i++) {
			 
			 MultipartFile file = product.getAddImg()[i];
			 ext = fileManager.getExtend(file.getOriginalFilename());
			 
			 //image table�� �ֱ�
			 Image image = new Image();
			 image.setProduct_id(product.getProduct_id());	//fk
			 image.setFilename(ext);  //Ȯ���� �ֱ�
			 imageDAO.insert(image);
			 
			 //�Ŵ����� ����޼��� ȣ��
			 String addImg = image.getImage_id()+"."+ext;
			 fileManager.saveFile(fileManager.getSaveAddonDir()+File.separator+addImg, file);
		 }
		 
	}

	@Override
	public void update(Product product) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int product_id) {
		// TODO Auto-generated method stub
		
	}

}