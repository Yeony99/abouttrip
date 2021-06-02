package com.aboutrip.app.diary;

import java.util.List;
import java.util.Map;

import org.apache.poi.poifs.filesystem.FileMagic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("diary.diaryServiceImpl")
public class DiaryServiceImpl implements DiaryService {
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertDiary(Diary dto, String pathname) throws Exception {
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		return 0;
	}

	@Override
	public List<Diary> listDiary(Map<String, Object> map) {
		List<Diary> list = null;
		
		try {
			list = dao.selectList("diary.listDiary", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Diary readDiary(int diaryNum) {
		
		return null;
	}

	@Override
	public void updateDiary(Diary dto, String pathname) throws Exception {
		
	}

	@Override
	public void deleteDiary(int diaryNum, String pathname) throws Exception {
		
	}
}
