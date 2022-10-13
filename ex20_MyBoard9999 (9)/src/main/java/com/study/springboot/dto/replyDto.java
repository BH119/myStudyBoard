package com.study.springboot.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class replyDto {

	private int reply_idx;
	private String reply_name;
	private String reply_content;
	private Date reply_date;
	private int reply_board_idx;
	private int reply_img_board_idx;
}
