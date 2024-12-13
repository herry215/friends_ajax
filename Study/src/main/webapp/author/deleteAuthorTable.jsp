<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "webdb1";
  String pass = "1234";
  
  String sql = " delete from author "
             + " where author_id = ?";
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
 
  
  try{
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, author_id);
    int count = 0;
    count = pstmt.executeUpdate();
    String msg = "";
    String url = "authorForm.jsp";
    
    if(count == 1){
      msg = "데이터 삭제 성공";
    %>
      <script>
      //alert("<%=msg%>");
      location.href="<%=url%>";
      </script>
    <%
    }else{
      msg = "데이터 삭제 실패";
    %>
      <script>
      //alert("<%=msg%>");
      location.href="<%=url%>";
      </script>
    <%
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