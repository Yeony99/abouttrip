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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.member.SessionInfo;

@Controller("diary.diaryController")
@RequestMapping("/diary/*")
public class DiaryController {
	@Autowired
	private DiaryService service;
	@Autowired
	private AboutUtil aboutUtil;
	@Autowired
	private FileManager fm;
	/*
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
        String articleUrl = cp+"/diary/article?page="+current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/diary/list?" + query;
        	articleUrl = cp+"/diary/article?page="+current_page+"&"+query;
        }
        
		String paging = aboutUtil.pagingMethod(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("menuIndex", 5);
		
		return ".diary.list";
	}
	*/
	
	
	@RequestMapping("main")
	public ModelAndView main() throws Exception {
		ModelAndView mav = new ModelAndView(".diary.list");
		return mav;
	}
	
	@RequestMapping(value="list")
	@ResponseBody
	public Map<String, Object> list(
		    @RequestParam(value="page", defaultValue="1") int current_page,
		    @RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req
		    ) throws Exception {
		String cp = req.getContextPath();
		
		Map<String, Object> map = new HashMap<String, Object>();
		int rows=5;
		int dataCount=service.dataCount(map);
		int total_page=aboutUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		List<Diary> list=service.listDiary(map);
		
		String query = "";
        String articleUrl = cp+"/diary/article?page="+current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	articleUrl = cp+"/diary/article?page="+current_page+"&"+query;
        }
		
		// 페이징 처리할 경우
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		model.put("articleUrl", articleUrl);
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("page", current_page);
		model.put("paging", paging); // 페이징
		
		model.put("condition", condition);
		model.put("keyword", keyword);
		
		
		return model;
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String createForm(Model model) throws Exception {
		
		model.addAttribute("mode", "create");
		model.addAttribute("menuIndex", 5);
		
		return ".diary.create";
	}
	
	@RequestMapping(value="create", method = RequestMethod.POST)
	public String createSubmit(
			Diary dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "diary";
		
		try {
			dto.setUserNum(info.getUserNum());
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

		dto.setDiaryContent(dto.getDiaryContent().replaceAll("\n","<br>"));
		
		List<Diary> listImg = service.listImg(diaryNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listImg", listImg);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuIndex", 5);
		
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

		if(info.getUserNum() != dto.getUserNum()) {
			return "redirect:/diary/list?page="+page;
		}
		
		List<Diary> listImg = service.listImg(diaryNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listImg", listImg);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("menuIndex", 5);
		
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
	
	@RequestMapping(value="delete", method=RequestMethod.GET)
	public String delete(
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
		
		Diary dto = service.readDiary(diaryNum);
		
		if(dto == null) {
			return "redirect:/diary/list?page="+page;
		}
		
		if(dto.getUserNum() != info.getUserNum()) {
			return "redirect:/";
		}
		
		try {
			service.deleteDiary(diaryNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/diary/list?"+query;		
	}
	
	@RequestMapping(value="deleteImg", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteImg(
			@RequestParam int diaryImgNum,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"diary";
		
		Diary dto = service.readImg(diaryImgNum);
		
		if(dto!=null) {
			fm.doFileDelete(dto.getSaveImgName(), pathname);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "diaryImgNum");
		map.put("diaryNum", diaryImgNum);
		service.deleteImg(map);
		
		Map<String, Object> model = new HashMap<>();
		map.put("state", "true");
		
		return model;
	}
	
	// 게시글 좋아요 추가 :  : AJAX-JSON
		@RequestMapping(value="insertDiaryLike", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertDiaryLike(
				@RequestParam int diaryNum,
				HttpSession session
				) {
			String state="true";
			int diaryLikeCount=0;
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			Map<String, Object> paramMap=new HashMap<>();
			paramMap.put("diaryNum", diaryNum);
			paramMap.put("userNum", info.getUserNum());
			
			try {
				service.insertDiaryLike(paramMap);
			} catch (Exception e) {
				state="false";
			}
				
			diaryLikeCount = service.diaryLikeCount(diaryNum);
			
			Map<String, Object> model=new HashMap<>();
			model.put("state", state);
			model.put("diaryLikeCount", diaryLikeCount);
			
			return model;
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