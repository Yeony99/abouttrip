package com.aboutrip.app.Mail;

import java.io.File;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.AboutUtil;

@Service("mail.myMailSender")
public class MailSender {
	@Autowired
	private AboutUtil aboutUtil;
	
	private String mailType; // 메일 타입
	private String encType;
	
	public MailSender() {
		this.encType = "utf-8";
		this.mailType = "text/html; charset=utf-8";
	}

	public void setMailType(String mailType, String encType) {
		this.mailType = mailType;
		this.encType = encType;
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator {
		  @Override
	      public PasswordAuthentication getPasswordAuthentication() {  
	           String username =  "aboutrip123"; // gmail 사용자;  
	          String password = "aboutrip$!"; // 패스워드;  
	          return new PasswordAuthentication(username, password);  
	       }  
	}
	private void makeMessage(Message msg, Mail dto) throws MessagingException {
		msg.setText(dto.getContent());
		msg.setHeader("Content-Type", mailType);
	}
	
	public boolean mailSend(Mail dto) {
		boolean b=false;
		
		Properties p = new Properties();   

		p.put("mail.smtp.user", "teststs210601");   
  

		p.put("mail.smtp.host", "smtp.gmail.com"); 
		       

		p.put("mail.smtp.port", "465");   
		p.put("mail.smtp.starttls.enable", "true");   
		p.put("mail.smtp.auth", "true");    
		p.put("mail.smtp.socketFactory.port", "465");   
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		p.put("mail.smtp.socketFactory.fallback", "false");  
		
		try {
			Authenticator auth = new SMTPAuthenticator();  
			Session session = Session.getDefaultInstance(p, auth);

			session.setDebug(true);
			
			Message msg = new MimeMessage(session);


			if(dto.getSenderName() == null || dto.getSenderName().equals(""))
				msg.setFrom(new InternetAddress(dto.getSenderEmail()));
			else
				msg.setFrom(new InternetAddress(dto.getSenderEmail(), dto.getSenderName(), encType));
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dto.getReceiverEmail()));
			
			// 제목
			msg.setSubject(dto.getSubject());
			
			if(mailType.indexOf("text/html") == -1) {
				dto.setContent(aboutUtil.htmlSymbols(dto.getContent()));
			}
			
			makeMessage(msg, dto);
			msg.setHeader("X-Mailer", dto.getSenderName());

			msg.setSentDate(new Date());

			Transport.send(msg);
			
			b=true;
						
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return b;
	}
}
