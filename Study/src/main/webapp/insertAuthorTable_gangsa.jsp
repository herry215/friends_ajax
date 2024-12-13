<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "webdb1";
  String pass = "1234";
  
  String sql = " INSERT INTO AUTHOR "
             + " VALUES (seq_author_id.nextval, ?, ?)";
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
  
  out.println("<span> author_id:"+ author_id + "</span><br>");
  out.println("<span> author_name:"+ author_name + "</span><br>");
  out.println("<span> author_desc:"+ author_desc + "</span><br>");
  
  try{
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, author_name);
    pstmt.setString(2, author_desc);
    int count = 0;
    count = pstmt.executeUpdate();
    
    if(count == 1){
      out.println("<h1> 데이터 입력 성공 </h1>");
    }else{
      out.println("<h1> 데이터 입력 실패 </h1>");
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