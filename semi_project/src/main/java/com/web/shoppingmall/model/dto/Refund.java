package com.web.shoppingmall.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * 	환불 내용 클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Refund {
	private int refundKey;
	private int ordersKey;
	private String refundContent;
}
