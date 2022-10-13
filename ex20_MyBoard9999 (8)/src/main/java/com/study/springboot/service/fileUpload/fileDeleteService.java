package com.study.springboot.service.fileUpload;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

@Component
public class fileDeleteService {

	
	public void fileDelete(
			@RequestParam("filename1") String filename1,
			@RequestParam("filename2") String filename2,
			@RequestParam("filename3") String filename3) 
	{
		//업로드파일 삭제
		String ProjectPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\resources\\img\\";
		List<String> files = new ArrayList<String>(Arrays.asList(filename1,filename2,filename3));
		
		File file;
		for (int i = 0; i < files.size(); i++) {
		file = new File(ProjectPath+ files.get(i));
		file.delete();
		}
	}
}
