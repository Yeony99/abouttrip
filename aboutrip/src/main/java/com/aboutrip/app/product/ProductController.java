package com.aboutrip.app.product;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@Controller("product.productController")
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	ProductService service;

	@Autowired
	AboutUtil aboutUtil;

	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "keyword", defaultValue = "all") String keyword, HttpServletRequest req, Model model)
			throws Exception {

		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		List<Integer> category = new ArrayList<Integer>();
		if (keyword.equals("package") || keyword.equals("all"))
			category.add(1);
		if (keyword.equals("ticket") || keyword.equals("all"))
			category.add(2);
		if (keyword.equals("mobile") || keyword.equals("all"))
			category.add(3);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", category);

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		dataCount = service.listCount(map);

		if (dataCount != 0)
			total_page = aboutUtil.pageCount(rows, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Product> list = service.listProducts(map);

		int listNum, n = 0;
		for (Product dto : list) {
			listNum = dataCount - (offset + n);
			dto.setNum(listNum);
			n++;
		}

		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/product/list";
		if (keyword.length() != 0) {
			query = "?keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/product/list?" + query;
		}

		String paging = aboutUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("keyword", keyword);

		return ".product.list";
	}

	@RequestMapping("article")
	public String article(@RequestParam int code, HttpSession session, Model model

	) throws Exception {
		Product dto = new Product();
		List<QnA> qna = new ArrayList<QnA>();
		List<Product> options = new ArrayList<Product>();

		dto = service.readProduct(code);
		options = service.listOption(code);

		int rows = 10; // 한 화면에 보여주는 게시물 수
		Map<String, Object> map = new HashMap<String, Object>();

		int offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		map.put("code", code);

		qna = service.listQna(map);
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		model.addAttribute("nickName", info.getNickName());
		model.addAttribute("qnalist", qna);
		model.addAttribute("options", options);
		model.addAttribute("dto", dto);
		model.addAttribute("code", code);

		return ".product.article";
	}

	@RequestMapping(value = "event", method = RequestMethod.GET)
	public String eventlist(@RequestParam(value = "keyword", defaultValue = "all") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		List<Product> package_list = service.listEvent(4);
		List<Product> ticket_list = service.listEvent(5);
		List<Product> mobile_list = service.listEvent(6);

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		model.addAttribute("package_list", package_list);
		model.addAttribute("ticket_list", ticket_list);
		model.addAttribute("mobile_list", mobile_list);

		model.addAttribute("keyword", keyword);

		return ".product.event";
	}

	@RequestMapping("carting")
	public String carting(@RequestParam int code, @RequestParam(value = "quantity", defaultValue = "1") int quantity,
			int detail_num, @RequestParam int choice, RedirectAttributes redirect, HttpSession session, Model model)
			throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Order dto = new Order();
		dto.setUser_num(info.getUserNum());
		dto.setDetail_num(detail_num);
		dto.setQuantity(quantity);
		service.insertcart(dto);
		redirect.addAttribute("code", code);
		if (choice == 1) {
			return "redirect:/product/cart";
		}
		return "redirect:/product/article";
	}

	@RequestMapping("cart")
	public String cart(HttpSession session, Model model) throws Exception {
		List<Order> list = new ArrayList<Order>();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		int countCart = 0;

		list = service.listcart(info.getUserNum());
		countCart = service.countcart(info.getUserNum());
		model.addAttribute("list", list);
		model.addAttribute("dataCount", countCart);
		return ".product.cart";
	}

	@RequestMapping("deletecart")
	public String deletecart(@RequestParam int cart_num, Model model) throws Exception {
		service.deletecart(cart_num);

		return "redirect:/product/cart";
	}

	@RequestMapping("deletecartlist")
	public String deletecartlist(@RequestParam List<String> carts, Model model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", carts);
		service.deletecart(map);

		return "redirect:/product/cart";
	}

	@RequestMapping("payment")
	public String payment(@RequestParam List<String> carts, HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_num", info.getUserNum());
		map.put("list", carts);

		Order dto = new Order();

		List<Order> list = null;
		List<Order> cardlist = null;

		dto = service.readMember(info.getUserNum());
		list = service.listPayment(map);
		cardlist = service.listCard(info.getUserNum());
		String payment_name = list.get(0).getProduct_name();
		if (carts.size() > 1)
			payment_name += " 외 " + carts.size() + " 개 품목";

		int final_price = 0;

		for (int i = 0; i < list.size(); i++) {
			final_price += list.get(i).getPrice();
		}

		model.addAttribute("list", list);
		model.addAttribute("member", dto);
		model.addAttribute("cardlist", cardlist);
		model.addAttribute("final_price", final_price);
		model.addAttribute("payment_name", payment_name);
		model.addAttribute("carts", carts);
		return ".product.payment";
	}

	@RequestMapping("complete")
	public String paymentComplete(@RequestParam String payment_name, @RequestParam int final_price,
			@RequestParam List<String> carts, HttpSession session, RedirectAttributes redirect) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		// orders 입력(주문)
		Order dto = new Order();
		dto.setUser_num(info.getUserNum());
		dto.setOrder_price(final_price);

		// orderDetail에 필요한 파라미터 불러오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user-num", info.getUserNum());
		map.put("list", carts);

		List<Order> list = new ArrayList<Order>();

		list = service.listPayment(map);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setFinal_price(list.get(i).getPrice() * list.get(i).getQuantity());
		}

		service.completePayment(dto, list);
		service.deletecart(map);

		redirect.addAttribute("payment_name", payment_name);
		redirect.addAttribute("final_price", final_price);
		return "redirect:/product/completed";
	}

	@RequestMapping("completed")
	public String paymentcompleted(@RequestParam String payment_name, @RequestParam int final_price, Model model)
			throws Exception {
		String message = payment_name + "\n" + final_price + "원이 결제 완료되었습니다.";
		model.addAttribute("message", message);
		return ".product.complete";
	}

	@RequestMapping("qna")
	public String qnalist(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			int code, HttpServletRequest req, Model model) throws Exception {
		List<QnA> list = new ArrayList<QnA>();
		Map<String, Object> map = new HashMap<String, Object>();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		dataCount = service.countQna(code);

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		if (dataCount != 0)
			total_page = aboutUtil.pageCount(rows, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		map.put("code", code);
		map.put("condition", condition);
		map.put("keyword", keyword);

		list = service.listQna(map);

		String cp = req.getContextPath();

		String query = "";
		String listUrl = cp + "/product/article";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			listUrl += query;
		}

		String paging = aboutUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

		return ".product.qna";
	}

	@RequestMapping("qnasubmit")
	public String qnacreated(QnA dto, Model model, HttpSession session, RedirectAttributes redirect) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setUser_num(info.getUserNum());
		service.insertQuestion(dto);
		redirect.addAttribute("code", dto.getCode());
		return "redirect:/product/article";
	}
}
