<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "hr";
  String pass = "hr";
  
  String sql = "SELECT e.employee_id ,"
		         + "e.first_name , "
		         + "TO_CHAR(e.hire_date, 'YYYY - MM - DD') AS hire_date , "
		         + "d.department_name ,"
		         + "m.FIRST_NAME ,"
		         + "e.salary "
	           + "FROM EMPLOYEES e ," 
		         + "EMPLOYEES m ,"
		         + "DEPARTMENTS d "
	           + "WHERE e.manager_id = m.EMPLOYEE_ID "
	           + "AND e.department_id = d.DEPARTMENT_ID" ;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 테이블</title>
<style type="text/css" media="screen">
*           { margin:0; padding:0 }
body { 
  font-family: '맑은 고딕' 돋움; 
  font-size:0.75em; 
  color:#333 }
  
h1 { 
  text-align:center; 
}

.tbl-ex { 
  margin:10px auto; 
  border:1px solid #333; 
  border-collapse:collapse;
}

.tbl-ex th  { 
  border:1px solid #333; 
  padding:8px;
  text-align: center;
}

.tbl-ex td  { 
  border:1px solid #333; 
  padding:8px;
  text-align: left;
} 

.tbl-ex th        { background-color:#999; font-size:1.1em; color:#fff; }
.tbl-ex tr.even     { background-color:#E8ECF6  }
.tbl-ex td:hover,
.tbl-ex td.even:hover   { background-color:#fc6; cursor:pointer }

</style>
</head>
<body>

<table width=800 class=tbl-ex>
  <tr>
    <th>사번</th>
    <th>이름</th>
    <th>고용일</th>
    <th>근무부서</th>
    <th>매니저</th>
    <th>급여</th>
  </tr>
  <%
  try{
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
    
    while(rs.next()){
      out.println("<tr>");
      out.println("<td>" + rs.getInt("employee_id") + "</td>");
      out.println("<td>" + rs.getString("first_name") + "</td>");
      out.println("<td>" + rs.getString("hire_date") + "</td>");
      out.println("<td>" + rs.getString("department_name") + "</td>");
      out.println("<td>" + rs.getString("FIRST_NAME") + "</td>");
      out.println("<td>" + rs.getInt("salary") + "</td>");
      out.println("</tr>");
    }
  }catch(Exception e){
    e.printStackTrace();
  }finally{
    try{
      if(rs != null) rs.close();
      if(pstmt != null) pstmt.close();
      if(conn != null) conn.close();
    }catch(Exception e){
      e.printStackTrace();
    }
  }
  %>
</table>
</body>
</html>