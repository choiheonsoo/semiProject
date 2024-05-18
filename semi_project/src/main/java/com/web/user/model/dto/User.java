package com.web.user.model.dto;

import java.sql.Date;

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
	
}
