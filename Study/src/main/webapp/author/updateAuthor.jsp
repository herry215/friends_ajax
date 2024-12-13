<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "webdb1";
  String pass = "1234";
  
  String sql = " UPDATE author SET author_name = ?, author_desc = ? WHERE author_id = ?";
%>

<!DOCTYPE html>	
<html>
<head>
  <meta charset="UTF-8">
  <title>저자정보</title>
</head>
<body>

  <%
  request.setCharacterEncoding("UTF-8");
  
  String author_id = request.getParameter("author_id");
  String author_name = request.getParameter("author_name");
  String author_desc = request.getParameter("author_desc");
  

  
  try{
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url, user, pass);
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, author_name);
	    pstmt.setString(2, author_desc);
		pstmt.setInt(3, Integer.parseInt(author_id));
	    
	    int count = 0;
	    count = pstmt.executeUpdate();
	    String msg = "";
	    String url = "authorForm.jsp";
	    
	    if(count == 1){
	        out.println("<script>");
	        out.println("alert('저자 정보 수정 성공!');");
	        out.println("location.href='authorForm.jsp';"); // Redirect to index.jsp
	        out.println("</script>");
	    } else {
	        out.println("저자 정보 수정 실패!");
	     }
	  }catch(Exception e){
	    e.printStackTrace();
	  }finally{
	    try{
	      if(pstmt != null) pstmt.close();
	      if(conn != null) conn.close();
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	  }
	  
	  %>
 
</body>
</html>