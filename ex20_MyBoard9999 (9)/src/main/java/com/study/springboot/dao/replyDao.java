package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.replyDto;

@Mapper
public interface replyDao {

	//댓글 리스트
	List<replyDto> replyList(int board_idx);
	
	//댓글 쓰기
	public int replyWrite(String reply_name , String reply_content ,int reply_board_idx);
	
	//이미지댓글 리스트
	List<replyDto> imgReplyList(int reply_img_board_idx);
	
	//이미지댓글 쓰기
	public int imgReplyWrite(String reply_name , String reply_content ,int reply_img_board_idx);
	
	//댓글 삭제
	public int replyDelete(int reply_idx);
	
	//댓글 전부 삭제
	public int replyDeleteAll(int reply_board_idx);
}
