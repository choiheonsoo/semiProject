package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	리뷰 이미지 이름 정보 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReviewImg {
	private int reviewImgKey;
	private int reviewKey;
	private String reviewImg;
}
