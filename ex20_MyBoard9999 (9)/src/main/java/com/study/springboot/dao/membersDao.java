package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.membersDto;

@Mapper
public interface membersDao {
//Ajax 중복체크
public int idChkAjax(String member_id);

//회원가입
public int joinAction(String member_id , String member_pw, String member_email,String member_name);

//로그인
public int loginAction(String member_id , String member_pw);

//아이디찾기
public List<membersDto> idFindAction(String member_email ,String member_name );

//비밀번호찾기 이름 아이디값 체크
public membersDto pwFindNextStep(String member_name , String member_id);

//비밀번호찾기 이름 아이디값 체크
public String pwFindAction(String member_name , String member_id , String member_email);

}
