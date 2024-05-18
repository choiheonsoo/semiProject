package com.web.user.model.service;

import static com.web.common.JDBCTemplate.getConnection;
import static com.web.common.JDBCTemplate.close;
import static com.web.user.model.dao.UserDao.getUserDao;
import java.sql.Connection;

import com.web.user.model.dto.User;
public class UserService {
	//싱글톤 적용
	private UserService() {} 
	private static UserService service = new UserService();
	public static UserService getUserService() {return service;}
	
	public User loginUser(String id,String password) {
		Connection conn = getConnection();
		User user = getUserDao().loginUser(conn,id,password);
		close(conn);
		return user;
	}
	
	public int enrollUser(User user) {
		Connection con = getConnection();
		int result = getUserDao().enrollUser(con, user);
		close(con);
		return result;
	}
}
