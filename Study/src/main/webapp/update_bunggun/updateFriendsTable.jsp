<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String user = "webdb";
    String pass = "1234";

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String memo = request.getParameter("memo");

    String sql = "UPDATE friends SET name = ?, phone = ?, email = ?, memo = ? WHERE id = ?";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, phone);
        pstmt.setString(3, email);
        pstmt.setString(4, memo);
        pstmt.setInt(5, Integer.parseInt(id));

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            out.println("<script>alert('친구 정보가 성공적으로 수정되었습니다.'); location.href='friendsForm.jsp';</script>");
        } else {
            out.println("<script>alert('친구 정보 수정에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>