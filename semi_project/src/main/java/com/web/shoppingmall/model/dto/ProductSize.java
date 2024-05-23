package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	상품 사이즈옵션 종류 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductSize {
	private int sizeKey;
	private String pSize;
}
