package com.web.user.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShippingAddress {
	private int shippingAddressKey;
	private String userId;
	private String shippingAddressName;
	private String recipientName;
	private String zipcode;
	private String shippingAddress;
	private String shippingPhone;
	private String shippingEmail;
	private String defaultShippingAddress;
}
