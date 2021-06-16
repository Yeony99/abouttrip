package com.aboutrip.app.product;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutrip.app.common.AboutUtil;

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

	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int code, 
			Model model) throws Exception {
		Product dto = new Product();
		List<Product> options = new ArrayList<Product>();

		dto = service.readProduct(code);
		options = service.listOption(code);

		model.addAttribute("options", options);
		model.addAttribute("dto", dto);

		return ".product.article";
	}
	
	@RequestMapping(value="event", method = RequestMethod.GET)
	public String eventlist(
			@RequestParam(value="keyword", defaultValue = "all") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		

		List<Product> package_list = service.listEvent(4);
		List<Product> ticket_list = service.listEvent(5);
		List<Product> mobile_list = service.listEvent(6);

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}


		model.addAttribute("package_list", package_list);
		model.addAttribute("ticket_list", ticket_list);
		model.addAttribute("package_list", mobile_list);

		model.addAttribute("keyword", keyword);
		
		return ".product.event";
	}
}
