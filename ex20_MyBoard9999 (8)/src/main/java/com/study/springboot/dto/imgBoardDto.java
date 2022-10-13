package com.study.springboot.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class imgBoardDto {
	private int img_board_idx;
	private String img_board_name;
	private String img_board_title;
	private String img_board_content;
	private String img_board_filename1;
	private String img_board_filename2;
	private String img_board_filename3;
	private String img_board_filepath;
	private Date img_board_date;
	private int img_board_rm;
	private int img_board_hit;
	private String img_board_category;
}
