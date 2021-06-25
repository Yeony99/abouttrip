package com.aboutrip.app.admin.productmanage;

import java.io.File;
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

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;
import com.aboutrip.app.product.Order;
import com.aboutrip.app.product.Product;
import com.aboutrip.app.product.QnA;

@Controller("admin.productmanage.productManageController")
@RequestMapping("/admin/productmanage/*")
public class ProductManageController {

	@Autowired
	AboutUtil aboutUtil;

	@Autowired
	ProductManageService service;

	@RequestMapping("productmanagement")
	public String productlist(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req, Model model) throws Exception {
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<String, Object>();

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

		String cp = req.getContextPath();
		String listUrl = cp + "/admin/productmanage/productmanagement";

		String paging = aboutUtil.paging(current_page, total_page, listUrl);

		List<Product> list = new ArrayList<Product>();
		List<Product> options = new ArrayList<Product>();

		list = service.listProduct(map);
		options = service.listOptions();
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("options", options);

		return ".admin.productmanage.productlist";
	}

	@RequestMapping(value = "inputproduct", method = RequestMethod.GET)
	public String productinput(HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (!info.getUserId().equals("admin")) {
			return "redirect:product/list";
		}
		model.addAttribute("mode", "inputproduct");
		return ".admin.productmanage.create";
	}

	@RequestMapping(value = "inputproduct", method = RequestMethod.POST)
	public String createSubmit(Product dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"product";
		
		try {
			service.insertProduct(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping("inputproductoption")
	public String detailinput(@RequestParam int code, HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (!info.getUserId().equals("admin")) {
			return "redirect:/admin/productmanage/productmanagement";
		}
		Product dto = null;
		int optionCount;
		try {
			dto = service.readProduct(code);
			optionCount = service.countOption(code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		model.addAttribute("option_value", optionCount + 1);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "inputproductoption");
		return ".admin.productmanage.createdetail";
	}

	@RequestMapping(value = "inputproductoption", method = RequestMethod.POST)
	public String createdetailSubmit(Product dto) throws Exception {
		try {
			service.insertProductDetail(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping(value = "updateproduct", method = RequestMethod.GET)
	public String updateproduct(@RequestParam int code, Model model) throws Exception {
		Product dto = new Product();
		dto = service.readProduct(code);
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "updateproduct");
		return ".admin.productmanage.create";
	}

	@RequestMapping(value = "updateproduct", method = RequestMethod.POST)
	public String updateproductsubmit(Product dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "product";

		try {
			service.updateProduct(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping(value = "updatedetail", method = RequestMethod.GET)
	public String updatedetail(@RequestParam int detail_num, Model model) throws Exception {
		Product dto = new Product();
		dto = service.readDetail(detail_num);

		model.addAttribute("detail_num", detail_num);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "updatedetail");
		return ".admin.productmanage.createdetail";
	}

	@RequestMapping(value = "updatedetail", method = RequestMethod.POST)
	public String updatedetailsubmit(Product dto) throws Exception {
		try {
			service.updateOption(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping(value = "deleteproduct")
	public String deleteproduct(@RequestParam int code) throws Exception {
		try {
			service.deleteProduct(code);
		} catch (Exception e) {
		}

		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping(value = "deleteoption")
	public String deleteoption(@RequestParam int detail_num) throws Exception {
		try {
			service.deleteOption(detail_num);
		} catch (Exception e) {
		}

		return "redirect:/admin/productmanage/productmanagement";
	}

	@RequestMapping("qnamanage")
	public String qnaManagement(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "0") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<QnA> list = null;
		String cp = req.getContextPath();

		int rows = 10;
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map.put("offset", offset);
		map.put("rows", rows);
		map.put("keyword", keyword);
		map.put("condition", condition);
		
		list = service.listQnA(map);
		
		int dataCount = service.qnaCount(map);
		
		int total_page = aboutUtil.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;
		
		String query = "";
        String listUrl = cp+"/admin/productmanage/article?condition=" + condition;
        
        if(keyword.length()!=0) {
        	query = "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
		String paging = aboutUtil.pagingMethod(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("query", query);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("paging", paging);
		
		return ".admin.productmanage.qnamanage";
	}

	@RequestMapping("respanswer")
	public String responseAnswer(int num, String answer) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("answer", answer);

		service.insertAnswer(map);
		return "redirect:/admin/productmanage/qnamanage";
	}

	@RequestMapping(value="salemanage")
	public String salemanage() throws Exception{
		
		return ".admin.productmanage.salemanage";
	}
	
	@RequestMapping(value="paymentmanage")
	public String paymentmanage(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception{
		List<Order> list = new ArrayList<Order>();
		List<Order> options = new ArrayList<Order>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		String cp = req.getContextPath();

		int rows = 10;
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map.put("offset", offset);
		map.put("rows", rows);
		
		
		list = service.list_Allpayment(map);
		options = service.list_Allpayment_Option();
		
		int dataCount = service.paymentCount();
		
		int total_page = aboutUtil.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;
		

        String listUrl = cp+"/admin/productmanage/paymentmanage";

		String paging = aboutUtil.pagingMethod(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("options",options);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		return ".admin.productmanage.paymentmanage";
	}
}
