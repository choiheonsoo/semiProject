package com.web.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Report {
	private int reportKey;
	private String reportType;
	private int reportTypeKey;
	private int bullNo;
	private String reportedId;
	private String reporterId;
	private String reportContent;
}
