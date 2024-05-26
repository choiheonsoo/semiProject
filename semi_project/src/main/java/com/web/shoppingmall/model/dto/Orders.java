package com.web.shoppingmall.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	주문 정보 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Orders {
	private int ordersKey;
	private String userId;
	private String shippingAddress;
	private String shippingStatus;
	private int shippingPrice;
	private String payment;
	private String req;
	private String purchaseStatus;
	private Date shippingDate;
}
