package com.web.mypage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartList {
	private String userId;
	private String productName;
	private int productKey;
	private int price;
	private double rateDiscount;
	private int optionKey;
	private int stock;
	private String productImg;
	private String productColor;
	private String productSize;
	private int cartKey;
}
