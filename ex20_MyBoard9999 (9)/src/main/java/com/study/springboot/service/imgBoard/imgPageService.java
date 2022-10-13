package com.study.springboot.service.imgBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.study.springboot.dao.boardDao;
import com.study.springboot.dao.imgBoardDao;
import com.study.springboot.dto.boardDto;
import com.study.springboot.dto.imgBoardDto;



@Component
public class imgPageService {
	@Autowired
	imgBoardDao iImgBoardDao;
	
	public List<imgBoardDto> PagingList(
			String selectList, String keyword,
			String page,Model model) {
		
	
		
		model.addAttribute("page",page); // 현재 페이지를 반환
		
		int curPage = Integer.parseInt(page); //현재페이지
		int listSize =8; //한페이지당 게시글 개수
		int startList = (curPage - 1) * listSize + 1;  //쿼리문 시작 게시물번호
		int endList =  (curPage * listSize); // 쿼리문 끝 게시물번호
		
		int endPage = (int)(Math.ceil((double)curPage / 5)) * 5; // 페이지 범위 마지막자리 구하는 공식 그냥 외우자.
		int startPage = endPage - 4; // 페이지범위 시작부분 구하는 공식.
		int totalList = iImgBoardDao.imgBoardCount(); //전체 게시글개수
		int totalPage = (int)Math.ceil((double)totalList/listSize); //전체페이지수
		 if(endPage > totalPage){ //페이지범위 마지막숫자가 > 총페이지수보다 크면
	            endPage = totalPage; //총페이지 수로 치환
	        }
		model.addAttribute("totalPage", totalPage); // next버튼 제어하기위해
		model.addAttribute("endPage", endPage); // c:foEach: begin , end 에서 end부분
		model.addAttribute("startPage", startPage); // c:foEach: begin , end 에서 begin부분
		List<imgBoardDto> list = iImgBoardDao.imgBetweenList(startList,endList); // 게시물 리스트 범위 출력
		model.addAttribute("list", list);
		model.addAttribute("selectList", "title"); //title을 반환하는 이유.. idx값을 또 가져오기 귀찮아서..
		                                           //어차피 title로 하나 idx로 하나 총게시물은 같기 때문에...
		                                           //(제목이 있는 게시물 싹다 출력) == (게시물 싹다출력) ->제목이 없는 게시물은 없으니까
		
		
		
		return list;
		
	
	
	}
}
