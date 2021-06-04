package com.aboutrip.app.member;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.common.FileManager;
import com.mongodb.DuplicateKeyException;

@Controller("member.memberController")
@RequestMapping(value = "/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private AboutUtil aboutUtil;

	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String memberForm(Model model) throws Exception {
		model.addAttribute("mode", "member");
		// tiles-defs에서 .에 관해서 설정해놓음
		// 화면결합을 위하면 tiles를 사용
		return ".member.member";
	}

	@RequestMapping(value = "member", method = RequestMethod.POST)
	public String memberSubmit(Member dto, final RedirectAttributes reAttr, Model model, HttpSession session) throws Exception {
		try {
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"member";
			service.insertMember(dto,pathname);
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
		s = dto.getUserName() + "(" + dto.getNickName() + ")님의 회원 가입이 정상적으로 처리되었습니다.<br>";
		s += "로그인창으로 이동하여 로그인 하시기 바랍니다.<br>";

		reAttr.addFlashAttribute("message", s);
		reAttr.addFlashAttribute("title", "회원 가입");
		return "redirect:/member/complete";
	}

	@RequestMapping(value = "complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {
		if (message == null || message.length() == 0)
			return "redirect:/";

		return ".member.complete";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm(Model model) throws Exception {
		return ".member.login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginsubmit(@RequestParam String userId, @RequestParam String userPwd, HttpSession session,
			Model model,HttpServletRequest req) throws Exception {

		Member dto = service.loginMember(userId);
		dto.setIpaddr(req.getRemoteAddr());
		service.checkIpAddr(dto);
		if (dto == null || !userPwd.equals(dto.getUserPwd())) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return ".member.login";
		}

		SessionInfo info = new SessionInfo();
		info.setUserNum(dto.getUserNum());
		info.setNickName(dto.getNickName());
		info.setUserId(dto.getUserId());

		session.setMaxInactiveInterval(60 * 60); // 세션 한시간 유지
		session.setAttribute("member", info);
		if(dto.getUserId().equals("admin")) {
			return "redirect:/admin/main";
		}
		return "redirect:/member/main";
	}

	@RequestMapping(value = "main")
	public String main() {

		return ".member.main";
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session) throws Exception {
		session.removeAttribute("member");
		session.invalidate();
		return "redirect:/member/login";
	}

	@RequestMapping(value = "emailfind", method = RequestMethod.GET)
	public String emailFind(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) {
			return "redirect:/";
		}
		return ".member.emailFind";
	}

	@RequestMapping(value = "emailfind", method = RequestMethod.POST)
	public String emailFindSubmit(@RequestParam String userName, @RequestParam String tel,
			final RedirectAttributes reAttr) throws Exception {
		Member dto = service.readMember(userName, tel);

		if (dto == null || dto.getUserId() == null || dto.getEnable() != 1) {
			reAttr.addFlashAttribute("message", "등록된 정보가 없습니다.");
			reAttr.addFlashAttribute("title", "이메일 찾기");
			return "redirect:/member/complete";
		}

		String s;
		s = dto.getUserName() + "님이 가입한 이메일주소는 '" + dto.getUserId() + "' 입니다.<br>";
		s += "로그인창으로 이동하여 로그인 하시기 바랍니다.";

		reAttr.addFlashAttribute("message", s);
		reAttr.addFlashAttribute("title", "비밀번호 찾기");
		return "redirect:/member/complete";
	}

	@RequestMapping(value = "pwdfind", method = RequestMethod.GET)
	public String findPwd(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) {
			return "redirect:/";
		}
		return ".member.pwdFind";
	}

	@RequestMapping(value = "pwdfind", method = RequestMethod.POST)
	public String findPwdSubmit(@RequestParam String userId, final RedirectAttributes reAttr)
			throws Exception {
		// readMember << userName과 tel로 찾는거 있어야함
		Member dto = service.readMember(userId);
		if (dto == null || dto.getUserId() == null || dto.getEnable() != 1) {
			reAttr.addFlashAttribute("message", "등록된 정보가 없습니다.");
			reAttr.addFlashAttribute("title", "이메일 찾기");
			return "redirect:/member/complete";
		}
		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			reAttr.addFlashAttribute("message", "이메일 전송이 실패했습니다.");
			reAttr.addFlashAttribute("title", "이메일 찾기");
			return "redirect:/member/complete";
		}
		String s;
		s = "회원님의 이메일로 임시 패스워드를 전송했습니다.<br>";
		s += "로그인 후 패스워드를 변경하시기 바랍니다.";

		reAttr.addFlashAttribute("message", s);
		reAttr.addFlashAttribute("title", "이메일 찾기");

		return "redirect:/member/complete";
	}
	
	@RequestMapping(value="mypage")
	public String update() {
		
		return".member.myPage";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(Model model, HttpSession session) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member dto = service.readMember(info.getUserId());
		
		if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
			dto.setUserId(dto.getEmail1()+"@"+dto.getEmail2());
		}
		
		model.addAttribute("mode","update");
		model.addAttribute("dto",dto);
		
		return".member.member";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Member dto,final RedirectAttributes reAttr,HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+"uploads"+File.separator+"member";
			dto.setUserNum(info.getUserNum());
			service.updateMember(dto,pathname);
		} catch (Exception e) {
		}
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return"redirect:/member/main";
	}
	
	@RequestMapping(value = "payment")
	public ModelAndView paymentForm(Model model) {
			
		return new ModelAndView(".member.payment");
	}
	
	@RequestMapping(value = "paymentList")
	public Map<String, Object> paymentList(@RequestParam(value="pageNo", defaultValue = "1") int current_page
			,HttpSession session) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		SessionInfo info=(SessionInfo)session.getAttribute("member");

        map.put("userNum", info.getUserNum());
		int rows=5;
		int dataCount = service.payCount(map);
		int total_page = aboutUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Member> paylist = service.payList(map);
        for(Member dto : paylist) {
        	dto.setPaymentCode(dto.getPaymentCode().replaceAll("\n", "<br>"));
        }
        
        Map<String, Object> model = new HashMap<>();
		
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);

		model.put("list", paylist);
        
        
        
		return model;
		
	}
	
	@RequestMapping(value = "payCreated", method = RequestMethod.GET)
	public String createdPayment(Member dto, HttpSession session, Model model) {
		
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto = service.readMember(info.getUserId());
			model.addAttribute("dto",dto);
			model.addAttribute("mode","payCreated");
		} catch (Exception e) {
		}
		
		return".member.payCreated";
	}
	@RequestMapping(value = "payCreated", method = RequestMethod.POST)
	public String paymentSubmit(Member dto, HttpSession session) {
		
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserNum(info.getUserNum());
			service.insertPayment(dto);
		} catch (Exception e) {
		}
		
		return"redirect:/member/payment";
	}
}
