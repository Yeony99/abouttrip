package com.aboutrip.app.scheduler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("scheduler.schedulerService")
public class SchedulerServiceImpl implements SchedulerService{
	
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertSchedule(Scheduler dto) throws Exception {
		try {
			//dto.setNum(dao.selectOne("scheduler.scheduler_seq"));
			dao.insertData("scheduler.insertScheduler", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertMate(Mate dto) throws Exception {
		try {
			dao.insertData("scheduler.insertMate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertShare(Share dto,String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFileName(saveFilename);
				
				dao.insertData("scheduler.insertShare", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Override
	public void insertReply(MateReply dto) throws Exception {
		try {
			dao.insertData("scheduler.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertReview(Review dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFileName(saveFilename);
				
				dao.insertData("scheduler.insertReview", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void insertReviewReply(ReviewReply dto) throws Exception {
		try {
			dao.insertData("scheduler.insertReviewReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public List<Scheduler> listMonth(Map<String, Object> map) throws Exception {
		List<Scheduler> list = null;
		try {
			list = dao.selectList("scheduler.listMonth",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return list;
	}

	@Override
	public List<Mate> listMate(Map<String, Object> map) throws Exception {
		List<Mate> list = null;
		try {
			list = dao.selectList("scheduler.listMate",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Mate> readMate(int userNum) throws Exception {
		List<Mate> list = null;
		try {
			list = dao.selectList("scheduler.readMate",userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}


	@Override
	public List<MateReply> listReply(Map<String, Object> map) throws Exception {
		List<MateReply> list = null;
		try {
			list = dao.selectList("scheduler.listReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Review> listreview(Map<String, Object> map) throws Exception {
		List<Review> list = null;
		try {
			list = dao.selectList("scheduler.listReview",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Share> sharelist(Map<String, Object> map) throws Exception {
		List<Share> list = null;
		try {
			list = dao.selectList("scheduler.sharelist",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<ReviewReply> listreviewReply(Map<String, Object> map) throws Exception {
		List<ReviewReply> list = null;
		try {
			list = dao.selectList("scheduler.listReviewReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateScheduler(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.updateScheduler", map);
		} catch (Exception e) {
			throw e;
		}
		
	}


	@Override
	public void updateReply(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.updateReply", map);
		} catch (Exception e) {
			throw e;
		}
		
	}
	
	@Override
	public void updateReviewReply(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.updateReviewReply", map);
		} catch (Exception e) {
			throw e;
		}
		
	}
	
	@Override
	public void updateReview(Review dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if(saveFilename != null) {
				if(dto.getImageFileName().length()!=0) {
					fileManager.doFileDelete(dto.getImageFileName(), pathname);
				}
				dto.setImageFileName(saveFilename);
			}
			dao.updateData("scheduler.updateReview", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.deleteScheduler", map);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void deleteMate(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.deleteMate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void deleteMateAdmin(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.deleteReplyAdmin", map);
			dao.updateData("scheduler.deleteMateAdmin", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("scheduler.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void deleteShare(int num) throws Exception {
		try {
			dao.updateData("scheduler.deleteShare", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public int MateCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.mateCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}



	@Override
	public void updateShare(Share dto,String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			dto.setImageFileName(saveFilename);
			dao.selectOne("scheduler.updateShare",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void updateCountreply(Map<String, Object> map) throws Exception {
			
		try {
			dao.selectOne("scheduler.updateAnswerCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.replyCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int shareCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.shareCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.replyAnswerCount",answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int reviewCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.reviewCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int shareHitCount(int num) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.shareHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int reviewReplyCount(int rev_num) {
		int result = 0;
		
		try {
			result = dao.selectOne("scheduler.reviewReplyCount",rev_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public Review readReview(int num) {
		Review dto = null;
		try {
			dto = dao.selectOne("scheduler.readReview",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public Share readShare(Map<String, Object> map) {
		Share dto = null;
		try {
			dto = dao.selectOne("scheduler.readShare",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public Scheduler readScheduler(Map<String, Object> map) {
		Scheduler dto = null;
		try {
			dto = dao.selectOne("scheduler.readScheduler",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public Share preReadShare(Map<String, Object> map) {
		Share dto = null;
		try {
			dto = dao.selectOne("scheduler.preReadShare", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Share nextReadShare(Map<String, Object> map) {
		Share dto = null;
		try {
			dto = dao.selectOne("scheduler.nextReadShare", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteReview(int num, String pathname) throws Exception {
		try {
			if(pathname!=null) {
				fileManager.doFileDelete(pathname);
			}
			dao.deleteData("scheduler.deleteReview", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteReviewReply(int num) throws Exception {
		try {
			dao.deleteData("scheduler.deleteReviewReply", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}
