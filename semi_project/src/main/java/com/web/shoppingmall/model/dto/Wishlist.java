package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	찜 상품 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Wishlist {
	private int wishlistKey;
	private int productKey;
	private String userId;
}
