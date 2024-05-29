package com.web.admin.service;

import static com.web.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import static com.web.admin.dao.AdminDao.getAdminDao;
import com.web.board.model.dto.Bulletin;
import com.web.board.model.dto.Report;

public class AdminService {
	private static AdminService service=new AdminService();
	private AdminService() {}
	public static AdminService getAdminService() {
		return service;
	}
	
	public List<Report> serachReport(){
		Connection con = getConnection();
		List<Report> reports = getAdminDao().serachReport(con);
		close(con);
		return reports;
	}
	// 나쁜사람 검색기능
	public List<Report> serachReport(String id){
		Connection con = getConnection();
		List<Report> reports = getAdminDao().serachReport(con, id);
		close(con);
		return reports;
	}
	
	public List<Report> serachReport(int cPage, int numPerpage){
		Connection con = getConnection();
		List<Report> reports = getAdminDao().serachReport(con, cPage, numPerpage);
		close(con);
		return reports;
	}
	
	public List<Bulletin> searchFreeBulletins(int type){
		Connection con = getConnection();
		List<Bulletin> bulletins = getAdminDao().searchFreeBulletins(con, type);
		close(con);
		return bulletins;
	}
	public List<Bulletin> searchBulletins(int type, int cPage, int numPerpage){
		Connection con = getConnection();
		List<Bulletin> bulletins = getAdminDao().searchFreeBulletins(con, type, cPage, numPerpage);
		close(con);
		return bulletins;
	}
	// 공지 및 이벤트 게시글 등록 메소드
	public int writeBoard(int type, String title, String description) {
		Connection con = getConnection();
		int result = getAdminDao().writeBoard(con, type, title, description);
		if(result>0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
		return result;
	}
}
