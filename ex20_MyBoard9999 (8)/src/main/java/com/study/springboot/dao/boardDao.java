package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.boardDto;

@Mapper
public interface boardDao {
	
	//글리스트 출력
	public List<boardDto> boardList();

	//글 저장하기
	public int WriteAction
	(String board_name, String board_title, String board_content, 
	 String fileName1, String fileName2,String fileName3,
	 String filePath );
	
	//글 갯수 출력
	public int boardCount();
	
	//글 수정페이지에 수정전 값 전달
	public boardDto boardModify(int board_idx);
	
	//글 수정하기 액션
	public int updateAction(String board_title, String board_name, String board_content, 
			int board_idx , String filename1,String filename2,String filename3, String filepath);
	
	//글 삭제하기
	public int deleteAction(int board_idx);
	
	//이미지 이름,경로 삭제
	public int imgDelNamePath(int board_idx );
	
	//조회수 올리기
	public int updateHit(int board_idx);
	
	//페이징당 게시글 출력
	public List<boardDto> betweenList(int startList, int endList);

	//제목검색 액션
	public List<boardDto> betweenListTitle(int startList, int endList, String keyword);
	public int titleCount(String keyword);
	
	//글쓴이검색
	public List<boardDto> betweenListWrite(int startList, int endList, String keyword);
	public int writeCount(String keyword);
	
	//조회수순
	public List<boardDto> orderHit(int startList,int endList);
}
