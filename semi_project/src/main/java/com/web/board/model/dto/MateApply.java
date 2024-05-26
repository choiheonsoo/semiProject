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
public class MateApply {
	private int mateApplyKey;
	private int BoardNo;
	private String userId;
	private char accept;
	private Date applyDate;
}
