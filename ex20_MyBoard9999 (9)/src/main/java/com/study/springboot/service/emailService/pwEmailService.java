package com.study.springboot.service.emailService;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.study.springboot.dao.membersDao;
import com.study.springboot.dto.membersDto;

import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class pwEmailService {
	@Autowired
	membersDao iMemberDao;
	
    private JavaMailSender mailSender; //의존성 추가해줘야함
    private static final String FROM_ADDRESS = "baga30040@gmail.com";

    public String mailSend(
    		String member_name,
    		String member_id,
    		String member_em) {
    	//비밀번호 이메일로 전송
    	//(id,name,email값이 다 매칭되야 pw값 꺼내줌..)
    	String member_pw = iMemberDao.pwFindAction(member_name, member_id, member_em);
    	if(member_pw != null) {
	    	System.out.println();
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(member_em);
	        message.setFrom(pwEmailService.FROM_ADDRESS);
	        message.setSubject("비밀번호 발송입니다.");
	        message.setText("비밀번호: "+ member_pw);
	        System.out.println(message.getTo());
	        System.out.println(message.getFrom());
	        System.out.println(message.getSubject());
	        System.out.println(message.getText());
	        mailSender.send(message);
			return "1";
    	}
    	else{
    		return "0";
    	}
   }
}
