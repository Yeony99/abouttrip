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
		
		return "redirect:/diary/main";
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
			return "redirect:/diary/main?"+query;

		dto.setDiaryContent(dto.getDiaryContent().replaceAll("\n","<br>"));
		int followingUser = dto.getUserNum();
		List<Diary> listImg = service.listImg(diaryNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("followingUser", followingUser);
		map.put("followerUser", info.getUserNum());
		map.put("userNum", info.getUserNum());
		map.put("diaryNum", diaryNum);
		boolean b = service.isDiaryLikeUser(map);
		boolean fol = service.isFollow(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listImg", listImg);
		model.addAttribute("isDiaryLikeUser", b);
		model.addAttribute("isFollow", fol);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
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
		
		return "redirect:/diary/article?diaryNum="+dto.getDiaryNum()+"&page="+page;
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
			return "redirect:/diary/main?page="+page;
		}
		
		if(dto.getUserNum() != info.getUserNum()) {
			return "redirect:/";
		}
		
		try {
			service.deleteDiary(diaryNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/diary/main?"+query;		
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
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("diaryNum", diaryNum);
		paramMap.put("userNum", info.getUserNum());
		
		// 좋아요 추가
		String state="true";
		try {
			service.insertDiaryLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		// 좋아요 개수 가져오기
		int diaryLikeCount = service.diaryLikeCount(diaryNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("diaryLikeCount", diaryLikeCount);
		return model;
	}
	
	// 좋아요 취소
	@RequestMapping(value = "deleteDiaryLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteDiaryLike(
			@RequestParam int diaryNum,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
			
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("diaryNum", diaryNum);
		paramMap.put("userNum", info.getUserNum());
			
		// 좋아요 취소
		String state="true";
		try {
			service.diaryLikeDelete(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		// 좋아요 개수 가져오기
		int diaryLikeCount = service.diaryLikeCount(diaryNum);
			
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("diaryLikeCount", diaryLikeCount);
		return model;
	}
	
	// 팔로우 추가
	@RequestMapping(value="addFollowing", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addFollowing(
			@RequestParam int followingUser,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
			
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("followingUser", followingUser);
		paramMap.put("followerUser", info.getUserNum());
			
		String state = "true";
		try {
			service.addFollowing(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		int followingCount = service.followingCount(followingUser);
			
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("followingCount", followingCount);
		return model;
	}
		
	@RequestMapping(value="cancelFollowing", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cancelFollowing(
			@RequestParam int followingUser,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("followingUser", followingUser);
		paramMap.put("followerUser", info.getUserNum());
			
		String state="true";
		try {
			service.cancelFollowing(paramMap);
		} catch (Exception e) {
			state="false";
		}			
			
		int followingCount = service.followingCount(followingUser);
			
		Map<String, Object> model=new HashMap<String, Object>();
		model.put("state", state);
		model.put("followingCount", followingCount);
		return model;
	}
	
}