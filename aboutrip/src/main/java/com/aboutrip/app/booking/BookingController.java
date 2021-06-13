package com.aboutrip.app.booking;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aboutrip.app.common.AboutUtil;

@Controller("booking.bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	@Autowired
	BookingService service;
	
	@Autowired
	AboutUtil aboutUtil;
	
	@RequestMapping(value="event", method=RequestMethod.GET)
	public String event(HttpServletRequest req, Model model) throws Exception{
		
		// 패키지
		List<Booking> package_list = service.listEvent(4);		
		int package_count = service.countEvent(4);

		// 티켓
		List<Booking> ticket_list= service.listEvent(5);		
		int ticket_count = service.countEvent(5);

		// 모바일
		List<Booking> mobile_list = service.listEvent(6);		
		int mobile_count = service.countEvent(6);
		
		model.addAttribute("package_list", package_list);
		model.addAttribute("ticket_list", ticket_list);
		model.addAttribute("mobile_list", mobile_list);
		model.addAttribute("package_count", package_count);
		model.addAttribute("ticket_count", ticket_count);
		model.addAttribute("mobile_count", mobile_count);
		
		return ".booking.event";
	}
	
	
	@RequestMapping(value="best", method=RequestMethod.GET)
	public String best() throws Exception{
		
		return ".booking.best";
	}
	
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String list() throws Exception{
		
		return ".booking.list";
	}
	
	@RequestMapping(value="article", method=RequestMethod.GET)
	public String article(@RequestParam int code,
			@RequestParam(value = "revNo", defaultValue = "1") int current_page,
			Model model) throws Exception{
		Booking dto = service.readBooking(code);
		model.addAttribute("dto", dto);
		
		
		
		// rev 리스트
		int rev_count = service.countReview(code);
		
		int rows=10;
		int total_page;

		total_page = aboutUtil.pageCount(rows, rev_count);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page - 1) * rows;
		if(offset<0) offset=0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("offset", offset);
		map.put("rows", rows);

		List<Order> rev_list = service.listReview(map);
		String paging = aboutUtil.pagingMethod(current_page, total_page, "revNo");
		
		model.addAttribute("list", rev_list);
		model.addAttribute("dataCount", rev_count);
		model.addAttribute("revNo", current_page);
		model.addAttribute("totalPage", total_page);
		model.addAttribute("paging", paging);
		
		return ".booking.article";
	}	
	
	@RequestMapping("qna")
	@ResponseBody
	public Map<String, Object> qnalist(
			@RequestParam int code,
			@RequestParam(value = "qnaNo", defaultValue = "1") int current_page
			) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("from", "product_qna");
		
		// qna 리스트
		int qna_count = service.countProduct(map);
		
		int rows=10;
		int total_page;

		total_page = aboutUtil.pageCount(rows, qna_count);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page - 1) * rows;
		if(offset<0) offset=0;
		
		map.put("offset", offset);
		map.put("rows", rows);

		List<QnA> qna_list = service.listQna(map);
		String paging = aboutUtil.pagingMethod(current_page, total_page, "qnaNo");
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("list", qna_list);
		model.put("dataCount", qna_count);
		model.put("qnaNo", current_page);
		model.put("totalPage", total_page);
		model.put("paging", paging);
		
		return model;
	}
	
}
