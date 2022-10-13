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
public class imgSearchService {
	@Autowired
	imgBoardDao iImgBoardDao;
	
	
	//type   0 hit
	//       1 title
	//       2 writer
	public List<imgBoardDto> betweenList(
			int type, 
			String keyword, 
			String selectList,
			String page, 
			String orderHit,
			String beans,
			String coldBrew,
			String recent, Model model) {
		
		model.addAttribute("page",page); //현재페이지 반환 (초기값은 1페이지로 설정했음)
		int curPage = Integer.parseInt(page); //현재페이지
		int listSize =8; //한페이지당 게시글 개수
		int startList = (curPage - 1) * listSize + 1;  //쿼리문 시작 게시물번호
		int endList =  (curPage * listSize); // 쿼리문 끝 게시물번호
		
		int endPage = (int)(Math.ceil((double)curPage / 5)) * 5;
		int startPage = endPage - 4;
		
		
		//분기점
		int totalList = 0;
		if( type == 0 ) {
			totalList = iImgBoardDao.imgBoardCount(); // 조회수 정렬 
		}
		else if( type == 1 ) {
			totalList = iImgBoardDao.imgTitleCount(keyword); //제목 게시글 개수
		}
		else if( type == 2 ) {
			totalList = iImgBoardDao.imgWriteCount(keyword); //글쓴이 게시글 개수
		}
		else if( type == 3 ) {
			totalList = iImgBoardDao.imgBeansCount(beans); //원두 게시글 개수
		}
		else if( type == 4 ) {
			totalList = iImgBoardDao.imgColdBrewCount(coldBrew); //콜드브루 게시글 개수
		}
		else if( type == 5 ) {
			totalList = iImgBoardDao.imgBoardCount(); // 최신순
		}
		
		int totalPage = (int)Math.ceil((double)totalList/listSize); //전체페이지수
		 if(endPage > totalPage){
	            endPage = totalPage;
	        }
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("startPage", startPage);
		
		
		List<imgBoardDto> list = null;
		if( type == 1 ) {
			list = iImgBoardDao.imgBetweenListTitle(startList, endList, keyword);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
		}
		else if( type == 2 ) {
			list = iImgBoardDao.imgBetweenListWrite(startList, endList, keyword);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			
		}
		else if( type == 3) {
			list = iImgBoardDao.imgBetweenListBeans(startList, endList, beans);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("beans", beans);
		}
		else if( type == 4) {
			list = iImgBoardDao.imgBetweenListColdBrew(startList, endList, coldBrew);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("coldBrew", coldBrew);
		}
		else if( type == 5) {
			list = iImgBoardDao.imgBetweenList(startList, endList);

			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("recent", recent);
		}
		else if( type == 0 ) {
			list = iImgBoardDao.imgOrderHit(startList,endList);
			
			model.addAttribute("list", list);
			model.addAttribute("selectList", selectList);
			model.addAttribute("keyword", keyword);
			model.addAttribute("orderHit", orderHit);
		}		
		return list;
	}
}
