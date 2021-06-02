package com.aboutrip.app.admin.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aboutrip.app.member.SessionInfo;

@Controller("admin.mainController")
@RequestMapping(value = "/admin/*")
public class MainController {
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String admin(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getUserNum()!=1111) {
			return "redirect:/member/main";
		}
		return ".admin.main.main";
	}
}
