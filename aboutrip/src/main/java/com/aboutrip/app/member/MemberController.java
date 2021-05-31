package com.aboutrip.app.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		return ".member.member";
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
			return ".member.member";
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "제약조건 위반으로 회원가입이 실패했습니다.");
			return ".member.member";
		} catch (Exception e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "회원가입이 실패했습니다.");
			return ".member.member";
		}
		String s;
		s = dto.getUserName() + "(" +dto.getNickName() + ")님의 회원 가입이 정상적으로 처리되었습니다.<br>";		
		s += "로그인창으로 이동하여 로그인 하시기 바랍니다.<br>";
		
		reAttr.addFlashAttribute("message", s);
		reAttr.addFlashAttribute("title", "회원 가입");
		return "redirect:/member/complete";
	}
	
	@RequestMapping(value="complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		if(message==null || message.length()==0)
			return "redirect:/";
		
		return ".member.complete";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm(Model model) {
		return ".member.login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String loginsubmit(
			@RequestParam String userId,
			@RequestParam String userPwd,
			HttpSession session,
			Model model	) {
			
		Member dto = service.loginMember(userId);
		if (dto==null || !userPwd.equals(dto.getUserPwd())) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "/member/login";
		}
		
		SessionInfo info = new SessionInfo();
		info.setUserNum(dto.getUserNum());
		info.setNickName(dto.getNickName());
		
		session.setMaxInactiveInterval(60*60); // 세션 한시간 유지
		
		session.setAttribute("member", info);
		
		return "redirect:/member/main";
	}
	
	@RequestMapping(value="main")
	public String main() {
	
		return ".member.main";
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		session.removeAttribute("member");
		session.invalidate();
		return "redirect:/member/login";
	}
}
