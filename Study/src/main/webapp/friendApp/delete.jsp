<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ page import="com.javaex.dao.GuestbookDao"%>
<%@ page import="com.javaex.dao.GuestbookDaoImpl"%>
<%@ page import="com.javaex.vo.GuestbookVo"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String password = request.getParameter("password");
	
  //String dbpassword = request.getParameter("dbPassWord");
	int no = Integer.parseInt(request.getParameter("no"));
	
	/* out.println("사용자가 입력한 비밀번호 : " + password + "<br>");
	out.println("DB의 No : " + no + "<br>");
	out.println("DB의 Password : " + dbpassword + "<br>"); */
      
	GuestbookVo vo = new GuestbookVo();
	vo.setNo(no);
	vo.setPassword(password);
	
	GuestbookDao dao = new GuestbookDaoImpl();
  if(dao.delete(vo)) {
    response.sendRedirect("list.jsp");
  }else{
    System.out.print("비밀번호가 틀렸습니다 ");
    response.sendRedirect("deleteform.jsp?no="+no);
  }
  
	
%>

