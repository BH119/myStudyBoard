package com.study.springboot;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.study.springboot.dao.boardDao;
import com.study.springboot.dao.chatDao;
import com.study.springboot.dao.imgBoardDao;
import com.study.springboot.dao.membersDao;
import com.study.springboot.dao.one2oneDao;
import com.study.springboot.dao.membersDao;
import com.study.springboot.dao.replyDao;
import com.study.springboot.dto.chatDto;
import com.study.springboot.dto.imgBoardDto;
import com.study.springboot.dto.membersDto;
import com.study.springboot.dto.replyDto;
import com.study.springboot.service.pageService;
import com.study.springboot.service.searchService;
import com.study.springboot.service.emailService.emailService;
import com.study.springboot.service.emailService.pwEmailService;
import com.study.springboot.service.fileUpload.fileDeleteService;
import com.study.springboot.service.fileUpload.imgBoardFileUploadService;
import com.study.springboot.service.fileUpload.imgBoardFileWriteService;
import com.study.springboot.service.fileUpload.modifyService;
import com.study.springboot.service.fileUpload.writeService;
import com.study.springboot.service.imgBoard.imgPageService;
import com.study.springboot.service.imgBoard.imgSearchService;
import com.study.springboot.service.one2one.one2onePageService;
import com.study.springboot.service.one2one.one2oneSearchService;


@Controller
public class boardController {
	
	@Autowired
	boardDao iBoardDao;
	@Autowired
	pageService iPageService;
	@Autowired
	replyDao iReplyDao;
	@Autowired
	searchService iSearchService;
	@Autowired
	membersDao iMemberDao;
	@Autowired
	writeService iWriteService;
	@Autowired
	modifyService iModifyService;
	@Autowired
	fileDeleteService iFileDeleteService;
	@Autowired
	emailService iEamilService;
	@Autowired
	pwEmailService iPwEmailService;
	@Autowired
	imgBoardFileWriteService iImgBoardFileWriteService;
	@Autowired
	imgBoardDao iImgBoardDao;
	@Autowired
	imgPageService iImgPageService;
	@Autowired
	imgSearchService iImgSearchService;
	@Autowired
	one2oneDao iOne2oneDao;
	@Autowired
	one2onePageService iOne2onePageService;
	@Autowired
	one2oneSearchService iOne2oneSearchService;
	@Autowired
	chatDao iChatDao;
	
	//메인페이지 폼으로
	@RequestMapping("/")
	public String main(
			@RequestParam(defaultValue = "1") String page, // null값이면 page 디폴트 값이 "1"이다 페이지초기값 설정
			@RequestParam(value="selectList",required=false) String selectList,
			@RequestParam(value="keyword",required=false) String keyword,
			@RequestParam(value="orderHit",required=false) String orderHit,
			Model model) {
		
		if(selectList == null) {
			//글 개수
			int listCount = iImgBoardDao.imgBoardCount();
			model.addAttribute("listCount" , listCount);
			//페이징
			iPageService.PagingList
			(selectList ,keyword ,page, model);
			
		}else if(selectList.equals("title")) {	
			int type = 1;
			//제목 검색글 개수
			int listCount = iImgBoardDao.imgTitleCount(keyword);
			model.addAttribute("listCount" , listCount);
			//제목 검색
			iSearchService.betweenList
			(type,keyword,selectList,page,orderHit,model);
			
			
		}else if(selectList.equals("write")) {
			int type = 2;
			//글쓴이 게시물 및 개수
			int listCount = iBoardDao.writeCount(keyword);
			model.addAttribute("listCount" , listCount);
			iSearchService.betweenList
			(type,keyword,selectList,page,orderHit,model);
			
		}
		//조회수 정렬
		if(orderHit == null) {
			orderHit = "0";
		}
		if(orderHit.equals("orderHit")) {
			int type = 0;
			iSearchService.betweenList
			(type,keyword,selectList,page,orderHit,model);
		}
		return "main";
	}
	
	
	
