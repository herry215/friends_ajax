<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%@ page import="com.javaex.dao.FriendDaoImpl" %>
<%
    String selectedIds = request.getParameter("selectedIds");

    // 유효성 검사
    if (selectedIds == null || selectedIds.trim().isEmpty()) {
        out.println("false");
        return;
    }
    System.out.println(selectedIds);
    try {
        FriendDaoImpl dao = new FriendDaoImpl();
        int count = dao.delete(selectedIds);

        if (count > 0) {
            out.println("true");
        } else {
            out.println("false");
        }
    } catch (NumberFormatException e) {
        out.println("false");
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>