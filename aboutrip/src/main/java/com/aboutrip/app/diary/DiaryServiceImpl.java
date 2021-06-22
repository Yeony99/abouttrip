package com.aboutrip.app.diary;

import java.util.HashMap;
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
		try {
			int seq=dao.selectOne("diary.seq");
			dto.setDiaryNum(seq);

			dao.insertData("diary.insertDiary", dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String saveImgName=fm.doFileUpload(mf, pathname);
					if(saveImgName==null) continue;
					
					dto.setSaveImgName(saveImgName);
					
					insertImg(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateDiary(Diary dto, String pathname) throws Exception {
		try {
			dao.updateData("diary.updateDiary", dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String saveImgName=fm.doFileUpload(mf, pathname);
					if(saveImgName==null) continue;
					
					dto.setSaveImgName(saveImgName);
					
					insertImg(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteDiary(int diaryNum, String pathname) throws Exception {
		try {
			// 파일 지우기
			List<Diary> listImg=listImg(diaryNum);
			if(listImg!=null) {
				for(Diary dto:listImg) {
					fm.doFileDelete(dto.getSaveImgName(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "diaryNum");
			map.put("diaryNum", diaryNum);
			deleteImg(map);
			
			dao.deleteData("diary.deleteDiary", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public void insertImg(Diary dto) throws Exception {
		try {
			dao.insertData("diary.insertImg", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Diary> listImg(int diaryNum) {
		List<Diary> listImg=null;
		
		try {
			listImg=dao.selectList("diary.listImg", diaryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listImg;
	}
	
	@Override
	public Diary readImg(int diaryImgNum) {
		Diary dto=null;
		
		try {
			dto=dao.selectOne("diary.readImg", diaryImgNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void deleteImg(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("diary.deleteImg", map);
		} catch (Exception e) {
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
			result = dao.selectOne("diary.diaryLikeCount", diaryNum);
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
	public int diaryLikeDelete(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("diary.diaryLikeDelete", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public void addFollowing(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("diary.addFollowing", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int followingCount(int followingUser) {
		int result = 0;
		
		try {
			result = dao.selectOne("diary.followingCount", followingUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean isFollow(Map<String, Object> map) {
		boolean result=false;
		try {
			int cnt = dao.selectOne("diary.followerCount", map);
			if(cnt > 0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void cancelFollowing(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("diary.cancelFollowing", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
