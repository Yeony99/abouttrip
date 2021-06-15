package com.aboutrip.app.admin.diaryManage;

import java.util.List;
import java.util.Map;

public interface DiaryManageService {
	public int dataCount(Map<String, Object> map);
	public List<DiaryManage> listDiaryManage(Map<String, Object> map);
	
	public void updateDiaryType(DiaryManage dto, String pathname) throws Exception;
	public DiaryManage readDiaryManage(int diaryNum);
	public void deleteDiary(int diaryNum, String pathname) throws Exception;
	
	public List<DiaryManage> listImg(int diaryNum);
	public DiaryManage readImg(int diaryImgNum);
	public void deleteImg(Map<String, Object> map) throws Exception;
}
