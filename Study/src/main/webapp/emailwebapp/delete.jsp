<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.javaex.dao.EmaillistDao"%>
<%@ page import="com.javaex.vo.EmaillistVo"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	//out.println(no);
	
  EmaillistDao dao = new EmaillistDao();
	dao.delete(no);
  
  

	response.sendRedirect("list.jsp");
	
%>
