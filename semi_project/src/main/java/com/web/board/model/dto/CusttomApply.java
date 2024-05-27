package com.web.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class CusttomApply {
	private String userId;
	private String userName;
	private String address;
	private int mateCount;
	private int totalMembers;
	private int boardNo;
}
