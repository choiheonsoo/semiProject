package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	주문 상세 내용 클래스
 * 	주문에 담긴 상품에관한 정보
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetail {
	private int orderDetailKey;
	private int ordersKey;
	private int productKey;
	private int quantity;
	private int price;
	private String orderColor;
	private String orderSize;
	
	private String img;
}