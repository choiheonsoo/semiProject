package com.web.mail.util;

import java.io.FileReader;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


public class NaverMailSend {
	
	public String sendEmail(String to) throws Exception {
		String authenCode = null;
		
		Properties props = new Properties();
		FileReader fr = new FileReader(NaverMailSend.class.getResource("/send_mail.properties").getPath());
		props.load(fr);
		
		// SMTP 서버 정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스를 생성
		Session session = Session.getDefaultInstance(props, new Authenticator() {
		    protected PasswordAuthentication getPasswordAuthentication() {
		        return new PasswordAuthentication(props.getProperty("user"), props.getProperty("password"));
		    }
		});
		// Message 객체에 수신자와 내용, 제목의 메시지를 작성 
		try {
            // 인증코드 생성
            authenCode = makeAuthenticationCode();
		    Message message = new MimeMessage(session);
		    // 발신자 설정
		    message.setFrom(new InternetAddress(props.getProperty("user"), "산책하개"));
		    // 수신자 메일주소 설정
		    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		    // 메일 제목 설정
		    message.setSubject("산책하개 사이트 임시 비밀번호 메일입니다.");
		    // 메일 내용 설정
		    message.setText("비밀번호 변경 인증번호는 [  "+authenCode+ "  ] 입니다.");
		    // 메세지 전송
		    Transport.send(message);
		    System.out.println("NaverMailSend : Email sent successfully.");
		} catch (MessagingException e) {
		    e.printStackTrace();
		}
		System.out.println("NaverMailSend : sendEmail() 종료");
		return authenCode;
	}
	
	// 인증코드 생성 메서드
	private String makeAuthenticationCode() throws Exception {
		// 인증코드 길이 설정
		int pwdLength = 8;
		// 인증코드를 만들기 위한 배열 설정
		final char[] pwdTable = { 	
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
                'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 
                'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*',
                '(', ')', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		
		// 중복 방지 처리를 위한 System.currentTimeMillis()의 사용
		Random ran = new Random(System.currentTimeMillis());
		StringBuffer bf = new StringBuffer();	// 인증코드 저장공간
		
		for(int i=0; i<pwdLength; i++) {
			bf.append(pwdTable[ran.nextInt(pwdTable.length)]);	// 랜덤한 값을 설정하여 인증코드를 bf에 담음
		}
		return bf.toString();
		
	}
}
