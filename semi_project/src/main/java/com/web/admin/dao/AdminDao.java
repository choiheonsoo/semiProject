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
	
	public List<Bulletin> searchFreeBulletins(Connection con){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchFreeBulletins"));
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
	
	public List<Bulletin> searchFreeBulletins(Connection con, int cPage, int numPerpage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			pstmt = con.prepareStatement(sql.getProperty("searchFreeBulletinsPaging"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
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
}
