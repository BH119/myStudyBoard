package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.boardDto;
import com.study.springboot.dto.one2oneDto;

@Mapper
public interface one2oneDao {
	
	//글리스트 출력
	public List<boardDto> boardList();

	//글 갯수 출력
	public int one2oneCount();
	
	//글 저장하기
		public int one2oneWriteAction
		(String one2one_name, String one2one_title, String one2one_content);
	
	//페이징당 게시글 출력
	public List<one2oneDto> betweenList(int startList, int endList);

	//제목검색 액션
	public List<one2oneDto> betweenListTitle(int startList, int endList, String keyword);
	public int titleCount(String keyword);
	
	//글쓴이검색
	public List<one2oneDto> betweenListWrite(int startList, int endList, String keyword);
	public int writeCount(String keyword);
	
}