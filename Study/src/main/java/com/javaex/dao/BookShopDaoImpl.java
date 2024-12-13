package com.javaex.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.BookShopVo;

public class BookShopDaoImpl implements BookShopDao {
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
			conn = DriverManager.getConnection(dburl, "webdb1", "1234");
		} catch (ClassNotFoundException e) {
			System.err.println("JDBC 드라이버 로드 실패!");
		}
		return conn;
	}
	
	public List<BookShopVo> getList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookShopVo> list = new ArrayList<BookShopVo>();

		try {
			conn = getConnection();
			String query = "select \r\n" + 
					"    b.book_id, \r\n" + 
					"    b.title, \r\n" + 
					"    b.pubs, \r\n" + 
					"    b.pub_date, \r\n" + 
					"    a.author_name\r\n" + 
					"from book b, author a\r\n" + 
					"where b.author_id = a.author_id" ;
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int book_id = rs.getInt("book_id");
				String title = rs.getString("title");
				String pubs = rs.getString("pubs");
				String pub_date = rs.getString("pub_date");
				String author_name = rs.getString("author_name");
				
				BookShopVo vo = new BookShopVo(book_id, title, pubs, pub_date, author_name);
				list.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
		}
		return list;
	}
}
