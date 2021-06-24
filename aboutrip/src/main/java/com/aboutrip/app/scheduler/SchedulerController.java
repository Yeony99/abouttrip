package com.aboutrip.app.scheduler;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	
	@RequestMapping(value = "share", method=RequestMethod.GET)
	public String share(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page=0;
		int dataCount =0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		 Map<String, Object> map = new HashMap<String, Object>();
	     map.put("condition", condition);
	     map.put("keyword", keyword);
	     
	     dataCount = service.shareCount(map);
	     if(dataCount != 0) total_page = aboutUtil.pageCount(rows, dataCount);
	     
	     if(total_page<current_page) current_page = total_page;
	     
	     int offset = (current_page-1)*rows;
	     if(offset<0) offset = 0;
	     map.put("offset", offset);
	     map.put("rows", rows);
	     
	     List<Share> list = service.sharelist(map);
	     
	     int listNum=0, n=0;
	     for(Share dto : list) {
	    	 listNum = dataCount -(offset+n);
	    	 dto.setListNum(listNum);
	    	 n++;
	     }
	     String query ="";
	     String listUrl = cp+"/scheduler/share";
	     String articleUrl = cp+"/scheduler/shareArticle?page="+current_page;
	     if(keyword.length()!=0) {
	        	query = "condition=" +condition + 
	        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
	        }
	     
	     if(query.length()!=0) {
	        	listUrl = cp+"/scheduler/share?" + query;
	        	articleUrl = cp+"/scheduler/shareArticle?page=" + current_page + "&"+ query;
	        }
	     String paging = aboutUtil.paging(current_page, total_page, listUrl);
	     model.addAttribute("list",list);
	     model.addAttribute("articleUrl", articleUrl);
	     model.addAttribute("page", current_page);
	     model.addAttribute("dataCount", dataCount);
	     model.addAttribute("total_page", total_page);
	     model.addAttribute("paging", paging);
	        
		 model.addAttribute("condition", condition);
		 model.addAttribute("keyword", keyword);
			
	     
		return ".scheduler.share";
	}
	
	@RequestMapping(value="create")
	public String createdForm() throws Exception {
		
		return ".scheduler.create";
	}
	
	@RequestMapping(value = "findshare")
	public String findshare(@RequestParam String search,HttpSession session,@RequestParam String color,Model model) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("user_num", info.getUserNum());
		map.put("color", color);
		Scheduler dto = service.readScheduler(map);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "created");
		if(dto==null) {
			return"redirect:/scheduler/create";
		} else {
			return ".scheduler.create";
		}
		
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(Share dto, HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"share";
		try {
			dto.setUserNum(info.getUserNum());
			service.insertShare(dto,pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/scheduler/share";
	}
	
	@RequestMapping(value = "shareArticle")
	public String shareArticle(@RequestParam int num, @RequestParam String page, @RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword, @RequestParam String search , 
			Model model) throws Exception{
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		service.shareHitCount(num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("search", search);
		Share dto = service.readShare(map);
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		Share preReadDto = service.preReadShare(map);
		Share nextReadDto = service.nextReadShare(map);
        switch(dto.getColor()) {
        case "green" : dto.setScheduler_color("개인일정"); break;
        case "blue" : dto.setScheduler_color("가족일정"); break;
        case "tomato" : dto.setScheduler_color("회사일정"); break;
        case "purple" : dto.setScheduler_color("기타일정"); break;
        }
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return".scheduler.article";
	}
	
	@RequestMapping(value = "updateShare", method = RequestMethod.GET)
	public String updateShareForm(@RequestParam int num, @RequestParam String page, HttpSession session, 
			@RequestParam String search,Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("search", search);
		Share dto = service.readShare(map);
		if(dto== null) {
			return "redirect:/scheduler/share?page="+page;
		}
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		
		return ".scheduler.article";
	}
	
	@RequestMapping(value = "updateShare", method = RequestMethod.POST)
	public String updateShareSubmit(Share dto, @RequestParam String page, HttpSession session) throws Exception{
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"share";	
		try {
			service.updateShare(dto,pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return"redirect:/scheduler/article?page="+page;
	}
	
	@RequestMapping(value = "delete")
	public String deleteShare(@RequestParam int num, @RequestParam String page, @RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword, HttpSession session) throws Exception{
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.deleteShare(num);
		
		return"redirect:/scheduler/share?"+query;
	}
	
	
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
		int listNum=0,n=0,answer=0;
		List<Mate> list = service.listMate(map);
		for(Mate dto :list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			n++;
			map.put("mate_num", dto.getNum());
			answer = service.replyCount(map);
			map.put("answer", answer);
			service.updateCountreply(map);
			dto.setAnswer(answer);
		}
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
		int listNum=0,n=0,answer=0;
		List<Mate> list = service.listMate(map);
		for(Mate dto :list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			n++;
			map.put("mate_num", dto.getNum());
			answer = service.replyCount(map);
			map.put("answer", answer);
			service.updateCountreply(map);
			dto.setAnswer(answer);
		}
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
			@RequestParam int num, @RequestParam String nickName,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map=new HashMap<>();
			if(nickName.equals("관리자")) {
				map.put("num", num);
				map.put("mate_num", num);
				service.deleteMateAdmin(map);
			} else {
				map.put("user_num", info.getUserNum());
				map.put("num", num);
				service.deleteMate(map);
			}
		}catch (Exception e) {
			state="false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state",state);
		
		return model;
	}
	
	@RequestMapping(value = "insertReply")
	public String insertReply (MateReply dto, HttpSession session, @RequestParam int mate_num, @RequestParam int reply_answer, @RequestParam String content) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setMate_num(mate_num);
			dto.setReply_answer(reply_answer);
			dto.setContent(content);
			dto.setUser_num(info.getUserNum());
			service.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/scheduler/mate";
	}
	
	@RequestMapping(value = "listReply")
	@ResponseBody
	public Map<String, Object> listReply(@RequestParam int mate_num,@RequestParam(value = "page", defaultValue = "1") int current_page) throws Exception{
		int rows=10;
		int total_page=0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mate_num", mate_num);
		
		dataCount = service.replyCount(map);
		total_page = aboutUtil.pageCount(rows, dataCount);
		if(current_page>total_page) current_page= total_page;
		
		int offset = (current_page-1)*rows;
		if(offset<0)offset=0;
		map.put("mate_num", mate_num);
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<MateReply> listReply = service.listReply(map);
		for(MateReply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		
		
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listReply",listReply);
		model.put("pageNo", current_page);
		model.put("replyCount", dataCount);
		model.put("total_page",total_page);
		model.put("paging",paging);
		
		return model;
	}
	
	@RequestMapping(value = "updateReply")
	public String updateReply (@RequestParam int mate_num, @RequestParam int reply_num, @RequestParam String content) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("mate_num", mate_num);
			map.put("reply_num", reply_num);
			map.put("content", content);
			service.updateReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/scheduler/mate";
	}
	
	@RequestMapping(value="deleteReply", method=RequestMethod.POST )
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam int reply_num,@RequestParam int mate_num){
		String state="true";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reply_num", reply_num);
		map.put("mate_num", mate_num);
		try {
			service.deleteReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("state", state);
		
		return map;
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
	@ResponseBody
	public Map<String, Object> reviewlist(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,@RequestParam(defaultValue = "") String keyword,HttpSession session) throws Exception{
		keyword = URLDecoder.decode(keyword,"utf-8");
		String root = session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review";
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
		for(Review dto : list) {
			dto.setSrc(path+dto.getImageFileName());
		}
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
	@ResponseBody
	public Map<String, Object> insertReview(Review dto, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "true";
		try {
			dto.setUser_num(info.getUserNum());
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
	@ResponseBody
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
		
		if(info.getUserNum()==dto.getUser_num()) {
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
		
		model.put("dto", dto);
		
		return model;
	}
	
	@PostMapping("updateReview")
	@ResponseBody
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
	@ResponseBody
	public Map<String, Object> deleteReview(@RequestParam int num, @RequestParam String imageFileName, HttpSession session){
		String root=session.getServletContext().getRealPath("/");
		String path = root+"uploads"+File.separator+"Review"+File.separator+imageFileName;
		
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
	
	@RequestMapping(value = "insertReviewReply")
	@ResponseBody
	public Map<String, Object> insertReviewReply(ReviewReply dto, HttpSession session, @RequestParam int rev_num, @RequestParam String ReplyContent)throws Exception{
		Map<String, Object> model = new HashMap<String, Object>();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setRev_num(rev_num);
			dto.setContent(ReplyContent);
			dto.setUser_num(info.getUserNum());
			service.insertReviewReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "listReviewReply")
	@ResponseBody
	public Map<String, Object> listReviewReply(ReviewReply dto , @RequestParam(value = "pageNo", defaultValue = "1") int current_page,HttpSession session,@RequestParam int rev_num)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page;
		int dataCount;
		
		Map<String, Object> map = new HashMap<String, Object>();
		dataCount = service.reviewReplyCount(rev_num);
		total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(total_page< current_page) current_page= total_page;
		int offset = (current_page-1)*rows;
		if(offset<0) offset =0;
		map.put("offset", offset);
		map.put("rows", rows);
		map.put("rev_num", rev_num);
		List<ReviewReply> list = service.listreviewReply(map);
		
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<String, Object>();
		if(info.getUserNum()==dto.getUser_num()) {
			model.put("uid", "writer");
		} else if(info.getUserId().equals("admin")) {
			model.put("uid", "true");
		} else {
			model.put("uid", "guest");
		}
		
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		
		return model;
	}
	
	
	@RequestMapping(value = "updateReviewReply")
	@ResponseBody
	public ModelAndView updateReviewReply (@RequestParam int num, @RequestParam String content,@RequestParam int rev_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("num", num);
			map.put("content", content);
			service.updateReviewReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView(".scheduler.review");
		return mav;
	}
	
	@RequestMapping(value = "deleteReviewReply")
	@ResponseBody
	public Map<String, Object> deleteReviewReply (@RequestParam int num) {
		Map<String, Object> model = new HashMap<String, Object>();
		try {
			service.deleteReviewReply(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
}