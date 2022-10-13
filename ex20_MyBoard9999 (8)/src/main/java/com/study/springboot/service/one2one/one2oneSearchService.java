package com.study.springboot.service.one2one;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.study.springboot.dao.boardDao;
import com.study.springboot.dto.boardDto;

@Component
public class one2oneSearchService {
	@Autowired
	boardDao iBoardDao;
	
	//type   0 hit
	//       1 title
	//       2 writer
	public List<boardDto> betweenList(
			int type, 
			String keyword, 
			String selectList,
			String page, 
			String orderHit,
			Model model) {
		
		model.addAttribute("page",page); //현재페이지 반환 (초기값은 1페이지로 설정했음)
		int curPage = Integer.parseInt(page); //현재페이지
		int listSize =5; //한페이지당 게시글 개수
		int startList = (curPage - 1) * listSize + 1;  //쿼리문 시작 게시물번호
		int endList =  (curPage * listSize); // 쿼리문 끝 게시물번호
		
		int endPage = (int)(Math.ceil((double)curPage / 5)) * 5;
		int startPage = endPage - 4;
		
		
		//분기점
		int totalList = 0;
		if( type == 0 ) {
			totalList = iBoardDao.boardCount(); // 조회수 정렬 
		}
		else if( type == 1 ) {
			totalList = iBoardDao.titleCount(keyword); //제목 게시글 개수
		}
		else if( type == 2 ) {
			totalList = iBoardDao.writeCount(keyword); //글쓴이 게시글 개수
		}
		
		int totalPage = (int)Math.ceil((double)totalList/listSize); //전체페이지수
		 if(endPage > totalPage){
	            endPage = totalPage;
	        }
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("startPage", startPage);
		
		
		List<boardDto> list = null;
		if( type == 1 ) {
			list = iBoardDao.betweenListTitle(startList, endList, keyword);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
		}
		else if( type == 2 ) {
			list = iBoardDao.betweenListWrite(startList, endList, keyword);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
		}
		else if( type == 0 ) {
			list = iBoardDao.orderHit(startList,endList);
			
			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("orderHit", orderHit);
		}		
		return list;
	}
}
