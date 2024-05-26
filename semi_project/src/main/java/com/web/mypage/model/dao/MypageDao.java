package com.web.mypage.model.dao;

import static com.web.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.web.mypage.model.dto.CartList;
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
		}
		return list;
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
	
	public List<CartList> getCartListByUserId(Connection con, String id){
		List<CartList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("getCartListByUserId"));
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) list.add(getCartList(rs));
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}return list;
	}
	
	public int getTotalCartList(Connection con, String id){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("getTotalCartList"));
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
	
	public int deleteCartListItem(Connection con, int key) {
		int result=0;
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("deleteCartListItem"));
			pstmt.setInt(1, key);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int moveToCart(Connection con, String userId, int key, String color, String size) {
		int result = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null; // 중복값 이동 방지를 위해 이미 있는지 확인하는 과정
		ResultSet rs = null;
		try {
			pstmt2 = con.prepareStatement(sql.getProperty("getCartRow"));
			pstmt2.setInt(1,key);
			pstmt2.setString(2,color);
			pstmt2.setString(3, size);
			pstmt2.setString(4, userId);
			rs=pstmt2.executeQuery();
			if(!rs.next()) {
				pstmt = con.prepareStatement(sql.getProperty("moveToCart"));
				pstmt.setInt(1, key);
				pstmt.setString(2, userId);
				pstmt.setString(3, color);
				pstmt.setString(4, size);
				result = pstmt.executeUpdate();
			} else { 
				return -100;	// 중복된 값을 받을 때 받는 고유한 리턴 값
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
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
								 .productColor(rs.getString("PRODUCT_COLOR"))
								 .productSize(rs.getString("PRODUCT_SIZE"))
								 .build();
	}
	
	public CartList getCartList(ResultSet rs) throws SQLException {
		return CartList.builder().userId(rs.getString("USER_ID"))
								 .productName(rs.getString("PRODUCT_NAME"))
								 .productKey(rs.getInt("PRODUCT_KEY"))
								 .price(rs.getInt("PRICE"))
								 .rateDiscount(rs.getDouble("RATE_DISCOUNT"))
								 .optionKey(rs.getInt("PRODUCT_OPTION_KEY"))
								 .stock(rs.getInt("STOCK"))
								 .productImg(rs.getString("PRODUCT_IMG"))
								 .productColor(rs.getString("PRODUCT_COLOR"))
								 .productSize(rs.getString("PRODUCT_SIZE"))
								 .cartKey(rs.getInt("CART_KEY"))
								 .build();
	}
}
