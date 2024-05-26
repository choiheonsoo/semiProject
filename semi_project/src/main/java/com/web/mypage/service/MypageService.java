package com.web.mypage.service;

import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.commit;
import static com.web.common.JDBCTemplate.getConnection;
import static com.web.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.web.mypage.model.dao.MypageDao;
import com.web.mypage.model.dto.CartList;
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
	
	public List<CartList> getCartListByUserId(String id){
		Connection con = getConnection();
		List<CartList> result = dao.getCartListByUserId(con, id);
		close(con);
		return result;
	}
	
	public int getTotalCartList(String id){
		Connection con = getConnection();
		int result = dao.getTotalCartList(con, id);
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
	
	public int deleteCartListItem(int key) {
		Connection con = getConnection();
		int result = dao.deleteCartListItem(con, key);
		if(result>0)commit(con);
		else rollback(con);
		close(con);
		return result;
	}
	
	public int moveToCart(String userId, int key, String color, String size) {
		Connection con = getConnection();
		int result = dao.moveToCart(con, userId, key, color, size);
		if(result>0)commit(con);
		else rollback(con);
		close(con);
		return result;
	}
}
