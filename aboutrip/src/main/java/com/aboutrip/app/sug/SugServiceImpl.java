package com.aboutrip.app.sug;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("sug.sugService")
public class SugServiceImpl implements SugService {
	
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertSug(Sug dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			dao.insertData("sug.insertSug", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public List<Sug> listSug(Map<String, Object> map) {
		List<Sug> list = null;
		try {
			list = dao.selectList("sug.listSug", map);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result =0;
		try {
			result=dao.selectOne("sug.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Sug readSug(int num) {
		Sug dto = null;
		try {
			dto = dao.selectOne("sug.readSug", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Sug preReadSug(Map<String, Object> map) {
		Sug dto = null;
		try {
			dto = dao.selectOne("sug.preReadSug", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Sug nextReadSug(Map<String, Object> map) {
		Sug dto = null;
		try {
			dto = dao.selectOne("sug.nextReadSug", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateSug(Sug dto, String pathname) throws Exception {
		try {
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.updateData("sug.updateSug", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteSug(int num, String pathname, int userNum) throws Exception {
		try {
			Sug dto=readSug(num);
			if(dto==null || ( userNum!=1111 && userNum!=dto.getUserNum() ) ) {
				return;
			}
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			
			dao.deleteData("sug.deleteSug", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertSugLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("sug.insertSugLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int sugLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("sug.sugLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
