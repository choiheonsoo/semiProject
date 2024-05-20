package com.web.shoppingmall.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	상품 리뷰 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Review {
	private int reviewKey;
	private int productKey;
	private String userId;
	private Date reviewDate;
	private int rating;
	private String reviewContent;
	private List<ReviewImg> reviewImgs;
}
