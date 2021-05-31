package com.aboutrip.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mongodb.DuplicateKeyException;

@Controller("member.memberController")
@RequestMapping(value = "/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping(value="member", method=RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "member");
		// tiles-defs에서 .에 관해서 설정해놓음
		// 화면결합을 위하면 tiles를 사용
		return "/member/member";
	}
	
	@RequestMapping(value="member", method=RequestMethod.POST)
	public String memberSubmit(
			Member dto, 
			final RedirectAttributes reAttr, 
			Model model) {
		try {
			service.insertMember(dto);
		} catch (DuplicateKeyException e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return "/member/member";
		} catch (Exception e) {
		}
		
		return "redirect:/member/complete";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm(Model model) {
		return "/main_W/login";
	}
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String main(Model model) {
		return "/main_W/main";
	}
	
}
