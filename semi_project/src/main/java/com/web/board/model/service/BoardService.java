package com.web.board.model.service;
import static com.web.common.JDBCTemplate.*;
import static com.web.board.model.dao.BoardDao.getDao;
import java.sql.Connection;
import java.util.List;

import com.web.board.model.dto.Bulletin;
public class BoardService {
	private static BoardService service = new BoardService();
	public static BoardService getService() {return service;};
	private BoardService() {}
	
	
	//게시글 총 갯수 조회
	public int selectBoardCount() {
		Connection conn = getConnection();
		int result = getDao().selectBoardCount(conn);
		close(conn);
		return result;
	}
	
	//게시글 전체 조회
	public List<Bulletin> selectBoardAll(int cPage, int numPerpage){
		Connection conn = getConnection();
		List<Bulletin> bulletins = getDao().selectBoardAll(conn,cPage,numPerpage);
		close(conn);
		return bulletins;
	}
}
