package com.web.dog.model.dao;

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

import com.web.dog.model.dto.Dog;

public class DogDao {
	private static DogDao dao;
	// 기본 생성자에 properties 초기화 설정
	private Properties sql = new Properties();
	private DogDao() {
		try(FileReader fr = new FileReader(DogDao.class.getResource("/sql/user/sql_user.properties").getPath())) {
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
	
	public String getDogImg(Connection con, String Id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dogImg="";
		try {
			pstmt = con.prepareStatement(sql.getProperty("selectDogImg"));
			pstmt.setString(1, Id);
			rs=pstmt.executeQuery();
			if(rs.next()) dogImg=rs.getString(1);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return dogImg;
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
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int updateDog(Connection con, Dog dog) {
		int result = 0;
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("updateDog"));
			pstmt.setString(1, dog.getDogBreedName());
			pstmt.setDouble(2, dog.getDogWeight());
			pstmt.setString(3, dog.getDogImg());
			pstmt.setString(4, dog.getDogName());
			pstmt.setString(5, dog.getUserId());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	// userId로 DB에서 Mapping되어 있는 반려견 전부 가져오기
	public List<Dog> selectDogs(Connection con, String userId){
		List<Dog> dogs = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("selectDogs"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dogs.add(getDog(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return dogs;
	}
	// 관리자 기능 : 전체 강아지 데려오기
	public List<Dog> serachAllDog(Connection con){
		List<Dog> dogs = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql.getProperty("serachAllDog"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				dogs.add(getDog(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return dogs;
	}
	
	public static Dog getDog(ResultSet rs) throws SQLException{
		return Dog.builder().userId(rs.getString("USER_ID"))
							.dogBreedName(rs.getString("DOG_BREED_NAME"))
							.dogName(rs.getString("DOG_NAME"))
							.dogWeight(rs.getDouble("DOG_WEIGHT"))
							.dogImg(rs.getString("DOG_IMG"))
						    .build();
	}
}
