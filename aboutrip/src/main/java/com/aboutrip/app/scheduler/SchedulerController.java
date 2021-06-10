package com.aboutrip.app.scheduler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("scheduler.schedulerController")
@RequestMapping("/scheduler/*")
public class SchedulerController {

	@RequestMapping(value = "mycalendar", method=RequestMethod.GET)
	public String scheduler() throws Exception {
		
		return ".scheduler.myCalendar";
	}
	
	@RequestMapping(value = "share", method=RequestMethod.GET)
	public String share() throws Exception {
		
		return ".scheduler.share";
	}
	
	@RequestMapping(value = "mate", method=RequestMethod.GET)
	public String mate() throws Exception {
		
		return ".scheduler.mate";
	}
	
	@RequestMapping(value = "review", method=RequestMethod.GET)
	public String review() throws Exception {
		
		return ".scheduler.review";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createdForm() throws Exception {
		
		return ".scheduler.create";
	}

}
