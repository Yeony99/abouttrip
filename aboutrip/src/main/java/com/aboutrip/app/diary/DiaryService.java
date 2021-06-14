package com.aboutrip.app.diary;

import java.util.List;
import java.util.Map;

public interface DiaryService {
	
	public void insertDiary(Diary dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Diary> listDiary(Map<String, Object> map);
	public Diary readDiary(int diaryNum);
	public void updateDiary(Diary dto, String pathname) throws Exception;
	public void deleteDiary(int diaryNum, String pathname) throws Exception;
	
	public void insertImg(Diary dto) throws Exception;
	public List<Diary> listImg(int diaryNum);
	public Diary readImg(int diaryImgNum);
	public void deleteImg(Map<String, Object> map) throws Exception;
	
	public void insertDiaryLike(Map<String, Object> map) throws Exception;
	public int diaryLikeCount(int diaryNum);
	public boolean isDiaryLikeUser(Map<String, Object> map);
	public int diaryLikeDelete(Map<String, Object> map) throws Exception;
	
}
