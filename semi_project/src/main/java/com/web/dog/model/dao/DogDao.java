package com.web.dog.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import static com.web.common.JDBCTemplate.*;
import com.web.dog.model.dto.Dog;

public class DogDao {
	private static DogDao dao;
	// 기본 생성자에 properties 초기화 설정
	private Properties sql = new Properties();
	private DogDao() {
		try(FileReader fr = new FileReader(DogDao.class.getResource("/sql.user/sql_user.properties").getPath())) {
			sql.load(fr);
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	// 싱글톤 적용
	public static DogDao getDogDao() {
		if(dao==null) dao = new DogDao();
		return dao;
	}
	
	public int enrollDog(Connection con, Dog dog) {
		int result=0;
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("insertDog"));
			pstmt.setString(1, dog.getUserId());
			pstmt.setString(2, dog.getDogBreedName());
			pstmt.setString(3, dog.getDogName());
			pstmt.setDouble(4, dog.getDogWeight());
			pstmt.setString(5, dog.getDogImg());
			result = pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
}
