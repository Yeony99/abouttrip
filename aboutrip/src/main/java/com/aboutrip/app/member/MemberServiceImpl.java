package com.aboutrip.app.member;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.Mail.Mail;
import com.aboutrip.app.Mail.MailSender;
import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;
import com.aboutrip.app.product.Order;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private AboutDAO dao;
	
	@Autowired
	private MailSender	mailSender;
	
	@Autowired
	private FileManager fileManager;
	
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
	public void insertMember(Member dto,String pathname) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setUserId(dto.getEmail1()+"@"+dto.getEmail2());
			}
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			dto.setProfile_pic(saveFilename);
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
	public void updateMember(Member dto,String pathname) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setUserId(dto.getEmail1()+"@"+dto.getEmail2());
			}
			//MemberMapper - member.updateMember1, dto
			//MemberMapper - member.updateMember2, dto
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			dto.setProfile_pic(saveFilename);
			dao.updateData("member.updateMember1", dto);
			dao.updateData("member.updateMember2", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void updatePwd(Member dto) throws Exception {
		try {
			dao.updateData("member.updatepwd", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public Member readMember(String userId) {
		Member dto = null;
		
		try {
			//memberMapper - member.readMember2, nickName
			dto = dao.selectOne("member.readMember", userId);
			
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
	public void deleteMember(String userId) throws Exception {
		Member dto = null;
		try {
			//MemberMapper - deleteMember2,userNum
			//MemberMapper - deleteMember1,userNum
			dto = readMember(userId);
			dao.selectOne("member.deletePayment", dto.getUserNum());
			dao.selectOne("member.deletefollowing", dto.getUserNum());
			dao.selectOne("member.deletefollower", dto.getUserNum());
			dao.selectOne("member.deleteMember2", dto.getUserNum());
			StringBuilder sb = new StringBuilder();
			Random rd=new Random();
			String s="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxtz";	
			for(int i=0;i<10;i++) {
				int n = rd.nextInt(s.length());
				sb.append(s.substring(n,n+1));
			}
			//dto.setUserPwd(sb.toString());
			//updatePwd(dto);
			//dao.selectOne("member.deleteMember1", dto.getUserNum());
			
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
	public int orderCount(int user_num) {
		int result = 0;
		
		try {
			result = dao.selectOne("member.orderCount", user_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int payCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("member.payCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public Member readMember(String userName, String tel) {
		Member dto = null;
		Member dto1 = null;
		Member dto2 = null;
		try {
			dto1 = dao.selectOne("member.checkName", userName);
			dto2 = dao.selectOne("member.checkTel", tel);
			
			if(dto1.getUserNum()==dto2.getUserNum()) {
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
		
		mail.setSenderEmail("aboutrip123@gmail.com");
		mail.setSenderName("Admin");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			dto.setUserPwd(sb.toString());
			updatePwd(dto);
		} else {
			throw new Exception();
		}
	}

	@Override
	public void checkIpAddr(Member dto) throws Exception {
		try {
			int loginseq = dao.selectOne("member.loginseq");
			dto.setLogNum(loginseq);
			dto = dao.selectOne("member.insertIpaddr",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertPayment(Member dto) throws Exception {
		String code1 = null,code2 = null,code3 = null;
		try {
			int paymentseq = dao.selectOne("member.paymentseq");
			dto.setCardNum(paymentseq);
			code1= dto.getPaymentCode().substring(0,4);
			code2= dto.getPaymentCode().substring(4,8);
			code3= dto.getPaymentCode().substring(8);
			dto.setPaymentCode(code1+"-"+code2+"-"+code3);
			dto = dao.selectOne("member.insertPayment",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Member> payList(Map<String, Object> map) {
		List<Member> paylist = null;
		
		try {
			paylist = dao.selectList("member.listPayment", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paylist;
	}

	@Override
	public int logCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("member.logCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Member> logList(Map<String, Object> map) {
		List<Member> loglist = null;
		
		try {
			loglist = dao.selectList("member.logList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loglist;
	}

	@Override
	public int followingCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("member.followingCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int followerCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("member.followerCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Member> followingList(Map<String, Object> map) {
		List<Member> followinglist = null;
		
		try {
			followinglist = dao.selectList("member.followinglist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return followinglist;
	}

	@Override
	public List<Member> followerList(Map<String, Object> map) {
		List<Member> followerList = null;
		
		try {
			followerList = dao.selectList("member.followerlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return followerList;
	}


	@Override
	public List<Order> orderList(Map<String, Object> map) {
		List<Order> list = null;
		try {
			list = dao.selectList("member.orderlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	@Override
	public void deleteFollow(Map<String, Object> map) throws Exception {
		try {
			dao.selectOne("member.deleteFollower",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deletePaymentCode(Map<String, Object> map) throws Exception {
		try {
			dao.selectOne("member.deletePaymentCode",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	

}
