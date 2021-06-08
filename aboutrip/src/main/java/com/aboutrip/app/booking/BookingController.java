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

@Controller("booking.bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	@Autowired
	BookingService service;
	
	@RequestMapping(value="event", method=RequestMethod.GET)
	public String event(HttpServletRequest req, Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		// 패키지
		map.put("category_num", "4");
		List<Booking> package_list = service.listEvent(map);		
		int package_count = service.countEvent(map);

		// 티켓
		map.replace("category_num", "5");
		List<Booking> ticket_list= service.listEvent(map);		
		int ticket_count = service.countEvent(map);

		// 모바일
		map.replace("category_num", "6");
		List<Booking> mobile_list = service.listEvent(map);		
		int mobile_count = service.countEvent(map);
		
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
}
