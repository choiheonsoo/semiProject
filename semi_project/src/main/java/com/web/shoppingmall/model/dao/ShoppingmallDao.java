package com.web.shoppingmall.model.dao;

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

import com.web.shoppingmall.model.dto.Product;

/*
 * 쇼핑몰 dao
 */
public class ShoppingmallDao {
	private static ShoppingmallDao dao = new ShoppingmallDao();
	public static ShoppingmallDao getDao() {return dao;}
	private Properties sql = new Properties();
	
	private ShoppingmallDao(){
		String path = ShoppingmallDao.class.getResource("/sql/shoppingmall/sql_shoppingmall.properties").getPath();
		try(FileReader fr=  new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			System.out.println("shoppingmall_properties 읽어오는 중 오류 발생");
			e.printStackTrace();
		}
	}
	
	/*
	 * 	해당 카테고리의 상풍 총 갯수를 반환하는 메소드
	 * 	매개변수 : 카테고리번호
	 * 	반환 : 해당 카테고리 상품의 총 갯수
	 */
	public int AllProductCount(Connection conn, int category) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("allProductCount"));
			pstmt.setInt(1, category);
			rs=pstmt.executeQuery();
			if(rs.next()) result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	페이지에 맞는 해당 카테고리의 상품들의 정보를 가져오는 메소드
	 */
	public List<Product> selectProduct(Connection conn, int category, int cPage, int numPerpage, String sort){
		List<Product> result=new ArrayList<Product>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProduct"));
			pstmt.setInt(1, category);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(getProduct(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	private Product getProduct(ResultSet rs)throws SQLException{
		return Product.builder()
				.productKey(rs.getInt("PRODUCT_KEY"))
				.productCategoryKey(rs.getInt("PRODUCT_CATEGORY_KEY"))
				.productName(rs.getString("PRODUCT_NAME"))
				.price(rs.getInt("PRICE"))
				.registrationDate(rs.getDate("REGISTRATION_DATE"))
				.brand(rs.getString("BRAND"))
				.content(rs.getString("CONTENT"))
				.deletionStatus(rs.getString("DELETION_STATUS"))
				.rateDiscount(rs.getInt("RATE_DISCOUNT"))
				.totalReviewCount(rs.getInt("R_COUNT"))
				.avgRating(rs.getInt("AVG_RATING"))
				.build();
	}
}
