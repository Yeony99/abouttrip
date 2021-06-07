package com.aboutrip.app.diary;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("diary.diaryService")
public class DiaryServiceImpl implements DiaryService {
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private FileManager fm;

	@Override
	public void insertDiary(Diary dto, String pathname) throws Exception {

		for(MultipartFile mf : dto.getUpload()) {
			try {
				
				String saveFilename = fm.doFileUpload(mf, pathname);
				if(saveFilename != null) {
					//dto.getSavePathname().add(pathname+File.separator+saveImgName);
					
					String originalFilename = mf.getOriginalFilename();
					
					dto.setSaveFilename(saveFilename);
					dto.setOriginalFilename(originalFilename);				
				}
				
				dao.insertData("diary.insertDiary", dto);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		int result = 0;
		
		try {
			result = dao.selectOne("diary.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
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
		
		Diary dto = null;
		
		try {
			dto=dao.selectOne("diary.readDiary", diaryNum);
		} catch (Exception e) {e.printStackTrace();// TODO: handle exception
		}
		
		return dto;
	}

	@Override
	public void updateDiary(Diary dto, String pathname) throws Exception {
		for(MultipartFile mf : dto.getUpload()) {
			try {
				String saveFilename = fm.doFileUpload(mf, pathname);
				if(saveFilename != null) {
					if(dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0)
						fm.doFileDelete(dto.getSaveFilename(), pathname);
					
					String originalFilename = mf.getOriginalFilename();
					
					dto.setSaveFilename(saveFilename);
					dto.setOriginalFilename(originalFilename);
				}
				dao.updateData("diary.updateDiary", dto);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
	}

	@Override
	public void deleteDiary(int diaryNum, String pathname, String userId) throws Exception {
		try{
			Diary dto=readDiary(diaryNum);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			fm.doFileDelete(dto.getSaveFilename(), pathname);
			
			dao.deleteData("diary.deleteDiary", diaryNum);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public void insertDiaryLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("diary.insertDiaryLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int diaryLikeCount(int diaryNum) {
		int result=0;
		
		try {
			result = dao.selectOne("diary.DiaryLikeCount", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public boolean isDiaryLikeUser(Map<String, Object> map) {
		boolean result=false;
		try {
			int cnt = dao.selectOne("diary.diaryLikeUserCount", map);
			if(cnt > 0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int DiaryLikeDelete(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("diary.diaryLikeDelete", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}
