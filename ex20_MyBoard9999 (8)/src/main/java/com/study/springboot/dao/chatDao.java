package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.boardDto;
import com.study.springboot.dto.chatDto;

@Mapper
public interface chatDao {
	
	//글리스트 출력
	public List<chatDto> chatList();

	//글 저장하기
	public int chatWrite
	(String member_nameVal, String chat_contentVal );
	
}
