package com.web.dog.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Dog {
	private String userId;
	private String dogBreedName;
	private String dogName;
	private double dogWeight;
	private String dogImg;
}
 