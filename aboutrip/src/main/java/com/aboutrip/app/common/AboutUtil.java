package com.aboutrip.app.common;

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
}
