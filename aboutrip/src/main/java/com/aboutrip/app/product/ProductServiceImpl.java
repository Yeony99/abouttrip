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
		List<Product> list = null;
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

	@Override
	public void insertcart(Order dto) throws Exception{
		try {
			dao.insertData("product.cart_insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Order> listcart(int userNum) throws Exception {
		List<Order> list = null;
		try {
			list=dao.selectList("product.cart_list", userNum);
			for(int i = 0; i<list.size(); i++) {
				list.get(i).setFinal_price(list.get(i).getPrice()*list.get(i).getQuantity());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public int countcart(int user_num) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("product.cart_count", user_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public void deletecart(int cart_num) throws Exception {
		try {
			dao.deleteData("product.delete_cart", cart_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deletecart(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("product.delete_cartlist", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Order> listPayment(Map<String, Object> map) throws Exception {
		List<Order> list = null;
		try {
			list = dao.selectList("product.payment_list", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public Order readMember(int user_num) throws Exception {
		Order dto = null;
		try {
			dto = dao.selectOne("product.readMember", user_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}

	@Override
	public List<Order> listCard(int user_num) throws Exception {
		List<Order> list = null;
		try {
			list = dao.selectList("product.payment_method", user_num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public void completePayment(Order dto, List<Order> list) throws Exception {
	
		try {
			dao.insertData("orders_insert", dto);
			for(int i = 0; i<list.size(); i++) {
				list.get(i).setOrder_num(dto.getOrder_num());
				dao.insertData("orderdetail_insert", list.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int countQna(int code) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("product.count_qna", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	
}
