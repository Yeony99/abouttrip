package com.aboutrip.app.admin.diaryManage;

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

import com.aboutrip.app.common.AboutUtil;
import com.aboutrip.app.common.FileManager;

@Controller("admin.diaryManage.diaryManageController")
@RequestMapping("/admin/diaryManage/*")
public class DiaryManageController {
	@Autowired
	private DiaryManageService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@Autowired
	private FileManager fm;
	
	@RequestMapping("list")
	public String diaryManage(
			@RequestParam(value="page", defaultValue = "1") int current_page, 
			@RequestParam(defaultValue = "userId") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String diaryType, 
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("diaryType", diaryType);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0)
			total_page = aboutUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<DiaryManage> list = service.listDiaryManage(map);
        
        
        int listNum, n = 0;
        for(DiaryManage dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/admin/diaryManage/list";
        
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = listUrl + "?" + query;
        }
        
		String paging = aboutUtil.pagingMethod(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("diaryType", diaryType);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".admin.diaryManage.list";
	}
	
	@RequestMapping(value="detail")
	public String detailDiary(
			@RequestParam int diaryNum,
			Model model) throws Exception {
		DiaryManage dto = service.readDiaryManage(diaryNum);
		
		model.addAttribute("dto", dto);
		
		return "admin/diaryManage/detail";
	}
	
	@RequestMapping(value="updateDiaryType", method=RequestMethod.POST)
	public String updateDiaryType(DiaryManage dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "diary";

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("diaryNum", dto.getDiaryNum());
			map.put("enable",dto.getDiaryType());
			
			service.updateDiaryType(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/diaryManage/list";
	}
	
	@RequestMapping(value="delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int diaryNum, 
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword, 
			HttpSession session
			) throws Exception {
		
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"diary";
		
		DiaryManage dto = service.readDiaryManage(diaryNum);
		
		if(dto == null) {
			return "redirect:/diaryManage/list?page="+page;
		}
		
		try {
			service.deleteDiary(diaryNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/diaryManage/list?"+query;		
	}
	
	@RequestMapping(value="deleteImg", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteImg(
			@RequestParam int diaryImgNum,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"diary";
		
		DiaryManage dto = service.readDiaryManage(diaryImgNum);
		
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
}
