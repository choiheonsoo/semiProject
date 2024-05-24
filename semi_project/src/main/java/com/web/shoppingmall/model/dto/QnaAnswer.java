package com.web.shoppingmall.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


/*
 * 	문의글 답변글에 대한 정보를 담는 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QnaAnswer {
	private int qnaAnswerKey;
	private String qnaAnswerContent;
	private Date qnaAnswerDate;
}
