package com.aboutrip.app.diary;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.member.SessionInfo;

@RestController("diary.diaryController")
@RequestMapping("/diary/*")
public class DiaryController {
	@Autowired
	private DiaryService service;

	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping("main")
	public ModelAndView main() throws Exception {
		return new ModelAndView(".diary.main");
	}
	
	@RequestMapping("list")
	public Map<String, Object> list(
			@RequestParam(value="pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String hashTag
			) throws Exception {
		
		int rows = 8;
		int total_page;
		int dataCount;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("hashTag", hashTag);
		
		dataCount = service.dataCount(map);
		total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page - 1) * rows;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Diary> list = service.listDiary(map);
		String paging = aboutUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("total_page", total_page);
		model.put("paging", paging);
		
		return model;
	}
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
}
