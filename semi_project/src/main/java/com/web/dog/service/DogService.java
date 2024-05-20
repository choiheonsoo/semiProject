package com.web.dog.service;

import static com.web.common.JDBCTemplate.close;
import static com.web.common.JDBCTemplate.commit;
import static com.web.common.JDBCTemplate.getConnection;
import static com.web.common.JDBCTemplate.rollback;
import static com.web.dog.model.dao.DogDao.getDogDao;

import java.sql.Connection;
import java.util.List;

import com.web.dog.model.dto.Dog;

public class DogService {
	
	private static DogService service;
	private DogService() { }
	public static DogService getDogService() {
		if(service==null) service = new DogService();
		return service;
	}
	
	public int enrollDog(Dog dog) {
		Connection con = getConnection();
		int result =  getDogDao().enrollDog(con, dog);
		if(result>0){
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return result;
	}
	
	public int updateDog(Dog dog) {
		Connection con = getConnection();
		int result = getDogDao().updateDog(con, dog);
		if(result>0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
		return result;
	}
	
	public List<Dog> selectDogs(String userId){
		Connection con = getConnection();
		List<Dog> dogs = getDogDao().selectDogs(con, userId);
		close(con);
		return dogs;
	}
	
}
