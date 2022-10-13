package com.study.springboot.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class boardDto {
	
	private int board_idx;
	private String board_name;
	private String board_title;
	private String board_content;
	private Date board_date;
	private int board_hit;
	private String filename1;
	private String filename2;
	private String filename3;
	private String filepath;
}
