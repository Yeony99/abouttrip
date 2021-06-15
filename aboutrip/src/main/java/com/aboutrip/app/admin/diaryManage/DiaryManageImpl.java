package com.aboutrip.app.admin.diaryManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("admin.diaryManage.diaryManageService")
public class DiaryManageImpl implements DiaryManageService {
	@Autowired
	private AboutDAO dao;

	@Autowired
	private FileManager fm;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("diaryManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<DiaryManage> listDiaryManage(Map<String, Object> map) {
		List<DiaryManage> list=null;
		try {
			list=dao.selectList("diaryManage.listDiaryManage", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateDiaryType(DiaryManage dto, String pathname) throws Exception {
		try {
			dao.updateData("diaryManage.updateDiaryType", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public DiaryManage readDiaryManage(int diaryNum) {
		DiaryManage dto = null;
		
		try {
			dto = dao.selectOne("diaryManage.readDiaryManage", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteDiary(int diaryNum, String pathname) throws Exception {
		try {
			// 파일 지우기
			List<DiaryManage> listImg = listImg(diaryNum);
			if(listImg!=null) {
				for(DiaryManage dto:listImg) {
					fm.doFileDelete(dto.getSaveImgName(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "diaryNum");
			map.put("diaryNum", diaryNum);
			deleteImg(map);
			
			dao.deleteData("diaryManage.deleteDiary", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public List<DiaryManage> listImg(int diaryNum) {
		List<DiaryManage> listImg=null;
		
		try {
			listImg=dao.selectList("diaryManage.listImg", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listImg;
	}

	@Override
	public DiaryManage readImg(int diaryImgNum) {
		DiaryManage dto=null;
		
		try {
			dto=dao.selectOne("diaryManage.readImg", diaryImgNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteImg(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("diaryManage.deleteImg", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
