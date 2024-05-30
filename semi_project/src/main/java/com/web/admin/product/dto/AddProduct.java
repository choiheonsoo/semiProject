package com.web.admin.product.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AddProduct {
	private int category;
	private String productName;
	private int price;
	private String brand;
	private int discount;
	private String mainImage;
	private String descriptionImages;
	private String color;
	private String size;
	private int stock;
}
