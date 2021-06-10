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
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				dto.setPlaceImgName(saveFilename);
				dto.setSavePlace(dto.getUpload().getOriginalFilename());
			}
			int placeNumseq = dao.selectOne("place.placeNumseq");
			dto.setPlaceNum(placeNumseq);
			int placeImgNumseq = dao.selectOne("place.ctgNumseq");
			dto.setPlaceImgNum(placeImgNumseq);
			dto.setPlaceFileName(dto.getPlaceFileName().substring(dto.getPlaceFileName().lastIndexOf("\\")));
			dto.setPlaceFileName(dto.getPlaceFileName().substring(1,dto.getPlaceFileName().length()));
			dao.insertData("place.insertPlace", dto);
			dao.insertData("place.insertPlaceImg", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.selectOne("place.updateHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Place readPlace(int placeNum) {
		Place dto = null;
		
		try {
			dto = dao.selectOne("place.readPlace",placeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Place preReadPlace(Map<String, Object> map) {
		Place dto = null;
		
		try {
			dto = dao.selectOne("place.preReadPlace",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Place nextReadPlace(Map<String, Object> map) {
		Place dto = null;
		
		try {
			dto = dao.selectOne("place.nextReadPlace",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	

}
