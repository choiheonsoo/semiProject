package com.web.shoppingmall.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*	
 *	쇼핑몰 상품 클래스
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Product {
	private int productKey;
	private int productCategoryKey;
	private String productName;
	private int price;
	private Date registrationDate;
	private String brand;
	private String content;
	private String deletionStatus;
	private int rateDiscount;
}
