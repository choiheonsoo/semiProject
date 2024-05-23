package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	쇼핑몰 상품 카테고리 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductCategory {
	private int productCategoryKey;
	private String productCategoryName;
}
