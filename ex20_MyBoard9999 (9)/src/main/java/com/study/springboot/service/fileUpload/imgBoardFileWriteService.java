package com.study.springboot.service.fileUpload;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dao.boardDao;

@Component
public class imgBoardFileWriteService {

	@Autowired
	boardDao iBoardDao;
	@Autowired
	imgBoardFileUploadService iImgBoardFileUploadService;
	public List<String> boardWriteAction( 
			String img_board_name,
			String img_board_title,
			String img_board_content ,
			//파일의 여러 값은 배열형태로
			MultipartFile[] filelist,
			String categoryList) throws IllegalStateException, IOException 
	{
		
		//파일개수 제한 3개이하면서 0번째 인덱스의 값이 실질적으로 있을 때.
		if (filelist.length <4 && !filelist[0].isEmpty()) {
			
			//List는 이름 값들을 저장  ,  3개의 값에 미리 null 을 넣어 놈
			List<String> fileNameList = new ArrayList<String>(Arrays.asList(null,null,null));
		
			int count =0; //count는 인덱스 치환용
			
			// 향상된 포문을 돌려서 오브젝트 처리.
			for( MultipartFile file : filelist) {
				
				//파일 1개 저장 로직
				String fileName = iImgBoardFileUploadService.writeAction(file); //폴더에 저장처리 및 파일이름리턴
				System.out.println("리턴받은값: "+fileName); 

				fileNameList.set(count, fileName); // 배열안에 파일이름저장 (인덱스,값)
				System.out.println("파일값들:"+fileNameList);	
			
				count++;
			}
			//DB저장 로직
			String filepath="";  //경로는 그냥 정해져있으므로 문자열로 할당.
			filepath = "resources\\imgBoard\\";
			
			//값들을 꺼내와서 할당
			String filename1 = fileNameList.get(0);
			String filename2 = fileNameList.get(1);
			String filename3 = fileNameList.get(2);
				
			System.out.println(filename1);
			System.out.println(filename2);
			System.out.println(filename3);
			
			List<String> files = new ArrayList<String>(Arrays.asList(filename1,filename2,filename3,filepath));
			return files;
		}
		else{
			String filepath="";  //경로는 그냥 정해져있으므로 문자열로 할당.
			filepath = "resources\\imgBoard\\";
			
			List<String> files = new ArrayList<String>(Arrays.asList(null,null,null,filepath));
			return files;
		}	
	}
}
