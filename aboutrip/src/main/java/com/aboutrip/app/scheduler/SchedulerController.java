package com.aboutrip.app.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.aboutrip.app.member.SessionInfo;

@RestController("scheduler.schedulerController")
@RequestMapping("/scheduler/*")
public class SchedulerController {

	@Autowired
	private SchedulerService service;
	
	@RequestMapping(value = "mycalendar", method=RequestMethod.GET)
	public ModelAndView scheduler() throws Exception {
		ModelAndView mav = new ModelAndView(".scheduler.myCalendar");
		return mav;
	}
	
	@PostMapping("insert")
	public Map<String, Object> insertSubmit(Scheduler dto, HttpSession session){
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUser_num(info.getUserNum());
			service.insertSchedule(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "month")
	public Map<String, Object> month(@RequestParam String start, @RequestParam String end, HttpSession session ) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String,Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("user_num", info.getUserNum());
		
		List<Scheduler> list = service.listMonth(map);
		for(Scheduler dto:list) {
	    	dto.setStart(dto.getCheck_in());
	    	dto.setEnd(dto.getCheck_out());
	    	if( dto.getStart().substring(0,4).compareTo(start.substring(0,4)) != 0 ) {
	    		dto.setStart(start.substring(0,4)+dto.getStart().substring(5));
	    		System.out.println("::::"+dto.getStart());
	    	}	    	
		}
		Map<String, Object> model = new HashMap<>();
		
		model.put("list", list);
		return model;
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
