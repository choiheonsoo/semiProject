package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/*
 * 	상품의 옵션 정보 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class ProductOption {
	private int productOptionKey;
	private int productKey;
	private int colorKey;
	private int sizeKey;
	private int stock;
	
	private ProductSize productSize;
	private Color color;
}
