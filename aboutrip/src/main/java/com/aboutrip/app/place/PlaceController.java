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
import com.aboutrip.app.member.Member;
import com.aboutrip.app.member.MemberService;
import com.aboutrip.app.member.SessionInfo;

@Controller("place.placeController")
@RequestMapping("/place/*")
public class PlaceController {
	
	@Autowired
	private PlaceService service;
	
	@Autowired
	private MemberService mservice;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping("list")
	public String placelist(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue = "0") int ctg,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
   	    String pick = "list";
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
		int mdPick = 0;
		if(req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("mdPick", mdPick);
        map.put("ctg", ctg);
        
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
        map.put("ctgNum", ctg);

        List<Place> list = service.listPlace(map);

        int listNum, n = 0;
        for(Place dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
            
        }
        List<Place> currentList = service.currentList(map);
        String query = "";
        String listUrl = cp+"/place/list?mdPick="+mdPick;
        String articleUrl = cp+"/place/listArticle?mdPick="+mdPick+"&page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/place/list?" + query;
        	articleUrl = cp+"/place/listArticle?page=" + current_page + "&"+ query;
        }
        String paging = aboutUtil.paging(current_page, total_page, listUrl);
        model.addAttribute("clist", currentList);
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("mdPick",mdPick);
		model.addAttribute("pick",pick);
		model.addAttribute("ctg",ctg);
		return ".place.list";
	}
	
	@RequestMapping("mdPick")
	public String mdPick(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue = "0") int ctg,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
   	    String pick = "mdPick";
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
		int mdPick = 1;
		if(req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("mdPick", 1);
        map.put("ctg", ctg);
        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = aboutUtil.pageCount(rows, dataCount);

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        map.put("mdPick", mdPick);
        map.put("ctgNum", ctg);
        List<Place> list = service.listPlace(map);

        int listNum, n = 0;
        for(Place dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        List<Place> currentList = service.currentList(map);
        String query = "";
        String listUrl = cp+"/place/list?mdPick="+mdPick;
        String articleUrl = cp+"/place/listArticle?mdPick="+mdPick+"&page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/place/list?" + query;
        	articleUrl =  cp+"/place/listArticle?mdPick="+mdPick+"&page=" + current_page + "&"+ query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);
        model.addAttribute("clist", currentList);
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("mdPick",mdPick);
		model.addAttribute("pick",pick);
		model.addAttribute("ctg",ctg);
		return ".place.list";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) throws Exception{
		model.addAttribute("pick","list");
		model.addAttribute("mode","create");
		return ".place.create";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createSubmit(Place dto, HttpSession session,@RequestParam String pick,Model model) throws Exception{
		
		try {
			String root= session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"place";
			service.insertPlace(dto,pathname);
			model.addAttribute("pick",pick);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(pick.equals("list")) {
			return "redirect:/place/list";
		}
		else {
			return "redirect:/place/mdPick";
		}
	}
	
	@RequestMapping(value = "createMd", method = RequestMethod.GET)
	public String createMdForm(Model model) throws Exception{
        model.addAttribute("pick","mdPick");
        model.addAttribute("mode","create");
		return ".place.create";
	}
	
	@RequestMapping(value="listArticle")
	public String listArticle(
			@RequestParam int placeNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam String pick,
			HttpSession session,
			Model model) throws Exception {
		int mdPick;
		if(pick.equals("list")) {
			mdPick=0;
		} else {
			mdPick=1;
		}
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(placeNum);

		Place dto = service.readPlace(placeNum);
		if(dto==null)
			return "redirect:/place/"+pick+"?"+query;
        dto.setPlaceContent(aboutUtil.htmlSymbols(dto.getPlaceContent()));
        
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("placeNum", placeNum);
		map.put("mdPick", mdPick);

		Place preReadDto = service.preReadPlace(map);
		Place nextReadDto = service.nextReadPlace(map);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("mdPick",dto.getMdPick());
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("pick",pick);

        return ".place.article";
	}
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int placeNum,
			@RequestParam String page,
			@RequestParam String pick,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member mdto = mservice.readMember(info.getUserId());
		Place dto = service.readPlace(placeNum);
		if(dto==null&&mdto==null) {
			return "redirect:/place/list?page="+page;
		}

		if(! info.getUserId().equals(mdto.getUserId())) {
			return "redirect:/place/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("pick",pick);
		
		return ".place.create";
	}
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Place dto, 
			@RequestParam String page,
			@RequestParam String pick,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"place";		

		try {
			service.updatePlace(dto, pathname);		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/place/"+pick+"?page="+page;
	}
	@RequestMapping("delete")
	public String deletePlace(@RequestParam int placeNum, 
			@RequestParam String page,
			@RequestParam String pick,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"place";
		
		service.deletePlace(placeNum, pathname);
		
		
		return"redirect:/place/"+pick+"?"+query;
	}
}