	//글쓰기 폼으로~
	@RequestMapping("boardWrite")
	public String boardWrite() {
		return "boardWrite";
	}
	//글쓰기 액션
	@RequestMapping("boardWriteAction")
	@ResponseBody
	public String boardWriteAction( 
			@RequestParam("boardTitle") String board_title,
			@RequestParam("boardContent") String board_content,
			@RequestParam("boardName") String board_name ,
			//여러 값은 배열형태로
			@RequestParam("filename") MultipartFile[] filelist ) throws IllegalStateException, IOException 
	{
		
		 List<String> files =iWriteService.boardWriteAction(board_title, board_content, board_name, filelist);
		 
		 int result =iBoardDao.WriteAction(board_name, board_title, board_content,
				  files.get(0), files.get(1), files.get(2), files.get(3));
		 System.out.println(result);
		 
		 if(result == 1 && filelist.length < 4) {
			 return "<script>alert('글 등록 성공!'); location.href='/';</script>";
		 }
		 else {
			 return "<script>alert('3개 이하로설정해주세요');window.history.back();</script>";
		 }
			 
	}
	
	//수정하기 폼으로~
		@RequestMapping("modifyForm")
		public String modifyForm(
				@RequestParam("board_idx") int board_idx,
				Model model) {
			//수정하기
			iBoardDao.boardModify(board_idx);
			model.addAttribute("dto" , iBoardDao.boardModify(board_idx));
			
			//댓글 리스트
			List<replyDto> list = iReplyDao.replyList(board_idx);
			model.addAttribute("list", list);
			
			//조회수
			iBoardDao.updateHit(board_idx);
			return "modifyForm";
		}
		//수정하기 액션
		@RequestMapping("modifyAction")
		@ResponseBody
		public String modifyAction(
				@RequestParam("boardIdx") int board_idx,
				@RequestParam("boardTitle") String board_title,
				@RequestParam("boardName") String board_name,
				@RequestParam("boardContent") String board_content,
				@RequestParam("filename1") String filename1,
				@RequestParam("filename2") String filename2,
				@RequestParam("filename3") String filename3,
				@RequestParam("filenames") MultipartFile[] filelist) throws IllegalStateException, IOException
		{
					System.out.println("ddddsss"+filelist[0].isEmpty());
			
			
			int result = iModifyService.updateAction(board_name, board_title, board_content, board_idx, 
								filelist, filename1, filename2, filename3);
			if(result == 1 && filelist.length < 4) {
				return "<script>alert('글 수정 성공!');location.href='modifyForm?board_idx="+board_idx+"';</script>";}
			else if(filelist.length >= 4) {
				return "<script>alert('3개 이하로설정해주세요');window.history.back();</script>";}
			else {
				return "<script>alert('글 수정 성공!');location.href='modifyForm?board_idx="+board_idx+"';</script>";}
	
		}
		
	//게시글 삭제하기
	@RequestMapping("listDelete")
	public String listDelete(
			@RequestParam("board_idx") int board_idx,
			@RequestParam("filename1") String filename1,
			@RequestParam("filename2") String filename2,
			@RequestParam("filename3") String filename3) 
	{
		
		//업로드파일 삭제
		iFileDeleteService.fileDelete(filename1, filename2, filename3);
		//글 삭제
		iBoardDao.deleteAction(board_idx);
		//댓글 삭제
		iReplyDao.replyDeleteAll(board_idx);
		return "redirect:/";
	}
	
	// 이미지 개별삭제
	@RequestMapping("imgDelete")
	public String imgDelete(
			@RequestParam("board_idx") int board_idx,
			@RequestParam("filename1") String filename1,
			@RequestParam("filename2") String filename2,
			@RequestParam("filename3") String filename3)
	{
		//DB에 저장된 파일이름,경로 삭제
		iBoardDao.imgDelNamePath(board_idx);
		//업로드파일 삭제
		iFileDeleteService.fileDelete(filename1, filename2, filename3);
		
		return "redirect:modifyForm?board_idx="+ board_idx;
	}
	
	//댓글달기 액션
	@RequestMapping("replyAction")
	public String replyAction(
			@RequestParam("reply_board_idx") int reply_board_idx,
			@RequestParam("reply_name") String reply_name,
			@RequestParam("reply_content") String reply_content,
			Model model) {
		
		//댓글 쓰기
		iReplyDao.replyWrite(reply_name, reply_content, reply_board_idx);
		
		return "redirect:modifyForm?board_idx="+reply_board_idx;
	}
	
