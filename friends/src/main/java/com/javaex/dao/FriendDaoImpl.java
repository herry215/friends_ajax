package com.javaex.dao;

import com.javaex.vo.FriendVo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FriendDaoImpl implements FriendDao {
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
    @Override
    public List<FriendVo> getList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<FriendVo> list = new ArrayList<FriendVo>();

        try {
            conn = getConnection();

            String query = "select id, name, phone, email, memo " +
                    "from friends "+
                    "order by 1 ";
            pstmt = conn.prepareStatement(query);

            rs = pstmt.executeQuery();
            // 4.결과처리
            while (rs.next()) {
                int no = rs.getInt("id");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String memo = rs.getString("memo");

                FriendVo vo = new FriendVo(no, name, phone, email, memo);
                list.add(vo);
            }

        } catch (SQLException e) {
            System.out.println("error:" + e);
        } finally {
            closeResources(pstmt, conn);
        }

        return list;
    }

    @Override
    public int insert(FriendVo vo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int count = 0;

        try {
            conn = getConnection();

            String query = "insert into friends values (seq_friends_id.nextval, ?, ?, ?,?)";
            pstmt = conn.prepareStatement(query);

            pstmt.setString(1, vo.getName());
            pstmt.setString(2, vo.getPhone());
            pstmt.setString(3, vo.getEmail());
            pstmt.setString(4, vo.getMemo());

            count = pstmt.executeUpdate();

            System.out.println(count + "건 등록");

        } catch (SQLException e) {
            System.out.println("error:" + e);
        } finally {
            closeResources(pstmt, conn);
        }

        return count;
    }

    @Override
    public int delete(String ids) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int count = 0;

        try {
            conn = getConnection();

            String query = "DELETE FROM friends WHERE id IN ("+ ids+ ")";
            System.out.println(query);
            pstmt = conn.prepareStatement(query);

            count = pstmt.executeUpdate();
            System.out.println(count + "건 삭제");

        } catch (SQLException e) {
            System.out.println("error:" + e);
        } finally {
            closeResources(pstmt, conn);
        }
        return count;
    }

    @Override
    public int update(FriendVo vo) {
        int count = 0;
        Connection connection = null;
        PreparedStatement pstmt = null;

        try {
            connection = getConnection();
            String query = "UPDATE friends SET name = ?, phone = ? ,email=?,memo=? WHERE id = ?";
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, vo.getName());
            pstmt.setString(2, vo.getPhone());
            pstmt.setString(3, vo.getEmail());
            pstmt.setString(4, vo.getMemo());
            pstmt.setInt(5, vo.getId());


            count = pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("error: " + e);
        } finally {
            closeResources(pstmt, connection);
        }

        return count; // 성공 시 1 이상, 실패 시 0 반환
    }

    @Override
    public boolean selectFriendByEmail(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;

        try {
            conn = getConnection();

            String query = "select id, name, phone, email, memo " +
                    "from friends "+
                    "where email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            // 4.결과처리
            if(rs.next()){
                flag = false;
            }else{
                flag = true;
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        } finally {
            closeResources(pstmt, conn);
        }

        return flag;
    }

    @Override
    public boolean selectFriendByPhone(String phone) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;

        try {
            conn = getConnection();

            String query = "select id, name, phone, email, memo " +
                    "from friends "+
                    "where phone = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, phone);

            rs = pstmt.executeQuery();
            System.out.println(rs);
            if(rs.next()){
                flag = false;
            }else{
                flag = true;
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        } finally {
            closeResources(pstmt, conn);
        }

        return flag;
    }

    private void closeResources(PreparedStatement pstmt, Connection connection) {
        try {
            if (pstmt != null) pstmt.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            System.out.println("error: " + e);
        }
    }
}
