package com.web.board.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class BulletinComment {
	private int mainComment;
	private int subComment;
	private int bullNo;
	private String userId;
	private String content;
	private Date rDate;
	private char delC;
	private int commentLevel;
}
