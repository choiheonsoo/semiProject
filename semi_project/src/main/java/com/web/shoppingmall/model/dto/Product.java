package com.web.shoppingmall.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	
	//리뷰 총 갯수
	private int totalReviewCount;
	//평균 별점
	private double avgRating;
	//이미지
	private Map<String, ProductImg> productImgs;
	//카테고리 이름
	private ProductCategory productCategory;
	//옵션
	private List<ProductOption> productOption;
}
