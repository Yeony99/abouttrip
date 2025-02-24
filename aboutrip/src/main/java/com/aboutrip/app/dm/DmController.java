package com.aboutrip.app.dm;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@Controller("dm.dmController")
@RequestMapping("/dm/*")
public class DmController {
	@Autowired
	private DmService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping(value="{menuItem}/list")
	public String listDm(
			@PathVariable String menuItem,
			@RequestParam(value="page", defaultValue = "1")int current_page,
			@RequestParam(defaultValue = "") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
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
		
		if(menuItem.equals("receive")) {
			dataCount = service.dataCountReceive(map);
		} else {
			dataCount = service.dataCountSend(map);
		}
		
		total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Dm> list = null;
        if(menuItem.equals("receive")) {
        	list = service.listReceive(map);
        } else {
        	list = service.listSend(map);
        }
        
        String cp = req.getContextPath();
        String query = "";
        String listUrl = cp+"/dm/"+menuItem+"/list";
        String articleUrl = cp+"/dm/"+menuItem+"/article?page="+current_page;
        if(keyword.length() != 0) {
        	query = "condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
        }
        if(query.length() != 0) {
        	listUrl = cp+"/dm/"+menuItem+"/list?"+query;
        	articleUrl = cp+"/dm/"+menuItem+"/article?page="+current_page+"&"+query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);
        
        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("page", current_page);
        model.addAttribute("paging", paging);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        model.addAttribute("menuItem", menuItem);
        
        model.addAttribute("menuIndex", 5);
		
		return ".dm.list";
	}
	
	// 쪽지 보내기 폼
	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		model.addAttribute("menuIndex", 5);
		return ".dm.write";
	}
	
	// 쪽지 보내기
	@PostMapping("write")
	public String writeSubmit(
			Dm dto,
			HttpSession session) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
			
		try {
			dto.setSenderNum(info.getUserNum());
			service.insertDm(dto);
		}catch(Exception e) {

		}
		return "redirect:/dm/send/list";
	}
	
	// 친구 리스트
	@GetMapping(value="listFriend")
	@ResponseBody
	public Map<String, Object> listFriend(
			@RequestParam String condition,
			@RequestParam String keyword) throws Exception {
			
		keyword = URLDecoder.decode(keyword, "UTF-8");
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		List<Dm> list=service.listFriend(map);
			
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listFriend", list);
		return model;
	}
	
	@RequestMapping(value="{menuItem}/article")
	public String article(
			@PathVariable String menuItem,
			@RequestParam int dmNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userNum", info.getUserNum());
		map.put("dmNum", dmNum);
		
		Dm dto = null;
		Dm preDto = null;
		Dm nextDto = null;
		if(menuItem.equals("send")) {
			dto = service.readSend(dmNum);
			preDto=service.preReadSend(map);
			nextDto=service.nextReadSend(map);
		} else {
			service.updateIdentifyDay(dmNum);;
			dto = service.readReceive(dmNum);
			preDto = service.preReadReceive(map);
			nextDto = service.nextReadReceive(map);
		}
		
		if(dto == null) {
			return "redirect:/dm/"+menuItem+"/list?"+query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("preDto", preDto);
		model.addAttribute("nextDto", nextDto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuItem", menuItem);
		
		model.addAttribute("menuIndex", 5);
		
		return ".dm.article";
	}
	
	@RequestMapping(value="{menuItem}/delete")
	public String delete(
			@PathVariable String menuItem,
			@RequestParam List<Integer> dmNums,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model,
			HttpSession session
			) throws Exception {
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		if(menuItem.equals("receive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		
		map.put("dmNumList", dmNums);
		
		try {
			service.deleteDm(map);
		} catch (Exception e) {
		}

		return "redirect:/dm/"+menuItem+"/list?"+query;
	}
	
}
