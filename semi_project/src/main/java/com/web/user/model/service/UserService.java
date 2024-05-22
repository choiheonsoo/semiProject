package com.web.user.model.service;

import static com.web.common.JDBCTemplate.*;
import static com.web.user.model.dao.UserDao.getUserDao;
import static com.web.dog.model.dao.DogDao.getDogDao;
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
	public User searchUserByEmail(String email) {
		Connection con = getConnection();
		User user = getUserDao().searchUserByEmail(con, email);
		close(con);
		return user;
	}
	public String getDogImg(String id) {
		Connection con = getConnection();
		String dogImg = getDogDao().getDogImg(con,id);
		close(con);
		return dogImg;
	}
	
	public int enrollUser(User user) {
		Connection con = getConnection();
		int result = getUserDao().enrollUser(con, user);
		if(result>0) {
			System.out.println(result);
			close(con);
		} else {
			rollback(con);
		} return result;
	}
	
	public int updateUser(User user) {
		Connection con = getConnection();
		int result = getUserDao().updateUser(con, user);
		if(result>0) {
			close(con);
		} else {
			rollback(con);
		} return result;
	}
	
	public String searchUserId(String email, String name) {
		Connection con = getConnection();
		String userId = getUserDao().searchUserId(con, email, name);
		close(con);
		return userId;
	}
	
	public String searchUserById(String id) {
		Connection con= getConnection();
		String result = getUserDao().searchUserById(con, id);
		close(con);
		return result;
	}
	
	public User selectUser(String id, String email) {
		Connection con = getConnection();
		User user = getUserDao().selectUser(con, id, email);
		close(con);
		return user;
	}
	
	public int changeUserPw(String id, String pw) {
		Connection con = getConnection();
		int result = getUserDao().changeUserPw(con, id, pw);
		if(result>0) {
			close(con);
		} else {
			rollback(con);
		}
		return result;
	}
}
