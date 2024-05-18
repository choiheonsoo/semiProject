package com.web.board.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import static com.web.common.JDBCTemplate.close;
import com.web.board.model.dto.Bulletin;

public class BoardDao {
	//싱글톤 적용
	private static BoardDao dao = new BoardDao();
	public static BoardDao getDao() {return dao;}
	private Properties sql = new Properties();
	
	//기본 생성자 안에 properties 넣기
	private BoardDao(){
		String path = BoardDao.class.getResource("/sql/board/sql_board.properties").getPath();
		try(FileReader fr=  new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			System.out.println("board_properties 읽어오는 중 오류 발생");
			e.printStackTrace();
		}
	}
	
	//게시글 총 갯수 조회
	public int selectBoardCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardCount"));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(0);
				System.out.println("selectBoardCount_result 결과 : "+result);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//게시글 전체 조회
	public List<Bulletin> selectBoardAll(Connection conn, int cPage, int numPerpage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardAll"));
			pstmt.setInt(1,cPage);
			pstmt.setInt(2, numPerpage);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bulletins.add(getBulletin(rs));
			}
		}catch(SQLException e) {
			System.out.println("BoardDao_selectBoardAll에서 SQL 오류");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return bulletins;
	}
	
	private Bulletin getBulletin(ResultSet rs) throws SQLException{
		return Bulletin.builder()
				.bullNo(rs.getInt("bull_no"))
				.categoryNo(rs.getInt("category_no"))
				.userId(rs.getString("user_id"))
				.title(rs.getString("title"))
				.content(rs.getString("content"))
				.rDate(rs.getDate("r_date"))
				.hits(rs.getInt("hits"))
				.likeC(rs.getInt("like_c"))
				.build();
	}
}
