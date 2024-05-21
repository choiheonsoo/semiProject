package com.web.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BulletinLike {
	private int bulletinLikeKey;
	private int bullNo;
	private String userId;
}
