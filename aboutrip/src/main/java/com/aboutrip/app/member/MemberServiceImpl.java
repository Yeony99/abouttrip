package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.dao.AboutDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private AboutDAO dao;
	
	
	@Override
	public Member loginMember(String userId) {
		Member dto= null;
		
		try {
			//MemberMapper - member.loginMember, userId
			dto = dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			//MemberMapper - member.insertMember1,dto
			//MemberMapper - member.insertMember2,dto
			dao.insertData("member.insertMember1", dto);
			dao.insertData("member.insertMember2", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			//MemberMapper - member.updateMember1, dto
			//MemberMapper - member.updateMember2, dto
			
			dao.updateData("member.updateMember1", dto);
			dao.updateData("member.updateMember2", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Member readMember(int userNum) {
		Member dto = null;
		
		try {
			//memberMapper - member.readMember1, userNum
			dto = dao.selectOne("member.readMember1", userNum);
			
			if(dto!=null) { 
				if(dto.getTel()!=null) { 
			 	String [] s=dto.getTel().split("-");
				dto.setTel1(s[0]); 
		 		dto.setTel2(s[1]); 
		 		dto.setTel3(s[2]); 
		 	} 
		 }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Member readMember(String nickName) {
		Member dto = null;
		
		try {
			//memberMapper - member.readMember2, nickName
			dto = dao.selectOne("member.readMember2", nickName);
			
			if(dto!=null) { 
				if(dto.getTel()!=null) { 
			 	String [] s=dto.getTel().split("-");
				dto.setTel1(s[0]); 
		 		dto.setTel2(s[1]); 
		 		dto.setTel3(s[2]); 
				}
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteMember(int userNum) throws Exception {
		Member dto = null;
		try {
			//MemberMapper - deleteMember2,userNum
			//MemberMapper - deleteMember1,userNum
			dto = readMember(userNum);
			dao.selectOne("member.deleteMember2", dto);
			dao.selectOne("member.deleteMember1", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;
		try {
			//MemberMapper - listMember, map
			list = dao.selectList("member.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("member.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int checkId(String userId) {
		int result=0;
		
		try {
			result = dao.selectOne("member.readMember3", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int checkNickName(String nickName) {
		int result=0;
		
		try {
			result = dao.selectOne("member.readMember2", nickName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	//DAO 차후 추가
	

}
