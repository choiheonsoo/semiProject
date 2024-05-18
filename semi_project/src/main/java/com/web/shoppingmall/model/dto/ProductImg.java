package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	상품 이미지 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductImg {
	private int productImgKey;
	private int productKey;
	private String productImg;
	private String thumnail;
	private String descriptionImg;
}
