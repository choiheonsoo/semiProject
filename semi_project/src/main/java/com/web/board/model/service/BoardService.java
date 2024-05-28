package com.web.board.model.service;
import static com.web.board.model.dao.BoardDao.getDao;
import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.commit;
import static com.web.common.JDBCTemplate.getConnection;
import static com.web.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.BulletinComment;
import com.web.board.model.dto.BulletinImg;
import com.web.board.model.dto.BulletinLike;
import com.web.board.model.dto.CusttomApply;
import com.web.board.model.dto.MateApply;
import com.web.board.model.dto.WalkingMate;
import com.web.dog.model.dto.Dog;
public class BoardService {
	private static BoardService service = new BoardService();
	public static BoardService getService() {return service;};
	private BoardService() {}
	
	
	//게시글 총 갯수 조회
	public int selectBoardCount(int cateNum) {
		Connection conn = getConnection();
		int result = getDao().selectBoardCount(conn, cateNum);
		close(conn);
		return result;
	}
	
	//게시글 전체 조회
	public List<Bulletin> selectBoardAll(int cPage, int numPerpage,String type, String keyword, int cateNum){
		Connection conn = getConnection();
		List<Bulletin> bulletins = getDao().selectBoardAll(conn,cPage,numPerpage,type, keyword,cateNum);
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
		close(conn);
		return result;
	}
	
	//게시글 수정
	public int updateFreeBoard(int bullNo, String content) {
		Connection conn = getConnection();
		int result = getDao().updateFreeBoard(conn, bullNo, content);
		if(result > 0 ) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//게시글 삭제
	public int deleteFreeBoard(int bullNo) {
		Connection conn = getConnection();
		int result = getDao().deleteFreeBoard(conn, bullNo);
		if(result > 0 ) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//회원 강아지 불러오기
	public List<Dog> getDog() {
		Connection conn = getConnection();
		List<Dog> dogs = getDao().getDog(conn);
		close(conn);
		return dogs;
	}
	
	//멍스타그램 등록하기
	public int insertMungStargram(Bulletin b) {
		Connection conn = getConnection();
		int result = getDao().insertMungStargram(conn, b);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//게시글 사진 등록하기
	public int insertBoardImg(int bullNo, List<BulletinImg> imgs) {
		Connection conn = getConnection();
		int result = getDao().insertBoardImg(conn,bullNo, imgs);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//게시글 이미지 불러오기
	public List<BulletinImg> selectBoardImg(){
		Connection conn = getConnection();
		List<BulletinImg> imgs = getDao().selectBoardImg(conn);
		close(conn);
		return imgs;
	}
	
	//게시글 좋아요
	public boolean boardLike(int no,String id) {
		Connection conn = getConnection();
		boolean result = getDao().selectBoardLike(conn,no,id);
		if(result) {
			getDao().boardLikeCount(conn,no,result);
			getDao().deleteBoardLike(conn,no,id);
		}else {
			getDao().insertBoardLike(conn,no,id);
			getDao().boardLikeCount(conn,no,result);
		}
		close(conn);
		return result;
	}
	
	//게시글 좋아요 총 갯수
	public int boardLikeTotalCount(int no) {
		Connection conn = getConnection();
		int result = getDao().boardLikeTotalCount(conn,no);
		close(conn);
		return result;
	}
	//게시글 좋아요 조회하기
	public List<BulletinLike> selectBoardLike() {
		Connection conn = getConnection();
		List<BulletinLike> bk = getDao().selectBoardLikeAll(conn);
		close(conn);
		return bk;
	}
	//댓글 조회하기
	public List<BulletinComment> selectBoardComment() {
		Connection conn = getConnection();
		List<BulletinComment> result = getDao().selectBoardComment(conn);
		close(conn);
		return result;
	}
	//댓글 등록하기
	public int insertBoardComment(BulletinComment bc) {
		Connection conn = getConnection();
		int result = getDao().insertBoardComment(conn, bc);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//댓글 삭제하기
	public int deleteBoardComment(int bcNo) {
		Connection conn = getConnection();
		int result = getDao().deleteBoardComment(conn,bcNo);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//산책메이트 게시글 전체 조회
	public List<WalkingMate> selectWalkingMateAll(int cPage, int numPerpage){
		Connection conn = getConnection();
		List<WalkingMate> boards = getDao().selectWalkingMateAll(conn, cPage, numPerpage);
		close(conn);
		return boards;
	}

	//산책메이트 게시글 전체 조회(pageX)
	public List<WalkingMate> selectWalkingMateAllpageX(){
		Connection conn = getConnection();
		List<WalkingMate> boards = getDao().selectWalkingMateAllpageX(conn);
		close(conn);
		return boards;
	}
	
	//산책메이트 게시글 수
	public int selectWalkingMateCount() {
		Connection conn = getConnection();
		int result = getDao().selectWalkingMateCount(conn);
		close(conn);
		return result;
	}
	
	//산책메이트 신청자 전체 조회
	public List<MateApply> selectMateApplyAll(){
		Connection conn = getConnection();
		List<MateApply> apply = getDao().selectMateApplyAll(conn);
		close(conn);
		return apply;
	}
	
	//산책메이트 게시글 등록
	public int insertWalkingMate(WalkingMate wm) {
		Connection conn = getConnection();
		int result = getDao().insertWalkingMate(conn, wm);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//산책메이트 게시글 삭제
	public int deleteWalkingMate(int no) {
		Connection conn = getConnection();
		int result = getDao().deleteWalkingMate(conn,no);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//산책메이트 신청
	public int insertApply(int no, String id) {
		Connection conn = getConnection();
		int result = getDao().insertApply(conn,no,id);
		if(result>0)commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//신고기능
	public int insertReport(String reporterId, String reportedId, String content, int categoryNo, int no) {
		Connection conn = getConnection();
		int result = getDao().insertReport(conn, reporterId, reportedId, content, categoryNo, no);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//산책메이트 조회
	public List<CusttomApply> selectApply(String id){
		Connection conn = getConnection();
		List<CusttomApply> users = getDao().selectApply(conn,id);
		close(conn);
		return users;
	}
	
	//산책메이트 수락기능
	public int updateApply(int totalMembers, int boardNo, String id) {
		Connection conn = getConnection();
		int result = getDao().updateApply(conn, totalMembers, boardNo, id);
		if(result > 0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//산책메이트 거절기능
	public int deleteApply(int boardNo, String id) {
		Connection conn =getConnection();
		int result = getDao().deleteApply(conn, boardNo, id);
		if(result > 0) commit(conn);
		else rollback(conn);
		return result;
	}
}
