package com.web.board.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bulletin {
	private int bullNo;
	private int categoryNo;
	private String userId;
	private String title;
	private String content;
	private Date rDate;
	private char delC;
	private int hits;
	private int likeC;
	private List<BulletinComment> comments;
	private List<BulletinImg> imgs;
	private List<BulletinLike> likes;
}
