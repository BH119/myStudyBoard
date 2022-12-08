package com.study.springboot.service.fileUpload;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dao.boardDao;

@Component
public class modifyService {
	@Autowired
	boardDao iBoardDao;
	@Autowired
	writeService iWriteService;
	@Autowired
	fileDeleteService iFieDeleteService;
	
	public int updateAction(
			String board_name,
			String board_title,
			String board_content,
			int board_idx,
			MultipartFile[] filelist, // 수정할 파일들 호출
			String filename1, //수정하기 전 파일들 호출
			String filename2,
			String filename3) throws IllegalStateException, IOException
	{
			
		// 0번인덱스에 파일실질적으로 있으면서 파일개수가 4미만 일 때
		if (!filelist[0].isEmpty() && filelist.length < 4) {
			
			//수정하면 기존에 있던 파일 삭제
			iFieDeleteService.fileDelete(filename1, filename2, filename3);
			System.out.println("파일 지움!!");
		
			// 수정하기 = 기존에 파일 삭제 후 -> 새로운 파일 업데이트 (저장할때 로직과 똑같기 때문에 코드 중복을 피한다.)
			List<String> files = iWriteService.boardWriteAction(board_title, board_content, board_name, filelist);
			int result = iBoardDao.updateAction(board_title , board_name, board_content, 
						board_idx, files.get(0), files.get(1), files.get(2), files.get(3));
			
			return result;
		}
		else {
			String filepath="";  //경로는 그냥 정해져있으므로 문자열로 할당.
			filepath = "/upload/";
			
			iBoardDao.updateAction(board_title , board_name, board_content, 
						board_idx, filename1, filename2, filename3, filepath);
			
			return 0;
		}
	}
}

