package com.aboutrip.app.place;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("place.placeService")
public class PlaceServiceImpl implements PlaceService {
	@Autowired
	private AboutDAO dao;
	
	@Autowired 
	private FileManager fileManager;

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("place.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Place> listPlace(Map<String, Object> map) {
		List<Place> list = null;
		
		try {
			//MemberMapper - listMember, map
			list = dao.selectList("place.listPlace", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void insertPlace(Place dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			dto.setPlaceImgName(saveFilename);
			dao.insertData("place.insertPlace", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	

}
