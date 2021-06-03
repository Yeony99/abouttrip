package com.aboutrip.app.scheduler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("scheduler.schedulerController")
@RequestMapping("/schedule/*")
public class SchedulerController {

	@RequestMapping(value = "scheduler", method=RequestMethod.GET)
	public String schduler() throws Exception {
		
		return ".scheduler.main";
	}
}
