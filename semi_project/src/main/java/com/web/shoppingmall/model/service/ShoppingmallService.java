package com.web.shoppingmall.model.service;

import static com.web.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.web.shoppingmall.model.dto.Product;
import static com.web.shoppingmall.model.dao.ShoppingmallDao.getDao;
import static com.web.common.JDBCTemplate.close;
/*
 * 	쇼핑몰 관련 서비스 클래스
 */
public class ShoppingmallService {
	private static ShoppingmallService service= new ShoppingmallService();
	public static ShoppingmallService getService() {return service;}
	private ShoppingmallService() {}
	
	/*
	 * 	각 카테고리의 총 상품의 갯수 반환 메소드
	 * 	매개변수 : 카테고리 정보
	 * 	반환 : 해당 카테고리 상품 총 갯수
	 */
	public int allProductCount(int category) {
		Connection conn=getConnection();
		int result=getDao().AllProductCount(conn, category);
		close(conn);
		return result;
	}
	
	/*
	 * 	페이지에 맞는 해당 카테고리의 상품들의 정보를 가져오는 메소드
	 * 	매개변수 : 카테고리넘버, 현재페이지숫자, 출력할상품갯수
	 * 	반환 : 상품 리스트
	 */
	public List<Product> selectProduct(int category, int cPage, int numPerpage, String sort){
		Connection conn=getConnection();
		List<Product> result=getDao().selectProduct(conn, category, cPage, numPerpage, sort);
		close(conn);
		return result;
	}
	
	
}
