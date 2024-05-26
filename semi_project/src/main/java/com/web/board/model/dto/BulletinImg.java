package com.web.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class BulletinImg {
	private int bulletinImgKey;
	private int bullNo;
	private String bullImg;
}
