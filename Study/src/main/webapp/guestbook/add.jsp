<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ page import="com.javaex.dao.GuestbookDao"%>
<%@ page import="com.javaex.dao.GuestbookDaoImpl"%>
<%@ page import="com.javaex.vo.GuestbookVo"%>
<%@ page import="java.util.List"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	
	GuestbookVo vo = new GuestbookVo(name, password, content);
	GuestbookDao dao = new GuestbookDaoImpl();
	
  if(dao.insert(vo)){
    response.sendRedirect("list.jsp");
  }else{
    out.println("데이터 저장 안됨");
  }
	
%>
