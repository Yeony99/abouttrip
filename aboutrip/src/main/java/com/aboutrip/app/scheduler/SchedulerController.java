package com.aboutrip.app.scheduler;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@Controller("scheduler.schedulerController")
@RequestMapping("/scheduler/*")
public class SchedulerController {

	@Autowired
	private AboutUtil aboutUtil;
	
	@Autowired
	private SchedulerService service;
	
	@RequestMapping(value = "mycalendar", method=RequestMethod.GET)
	public ModelAndView scheduler(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView(".scheduler.myCalendar");
		if(info.getUserId().equals("")) {
			ModelAndView nl = new ModelAndView(".member.login");
			return nl;
		}
		
		return mav;
	}
	
	@PostMapping("insert")
	@ResponseBody
	public Map<String, Object> insertSubmit(Scheduler dto, HttpSession session){
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int y=0,m=0,d=0;
		String state="true";
		try {
			dto.setUser_num(info.getUserNum());
			y = Integer.parseInt(dto.getCheck_out().substring(0,4));
			m = Integer.parseInt(dto.getCheck_out().substring(5,7));
			d = Integer.parseInt(dto.getCheck_out().substring(8))+1;
			dto.setCheck_out(y+"-"+m+"-"+d);
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
	@ResponseBody
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
	    	dto.setTitle(dto.getSubject());
	    	if( dto.getStart().substring(0,4).compareTo(start.substring(0,4)) != 0 ) {
	    		dto.setStart(start.substring(0,4)+dto.getStart().substring(5));
	    		System.out.println("::::"+dto.getStart());
	    	}	   
		}
		Map<String, Object> model = new HashMap<>();
		
		model.put("list", list);
		return model;
	}
	
	@PostMapping("update")
	@ResponseBody
	public Map<String, Object> updateSubmit(@RequestParam String subject, @RequestParam String color,
			@RequestParam String check_in, @RequestParam String check_out, @RequestParam int num,
			@RequestParam String memo,
			HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		String state="true";
		try {
			map.put("subject", subject);
			map.put("check_in", check_in);
			map.put("check_out", check_out);
			map.put("user_num",info.getUserNum());
			map.put("color", color);
			map.put("num", num);
			map.put("memo", memo);
			service.updateScheduler(map);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	@PostMapping("delete")
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("user_num", info.getUserNum());
			map.put("num", num);
			service.deleteSchedule(map);
		}catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	/*
	 * @RequestMapping(value = "mate", method=RequestMethod.GET) public String
	 * mate(Model model) throws Exception { model.addAttribute("check","true");
	 * return ".scheduler.test"; }
	 */
	@RequestMapping(value = "mate", method = RequestMethod.GET)
	public String mate(
		    @RequestParam(value="page", defaultValue="1") int current_page,HttpSession session,Model model) throws Exception{
		int row =5;
		int dataCount = service.MateCount();
		int total_page = aboutUtil.pageCount(row, dataCount);
		if(current_page>total_page) current_page=total_page;
		
		Map<String, Object> map = new HashMap<>();
		int offset = (current_page-1)* row;
		if(offset<0)offset = 0;
		map.put("offset", offset);
		map.put("rows", row);
		int listNum=0,n=0;
		List<Mate> list = service.listMate(map);
		for(Mate dto :list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			n++;
		}
		
		/*
		 * int listNum, n = 0; 
		 * for(Place dto : list) { 
		 * 		listNum = dataCount - (offset + n); 
		 * 		dto.setListNum(listNum); 
		 * 		n++;
		 * }
		 */
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listNum", listNum);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("check", "true");
		
		return ".scheduler.test";
	}
	@PostMapping("insertMate")
	public String insertMate(Mate dto, HttpSession session, Model model){
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		dto.setUser_num(info.getUserNum());
		String state="true";
		try {
			service.insertMate(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		model.addAttribute("state",state);
		return "redirect:/scheduler/mate";
	}
	
	@RequestMapping(value = "matelist",method = RequestMethod.POST)
	public String matelist(
		    @RequestParam(value="page", defaultValue="1") int current_page,HttpSession session,Model model) throws Exception{
		int row =5;
		int dataCount = service.MateCount();
		int total_page = aboutUtil.pageCount(row, dataCount);
		if(current_page>total_page) current_page=total_page;
		
		Map<String, Object> map = new HashMap<>();
		int offset = (current_page-1)* row;
		if(offset<0)offset = 0;
		map.put("offset", offset);
		map.put("rows", row);
		int listNum=0,n=0;
		List<Mate> list = service.listMate(map);
		for(Mate dto :list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			n++;
		}
		
		/*
		 * int listNum, n = 0; 
		 * for(Place dto : list) { 
		 * 		listNum = dataCount - (offset + n); 
		 * 		dto.setListNum(listNum); 
		 * 		n++;
		 * }
		 */
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listNum", listNum);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		model.addAttribute("check", "true");
		
		return ".scheduler.test";
	}
	
	@PostMapping("deleteMate")
	@ResponseBody
	public Map<String, Object> deleteMate(
			@RequestParam int num,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("user_num", info.getUserNum());
			map.put("num", num);
			service.deleteMate(map);
		}catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state",state);
		
		return model;
	}
	
	@RequestMapping(value = "insertReply")
	public Map<String, Object> insertReply (MateReply dto, HttpSession session) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUser_num(info.getUserNum());
			service.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="deteleReply", method=RequestMethod.POST )
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap){
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		
		return map;
	}
	
