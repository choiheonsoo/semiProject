package com.web.mypage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class WishList {
	private double rateDiscount;
	private int productKey;
	private String productName;
	private int price;
	private String productImg;
	private int wishListKey;
	private String thumnail;
	private int productCategoryKey;
}
