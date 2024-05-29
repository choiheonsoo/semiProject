package com.web.mypage.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CusttomBoardList {
	private int cateNo;
	private String title;
	private Date rDate;
	private int hits;
	private int bullNo;
}