	@RequestMapping(value = "listReplyAnswer")
	@ResponseBody
	public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception{
		List<MateReply> listReply = service.listReply(answer);
		for(MateReply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReply",listReply);
		return ".scheduler.mate";
	}
	
	@RequestMapping(value = "countMateAnswer")
	@ResponseBody
	public Map<String, Object> countMateAnswer(@RequestParam int answer) throws Exception{
		int count = service.replyAnswerCount(answer);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count",count);
		return model;
	}
	
	@RequestMapping("review")
	public ModelAndView review() throws Exception {
		ModelAndView mav = new ModelAndView(".scheduler.review");
		return mav;
	}
	
	@RequestMapping(value = "reviewlist")
	public Map<String, Object> reviewlist(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,@RequestParam(defaultValue = "") String keyword) throws Exception{
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		int rows = 10;
		int total_page;
		int dataCount;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		dataCount = service.reviewCount(map);
		total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(total_page< current_page) current_page= total_page;
		int offset = (current_page-1)*rows;
		if(offset<0) offset =0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Review> list = service.listreview(map);
		
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		
		model.put("condition", condition);
		model.put("keyword", keyword);
		
		return model;
	}
	
	@PostMapping("insertReview")
	public Map<String, Object> insertReview(Review dto, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		try {
			dto.setUserNum(info.getUserNum());
			dto.setNickName(info.getNickName());
			service.insertReview(dto, path);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	@GetMapping("articleReview")
	public Map<String, Object> reviewArticle(@RequestParam int num, @RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword= URLDecoder.decode(keyword,"utf-8");
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		Review dto = service.readReview(num);
		if(dto == null) {
			model.put("state", "false");
			return model;
		}
		model.put("state", "true");
		
		if(info.getUserNum()==dto.getUserNum()) {
			model.put("uid", "writer");
		} else if(info.getUserId().equals("admin")) {
			model.put("uid", "true");
		} else {
			model.put("uid", "guest");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		Review preReadDto = service.preReadReview(map);
		Review nextReadDto = service.nextReadReview(map);
		
		model.put("dto", dto);
		model.put("preReadDto", preReadDto);
		model.put("nextReadDto", nextReadDto);
		
		return model;
	}
	
	@PostMapping("updateReview")
	public Map<String, Object> updateReview(Review dto, HttpSession session) throws Exception{
		String root=session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review";
		
		String state = "true";
		try {
			service.updateReview(dto, path);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
	@PostMapping("deleteReview")
	public Map<String, Object> deleteReview(@RequestParam int num, @RequestParam String imageFilename, HttpSession session){
		String root=session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review"+File.separator+imageFilename;
		
		String state= "true";
		try {
			service.deleteReview(num, path);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
}
