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
			for(Product dto : list) {
				switch (dto.getCategory_num()) {
				case 1: dto.setCategory_name("패키지"); break;
				case 2: dto.setCategory_name("티켓/투어"); break;
				case 3: dto.setCategory_name("모바일"); break;
				case 4: dto.setCategory_name("패키지 이벤트"); break;
				case 5: dto.setCategory_name("티켓/투어 이벤트"); break;
				case 6: dto.setCategory_name("모바일 이벤트"); break;
				}
			}
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
	public List<QnA> listQna(Map<String,Object> map) throws Exception {
		List<QnA> list = null;
		try {
			list = dao.selectList("product.qna_list", map);
			for(int i=0; i<list.size(); i++) {
				switch(list.get(i).getType()) {
				case "1" : list.get(i).setType("상품질문"); break;
				case "2" : list.get(i).setType("교환/환불"); break;
				case "3" : list.get(i).setType("기타"); break;
				}
			}
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
	public void completePayment(Order dto, List<Order> list, Payment pay) throws Exception {
	
		try {
			dao.insertData("product.orders_insert", dto);
			dao.insertData("product.payCharge_insert", pay);
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

	@Override
	public List<Order> listReview(Map<String, Object> map) throws Exception {
		List<Order> list = null;
		try {
			list = dao.selectList("product.review_list", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public int countReview(int code) throws Exception {
		int result=0;
		try {
			result = dao.selectOne("product.count_rev", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Order readOrder(int order_detail) throws Exception {
		Order dto = null;
		try {
			dto = dao.selectOne("product.readOrderDetail", order_detail);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}

	@Override
	public void repundPayment(Payment dto) throws Exception {
		try {
			dao.insertData("product.repundPayment", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
}
