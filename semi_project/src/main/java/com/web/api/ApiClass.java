package com.web.api;

import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.getConnection;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

public class ApiClass {
	private static final String dogFacilityPath = ApiClass.class.getResource("/DOG_FACILITY.csv").getPath();
	
	public static void main(String[] args) {
		System.out.println("왔지롱 ㅋㅋ");
		try(BufferedReader br = new BufferedReader(new FileReader(dogFacilityPath))) {
			String line;
			while((line=br.readLine())!=null) {
				String[] data = line.split(",");
				insertDataIntoDB(data);
			}
		} catch(IOException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void insertDataIntoDB(String[] data) throws SQLException, IOException{
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "INSERT INTO DOG_FACILITY (FACILITY_NO, NAME, CATEGORY_ONE, CATEGORY_TWO, LATITUDE, LOGITUDE, OLD_ADR, NEW_ADR, TEL) "
					+ "VALUES (FACILITY_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			for(int i=0; i<data.length; i++) {
				pstmt.setString(i+1, data[i]);
			}
			pstmt.executeUpdate();
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
	}
	
	
}
