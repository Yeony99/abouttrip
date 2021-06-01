package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.Mail.Mail;
import com.aboutrip.app.Mail.MailSender;
import com.aboutrip.app.common.dao.AboutDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private MailSender	mailSender;
	
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
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setUserId(dto.getEmail1()+"@"+dto.getEmail2());
			}
			
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
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setUserId(dto.getEmail1()+"@"+dto.getEmail2());
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
			
			if(dto != null) {
				if(dto.getUserId()!=null) {
					String [] s = dto.getUserId().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
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
							
				if(dto.getUserId()!=null) {
					String [] s=dto.getUserId().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
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
	public Member checkAccount(String userName, String tel) {
		Member dto = null;
		Member dto1 = null;
		Member dto2 = null;
		try {
			dto1 = dao.selectOne("member.checkName", userName);
			dto2 = dao.selectOne("member.checkTel", tel);
			
			if(dto1.getUserId().equals(dto2.getUserId())) {
				dto= dto1;
			} else {
				throw new Exception("입력한 이름과 전화번호가 일치하는 회원이 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		StringBuilder sb = new StringBuilder();
		Random rd=new Random();
		String s="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxtz";	
		for(int i=0;i<10;i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n,n+1));
		}
		
		String result;
		result = dto.getEmail1()+"님의 새로 발급된 임시 패스워드는 <b>"+sb.toString()+"</b> 이며, "
				+"로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getUserId());
		
		mail.setSenderEmail("teststs210601@gmail.com");
		mail.setSenderName("Admin");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			dto.setUserPwd(sb.toString());
			updateMember(dto);
		} else {
			throw new Exception();
		}
	}
	

}
