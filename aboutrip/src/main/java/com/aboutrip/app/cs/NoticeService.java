package com.aboutrip.app.cs;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public void insertNotice(Notice dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	public Notice readNotice(int noticeNum);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Notice dto, String pathname) throws Exception;
	public void deleteNotice(int noticeNum, String pathname) throws Exception;
	
	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int noticeNum);
	public Notice readFile(int nfileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
}
