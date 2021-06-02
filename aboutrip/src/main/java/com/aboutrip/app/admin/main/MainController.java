package com.aboutrip.app.admin.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.mainController")
@RequestMapping(value = "/admin/*")
public class MainController {
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String admin() throws Exception {
		return ".admin.main.main";
	}
}
