<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%@ page import="com.javaex.vo.FriendVo" %>
<%@ page import="com.javaex.dao.FriendDaoImpl" %>
<%
  String phone = request.getParameter("phone");

  try {
    FriendDaoImpl dao = new FriendDaoImpl();

    if (dao.selectFriendByPhone(phone)) {
      System.out.println("db에 폰 없음");
      out.println("true");
    } else {
      System.out.println("db에 폰 있음");

      out.println("false");
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>