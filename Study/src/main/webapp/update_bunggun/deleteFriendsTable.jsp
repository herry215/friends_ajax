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

    String selectedIds = request.getParameter("selectedIds");

    // 유효성 검사
    if (selectedIds == null || selectedIds.trim().isEmpty()) {
        out.println("<script>alert('삭제할 항목이 선택되지 않았습니다.'); location.href='friendsForm.jsp';</script>");
        return;
    }

    String sql = "DELETE FROM friends WHERE id IN (" + selectedIds + ")";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);
        pstmt = conn.prepareStatement(sql);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            out.println("<script>alert('선택한 친구 정보가 성공적으로 삭제되었습니다.'); location.href='friendsForm.jsp';</script>");
        } else {
            out.println("<script>alert('친구 정보 삭제에 실패했습니다.'); history.back();</script>");
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 입력 형식입니다.'); history.back();</script>");
        e.printStackTrace();
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