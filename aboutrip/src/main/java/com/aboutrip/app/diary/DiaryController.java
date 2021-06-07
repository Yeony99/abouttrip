package com.aboutrip.app.diary;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.member.SessionInfo;

@RestController("diary.diaryController")
@RequestMapping("/diary/*")
public class DiaryController {
	@Autowired
	private DiaryService service;
	@Autowired
	private AboutUtil aboutUtil;
	@Autowired
	private FileManager fm;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 8;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = aboutUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page - 1) * rows;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Diary> list = service.listDiary(map);
		
		int listNum, n = 0;
        for(Diary dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/diary/list";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/diary/list?" + query;
        }
        
		String paging = aboutUtil.pagingMethod(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".diary.list";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode", "create");
		return ".diary.create";
	}
	
	@RequestMapping(value="/diary/create", method = RequestMethod.POST)
	public String createdSubmit(
			Diary dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "diary";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertDiary(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/diary/list";
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam int diaryNum, 
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if(keyword.length() != 0 ) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		Diary dto = service.readDiary(diaryNum);
		if(dto == null)
			return "redirect:/diary/list?"+query;
		
		dto.setDiaryContent(aboutUtil.htmlSymbols(dto.getDiaryContent()));
		
		return ".diary.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int diaryNum,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Diary dto = service.readDiary(diaryNum);
		if(dto==null) {
			return "redirect:/diary/list?page="+page;
		}

		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/diary/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".diary.create";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Diary dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"diary";		

		try {
			service.updateDiary(dto, pathname);		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/diary/list?page="+page;
	}
	
	@RequestMapping(value="deleteFile")
	public String deleteFile(
			@RequestParam int diaryNum,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"diary";
		
		Diary dto = service.readDiary(diaryNum);
		
		if(dto == null) {
			return "redirect:/diary/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/diary/list?page="+page;
		}
		
		try {
			if(dto.getSaveFilename() != null) {
				fm.doFileDelete(dto.getSaveFilename(), pathname);
				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				service.updateDiary(dto, pathname);
			}
		} catch (Exception e) {
		}
		
		return "redirect:/diary/update?num="+diaryNum+"&page="+page;
	}
	
	@PostMapping(value="delete")
	public String deleteSubmit(
			@RequestParam int diaryNum, 
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword, 
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"diary";
		
		service.deleteDiary(diaryNum, pathname, info.getUserId());
		
		return "redirect:/diary/list?"+query;		
	}
	
	/*
	// 세션에 있는게 userNum인지 UserId인지 다시 확인하고 수정하기
		@PostMapping("insert")
		public Map<String, Object> insertSubmit(
				Diary dto,
				HttpSession session
				) throws Exception {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setUserNum(info.getUserNum());
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"diary";
			
			String state = "true";
			try {
				service.insertDiary(dto, pathname);
			} catch (Exception e) {
				state = "false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			return model;
		}
		
		@GetMapping("article")
		public Map<String, Object> article(
				@RequestParam int diaryNum, 
				@RequestParam(defaultValue = "all") String condition, 
				@RequestParam(defaultValue = "") String hashTag,
				HttpSession session
				) throws Exception {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			hashTag = URLDecoder.decode(hashTag, "utf-8");
			
			Map<String, Object> model = new HashMap<>();
			
			Diary dto = service.readDiary(diaryNum);
			if(dto == null) {
				model.put("state", "false");
				return model;
			}
			model.put("state", "true");
			
			if(info.getUserId().equals(dto.getUserId())) {
				model.put("uid", "writer");
			} else if(info.getUserId().equals("admin")) {
				model.put("uid", "true");
			} else {
				model.put("uid", "guest");
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("condition", condition);
			map.put("hashTag", hashTag);
			map.put("diaryNum", diaryNum);
			model.put("dto", dto);
			
			return model;
		}
		@PostMapping("update")
		public Map<String, Object> updateSubmit(
				Diary dto,
				HttpSession session
				) throws Exception {
			
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"diary";
			
			String state = "true";
			try {
				service.updateDiary(dto, pathname);
			} catch (Exception e) {
				state = "false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			return model;
		}
		*/
}
