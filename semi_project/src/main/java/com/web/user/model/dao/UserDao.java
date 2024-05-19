package com.web.user.model.dao;

import static com.web.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

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
			if(rs.next()) {
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
	
	private User getUser(ResultSet rs) throws SQLException{
		return User.builder()
				.userId(rs.getString("user_id"))
				.userName(rs.getString("user_name"))
				.phone(rs.getString("phone"))
				.email(rs.getString("email"))
				.address(rs.getString("address"))
				.password(rs.getString("password"))
				.mateCount(rs.getInt("mate_count"))
				.point(rs.getInt("point"))
				.status(rs.getBoolean("status"))
				.birthDay(rs.getDate("birth_day"))
				.build();
	}
}
