package com.javaex.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.GuestBook2Vo;

public class Guestbook2Dao {
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
  
	public List<GuestBook2Vo> getList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GuestBook2Vo> list = new ArrayList<GuestBook2Vo>();

		try {
			conn = getConnection();
			String query = " select no, name, password, content, reg_date " + 
			               " from guestbook2 "+
					           " order by reg_date desc ";
			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();
			// 4.결과처리
			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String content = rs.getString("content");
				String regDate = rs.getString("reg_date");

				GuestBook2Vo vo = new GuestBook2Vo(no, name, password, content, regDate);
				list.add(vo);
			}

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null)  conn.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
		}

		return list;
	}
	
	public int insert(GuestBook2Vo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;

		try {
			
			conn = getConnection();

			String query = "insert into guestbook2 values (seq_guestbook2_no.nextval, ?, ?, ?,sysdate)";
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getContent());

			count = pstmt.executeUpdate();

			System.out.println(count + "건 등록");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
      try {
        if (pstmt != null) pstmt.close();
        if (conn != null)  conn.close();
      } catch (SQLException e) {
        System.out.println("error:" + e);
      }
    }
		return count;
	}
	
	public int delete(GuestBook2Vo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;

		try {
			conn = getConnection();

			String query = "delete from guestbook2 where no= ? and password= ?";
			pstmt = conn.prepareStatement(query);

			pstmt.setLong(1, vo.getNo());
			pstmt.setString(2, vo.getPassword());

			count = pstmt.executeUpdate();

			System.out.println(count + "건 삭제");

		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
		  try {
        if (pstmt != null) pstmt.close();
        if (conn != null)  conn.close();
      } catch (SQLException e) {
        System.out.println("error:" + e);
      }
		}
		return count;
	}
	
}
