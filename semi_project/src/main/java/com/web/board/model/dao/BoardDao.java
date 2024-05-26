package com.web.board.model.dao;

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
import com.web.board.model.dto.BulletinComment;
import com.web.board.model.dto.BulletinImg;
import com.web.board.model.dto.BulletinLike;
import com.web.board.model.dto.MateApply;
import com.web.board.model.dto.WalkingMate;
import com.web.dog.model.dao.DogDao;
import com.web.dog.model.dto.Dog;

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
	public int selectBoardCount(Connection conn, int cateNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardCount"));
			pstmt.setInt(1, cateNum);
			if(cateNum!=4) {
				pstmt.setInt(2, 2);
			}else {
				pstmt.setInt(2, cateNum);
			}
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	//게시글 전체 조회
	public List<Bulletin> selectBoardAll(Connection conn, int cPage, int numPerpage, String type, String keyword,int cateNum){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Bulletin> bulletins = new ArrayList<>();
		try {
			String newSql = sql.getProperty("selectBoardAll").replace("#type", type);
			pstmt = conn.prepareStatement(newSql);
			pstmt.setInt(1, cateNum);
			if(cateNum!=4) {
				pstmt.setInt(2, 2);
			}else {
				pstmt.setInt(2, cateNum);
			}
			pstmt.setString(3,"%"+keyword+"%");
			pstmt.setInt(4,(cPage-1)*numPerpage+1);
			pstmt.setInt(5, numPerpage*cPage);
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
	
	//게시글 번호로 조회
	public Bulletin selectBoardNo(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bulletin bulletin  = null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardNo"));
			pstmt.setInt(1,no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bulletin = getBulletin(rs);
				do {
					bulletin.getComments().add(getComments(rs));
				}while(rs.next());
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return bulletin;
	}
	
	//게시글 등록하기
	public int insertBoard(Connection conn, String id, String title, String content) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertBoard"));
			pstmt.setString(1,id);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	//게시글 수정하기
	public int updateFreeBoard(Connection conn, int bullNo, String content) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("updateFreeBoard"));
			pstmt.setString(1, content);
			pstmt.setInt(2, bullNo);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//게시글 삭제하기
	public int deleteFreeBoard(Connection conn, int bullNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt= conn.prepareStatement(sql.getProperty("deleteFreeBoard"));
			pstmt.setInt(1, bullNo);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//강아지 불러오기
	public List<Dog> getDog(Connection conn){
		List<Dog> dogs = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("getDog"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				dogs.add(DogDao.getDog(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return dogs;
	}
	
	//게시글 조회 수 증가
	public int updateFreeBoardReadCount(Connection conn, int no) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateFreeBoardReadCount"));
			pstmt.setInt(1, no);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	// 게시글 등록하기
	public int insertMungStargram(Connection conn, Bulletin b) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("insertMungStargram"));
	        pstmt.setInt(1, b.getCategoryNo());
	        pstmt.setString(2, b.getUserId());
	        pstmt.setString(3, b.getTitle());
	        pstmt.setString(4, b.getContent());
	        result = pstmt.executeUpdate();

	        // 게시글 등록 후 시퀀스 값을 가져옴
	        int bullNo = selectSeqBoard(conn);
	        
	        // 이미지 등록
	        if (bullNo > 0) {
	            result += insertBoardImg(conn, bullNo, b.getImgs());
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return result;
	}

	// 게시글 시퀀스 조회하기
	public int selectSeqBoard(Connection conn) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("selectSeqBoard"));
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            result = rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return result;
	}

	// 게시글 이미지 등록하기
	public int insertBoardImg(Connection conn, int bullNo, List<BulletinImg> imgs) {
	    PreparedStatement pstmt = null;
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("insertBoardImg"));
	        for (BulletinImg img : imgs) {
	            pstmt.setInt(1, bullNo);
	            pstmt.setString(2, img.getBullImg());
	            result += pstmt.executeUpdate();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }
	    return result;
	}
	
	//게시글 이미지 불러오기
	public List<BulletinImg> selectBoardImg(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BulletinImg> imgs = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardImg"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				imgs.add(getImg(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return imgs;
	}
	//좋아요 테이블 전부 가져오기
	public List<BulletinLike> selectBoardLikeAll(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BulletinLike> bk = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardLikeAll"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bk.add(getLike(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return bk;
	}
	//좋아요 여부 확인하기
	public boolean selectBoardLike(Connection conn, int no, String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardLike"));
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getInt(1)>0) {
					result = true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	//좋아요 증가, 감소
	public void boardLikeCount(Connection conn, int no, boolean result) {
		PreparedStatement pstmt = null;
		int rs = 0;
		try {
			if(result) {
				pstmt = conn.prepareStatement(sql.getProperty("boardLikeCountDown"));
			}else {
				pstmt = conn.prepareStatement(sql.getProperty("boardLikeCountUp"));
			}
			pstmt.setInt(1, no);
			rs=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
	}
	//좋아요 생성
	public void insertBoardLike(Connection conn, int no, String id) {
		PreparedStatement pstmt =null;
		int rs = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertBoardLike"));
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			rs=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
	}
	//좋아요 지우기
	public void deleteBoardLike(Connection conn, int no, String id) {
		PreparedStatement pstmt =null;
		int rs = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("deleteBoardLike"));
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			rs=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
	}
	
	//좋아요 총 갯수
	public int boardLikeTotalCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("boardLikeTotalCount"));
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	//총 댓글 조회하기
	public List<BulletinComment> selectBoardComment(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BulletinComment> result = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectBoardComment"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(getComments(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	//댓글 등록하기
	public int insertBoardComment(Connection conn, BulletinComment bc) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertBoardComment"));
			pstmt.setString(1, bc.getSubComment()==0?null:String.valueOf(bc.getSubComment()));
			pstmt.setInt(2, bc.getBullNo());
			pstmt.setString(3,bc.getUserId());
			pstmt.setString(4,bc.getContent());
			pstmt.setInt(5,bc.getCommentLevel());
			result= pstmt.executeUpdate();
			if(result>0) {
				result = selectSeqComment(conn);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//댓글 삭제하기
	public int deleteBoardComment(Connection conn, int bcNo) {
		PreparedStatement pstmt =null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("deleteBoardComment"));
			pstmt.setInt(1, bcNo);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//댓글 시퀀스 조회하기
		public int selectSeqComment(Connection conn) {
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    int result = 0;
		    try {
		        pstmt = conn.prepareStatement(sql.getProperty("selectSeqComment"));
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		            result = rs.getInt(1);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        close(rs);
		        close(pstmt);
		    }
		    return result;
		}
		
	//산책메이트 전체 조회(페이징처리 x)
	public List<WalkingMate> selectWalkingMateAllpageX(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<WalkingMate> boards = new ArrayList<>();
		try {
			pstmt =conn.prepareStatement(sql.getProperty("selectWalkingMateAllpageX"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				boards.add(getWalkingMate(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return boards;
	}
	
	//산책메이트 전체 조회
	public List<WalkingMate> selectWalkingMateAll(Connection conn, int cPage, int numPerpage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<WalkingMate> boards = new ArrayList<>();
		try {
			pstmt =conn.prepareStatement(sql.getProperty("selectWalkingMateAll"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, numPerpage*cPage);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				boards.add(getWalkingMate(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return boards;
	}
	//산책메이트 게시글 수
	public int selectWalkingMateCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectWalkingMateCount"));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	//산책메이트 신청자 전체 조회
	public List<MateApply> selectMateApplyAll(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MateApply> apply = new ArrayList<>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectMateApplyAll"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				apply.add(getMateApply(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return apply;
	}
	
	//산책메이트 게시글 등록
	public int insertWalkingMate(Connection conn, WalkingMate wm) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertWalkingMate"));
			pstmt.setString(1, wm.getUserId());
			pstmt.setString(2,wm.getPlace());
			pstmt.setTimestamp(3, wm.getPlaceTime());
			pstmt.setString(4, wm.getTitle());
			pstmt.setString(5, wm.getContent());
			pstmt.setInt(6,wm.getRecruitmentNumber());
			pstmt.setDouble(7,wm.getLatitue());
			pstmt.setDouble(8,wm.getLogitude());
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//산책메이트 게시글 삭제
	public int deleteWalkingMate(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt =conn.prepareStatement(sql.getProperty("deleteWalkingMate"));
			pstmt.setInt(1,no);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//산책메이트 신청
	public int insertApply(Connection conn, int no, String id) {
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertApply"));
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	//게시글 좋아요 생성
	private static BulletinLike getLike(ResultSet rs) throws SQLException{
		return BulletinLike.builder()
							.bulletinLikeKey(rs.getInt("bulletin_like_key"))
							.bullNo(rs.getInt("bull_no"))
							.userId(rs.getString("user_id"))
							.build();
	}
	//게시글 이미지 생성
	private static BulletinImg getImg(ResultSet rs) throws SQLException{
		return BulletinImg.builder()
							.bulletinImgKey(rs.getInt("bulletin_img_key"))
							.bullNo(rs.getInt("bull_no"))
							.bullImg(rs.getString("bull_img"))
							.build();
	}
	
	//댓글 생성
	private static BulletinComment getComments(ResultSet rs) throws SQLException{
			 String delCStr = rs.getString("bc_del_c");
			 char delC = (delCStr != null && !delCStr.isEmpty()) ? delCStr.charAt(0) : 'N';
		return BulletinComment.builder()
				.mainComment(rs.getInt("main_comment"))
				.subComment(rs.getInt("sub_comment"))
				.bullNo(rs.getInt("bc_bull_no"))
				.userId(rs.getString("bc_user_id"))
				.content(rs.getString("bc_content"))
				.rDate(rs.getDate("bc_r_date"))
				.delC(delC)
				.commentLevel(rs.getInt("comment_level"))
				.build();
	}
	//게시글 생성
	private static Bulletin getBulletin(ResultSet rs) throws SQLException{
		return Bulletin.builder()
				.bullNo(rs.getInt("b_bull_no"))
				.categoryNo(rs.getInt("category_no"))
				.userId(rs.getString("b_user_id"))
				.title(rs.getString("b_title"))
				.content(rs.getString("b_content"))
				.rDate(rs.getDate("b_r_date"))
				.hits(rs.getInt("hits"))
				.likeC(rs.getInt("like_c"))
				.comments(new ArrayList<>())
				.likes(new ArrayList<>())
				.build();
	}
	
	//산책메이트 게시글 생성
	public WalkingMate getWalkingMate(ResultSet rs) throws SQLException {
		return WalkingMate.builder()
							.walkingMateNo(rs.getInt("walking_mate_no"))
							.userId(rs.getString("user_id"))
							.place(rs.getString("place"))
							.placeTime(rs.getTimestamp("place_time"))
							.title(rs.getString("title"))
							.content(rs.getString("content"))
							.rDate(rs.getDate("r_date"))
							.delC(rs.getString("del_c").charAt(0))
							.recruitmentNumber(rs.getInt("recruitment_number"))
							.latitue(rs.getDouble("latitude"))
							.logitude(rs.getDouble("longitude"))
							.build();
	}
	
	//산책메이트 신청자 생성
	public MateApply getMateApply(ResultSet rs) throws SQLException{
		return MateApply.builder()
						.mateApplyKey(rs.getInt("mate_apply_key"))
						.BoardNo(rs.getInt("board_no"))
						.userId(rs.getString("user_id"))
						.accept(rs.getString("accept").charAt(0))
						.applyDate(rs.getDate("apply_date"))
						.build();
	}
}
