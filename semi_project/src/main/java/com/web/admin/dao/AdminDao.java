package com.web.admin.dao;

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

import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.Report;

public class AdminDao {
	private Properties sql = new Properties();
	private static AdminDao dao=new AdminDao();
	private AdminDao() {
		try(FileReader fr = new FileReader(AdminDao.class.getResource("/sql/admin/sql_admin.properties").getPath())) {
			sql.load(fr);
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	public static AdminDao getAdminDao() {
		return dao;
	}	
	
	public List<Bulletin> searchFreeBulletins(Connection con, int type){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchBulletins"));
			pstmt.setInt(1, type);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bulletins.add(getBulletin(rs));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return bulletins;
	}
	
	public List<Bulletin> searchFreeBulletins(Connection con, int type, int cPage, int numPerpage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchBulletinsPaging"));
			pstmt.setInt(1, type);
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bulletins.add(getBulletin(rs));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return bulletins;
	}
	
	public List<Report> serachReport(Connection con){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Report> reports = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("serachReport"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				reports.add(getReport(rs));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return reports;
	}
	// 나쁜 사람 검색기능
	public List<Report> serachReport(Connection con, String id){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Report> reports = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchReportByUserId"));
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				reports.add(getReport(rs));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return reports;
	}
	 
	public List<Report> serachReport(Connection con, int cPage, int numPerpage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Report> reports = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchReportPaging"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				reports.add(getReport(rs));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		} return reports;
	}
	
	public int writeBoard(Connection con, int type, String title, String description) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = con.prepareStatement(sql.getProperty("writeBoard"));
			pstmt.setInt(1, type);
			pstmt.setString(2, title);
			pstmt.setString(3, description);
			result = pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(pstmt);
		} return result;
	}
	
	private Bulletin getBulletin(ResultSet rs) throws SQLException{
		return Bulletin.builder().bullNo(rs.getInt("BULL_NO"))
								 .categoryNo(rs.getInt("CATEGORY_NO"))
								 .userId(rs.getString("USER_ID"))
								 .title(rs.getString("TITLE"))
								 .content(rs.getString("CONTENT"))
								 .rDate(rs.getDate("R_DATE"))
								 .hits(rs.getInt("HITS"))
								 .likeC(rs.getInt("LIKE_C"))
								 .build();
	}
	
	private Report getReport(ResultSet rs) throws SQLException{
		return Report.builder().reportKey(rs.getInt("REPORT_KEY"))
							   .reportTypeKey(rs.getInt("REPORT_TYPE_KEY"))
							   .reportType(rs.getString("REPORT_TYPE"))
							   .bullNo(rs.getInt("BULL_NO"))
							   .reporterId(rs.getString("REPORTER_ID"))
							   .reportedId(rs.getString("REPORTED_ID"))
							   .reportContent(rs.getString("REPORT_CONTENT"))
							   .build();
	}
}
