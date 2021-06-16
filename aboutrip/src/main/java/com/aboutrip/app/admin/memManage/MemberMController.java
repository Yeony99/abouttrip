package com.aboutrip.app.admin.memManage;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aboutrip.app.common.AboutUtil;

@Controller("admin.memManage.memberMController")
@RequestMapping("/admin/memManage/*")
public class MemberMController {
	@Autowired
	private MemberMService service;
	
	@Autowired
	private AboutUtil aboutUtil;
	
	@RequestMapping("list")
	public String memManage(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="userId") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String enable,
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

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("enable", enable);
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = aboutUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 멤버 리스트
        List<Member> list = service.listMember(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Member dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/admin/memManage/list";
        
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        /*
        if(enable.length()!=0) {
        	if(query.length()!=0)
        		query = query +"&enable="+enable;
        	else
        		query = "enable="+enable;
        }
        */
        if(query.length()!=0) {
        	listUrl = listUrl + "?" + query;
        }
        
        String paging = aboutUtil.paging(current_page, total_page, listUrl);        
		
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("enable", enable);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        
		return ".admin.memManage.list";
	}
	
	@RequestMapping(value="detail")
	public String detailMember(
			@RequestParam String userId,
			Model model
			) throws Exception {
		
		Member dto=service.readMember(userId);

		model.addAttribute("dto", dto);
		
		return "admin/memManage/detail";
	}
	
	@RequestMapping(value="updateEnable", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateEnable(
			Member dto) throws Exception {
		
		String state = "true";
		try {
			// 회원 활성/비활성 변경
			Map<String, Object> map = new HashMap<>();
			map.put("userNum", dto.getUserNum());
			map.put("enable",dto.getEnable());
			

			service.updateEnable(map);

		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping("analysis")
	public String analysis(Model model) throws Exception {
		return ".admin.memManage.analysis";
	}
	
	// 회원 연령대별 인원수 : AJAX-JSON 응답
	@RequestMapping("ageAnalysis")
	@ResponseBody
	public Map<String, Object> listAgeSection() throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 연령대별 인원수
		List<Analysis> list = service.listAgeSection();
		
		model.put("list", list);
		
		return model;
	}	
}
