package com.web.listener;

import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.getConnection;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.web.api.ApiClass;

/**
 * Application Lifecycle Listener implementation class ApiListener
 *
 */
@WebListener
public class ApiListener implements ServletContextListener {
	private final String dogFacilityPath = ApiClass.class.getResource("/DOG_FACILITY.csv").getPath();
    /**
     * Default constructor. 
     */
    public ApiListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	parseData();
    	
    }
    public void parseData() {
//		try(BufferedReader br = new BufferedReader(new FileReader(dogFacilityPath))) {
//			String line;
//			String holiday="확인 필요";
//			while((line=br.readLine())!=null) {
//				if(line.contains("연중무휴")) {
//					holiday="연중 무휴";
//				} 
//				String[] data = line.split(",");
//				insertDataIntoDB(data, holiday);
//			}
//		}catch(IOException | SQLException e) {
//			e.printStackTrace();
//		}
	}
//for(char c : line.toCharArray()) {
//	if(c == '"') {
//		inQuotes = !inQuotes;
//	}else if(c == ',' && !inQuotes) {
//		fields.add(field.toString());
//		field.setLength(0);
//	}else {
//		filed.append(c);
//	}
//	fields.add(field.toString());
//	return fields;
	public void insertDataIntoDB(String[] data, String holiday) throws SQLException, IOException{
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "INSERT INTO DOG_FACILITY (FACILITY_NO, NAME, CATEGOTY_ONE, CATEGOTY_TWO, LATITUDE, LONGITUDE, OLD_ADR, NEW_ADR, TEL, HOLIDAY) VALUES (FACILITY_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, data[0]);
			pstmt.setString(2, data[2]);
			pstmt.setString(3, data[3]);
			pstmt.setDouble(4, Double.parseDouble(data[11]));
			pstmt.setDouble(5, Double.parseDouble(data[12]));
			pstmt.setString(6, data[15]);
			pstmt.setString(7, data[14]);
			pstmt.setString(8, data[16]);
			pstmt.setString(9, holiday);
			pstmt.executeUpdate();
		} finally {
			close(pstmt);
			close(con);
		}
	
	}
	
}
