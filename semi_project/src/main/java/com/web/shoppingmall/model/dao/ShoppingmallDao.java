package com.web.shoppingmall.model.dao;

import static com.web.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.web.dog.model.dto.Dog;
import com.web.shoppingmall.model.dto.Cart;
import com.web.shoppingmall.model.dto.Color;
import com.web.shoppingmall.model.dto.OrderDetail;
import com.web.shoppingmall.model.dto.Orders;
import com.web.shoppingmall.model.dto.Product;
import com.web.shoppingmall.model.dto.ProductCategory;
import com.web.shoppingmall.model.dto.ProductImg;
import com.web.shoppingmall.model.dto.ProductOption;
import com.web.shoppingmall.model.dto.ProductSize;
import com.web.shoppingmall.model.dto.Qna;
import com.web.shoppingmall.model.dto.QnaAnswer;
import com.web.shoppingmall.model.dto.Review;
import com.web.shoppingmall.model.dto.ReviewImg;
import com.web.shoppingmall.model.dto.Wishlist;
import com.web.user.model.dto.User;

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
	 * 	매개변수로 받은 카테고리의 상풍 총 개수를 반환하는 메소드
	 * 	매개변수 : 카테고리번호
	 * 	반환 : 카테고리 상품의 총 개수(int)
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
	 * 	매개변수로 받은 페이지와 카테고리와 정렬기준에 맞는 상품들의 정보를 가져오는 메소드
	 * 	매개변수 : 카테고리넘버, 현재페이지숫자, 출력할상품개수, 정렬기준
	 * 	반환 : 상품 리스트
	 */
	public List<Product> selectProduct(Connection conn, int category, int cPage, int numPerpage, String sort){
		List<Product> result=new ArrayList<Product>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sortSql=sql.getProperty("selectProduct").replace(":SORT", sort);
		try {
			pstmt=conn.prepareStatement(sortSql);
			pstmt.setInt(1, category);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(getProductForListpage(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지에 필요한 상품정보를 가져오는 메소드
	 * 	상품의 고유키로 상품을 검색하여 가져온다.
	 * 	매개변수 : 상품고유키
	 * 	반환 : 상품 객체
	 */
	public Product selectProductByKey(Connection conn, int productKey) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Product result=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProductByKey"));
			pstmt.setInt(1, productKey);
			pstmt.setInt(2, productKey);
			pstmt.setInt(3, productKey);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=getProductForDetailpage(rs, result);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지의 상품에 대한 상품옵션 객체를 반환하는 메소드
	 * 	상품의 고유키와 사이즈로 검색하여 상품옵션객체를 가져온다
	 * 	매개변수 : 상품고유키
	 * 	반환 : 상품옵션 객체
	 */
	public ProductOption selectProductOptionByKey(Connection conn, int productKey){
		ProductOption result=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProductOptionByKey"));
			pstmt.setInt(1, productKey);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result=new ProductOption().builder().stock(rs.getInt("STOCK")).build();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지의 상품에 대한 사이즈 옵션에 대한 상품옵션 객체리스트를 반환하는 메소드
	 * 	상품의 고유키와 사이즈로 검색하여 상품옵션객체를 가져온다
	 * 	매개변수 : 상품고유키, 사이즈
	 * 	반환 : 상품옵션 리스트
	 */
	public List<ProductOption> selectProductOptionBySize(Connection conn, int productKey, String size){
		List<ProductOption> result=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProductOptionBySize"));
			pstmt.setInt(1, productKey);
			pstmt.setString(2, size);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(new ProductOption().builder().color(new Color().builder().color(rs.getString("COLOR")).build()).stock(rs.getInt("STOCK")).build());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지의 상품에 대한 상품옵션 객체를 반환하는 메소드
	 * 	상품의 고유키와 색상으로 검색하여 상품옵션객체를 가져온다
	 * 	매개변수 : 상품고유키, 색상
	 * 	반환 : 상품옵션 객체
	 */
	public ProductOption selectProductOptionByColor(Connection conn, int productKey, String color){
		ProductOption result=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProductOptionByColor"));
			pstmt.setInt(1, productKey);
			pstmt.setString(2, color);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result=new ProductOption().builder().stock(rs.getInt("STOCK")).build();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지의 상품에대한 리뷰객체리스트를 담고있는 회원객체리스트를 반환하는 메소드
	 * 	상품의 고유키로 리뷰들을 검색하여 리뷰 리스트를 반환
	 * 	매개변수 : 상품고유키
	 * 	반환 : 리뷰 리스트
	 */	
	 public List<User> selectReviewByProductKey(Connection conn, int productKey, int cPage, int numPerpage, String sort){
		 PreparedStatement pstmt=null;
		 ResultSet rs=null;
		 List<User> result=new ArrayList<>();
		 String newSql=sql.getProperty("selectReviewByProductKey").replace(":SORT", sort);
		 try {
			 pstmt=conn.prepareStatement(newSql);
			 pstmt.setInt(1, productKey);
			 pstmt.setInt(2, (cPage-1)*numPerpage+1);
			 pstmt.setInt(3, cPage*numPerpage);
			 rs=pstmt.executeQuery();
			 while(rs.next()) {
				 getUser(result, rs);
			 }
		 }catch(SQLException e) {
			 e.printStackTrace();
		 }finally {
			 close(rs);
			 close(pstmt);
		 }return result;
	 }
	 
	/*
	 * 	쇼핑몰 상품 상세페이지에 해당 상품의 qna 총 개수를 구해오는 메소드
	 * 	매개변수 : 상품 고유키
	 * 	반환 : qna 총 개수
	 */
	public int getTotalQnaCount(Connection conn, int productKey) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("getTotalQnaCount"));
			pstmt.setInt(1, productKey);
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
	 * 	상품 상세페이지의 qna정보를 DB에서 가져와서 반환하는 메소드
	 * 	매개변수 : 상품 고유키, 현재 페이지, numPerpage
	 */
	public List<Qna> selectQnaByProductKey(Connection conn, int productKey, int cPage, int numPerpage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Qna> result=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectQnaByProductKey"));
			pstmt.setInt(1, productKey);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(getQna(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	Q&A 문의글을 DB에 저장하는 메소드
	 * 	매개변수 : Qna 객체
	 * 	반환 : 결과 result
	 */
	public int insertQna(Connection conn, Qna q) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertQna"));
			pstmt.setInt(1, q.getProductKey());
			pstmt.setString(2, q.getUserId());
			pstmt.setString(3, q.getQnaContent());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	/*
	 *  문의글을 DB에서 삭제
	 *  매개변수 : 문의글 고유키
	 *  반환 : 결과 result
	 */
	public int deleteQna(Connection conn, int qnaKey) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteQna"));
			pstmt.setInt(1, qnaKey);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	문의글 수정 기능
	 * 	매개변수 : 문의글 고유키, 바꿀 글내용
	 *  반환 : 결과 result
	 */
	public int updateQna(Connection conn, int qnaKey, String content) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateQna"));
			pstmt.setString(1, content);
			pstmt.setInt(2, qnaKey);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	/*
	 * 	리뷰 삭제 메소드
	 * 	매개변수 : 리뷰 고유키
	 * 	반환 : 결과 result
	 */
	public int deleteReview(Connection conn, int reviewKey) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteReview"));
			pstmt.setInt(1, reviewKey);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int insertOrders(Connection conn, Orders orders) {
		PreparedStatement pstmt=null;
		int result=0;
		String newSql=sql.getProperty("insertOrders").replace(":STATUS", "배송준비중");
		try {
			pstmt=conn.prepareStatement(newSql);
			pstmt.setString(1,orders.getUserId());
			pstmt.setString(2, orders.getShippingAddress());
			pstmt.setInt(3, orders.getShippingPrice());
			pstmt.setString(4, orders.getPayment());
			pstmt.setString(5, orders.getReq());
			pstmt.setString(6, orders.getImpUid());
			pstmt.setString(7, orders.getReceiverName());
			pstmt.setString(8, orders.getReceiverPhone());
			pstmt.setString(9, orders.getZipcode());
			pstmt.setInt(10, orders.getUsedPoint());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int[] insertOrderDetail(Connection conn, List<OrderDetail> orderDetail) {
		PreparedStatement pstmt=null;
		int[] result=new int[orderDetail.size()];
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertOrderDetail"));
			for(OrderDetail od:orderDetail) {
				pstmt.setInt(1, od.getProductKey());
				pstmt.setInt(2, od.getQuantity());
				pstmt.setInt(3, od.getPrice());
				pstmt.setString(4, od.getOrderColor());
				pstmt.setString(5, od.getOrderSize());
				pstmt.addBatch();
			}
			result=pstmt.executeBatch();
		}catch(SQLException e) {
			e.printStackTrace();
			System.err.println("Batch update failed: " + e.getMessage());
		    for (Throwable t : e) {
		        System.err.println("Cause: " + t);
		    }
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int updatePoint(Connection conn, Orders orders) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updatePoint"));
			pstmt.setInt(1, orders.getUsedPoint());
			pstmt.setString(2, orders.getUserId());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int isCartExist(Connection conn, Cart c) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String newSql;
		if(c.getProductColor()!=null&&c.getProductSize()!=null) {
			//옵션이 모두 있음
			newSql=sql.getProperty("isExistCartWithAllOption");
		}else if(c.getProductColor()!=null&&c.getProductSize()==null){
			//색상옵션만 있음
			newSql=sql.getProperty("isExistCartWithColorOption");
		}else if(c.getProductColor()!=null&&c.getProductSize()==null){
			//사이즈 옵션만 있음
			newSql=sql.getProperty("isExistCartWithSizeOption");
		}else {
			//옵션 없음
			newSql=sql.getProperty("isExistCartWithNoOption");
		}
		int result=0;
		try {
			pstmt=conn.prepareStatement(newSql);
			pstmt.setInt(1, c.getProductKey());
			pstmt.setString(2, c.getUserId());
			if(c.getProductColor()!=null) {
				pstmt.setString(3, c.getProductColor());
			}else if(c.getProductColor()==null&&c.getProductSize()!=null) {
				pstmt.setString(3, c.getProductSize());
			}
			if(c.getProductColor()!=null&&c.getProductSize()!=null) {
				pstmt.setString(4, c.getProductSize());
			}
			rs=pstmt.executeQuery();
			if(rs.next())result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public int insertCart(Connection conn, Cart c) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertCart"));
			pstmt.setInt(1, c.getProductKey());
			pstmt.setString(2, c.getUserId());
			pstmt.setString(3, c.getProductColor());
			pstmt.setString(4, c.getProductSize());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int isExistWish(Connection conn, int productKey, String userId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("isExistWish"));
			pstmt.setInt(1, productKey);
			pstmt.setString(2, userId);
			rs=pstmt.executeQuery();
			if(rs.next())result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public int insertWish(Connection conn, Wishlist w) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertWish"));
			pstmt.setString(1, w.getUserId());
			pstmt.setInt(2, w.getProductKey());
			pstmt.setString(3, w.getProductColor());
			pstmt.setString(4, w.getProductSize());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int deleteWish(Connection conn, int productKey, String userId) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteWish"));
			pstmt.setInt(1, productKey);
			pstmt.setString(2, userId);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	/*
	 * 	마이페이지 주문내역에 필요한 주문 객체 리스트 가져오기
	 * 	매개변수 : 유저아이디
	 * 	반환 : 주문 객체 리스트
	 */
	public List<Orders> selectOrdersById(Connection conn, String userId){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Orders> result=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectOrdersById"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result=getOrders(rs, result);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public Map<String, Product> selectProductById(Connection conn, String userId){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Map<String, Product>result= new HashMap<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectProductById"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result=getProductById(rs, result);
			}
		}catch(SQLException e) {
			e.printStackTrace();		
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public List<Review> selectReviewById(Connection conn, String userId){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Review> result=new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectReviewById"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(getReview(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public int insertReview(Connection conn, Review r) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertReview"));
			pstmt.setInt(1, r.getProductKey());
			pstmt.setString(2, r.getUserId());
			pstmt.setInt(3, r.getRating());
			pstmt.setString(4, r.getReviewContent());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public int[] insertReviewImgs(Connection conn, List<String> fileNames) {
		PreparedStatement pstmt=null;
		int[] result=new int[fileNames.size()];
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertReviewImgs"));
			for(String fn:fileNames) {
				pstmt.setString(1, fn);
				pstmt.addBatch();
			}
			result=pstmt.executeBatch();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	
	
	
	
	/*
	 * 	쇼핑몰 리스트 페이지에 필요한 상품의 정보만 담아서 Product 객체를 반환하는 메소드
	 * 	상품의 이름, 가격, 할인율, 리뷰총개수, 평균별점, 이미지, 카테고리 정보가 포함되어 있음
	 * 	매개변수 : ResultSet
	 * 	반환 : 상품 객체
	 */
	public static Product getProductForListpage(ResultSet rs) throws SQLException{
		Map<String, ProductImg> imgs=new HashMap<>();
		imgs.put("thumbnail", ProductImg.builder().productImg(rs.getString("PRODUCT_IMG")).build());
		return new Product().builder()
				.productKey(rs.getInt("PRODUCT_KEY"))
				.productName(rs.getString("PRODUCT_NAME"))
				.price(rs.getInt("PRICE"))
				.rateDiscount(rs.getInt("RATE_DISCOUNT"))
				.totalReviewCount(rs.getInt("R_COUNT"))
				.avgRating(rs.getDouble("AVG_RATING"))
				.productImgs(imgs)
				.productCategory(ProductCategory.builder().productCategoryName(rs.getString("PRODUCT_CATEGORY_NAME")).build())
				.build();
	}
	
	/*
	 * 	쇼핑몰 상품 상세페이지에 필요한 상품 정보를 담아 반환하는 메소드
	 * 	상품의 이름, 가격, 할인율, 총리뷰개수, 평균별점, 이미지이름, 옵션 정보가 포함되어 있음
	 * 	매개변수 : ResultSet
	 * 	반환 : 상품 객체
	 */
	private Product getProductForDetailpage(ResultSet rs, Product p) throws SQLException{
		p=new Product().builder()
				.productKey(rs.getInt("PRODUCT_KEY"))
				.productName(rs.getString("PRODUCT_NAME"))
				.productCategory(ProductCategory.builder().productCategoryName(rs.getString("PRODUCT_CATEGORY_NAME")).build())
				.price(rs.getInt("PRICE"))
				.rateDiscount(rs.getInt("RATE_DISCOUNT"))
				.totalReviewCount(rs.getInt("R_COUNT"))
				.avgRating(rs.getDouble("AVG_RATING"))
				.build();
		Map<String, ProductImg> imgs=new HashMap<>();
		List<String> imgNames=new ArrayList<String>();
		int num=0;
		do {
			if(!imgNames.contains(rs.getString("PRODUCT_IMG"))) {
				imgNames.add(rs.getString("PRODUCT_IMG"));
				if(rs.getString("THUMBNAIL").equals("Y")) {
					imgs.putIfAbsent("thumbnail", ProductImg.builder().productImg(rs.getString("PRODUCT_IMG")).build());
				}else if(rs.getString("DESCRIPTION_IMG").equals("Y")) {
					imgs.putIfAbsent("description", ProductImg.builder().productImg(rs.getString("PRODUCT_IMG")).build());
				}else {
					imgs.putIfAbsent("imgs"+num++, ProductImg.builder().productImg(rs.getString("PRODUCT_IMG")).build());
				}
			}
			ProductOption po=new ProductOption().builder()
			.productSize(ProductSize.builder().pSize(rs.getString("P_SIZE")).build())
			.color(Color.builder().color(rs.getString("COLOR")).build())
			.stock(rs.getInt("STOCK")).build();
			if(p.getProductOption()==null) {
				p.setProductOption(new ArrayList<ProductOption>());
				p.getProductOption().add(po);
			}else {
				if(!p.getProductOption().stream().anyMatch(e->e.equals(po))) {
					p.getProductOption().add(po);
				}else {
					p.getProductOption().stream().forEach(e->{
						if(e.getColorKey()==po.getColorKey()&&e.getSizeKey()==po.getSizeKey()) {
							e.setStock(e.getStock()+po.getStock());
						}
					});
				}
			}
		}while(rs.next());
		p.setProductImgs(imgs);
		return p;
	}
	
	
	private List<User> getUser(List<User> users, ResultSet rs) throws SQLException{
		String userId=rs.getString("USER_ID");
		if(users.stream().anyMatch(e->userId.equals(e.getUserId()))) {
			users.stream().filter(e->userId.equals(e.getUserId())).forEach(u->{
				u.getReviews().forEach(rr->{
					try {
						rr.getReviewImgs().add(new ReviewImg().builder().reviewImg(rs.getString("REVIEW_IMG")).build());
					}catch(SQLException s) {
						s.printStackTrace();
					}
				});
			});
		}else {
			User u=new User().builder().userId(rs.getString("USER_ID")).dog(new ArrayList<Dog>()).reviews(new ArrayList<Review>()).build();
			u.getDog().add(new Dog().builder().dogImg(rs.getString("DOG_IMG")).build());
			Review r=new Review().builder()
					.reviewKey(rs.getInt("REVIEW_KEY"))
					.reviewDate(rs.getDate("REVIEW_DATE"))
					.rating(rs.getInt("RATING"))
					.reviewContent(rs.getString("REVIEW_CONTENT"))
					.reviewImgs(new ArrayList<ReviewImg>())
					.build();
			r.getReviewImgs().add(new ReviewImg().builder().reviewImgKey(rs.getInt("REVIEW_IMG_KEY")).reviewImg(rs.getString("REVIEW_IMG")).build());
			u.getReviews().add(r);
			users.add(u);
		}
		return users;
	}
	
	private Qna getQna(ResultSet rs) throws SQLException{
		return new Qna().builder()
				.qnaKey(rs.getInt("QNA_KEY"))
				.qnaContent(rs.getString("QNA_CONTENT"))
				.productKey(rs.getInt("PRODUCT_KEY"))
				.userId(rs.getString("USER_ID"))
				.qnaDate(rs.getDate("QNA_DATE"))
				.answer(new QnaAnswer().builder()
										.qnaAnswerKey(rs.getInt("QNA_ANSWER_KEY"))
										.qnaAnswerContent(rs.getString("QNA_ANSWER_CONTENT"))
										.qnaAnswerDate(rs.getDate("QNA_ANSWER_DATE"))
										.build())
				.build();
	}
	
	private List<Orders> getOrders(ResultSet rs, List<Orders> result) throws SQLException{
		int key=rs.getInt("ORDERS_KEY");
		if(result.stream().anyMatch(e->e.getOrdersKey()==key)) {
			result.stream().filter(e->e.getOrdersKey()==key).forEach(o->{
				try {
					o.getOrderDetails().add(getOrderDetail(rs));
				}catch(SQLException s) {
					s.printStackTrace();
				}
			});
		}else {
			Orders o=new Orders().builder()
					.ordersKey(rs.getInt("ORDERS_KEY"))
					.shippingStatus(rs.getString("SHIPPING_STATUS"))
					.shippingPrice(rs.getInt("SHIPPING_PRICE"))
					.purchaseStatus(rs.getString("PURCHASE_STATUS"))
					.shippingDate(rs.getDate("SHIPPING_DATE"))
					.impUid(rs.getString("IMP_UID"))
					.usedPoint(rs.getInt("USED_POINT"))
					.orderDetails(new ArrayList<>())
					.build();
			o.getOrderDetails().add(getOrderDetail(rs));
			result.add(o);
		}return result;
	}
	
	private OrderDetail getOrderDetail(ResultSet rs) throws SQLException{
		return OrderDetail.builder()
				.orderColor(rs.getString("ORDER_COLOR"))
				.orderSize(rs.getString("ORDER_SIZE"))
				.productKey(rs.getInt("PRODUCT_KEY"))
				.quantity(rs.getInt("QUANTITY"))
				.build();
	}
	
	private Map<String, Product> getProductById(ResultSet rs, Map<String, Product> result) throws SQLException{
		int pk=rs.getInt("PRODUCT_KEY");
		if(!result.containsKey(pk)) {
			Product p=new Product().builder()
					.productKey(rs.getInt("PRODUCT_KEY"))
					.productName(rs.getString("PRODUCT_NAME"))
					.productCategory(new ProductCategory().builder().productCategoryName(rs.getString("PRODUCT_CATEGORY_NAME")).build())
					.productImgs(new HashMap<>())
					.build();
			p.getProductImgs().put("thumbnail", new ProductImg().builder().productImg(rs.getString("PRODUCT_IMG")).build());
			result.put(String.valueOf(rs.getInt("PRODUCT_KEY")), p);
		}
		return result;
	}
	
	private Review getReview(ResultSet rs) throws SQLException{
		return new Review().builder()
				.reviewKey(rs.getInt("REVIEW_KEY"))
				.productKey(rs.getInt("PRODUCT_KEY"))
				.build();
	}
}