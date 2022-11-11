package com.study.springboot.service.fileUpload;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dao.boardDao;

@Component
public class fileUploadService {
	
	@Autowired
	boardDao iBoardDao;
	public String writeAction(MultipartFile file) throws IllegalStateException, IOException
	{

			
			//저장할 경로 설정   System.getProperty("user.dir") = 현재 디렉토리 (경로딸때 유용)
			String ProjectPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\resources\\img"; 
			System.out.println("경로: "+ ProjectPath);
			
			
			// 서버에서 저장 할 파일 이름
			String fileName = "";
			Calendar calendar = Calendar.getInstance();
			fileName += calendar.get(Calendar.YEAR);
			fileName += calendar.get(Calendar.MONTH)+1;
			fileName += calendar.get(Calendar.DATE);
			fileName += calendar.get(Calendar.HOUR);
			fileName += calendar.get(Calendar.MINUTE);
			fileName += calendar.get(Calendar.SECOND);
			
			int PK = 0; //겹치기 방지용
			PK = calendar.get(Calendar.MILLISECOND);
			
			//파일이름 적용
			fileName = fileName +"_"+PK;
			
			// 결과물 할당
			File saveFile = new File(ProjectPath, fileName);
			System.out.println("결과물"+saveFile);
			// 설정해준 폴더경로에 업로드한 파일을 저장시켜줌
			file.transferTo(saveFile); 
			
			return fileName;
	}
}	
	
// ---------  그냥 알아만 두자.. -------------
//	String extName //이건 파일이름에서 .png만 출력하는 코드
//		= fileName.substring(fileName.lastIndexOf("."), fileName.length());
//	System.out.println(extName);


//이건 문자열 치환하는 코드
//ProjectPath = ProjectPath.replace // 패스경로를 resources\img\로 치환 (resources로 시작안하면 파일을 못 찾음..)
//("C:\\Users\\EZEN\\Downloads\\ex20_MyBoard9999 (5)\\src\\main\\webapp\\webapp\\", "");
//ProjectPath = ProjectPath.replace
//("resources\\img", "resources\\img\\");
	
