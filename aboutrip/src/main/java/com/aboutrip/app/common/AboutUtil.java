package com.aboutrip.app.common;

import org.springframework.stereotype.Service;

@Service("aboutUtil")

public class AboutUtil {
	
	/**
	 * 전체 페이지수를 구하는 메소드
	 * @param rows			한 화면에 출력할 데이터 개수
	 * @param dataCount		총 데이터 개수
	 * @return				총 페이지 수
	 */
	public int pageCount(int rows, int dataCount) {
		if(dataCount <= 0)
			return 0;
		return dataCount / rows +(dataCount % rows > 0 ? 1 : 0);
	}
	
	public String paging(int current_page, int total_page, String list_url) {
		StringBuffer sb = new StringBuffer();
		
		int numPerBlock = 10;
		int currentPageSetup;
		int n, page;
		
		if(current_page<1 || total_page < 1) {
			return "";
		}
		
		if(list_url.indexOf("?")!=-1) {
			list_url+="&";
		} else {
			list_url+="?";
		}
		
		// currentPageSetup : 표시할 첫 페이지 -1
		currentPageSetup=(current_page/numPerBlock)*numPerBlock;
		if(current_page%numPerBlock==0) {
			currentPageSetup=currentPageSetup-numPerBlock;
		}
		return "";
	}
	public String htmlSymbols(String str) {
		if(str==null||str.length()==0) {
			return "";
		}

    	 str=str.replaceAll("&", "&amp;");
    	 str=str.replaceAll("\"", "&quot;");
    	 str=str.replaceAll(">", "&gt;");
    	 str=str.replaceAll("<", "&lt;");
    	 
    	 str=str.replaceAll(" ", "&nbsp;"); 
    	 str=str.replaceAll("\n", "<br>");
    	 
    	 return str;
	}
	public String pagingMethod(int current_page, int total_page, String methodName) {
		if(current_page < 1 || total_page < 1) {
			return "";
		}

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n;
        int page;
        StringBuffer sb=new StringBuffer();
        
        // 표시할 첫 페이지
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0) {
            currentPageSetUp = currentPageSetUp - numPerBlock;
        }

		sb.append("<div id='paginate'>");
        
        // 처음페이지, 이전(10페이지 전)
        n = current_page - numPerBlock;
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
			sb.append("<a onclick='"+methodName+"(1);'>처음</a>");
			sb.append("<a onclick='"+methodName+"("+n+");'>이전</a>");
        }

        // 바로가기 페이지 구현
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
        	   sb.append("<span class='curBox'>"+page+"</span>");
           } else {
			   sb.append("<a onclick='"+methodName+"("+page+");' class='numBox'>"+page+"</a>");
           }
           page++;
        }

        // 다음(10페이지 후), 마지막 페이지
        n = current_page + numPerBlock;
		if(n>total_page) n=total_page;
        if (total_page - currentPageSetUp > numPerBlock) {
			sb.append("<a onclick='"+methodName+"("+n+");'>다음</a>");
			sb.append("<a onclick='"+methodName+"("+total_page+");'>끝</a>");
        }
		sb.append("</div>");

        return sb.toString();
    }
}
