package com.web.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	
	public static Connection getConnection() {
		Properties driver = new Properties();
		Connection conn = null;
		String path=JDBCTemplate.class.getResource("/driver.properties").getPath();
		try(FileReader fr = new FileReader(path)){
			driver.load(fr);
			Class.forName(driver.getProperty("driver"));
			conn = DriverManager.getConnection(
					driver.getProperty("url"),
					driver.getProperty("user"),
					driver.getProperty("pwd")
					);
			conn.setAutoCommit(false);
		}catch(ClassNotFoundException | SQLException | IOException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection var) {
		try {
			if(var != null && !var.isClosed()) {
				var.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(Statement var) {
		try {
			if(var != null && !var.isClosed()) {
				var.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet var) {
		try {
			if(var != null && !var.isClosed()) {
				var.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void commit(Connection var) {
		try {
			if(var != null && !var.isClosed()) {
				var.commit();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void rollback(Connection var) {
		try {
			if(var != null && !var.isClosed()) {
				var.rollback();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
