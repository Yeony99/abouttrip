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
}
