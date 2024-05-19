package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	장바구니 목록 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cart {
	private int cart;
	private int productKey;
	private String userId;
}
