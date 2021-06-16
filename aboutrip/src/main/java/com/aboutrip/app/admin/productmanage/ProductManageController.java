package com.aboutrip.app.admin.productmanage;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutrip.app.member.SessionInfo;
import com.aboutrip.app.product.Product;

@Controller("admin.productmanage.productManageController")
@RequestMapping("/admin/productmanage/*")
public class ProductManageController {

	@Autowired
	ProductManageService service;
	
	@RequestMapping("productmanagement")
	public String productlist() throws Exception{
		
		return ".admin.productmanage.productlist";
	}
	
	@RequestMapping(value = "inputproduct", method=RequestMethod.GET)
	public String productinput(
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (!info.getUserId().equals("admin")) {
			return "redirect:product/list";
		}
		model.addAttribute("mode", "created");
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
	public String detailinput(@RequestParam int code, HttpSession session, Model model)
			throws Exception {
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
		model.addAttribute("mode", "detail");
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
	
	
}