	//댓글삭제 액션
	@RequestMapping("replyDelete")
	public String replyDelete(
			@RequestParam("reply_board_idx") int reply_board_idx,
			@RequestParam("reply_idx") int reply_idx,
			Model model) {
		//댓글 삭제
		iReplyDao.replyDelete(reply_idx);
		return "redirect:modifyForm?board_idx="+reply_board_idx;
	}
	//회원가입 페이지이동
	@RequestMapping("joinForm")
	public String joinForm() {
		return "joinForm";
	
	}
	//Ajax 아이디 중복처리
	@RequestMapping("/joinForm/idChkAjax")
	@ResponseBody
	public String idChkAjax(
			@RequestParam("member_id")String member_id) {
		int reuslt = iMemberDao.idChkAjax(member_id);
		if(reuslt >= 1) {
			return "1";
		}
		else {
			return "0";
		}
	}
	
    //Ajax 이메일 전송
	@RequestMapping("/joinForm/emailAction")
	@ResponseBody
	public String emailAction(
			@RequestParam("member_em")String member_em) {
		String result = iEamilService.mailSend(member_em );
		return result;
	}
	
	//회원가입
	@RequestMapping("joinAction")
	@ResponseBody
	public String joinAction(
			@RequestParam("member_id")String member_id,
			@RequestParam("member_pw")String member_pw,
			@RequestParam("member_email")String member_email,
			@RequestParam("member_name")String member_name) {
		iMemberDao.joinAction(member_id, member_pw, member_email,member_name);
		return "<script>alert('회원가입이 완료되었습니다.^^'); location.href='/';</script>";
	}
	//로그인 및 세션저장
	@RequestMapping("loginAction")
	@ResponseBody
	public String loginAction(
			@RequestParam("member_id")String member_id,
			@RequestParam("member_pw")String member_pw,
			HttpServletRequest request){ 
		int result = iMemberDao.loginAction(member_id, member_pw);
		
		if(result == 1) {
			request.getSession().setAttribute("member_id", member_id);
			request.getSession().setAttribute("member_pw", member_pw);
			return "1";
		}
		else {
			return "0";
		}
	}
	//로그아웃
	@RequestMapping("logoutAction")
	public String loginAction(HttpServletRequest request) {
		//세션삭제
		request.getSession().invalidate();
		return "redirect:/";
	}
	//아이디찾기폼
	@RequestMapping("idFind")
	public String idFind() {
		return "idFind";
	}
	
	//아이디찾기액션
	@RequestMapping("/idFind/idFindAction")
	@ResponseBody
	public String idFindAction(
			@RequestParam("member_emVal")String member_emVal,
			@RequestParam("member_nameVal")String member_nameVal,
			Model model) {
		
		List<membersDto> list = iMemberDao.idFindAction(member_emVal, member_nameVal);
		
		if(!list.isEmpty()) { //일치하는 값이 있으면..
			Gson gson = new GsonBuilder().create(); //gson라이브러리로 list를 json형식으로 바꿔버림
			System.out.println(gson.toJson(list));
			return gson.toJson(list);
		}
		else { //일치하는 값이 없으면..
			return "0";
		}
	}
	
	//비밀번호찾기폼
	@RequestMapping("pwFind")
	public String pwFind() {
		return "pwFind";
	}
	
	//비밀번호찾기: db쪽 namd,id값 일치하는지 확인
	@RequestMapping("pwFindNextStep")
	@ResponseBody
	public String pwFind1(
			@RequestParam("member_name")String member_name,
			@RequestParam("member_id")String member_id) {
		
		membersDto result = iMemberDao.pwFindNextStep(member_name, member_id);
		if(result != null) {
			return "1"; // db속 id,name값을 param값과 겹치면 1반환
		}
		else {
			return "0"; // null이면( 매칭이 안된거니까) 0반환 
		}
	}
	
