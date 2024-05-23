package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	상품 색상 종류 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Color {
	private int colorKey;
	private String color;
}
