package com.web.user.model.dao;

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

import com.web.user.model.dto.ShippingAddress;
import com.web.user.model.dto.User;

public class UserDao {
	//싱글톤 적용
	private static UserDao dao = new UserDao();
	public static UserDao getUserDao() {return dao;}

	//properties 초기화 설정
	Properties sql = new Properties();
	private UserDao() {
		String path=UserDao.class.getResource("/sql/user/sql_user.properties").getPath();
		try(FileReader fr = new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			System.out.println("properties 파일 불러오는 중 오류 발생");
			e.printStackTrace();
		}
	}

	public User loginUser(Connection conn, String id, String password) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("userLogin"));
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				user=getUser(rs);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}
		return user;
	}
	public User searchUserByEmail(Connection con, String email) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchUserByEmail"));
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) user=getUser(rs);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return user;
	}
	public int enrollUser(Connection con, User user) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql.getProperty("insertUser"));
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());
			pstmt.setDate(7, user.getBirthDay());
			pstmt.setString(8, user.getZipCode());
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int updateUser(Connection con, User user) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt=con.prepareStatement(sql.getProperty("updateUser"));
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getPhone());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getAddress());
			pstmt.setString(5, user.getPassword());
			pstmt.setDate(6, user.getBirthDay());
			pstmt.setString(7, user.getUserId());
			result = pstmt.executeUpdate();
			System.out.println(user);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int changeUserPw(Connection con, String id, String pw) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql.getProperty("changeUserPw"));
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	
	public String searchUserId(Connection con, String email, String name) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userId = "";
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchUserId"));
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			rs=pstmt.executeQuery();
			if(rs.next()) userId=rs.getString(1);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return userId;
	}
	
	public String searchUserById(Connection con, String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userId = "";
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchUserById"));
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			if(rs.next())userId = rs.getString(1);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return userId;
	}
	
	public User selectUser(Connection con, String id, String email) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("findUser"));
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) user=getUser(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return user;
	}
	// 관리자 기능 : 전체 회원 조회
	public List<User> searchAllUser(Connection con, String status){
		List<User> users = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchAllUser"));
			pstmt.setString(1, status);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				users.add(getUser(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return users;
	}
	// 페이징 처리를 위한 가져오는 메소드
	public List<User> searchAllUser(Connection con, int cPage, int numPerpage, String status){
		List<User> users = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchUser"));
			pstmt.setString(1, status);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				users.add(getUser(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return users;
	}
	// 특정 ID의 회원 조회
	public User adminSearchUserById(Connection con, String id, String status) {
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		User user = new User();
		try {
			pstmt = con.prepareStatement(sql.getProperty("adminSearchUserById"));
			pstmt.setString(1, id);
			pstmt.setString(2, status);
			rs=pstmt.executeQuery();
			if(rs.next()) user = getUser(rs);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return user;
	}
	
	// 회원 상태 변경 기능
	public int deleteUserById(Connection con, String userId, String status) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			if(status.equals("N")) {	// 실사용 유저는 탈퇴처리
				pstmt = con.prepareStatement(sql.getProperty("adminDeleteUserById"));
			} else {					// 탈퇴했던 유저의 재가입 처리
				pstmt = con.prepareStatement(sql.getProperty("adminRollBackUserById"));
			}
			pstmt.setString(1, userId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	private static User getUser(ResultSet rs) throws SQLException{
		return User.builder()
				.userId(rs.getString("user_id"))
				.userName(rs.getString("user_name"))
				.phone(rs.getString("phone"))
				.email(rs.getString("email"))
				.address(rs.getString("address"))
				.password(rs.getString("password"))
				.mateCount(rs.getInt("mate_count"))
				.point(rs.getInt("point"))
				.status(rs.getString("status"))
				.birthDay(rs.getDate("birth_day"))
				.zipCode(rs.getString("zipcode"))
				.build();
	}
	
	private static User getUser(ResultSet rs, User user) throws SQLException{
		if(user==null) {
			user=User.builder()
				.userId(rs.getString("user_id"))
				.userName(rs.getString("user_name"))
				.phone(rs.getString("phone"))
				.email(rs.getString("email"))
				.address(rs.getString("address"))
				.password(rs.getString("password"))
				.mateCount(rs.getInt("mate_count"))
				.point(rs.getInt("point"))
				.status(rs.getString("status"))
				.birthDay(rs.getDate("birth_day"))
				.zipCode(rs.getString("zipcode"))
				.build();
			user.setShippingAddress(new ArrayList<>());
			user.getShippingAddress().add(getShippingAddress(rs));
		}else {
			user.getShippingAddress().add(getShippingAddress(rs));
		}
		return user;
	}
	
	private static ShippingAddress getShippingAddress(ResultSet rs) throws SQLException{
		return new ShippingAddress().builder()
				.shippingAddressKey(rs.getInt("SHIPPING_ADDRESS_KEY"))
				.shippingAddressName(rs.getString("SHIPPING_ADDRESS_NAME"))
				.recipientName(rs.getString("RECIPIENT_NAME"))
				.zipcode(rs.getString("ZIPCODE"))
				.shippingAddress(rs.getString("SHIPPING_ADDRESS"))
				.shippingPhone(rs.getString("SHIPPING_PHONE"))
				.shippingEmail(rs.getString("SHIPPING_EMAIL"))
				.defaultShippingAddress(rs.getString("DEFAULT_SHIPPING_ADDRESS"))
				.build();
	}
}
