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
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			//MemberMapper - member.insertMember1,dto
			//MemberMapper - member.insertMember2,dto
		} catch (Exception e) {
			e.printStackTrace();
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Member readMember(int userNum) {
		Member dto = null;
		
		try {
			//memberMapper - member.readMember1, userNum
			
			/*
			 * if(dto!=null) { 
			 * 	if(dto.getTel()!=null) { 
			 * 		String [] s=dto.getTel().split("-");
			 * 		dto.setTel1(s[0]); 
			 * 		dto.setTel2(s[1]); 
			 * 		dto.setTel3(s[2]); 
			 * 	} 
			 * }
			 */
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
			
			/*
			 * if(dto!=null) { 
			 * 	if(dto.getTel()!=null) { 
			 * 		String [] s=dto.getTel().split("-");
			 * 		dto.setTel1(s[0]); 
			 * 		dto.setTel2(s[1]); 
			 * 		dto.setTel3(s[2]); 
			 * 	} 
			 * }
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteMember(int userNum) throws Exception {
		try {
			//MemberMapper - deleteMember2,userNum
			//MemberMapper - deleteMember1,userNum
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		try {
			//MemberMapper - listMember, map
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	//DAO 차후 추가
	

}
