package com.web.mypage.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static com.web.common.JDBCTemplate.*;
import com.web.mypage.model.dto.WishList;

public class MypageDao {
	private Properties sql = new Properties();
	private static MypageDao dao = new MypageDao();
	public static MypageDao getMypageDao() {return dao;}
	private MypageDao() {
		try(FileReader fr = new FileReader(MypageDao.class.getResource("/sql/mypage/sql_mypage.properties").getPath())){
			sql.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	};
	
	
	public List<WishList> getWishListByUserId(Connection con, String id, int cPage, int numPerpage){
		List<WishList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("getWishListByUserId"));
			pstmt.setString(1, id);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) list.add(getWishList(rs));
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}return list;
	}
	
	public int getTotalWishList(Connection con, String id){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("getTotalWishList"));
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public int deleteWishListItems(Connection con, String items) {
		int result=0;
		PreparedStatement pstmt = null;
		try {
			String sqlStatement = sql.getProperty("deleteWishListItems").replace("#VALUE", items);
			pstmt = con.prepareStatement(sqlStatement);
			result = pstmt.executeUpdate();		
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public WishList getWishList(ResultSet rs) throws SQLException {
		return WishList.builder().rateDiscount(rs.getDouble("rate_discount"))
								 .productKey(rs.getInt("product_key"))
								 .productName(rs.getString("product_name"))
								 .price(rs.getInt("price"))
								 .productImg(rs.getString("product_img"))
								 .wishListKey(rs.getInt("wishlist_key"))
								 .thumnail(rs.getString("thumbnail"))
								 .productCategoryKey(rs.getInt("PRODUCT_CATEGORY_KEY"))
								 .build();
	}
}
