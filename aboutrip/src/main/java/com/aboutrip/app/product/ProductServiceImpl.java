package com.aboutrip.app.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("product.productService")
public class ProductServiceImpl implements ProductService {
	@Autowired
	AboutDAO dao;

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
	public Product readProduct(int code) throws Exception {
		Product dto = null;
		try {
			dto = dao.selectOne("product.product_read", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}

	@Override
	public List<Product> listOption(int code) throws Exception {
		List<Product> list;
		try {
			list = dao.selectList("product.option_list", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public List<Product> listEvent(int category_num) throws Exception {
		List<Product> list = null;
		try {
			list = dao.selectList("product.product_list_event", category_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}
}
