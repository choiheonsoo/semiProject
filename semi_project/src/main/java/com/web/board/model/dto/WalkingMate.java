package com.web.board.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class WalkingMate {
	private int walkingMateNo;
	private String userId;
	private String place;
	private Timestamp placeTime;
	private String title;
	private String content;
	private Date rDate;
	private char delC;
	private int recruitmentNumber;
	private double latitue;
	private double logitude;
}