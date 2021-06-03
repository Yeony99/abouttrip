package com.aboutrip.app.booking;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("booking.bookingController")
@RequestMapping("/booking/*")
public class BookingController {

	@RequestMapping(value="event", method=RequestMethod.GET)
	public String event() throws Exception{
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
