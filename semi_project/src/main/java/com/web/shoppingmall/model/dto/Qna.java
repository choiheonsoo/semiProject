package com.web.shoppingmall.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	상품 문의(Q&A)글 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Qna {
	private int qnaKey;
	private int productKey;
	private String userId;
	private String qnaContent;
	private Date qnaDate;
	
	private QnaAnswer answer;
}
