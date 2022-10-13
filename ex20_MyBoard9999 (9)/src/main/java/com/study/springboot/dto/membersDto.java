package com.study.springboot.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class membersDto {

	private int member_idx;
	private String member_id;
	private String member_pw;
	private String member_email;
	private String member_name;
	private Date member_joindate;
}
