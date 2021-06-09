package com.aboutrip.app.faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutrip.app.common.AboutUtil;

@Controller("faq.faqController")
@RequestMapping("/faq/*")
public class FaqController {
	
	@Autowired
	private FaqService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping(value="main")
	public String main(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("mode", "enabled");
		List<Faq> listCategory = service.listCategory(map);
		
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("categoryNum", "0");
		model.addAttribute("pageNo", current_page);
		
		return ".faq.main";
	}
	
	
	
	
	
	
}
