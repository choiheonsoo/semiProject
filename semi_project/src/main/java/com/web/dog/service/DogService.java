package com.web.dog.service;

import java.sql.Connection;

import static com.web.common.JDBCTemplate.*;
import static com.web.dog.model.dao.DogDao.*;
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
	
}
