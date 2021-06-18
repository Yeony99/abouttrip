package com.aboutrip.app.sug;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.aboutrip.app.member.SessionInfo;

@Controller("sug.sugController")
@RequestMapping("/sug/*")
public class SugController {
	
	@Autowired
	private SugService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@Autowired
	private FileManager fileManager;
	
	//제안 리스트
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
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
        
        dataCount = service.dataCount(map);
        if(dataCount != 0) total_page = aboutUtil.pageCount(rows, dataCount);
        
        if(total_page < current_page) 
            current_page = total_page;
        
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Sug> list = service.listSug(map);
        
        int listNum, n = 0;
        for(Sug dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
		
        String query = "";
        String listUrl = cp+"/sug/list";
        String articleUrl = cp+"/sug/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/sug/list?" + query;
        	articleUrl = cp+"/sug/article?page=" + current_page + "&"+ query;
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
        
		return ".sug.list";
		
	}
	
	//제안 글 올리기
	@RequestMapping(value="created", method = RequestMethod.GET)
	public String createForm(
			Model model) throws Exception{
		
		model.addAttribute("mode", "created");
		return ".sug.created";
	}
	
	//제안 글 올리기
	@RequestMapping(value="/sug/created", method = RequestMethod.POST)
	public String createdSubmit(
			Sug dto,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"sug";
		
		try {
			dto.setUserNum(info.getUserNum());
			service.insertSug(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/sug/list";
	}
	
	//제안 글보기
	@RequestMapping(value="article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Sug dto = service.readSug(num);
		
		if(dto==null)
			return "redirect:/sug/list?"+query;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Sug preReadDto = service.preReadSug(map);
		Sug nextReadDto = service.nextReadSug(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
        return ".sug.article";
	}
	
	//제안 글 수정
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Sug dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"sug";		

		try {
			service.updateSug(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/sug/list?page="+page;
	}
	
	//제안 글 첨부파일 수정
	@RequestMapping(value="deleteFile")
	public String deleteFile(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"sug";
		
		Sug dto = service.readSug(num);
		if(dto==null) {
			return "redirect:/sug/list?page="+page;
		}
		
		if(info.getUserNum()!=dto.getUserNum()) {
			return "redirect:/sug/list?page="+page;
		}
		
		try {
			if(dto.getSaveFilename()!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname); //실제파일 삭제 
				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				service.updateSug(dto, pathname); //DB 테이블의 파일명 변경
			}
		} catch (Exception e) {
		}
		
		return "redirect:/sug/update?num="+num+"&page="+page;
	}
	
	// 제안 글 삭제
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
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"sug";
		
		service.deleteSug(num, pathname, info.getUserNum());
		
		return "redirect:/sug/list?"+query;
	}
	
	//제안 첨부파일 삭제
	@RequestMapping(value="download")
	public void download(
			@RequestParam int num,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"sug";
		
		Sug dto=service.readSug(num);
		
		if(dto!=null) {
			boolean b=fileManager.doFileDownload(dto.getSaveFilename(),
					                   dto.getOriginalFilename(), pathname, resp);
			if(b) return;
		}
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print("<script>alert('파일 다운로드가 실패 했습니다.');history.back();</script>");
	}
	
	// 제안 글 좋아요 추가 
	@RequestMapping(value="insertSugLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSugLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int sugLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userNum", info.getUserNum());
		
		try {
			service.insertSugLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		sugLikeCount = service.sugLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("sugLikeCount", sugLikeCount);
		
		return model;
	}
	
}
