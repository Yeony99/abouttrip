package com.aboutrip.app.scheduler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("scheduler.schedulerController")
@RequestMapping("/scheduler/*")
public class SchedulerController {

	@RequestMapping(value = "main", method=RequestMethod.GET)
	public String main() throws Exception {
		
		return ".scheduler.main";
	}
}
