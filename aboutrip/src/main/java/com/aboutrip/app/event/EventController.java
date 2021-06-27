package com.aboutrip.app.event;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@Controller("event.eventController")
@RequestMapping("/event/*")
public class EventController {
	
	@Autowired
	private EventService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	//이벤트 참여 리스트
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String cp= req.getContextPath();
		
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("userNum", info.getUserNum());
        
        dataCount = service.dataCount(map);
        if(dataCount != 0) total_page = aboutUtil.pageCount(rows, dataCount);
        
        if(total_page < current_page) 
            current_page = total_page;
        
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Event> list = service.listEvent(map);
        
        int listNum, n = 0;
        for(Event dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
		
        String query = "";
        String listUrl = cp+"/event/list";
        String articleUrl = cp+"/event/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/event/list?" + query;
        	articleUrl = cp+"/event/article?page=" + current_page + "&"+ query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".event.list";
	}
	
	// 이벤트 참여 글 작성
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception{
		model.addAttribute("mode", "created");
		return ".event.created";
	}
	
	// 이벤트 참여 글 작성
	@RequestMapping(value="/event/created", method=RequestMethod.POST)
	public String createdSubmit(
			Event dto,
			HttpSession session
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setAdminNum(info.getUserNum());
			service.insertEvent(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/event/list";
	}
	
	//이벤트 글 보기
	@RequestMapping(value="article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model
			) throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Event dto = service.readEvent(num);
		
		if(dto==null) {
			return "redirect:/event/list?"+query;	
		}
		
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

        Event preReadDto = service.preReadEvent(map);
        Event nextReadDto = service.nextReadEvent(map);
        List<Event> listPart = service.listPart(map);
        List<Event> listWin = service.listWin(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("listPart", listPart);
		model.addAttribute("listWin", listWin);
		
		return ".event.article";
	}
	
	// 이벤트 페이지 업데이트
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		
		if(!info.getUserId().equals("admin")) {
			return "redirect:/event/list?"+page;
		}
		
		Event dto = service.readEvent(num);
		if(dto==null) {
			return "redirect:/event/list?page="+page;	
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".event.created";
	}
	
	// 이벤트 페이지 업데이트 
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Event dto,
			@RequestParam String page
			) throws Exception {
		
		try {
			service.updateEvent(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/event/list?page="+page;
	}
	
	// 이벤트 글 삭제
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.deleteEvent(num, info.getUserNum());
		
		return "redirect:/event/list?"+query;
	}
	
	
	
	//이벤트 참여 신청
	@RequestMapping(value="partEvent", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> partEvent(
			@RequestParam int num,
			HttpSession session
			){
		String state="true";
		int partCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userNum", info.getUserNum());
		
		try {
			service.partEvent(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		partCount = service.partCount(num);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("partCount", partCount);
		return model;
	}
	
	//이벤트 참여 취소
	@RequestMapping(value="deletePart", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deletePart(
			@RequestParam int num,
			HttpSession session
			){
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		try {
			
			service.deletePart(num, info.getUserNum());
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	//이벤트 당첨자 추출, 난수발생 
	@RequestMapping(value="winEvent", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> winEvent(
			@RequestParam int num,
			HttpSession session
			){
		String state="true";
		
		try {
			Event dto = service.readEvent(num);
			Map<String, Object> map = new HashMap<>();
			
			map.put("num", num);
			map.put("winCount",dto.getWinCount());
			
			service.winEvent(dto);
			
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	

	
}
