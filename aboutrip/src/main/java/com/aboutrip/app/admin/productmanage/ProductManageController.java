package com.aboutrip.app.admin.productmanage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutrip.app.member.SessionInfo;
import com.aboutrip.app.product.Order;
import com.aboutrip.app.product.Product;

@Controller("admin.productmanage.productManageController")
@RequestMapping("/admin/productmanage/*")
public class ProductManageController {

	@Autowired
	ProductManageService service;

	@RequestMapping("productmanagement")
	public String productlist(Model model) throws Exception {

		List<Product> list = new ArrayList<Product>();
		List<Product> options = new ArrayList<Product>();

		list = service.listProduct();
		options = service.listOptions();
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

	@RequestMapping(value = "inputProduct", method = RequestMethod.POST)
	public String createSubmit(Product dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "product";

		try {
			service.insertProduct(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/productmanagement";
	}

	@RequestMapping("inputproductoption")
	public String detailinput(@RequestParam int code, HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (!info.getUserId().equals("admin")) {
			return "redirect:/productmanagement";
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
		return "redirect:/productmanagement";
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
		return "redirect:/productmanagement";
	}

	@RequestMapping(value = "updatedetail", method = RequestMethod.GET)
	public String updatedetail(@RequestParam int detail_num, Model model) throws Exception {
		Product dto = new Product();
		dto = service.readDetail(detail_num);

		model.addAttribute("dto", dto);
		model.addAttribute("mode", "updateproduct");
		return ".admin.productmanage.createdetail";
	}

	@RequestMapping(value = "updatedetail", method = RequestMethod.POST)
	public String updatedetailsubmit(Product dto) throws Exception {
		try {
			service.updateOption(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/productmanagement";
	}

	@RequestMapping(value = "deleteproduct")
	public String deleteproduct(@RequestParam int code) throws Exception {
		try {
			service.deleteProduct(code);
		} catch (Exception e) {
		}

		return "redirect:/productmanagement";
	}

	@RequestMapping(value = "deleteoption")
	public String deleteoption(@RequestParam int detail_num) throws Exception {
		try {
			service.deleteOption(detail_num);
		} catch (Exception e) {
		}

		return "redirect:/productmanagement";
	}
	
}
