package com.web.user.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static com.web.common.JDBCTemplate.close;
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
	
	private User getUser(ResultSet rs) throws SQLException{
		return User.builder()
				.userId(rs.getString("user_id"))
				.userName(rs.getString("user_name"))
				.age(rs.getInt("age"))
				.phone(rs.getString("phone"))
				.email(rs.getString("email"))
				.nickName(rs.getString("nickname"))
				.password(rs.getString("password"))
				.mateCount(rs.getInt("mate_count"))
				.point(rs.getInt("point"))
				.status(rs.getBoolean("status"))
				.birthDay(rs.getDate("birth_day"))
				.gender(rs.getString("gender").charAt(0))
				.build();
	}
}
