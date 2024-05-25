package com.web.mypage.service;

import static com.web.common.JDBCTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.web.mypage.model.dao.MypageDao;
import com.web.mypage.model.dto.WishList;

public class MypageService {
	private static MypageService service;
	private MypageDao dao = MypageDao.getMypageDao();
	private MypageService() {};
	public static MypageService getService() {
		if(service==null) service = new MypageService();
		return service;
	}
	
	public List<WishList> getWishListByUserId(String id,int cPage, int numPerpage){
		Connection con = getConnection();
		List<WishList> result = dao.getWishListByUserId(con, id, cPage, numPerpage);
		close(con);
		return result;
	}
	
	public int getTotalWishList(String id){
		Connection con = getConnection();
		int result = dao.getTotalWishList(con, id);
		close(con);
		return result;
	}
	
	public int deleteWishListItems(String items) {
		Connection con = getConnection();
		int result = dao.deleteWishListItems(con, items);
		if(result>0)commit(con);
		else rollback(con);
		close(con);
		return result;
	}
}
