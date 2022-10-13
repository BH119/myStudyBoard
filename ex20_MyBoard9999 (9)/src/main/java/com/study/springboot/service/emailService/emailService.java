package com.study.springboot.service.emailService;

import java.util.Random;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor // 이 어노테이션을 사용해야함(필드내 모든생성자를 생성해준다는데..) 
					// 저 스택틱저놈이랑 javaMailsender 이녀석을 mailsend에서 쓸수 있게 생성자를
					// 생성해준다는 그런 말t인것같은데
public class emailService {

    private JavaMailSender mailSender; //의존성 추가해야함
    private static final String FROM_ADDRESS = "baga30040@gmail.com";

    public String mailSend(String member_em) {
    	
    	

    	//랜덤난수6자리 0이 맨앞에붙으면 자릿수가 줄어듦 그래서 111111~99999까지
    	Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		String Chknum = String.valueOf(checkNum); 
    	
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(member_em);
        message.setFrom(emailService.FROM_ADDRESS);
        message.setSubject("인증번호 발송입니다.");
        message.setText("인증번호: "+ Chknum);
        System.out.println(message.getTo());
        System.out.println(message.getFrom());
        System.out.println(message.getSubject());
        System.out.println(message.getText());
        mailSender.send(message);
		return Chknum;
    }
}
