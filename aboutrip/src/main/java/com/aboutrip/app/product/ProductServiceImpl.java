package com.aboutrip.app.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("product.productService")
public class ProductServiceImpl implements ProductService{
	@Autowired
	AboutDAO dao;

	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertProduct(Product dto, String pathname) throws Exception {

		try {
			
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				dto.setImg_name(saveFilename);
			}
			dao.insertData("product.insert_product", dto);
			dao.insertData("product.insert_product_image", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void insertProductDetail(Product dto) throws Exception {

		try {
			dao.insertData("product.insertproduct_detail", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertReview(Order dto) throws Exception {
		try {
			dao.insertData("product.insert_review", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void insertQuestion(QnA dto) throws Exception {
		try {
			dao.insertData("product.insert_product_q", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertAnswer(QnA dto) throws Exception {
		try {
			dao.updateData("product.insert_product_a", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<Product> listProduct(Map<String, Object> map) throws Exception {
		List<Product> list = null;
		try {
			list = dao.selectList("product.product_list", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public List<Product> listProducts(Map<String, Object> map) throws Exception {
		List<Product> list = null;
		try {
			list = dao.selectList("product.product_list_categories", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}
	@Override
	public List<Order> listOrder(int code) throws Exception {
		List<Order> list = null;

		return list;
	}

	@Override
	public List<QnA> listQna(int code) throws Exception {
		List<QnA> list = null;
		try {
			list = dao.selectList("booking.qna_list", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	
	}

	@Override
	public int listCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("product.list_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateQnA(int num) throws Exception {
		
	}

	@Override
	public void updateProduct(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProduct(int code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int countProduct(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Product readProduct(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



	
}
