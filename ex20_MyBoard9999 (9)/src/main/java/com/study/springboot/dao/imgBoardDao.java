package com.study.springboot.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.boardDto;
import com.study.springboot.dto.imgBoardDto;

@Mapper
public interface imgBoardDao {

		//글리스트 출력(이미지게시판)
		public List<imgBoardDto> imgBoardList();

		//글 저장하기(이미지게시판)
		public int imgWriteAction
		(String img_board_title,String img_board_name, String img_board_content,
		String img_board_filename1, String img_board_filename2, String img_board_filename3,
		String img_board_filepath,String img_board_category );
		
		//글 갯수 출력(이미지게시판)
		public int imgBoardCount();
		
		//글 수정페이지에 수정전 값 전달 (이미지게시판)
		public imgBoardDto imgBoardModify(int img_board_idx);
		
		//글 수정하기 액션
		public int updateAction(String board_title, String board_name, String board_content, 
				int board_idx , String filename1,String filename2,String filename3, String filepath);
		
		//글 삭제하기
		public int deleteAction(int board_idx);
		
		//이미지 이름,경로 삭제
		public int imgDelNamePath(int board_idx );
		
		//조회수 올리기 (이미지게시판)
		public int imgUpdateHit(int img_board_idx);
		
		//페이징당 게시글 출력 (이미지게시판)
		public List<imgBoardDto> imgBetweenList(int startList, int endList);

		//제목검색 액션(이미지게시판)
		public List<imgBoardDto> imgBetweenListTitle(int startList, int endList, String keyword);
		public int imgTitleCount(String keyword);
		
		//글쓴이검색(이미지게시판)
		public List<imgBoardDto> imgBetweenListWrite(int startList, int endList, String keyword);
		public int imgWriteCount(String keyword);
		
		//조회수순(이미지게시판)
		public List<imgBoardDto> imgOrderHit(int startList,int endList);
		
		//카테고리(원두)(이미지게시판)
		public List<imgBoardDto> imgBetweenListBeans(int startList, int endList, String ColdBrew);
		public int imgBeansCount(String ColdBrew);
		
		//카테고리(콜드브루)(이미지게시판)
		public List<imgBoardDto> imgBetweenListColdBrew(int startList, int endList, String ColdBrew);
		public int imgColdBrewCount(String ColdBrew);
}