	//Ajax 패스워드 이메일 전송
	@RequestMapping("PwEmailAction")
	@ResponseBody
	public String PwEmailAction(
			@RequestParam("member_name")String member_name,
			@RequestParam("member_id")String member_id,
			@RequestParam("member_email")String member_em) {
		//비밀번호 이메일로 전송(id,name,email값이 다 매칭되야 1반환)
		String result =iPwEmailService.mailSend(member_name, member_id, member_em);
		if(result == "1") {
			return "1"; 
		}
		else {
			return "0";
		}
	}
	

	
	
	
	//이미지 게시판
	@RequestMapping("/imgBoard1")
	public String imgBoard(
			@RequestParam(defaultValue = "1") String page, // null값이면 page 디폴트 값이 "1"이다 페이지초기값 설정
			@RequestParam(value="selectList",required=false) String selectList,
			@RequestParam(value="keyword",required=false) String keyword,
			@RequestParam(value="orderHit",required=false) String orderHit,
			@RequestParam(value="beans",required=false) String beans,
			@RequestParam(value="coldBrew",required=false) String coldBrew,
			@RequestParam(value="recent",required=false) String recent,
			Model model) {
		
		
		if(selectList == null) {
			//글 개수
			int listCount = iImgBoardDao.imgBoardCount();
			model.addAttribute("listCount" , listCount);
			//페이징
			iImgPageService.PagingList
			(selectList ,keyword ,page, model);
		}
		else if(selectList.equals("title")) {	
			int type = 1;
			//제목 검색글 개수
			int listCount = iImgBoardDao.imgTitleCount(keyword);
			model.addAttribute("listCount" , listCount);
			//제목 검색
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent, model);
		}
		else if(selectList.equals("write")) {
			int type = 2;
			//글쓴이 게시물 및 개수
			int listCount = iBoardDao.writeCount(keyword);
			model.addAttribute("listCount" , listCount);
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent, model);
		}
		
		
		//원두
		if(beans == null) {
			beans = "0";
		}
		if(beans.equals("1")) {
			int type = 3;
			int listCount = iImgBoardDao.imgBeansCount(beans);
			model.addAttribute("listCount" , listCount);
			//카테고리검색 원두
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent,model);
		}
		
		//콜드브루
		if(coldBrew == null) {
			coldBrew = "0";
		}
		if(coldBrew.equals("2")) {
			int type = 4;
			//카테고리가 콜드브루
			int listCount = iImgBoardDao.imgBeansCount(coldBrew);
			model.addAttribute("listCount" , listCount);
			//카테고리검색 원두
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent,model);
		}	
		if(recent == null) {
			recent = "0";
		}
		if(recent.equals("3")) {
			int type = 5;
			//최신순
			int listCount = iImgBoardDao.imgBoardCount();
			model.addAttribute("listCount" , listCount);
			//카테고리검색 원두
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent,model);
		}	
		
		
		//조회수 정렬
		if(orderHit == null) {
			orderHit = "0";
		}
		if(orderHit.equals("orderHit")) {
			int type = 0;
			iImgSearchService.betweenList
			(type,keyword,selectList,page,orderHit,beans,coldBrew,recent, model);
		}
		return "imgBoard/imgBoard1";
	}
	
	//이미지글쓰기폼
	@RequestMapping("imgBoardWrite")
	public String imgBoardWrite( ) {
		return "imgBoard/imgBoardWrite";
	}
	
	//이미지글쓰기 액션
	@RequestMapping("imgBoardWriteAction")
	@ResponseBody
	public String imgBoardWriteAction( 
			@RequestParam("imgBoardName") String img_board_name,
			@RequestParam("imgBoardTitle") String img_board_title,
			@RequestParam("imgBoardContent") String img_board_content ,
			//여러 값은 배열형태로
			@RequestParam("filename") MultipartFile[] filelist,
			@RequestParam("categoryList") String categoryList ) throws IllegalStateException, IOException 
	{
		if(filelist.length < 4 && !filelist[0].isEmpty()) {
		List<String> files = iImgBoardFileWriteService.boardWriteAction
		(img_board_name, img_board_title, img_board_content, filelist, categoryList);
		
		
		   int result = iImgBoardDao.imgWriteAction
		(img_board_title, img_board_name, img_board_content, files.get(0),
				files.get(1), files.get(2), files.get(3), categoryList);
			System.out.println("dddsss:"+result);
			
			 return "<script>alert('글 등록 성공!'); location.href='imgBoard1';</script>";
		 }
		 else if (filelist[0].isEmpty()){
			 return "<script>alert('이미지를 한 개 이상 올려주세요');window.history.back();</script>";
		 }
		 else {
			 return "<script>alert('이미지를 3개이하로 설정해주세요');window.history.back();</script>";
		 }
	}
		
	//이미지view폼
	@RequestMapping("imgView")
	public String imgView(
		@RequestParam("img_board_idx") int img_board_idx,
			Model model) 
	{
		//수정하기
		iImgBoardDao.imgBoardModify(img_board_idx);
		model.addAttribute("dto" , iImgBoardDao.imgBoardModify(img_board_idx));
		
		//댓글 리스트
		List<replyDto> list = iReplyDao.imgReplyList(img_board_idx);
		model.addAttribute("list", list);
		
		//조회수
		iImgBoardDao.imgUpdateHit(img_board_idx);
		return "imgBoard/imgView";
	}  
		
		//이미지댓글달기 액션
		@RequestMapping("imgReplyAction")
		public String imgReplyAction(
				@RequestParam("reply_img_board_idx") int reply_img_board_idx,
				@RequestParam("reply_name") String reply_name,
				@RequestParam("reply_content") String reply_content,
				Model model) {
			
			//댓글 쓰기
			iReplyDao.imgReplyWrite(reply_name, reply_content, reply_img_board_idx);
			
			return "redirect:imgView?img_board_idx="+reply_img_board_idx;
		}

	
	
	
	
	//1대1문의 게시판
	@RequestMapping("one2one")
	public String one2one(
			@RequestParam(defaultValue = "1") String page, // null값이면 page 디폴트 값이 "1"이다 페이지초기값 설정
			Model model) {
			
			System.out.println("아ㅏㅏㅏㅏㅏㅏㅏㅏㅏ");
			//글 개수
			int listCount = iOne2oneDao.one2oneCount();
			model.addAttribute("listCount" , listCount);
			//페이징
			iOne2onePageService.PagingList
			(page, model);
			
		
		return "one2one/one2one";
	
	}
	@RequestMapping("one2oneWrite")
	public String one2oneWrite( )
	{
		 return "one2one/one2oneWrite";
	}
	@RequestMapping("one2oneWrite2")
	public String one2oneWrite2(
			@RequestParam("one2one_idx") int one2one_idx,
			Model model)
	{
		System.out.println(one2one_idx);
		model.addAttribute("dto" ,iOne2oneDao.one2oneIDX(one2one_idx)); 
		 System.out.println(iOne2oneDao.one2oneIDX(one2one_idx));
		 return "one2one/one2oneWrite2";
	}
	
	
	
	
	@RequestMapping("one2oneWriteAction")
	public String one2oneWriteAction( 
			@RequestParam("one2oneTitle") String one2one_title,
			@RequestParam("one2oneContent") String one2one_content,
			@RequestParam("one2oneName") String one2one_name)
	{
		 System.out.println(one2one_title);
		 iOne2oneDao.one2oneWriteAction(one2one_name, one2one_title, one2one_content);
		 
		 return "redirect:/one2one";
	}
	
	
	@RequestMapping("one2oneWriteAction2")
	public String one2oneWriteAction2( 
			@RequestParam("one2oneTitle") String one2one_title,
			@RequestParam("one2oneContent") String one2one_content,
			@RequestParam("one2oneName") String one2one_name,
			@RequestParam("one2one_idx") int one2one_idx)
	{
		 
		 iOne2oneDao.replyUpdateAction(one2one_idx);
		 iOne2oneDao.one2oneReplyAction(one2one_name, one2one_title, one2one_content,one2one_idx);
		 return "redirect:/one2one";
	}
	
	
	//채팅방으로~
	@RequestMapping("/chat")
	public String chat() {
		return "/chat";
	}
	
	
	//채팅저장
	@RequestMapping("/chatAction")
	public String chatAction(
			@RequestParam("member_nameVal")String member_nameVal,
			@RequestParam("chat_contentVal")String chat_contentVal,
			Model model) {
			
		
		iChatDao.chatWrite(member_nameVal, chat_contentVal);
		List<chatDto> list = iChatDao.chatList();
		
		model.addAttribute("list", list);
		
		
		System.out.println(list);
		System.out.println(member_nameVal);
		System.out.println(chat_contentVal);
		return "0";
	}
	
	
	
}	
