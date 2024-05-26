package com.web.user.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.web.dog.model.dto.Dog;
import com.web.shoppingmall.model.dto.Review;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class User {
	private String userId;
	private String userName;
	private String phone;
	private String email;
	private String address;
	private String password;
	private int mateCount;
	private int point;
	private boolean status;
	private Date birthDay;
	private String zipCode;
	private List<Review> reviews;
	private List<Dog> dog;
	private List<ShippingAddress> shippingAddress;
}
