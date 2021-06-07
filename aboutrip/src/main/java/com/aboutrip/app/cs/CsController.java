package com.aboutrip.app.cs;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@Controller("cs.csController")
@RequestMapping("/notice/*")
public class CsController {
	@Autowired
	private NoticeService service;	
	@Autowired
	private AboutUtil aboututil; 
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, 
			Model model
			) throws Exception{
		
		int rows = 10;
		int total_page=0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = aboututil.pageCount(rows,  dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        List<Notice> noticeList = null;
        if(current_page==1) {
          noticeList=service.listNoticeTop();
        }
        
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Notice> list = service.listNotice(map);

        Date endDate = new Date();
        long gap;
        int listNum, n = 0;
        for(Notice dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date beginDate = formatter.parse(dto.getReg_date());

            gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
            dto.setGap(gap);
            
            dto.setReg_date(dto.getReg_date().substring(0, 10));
            
            n++;
        }
        
        String cp=req.getContextPath();
        String query = "";
        String listUrl = cp+"/notice/list";
        String articleUrl = cp+"/notice/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" + condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/notice/list?" + query;
        	articleUrl = cp+"/notice/article?page=" + current_page + "&"+ query;
        }
        
        String paging = aboututil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);		
		model.addAttribute("articleUrl", articleUrl);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".notice.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model,
			HttpSession session
			) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list";
		}
		String nickName = info.getNickName();
		model.addAttribute("nickName", nickName);
		model.addAttribute("mode", "created");
		
		return ".notice.created";
	}

	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(
			Notice dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		System.out.println(info.getUserId());
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list";	
		}

		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "notice";		
			
			dto.setAdminNum(info.getUserNum());
			service.insertNotice(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/notice/list";
	}

	@RequestMapping(value="article")
	public String article(
			@RequestParam int noticeNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		

		Notice dto = service.readNotice(noticeNum);
		if(dto==null) {
			return "redirect:/notice/list?"+query;
		}
		
        dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
         
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("noticeNum", noticeNum);

		Notice preReadDto = service.preReadNotice(map);
		Notice nextReadDto = service.nextReadNotice(map);
        
		// 파일
		List<Notice> listFile=service.listFile(noticeNum);
				
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".notice.article";
	}

	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int noticeNum,
			@RequestParam String page,
			HttpSession session,			
			Model model	) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list?page="+page;
		}

		Notice dto = service.readNotice(noticeNum);
		if(dto==null) {
			return "redirect:/notice/list?page="+page;
		}
		
		List<Notice> listFile=service.listFile(noticeNum);
			
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".notice.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Notice dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list?page="+page;
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "uploads" + File.separator + "notice";		
			
			dto.setAdminNum(info.getUserNum());
			service.updateNotice(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/notice/list?page="+page;
	}

	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int noticeNum,
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
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/notice/list?"+query;
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "notice";
			service.deleteNotice(noticeNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/notice/list?"+query;
	}

	@RequestMapping(value="download")
	public void download(
			@RequestParam int nfileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		boolean b = false;
		
		Notice dto = service.readFile(nfileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}

	}
	
	@RequestMapping(value="zipdownload")
	public void zipdownload(
			@RequestParam int noticeNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator + "notice";
		
		boolean b = false;
		
		List<Notice> listFile = service.listFile(noticeNum);
		if(listFile.size()>0) {
			String sources[] = new String[listFile.size()];
			String originals[] = new String[listFile.size()];
			String zipFilename = noticeNum+".zip";
			
			for (int i = 0; i < listFile.size(); i++) {
				sources[i]=pathname+File.separator+listFile.get(i).getSaveFilename();
				originals[i]=pathname+File.separator+listFile.get(i).getOriginalFilename();
				
			}
			b= fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
	
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
		
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int nfileNum,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		Notice dto=service.readFile(nfileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "nfileNum");
		map.put("num", nfileNum);
		service.deleteFile(map);
		
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
}
