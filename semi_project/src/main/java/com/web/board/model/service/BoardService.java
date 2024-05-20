package com.web.board.model.service;
import static com.web.common.JDBCTemplate.*;
import static com.web.board.model.dao.BoardDao.getDao;
import java.sql.Connection;
import java.util.List;

import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.BulletinComment;
import com.web.dog.model.dto.Dog;
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
	public List<Bulletin> selectBoardAll(int cPage, int numPerpage,String type, String keyword){
		Connection conn = getConnection();
		List<Bulletin> bulletins = getDao().selectBoardAll(conn,cPage,numPerpage,type, keyword);
		close(conn);
		return bulletins;
	}
	
	//게시글 번호로 조회
	public Bulletin selectBoardNo(int no, boolean readResult) {
		Connection conn = getConnection();
		Bulletin bulletin = getDao().selectBoardNo(conn, no);
		if(bulletin!=null&&!readResult) {
			int result=getDao().updateFreeBoardReadCount(conn, no);
			if(result>0) {
				commit(conn);
				bulletin.setHits(bulletin.getHits()+1);
			}
			else rollback(conn);
		}
		close(conn);
		return bulletin;
	}
	
	//게시글 등록
	public int insertBoard(String id, String title, String content) {
		Connection conn = getConnection();
		int result = getDao().insertBoard(conn,id, title, content);
		if(result > 0 ) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//게시글 수정
	public int updateFreeBoard(int bullNo, String content) {
		Connection conn = getConnection();
		int result = getDao().updateFreeBoard(conn, bullNo, content);
		if(result > 0 ) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//게시글 삭제
	public int deleteFreeBoard(int bullNo) {
		Connection conn = getConnection();
		int result = getDao().deleteFreeBoard(conn, bullNo);
		if(result > 0 ) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//회원 강아지 불러오기
	public List<Dog> getDog() {
		Connection conn = getConnection();
		List<Dog> dogs = getDao().getDog(conn);
		close(conn);
		return dogs;
	}
	
	//댓글 등록하기
	public int insertBoardComment(BulletinComment bc) {
		Connection conn = getConnection();
		int result = getDao().insertBoardComment(conn, bc);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//댓글 삭제하기
	public int deleteBoardComment(int bcNo) {
		Connection conn = getConnection();
		int result = getDao().deleteBoardComment(conn,bcNo);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
}
