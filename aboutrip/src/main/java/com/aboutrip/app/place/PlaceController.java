package com.aboutrip.app.place;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aboutrip.app.common.AboutUtil;

@Controller("place.placeController")
@RequestMapping("/place/*")
public class PlaceController {
	
	@Autowired
	private PlaceService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping("list")
	public String placelist(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
   	    
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("mdPick", 0);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = aboutUtil.pageCount(rows, dataCount);

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        map.put("mdPick", 0);

        // 글 리스트
        List<Place> list = service.listPlace(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Place dto : list) {
            listNum = dataCount - (offset + n);
            dto.setPlaceNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/place/list";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/place/list?" + query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".place.list";
	}
	
	@RequestMapping("mdPick")
	public String mdPick(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
   	    
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("mdPick", 1);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = aboutUtil.pageCount(rows, dataCount);

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        map.put("mdPick", 1);

        // 글 리스트
        List<Place> list = service.listPlace(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Place dto : list) {
            listNum = dataCount - (offset + n);
            dto.setPlaceNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/place/list";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/place/list?" + query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".place.mdPick";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) throws Exception{
		model.addAttribute("pick","list");
		model.addAttribute("mode","create");
		return ".place.create";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createSubmit(Place dto, HttpSession session) throws Exception{
		
		try {
			String root= session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"place";
			dto.setMdPick(0);
			service.insertPlace(dto,pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/place/list";
	}
	
	@RequestMapping(value = "createMd", method = RequestMethod.GET)
	public String createMdForm(Model model) throws Exception{
        model.addAttribute("pick","mdPick");
        model.addAttribute("mode","create");
		return ".place.create";
	}
	
	@RequestMapping(value = "createMd", method = RequestMethod.POST)
	public String createMdSubmit() throws Exception{
		return "redirect:/place/mdPick";
	}
	
	
	
	
}