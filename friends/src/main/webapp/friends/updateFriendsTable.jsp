<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%@ page import="com.javaex.dao.FriendDaoImpl" %>
<%@ page import="com.javaex.vo.FriendVo" %>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String memo = request.getParameter("memo");

    try {
        FriendDaoImpl dao = new FriendDaoImpl();
        FriendVo friend = new FriendVo(Integer.parseInt(id),name, phone, email, memo);
        int count = dao.update(friend);

        if (count > 0) {
            out.println("true");
        } else {
            out.println("false");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>