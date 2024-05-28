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
		List<Report> reports = null;
				//getAdminDao().serachReport();
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
}
