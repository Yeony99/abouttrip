package com.aboutrip.app.inquiry;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@Controller("inquiry.inquiryController")
@RequestMapping("/inquiry/*")
public class InquiryController {
	
	@Autowired
	private InquiryService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int rows = 10;
		int total_page = 0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userNum", info.getUserNum());
		
		dataCount = service.dataCount(map);
		if(dataCount!=0)
			total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page) current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset <0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Inquiry> list = service.listInquiry(map);
		
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "inquiry/list";
	}
	
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {
		
		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "created");
		
		return "inquiry/created";
	}
	
	@RequestMapping(value = "created", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Inquiry dto,
			HttpSession session
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		try {
			dto.setUserNum(info.getUserNum());
			service.insertInquiry(dto);
		} catch (Exception e) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping()
	public String article(
			@RequestParam int num,
			@RequestParam String pageNo,
			HttpServletResponse resp,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Inquiry dto = service.readInquiry(num);
		if(dto==null) {
			resp.sendError(410, "삭제된 게시물입니다.");
			return null;
		}
		
		if(! info.getUserId().equals("admin") &&  info.getUserNum() != dto.getUserNum()) {
			resp.sendError(402, "권한이 없습니다.");
			return null;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("pageNo", pageNo);
		
		return "inquiry/article";
	}
	
	@RequestMapping(value = "reply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replySubmit(
			Inquiry dto,
			HttpSession session
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "false";
		
		if(info.getUserId().equals("amdin")) {
			try {
				dto.setAdminNum(info.getUserNum());
				service.answerInquiry(dto);
				state = "true";
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="deleteAnswer", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAnswer(
			@RequestParam int num,
			HttpSession session) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "false";
		Inquiry dto = service.readInquiry(num);
		if(dto!=null) {
			if(info.getUserId().equals("admin")) {
				try {
					service.deleteAnswer(num);
					state="true";
				} catch (Exception e) {
					
				}
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "false";
		Inquiry dto = service.readInquiry(num);
		if(dto!=null) {
			if(info.getUserId().equals("admin") || info.getUserNum() == dto.getUserNum()) {
				try {
					service.deleteInquiry(num);
					state="true";
				} catch (Exception e) {
					
				}
			}
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
}
