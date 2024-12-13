<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "webdb1";
  String pass = "1234";
  
  String sql = " Select author_id, " 
             + " author_name,"
             + " author_desc"
             + " from author"
             + " ORDER BY author_id";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js?v=1"></script>
<title>저자정보 저장</title>
<style type="text/css" media="screen">
*           { margin:0; padding:0 }
body        { font-family: '맑은 고딕' 돋움; font-size:0.75em; color:#333 }

.tbl-ex     { margin:10px auto; border:1px solid #333; border-collapse:collapse; border-left-width:0; border-right-width:0 }

.tbl-ex th, 
.tbl-ex td  { border:1px solid #333; padding:8px; border-left-width:1; border-right-width:1  } 

.tbl-ex th  { background-color:#999; font-size:1.1em; color:#fff; border-top-width:2px; border-bottom-width:2px }
.tbl-ex td  { border-style:solid }
.tbl-ex tr.even     { background-color:#E8ECF6  }

.tbl-ex tr:hover,
.tbl-ex tr.even:hover   { background-color:#fc6; cursor:pointer }

</style>

<script>
function selectAuthor(tableRow) {
  // Get references to the table cells (assuming there are 3 columns)
  var authorIdCell = tableRow.cells[0];
  var authorNameCell = tableRow.cells[1];
  var authorDescCell = tableRow.cells[2];

  // Extract text content from table cells
  var authorId = authorIdCell.textContent.trim();
  var authorName = authorNameCell.textContent.trim();
  var authorDesc = authorDescCell.textContent.trim();

  // Update the text input fields with the extracted values

  document.getElementById("author_id").value = authorId.replace("(삭제)","");
  document.getElementById("author_name").value = authorName;
  document.getElementById("author_desc").value = authorDesc;
}
</script>

<script>
	$(function( ){
		$("#save").on("click", function() {	
			$("#insertForm").attr("action","updateAuthor.jsp");
			$("#insertForm").submit();
		});
		$("#new").on("click", function() {
			$("#insertForm").attr("action","insertAuthorTable33333333 copy.jsp");
			$("#insertForm").submit();
		});
	});
</script>

<script>
function validateForm() {
  var authorName = document.getElementById("author_name").value;
  var authorDesc = document.getElementById("author_desc").value;

  var errorMessage = "";

  if (authorName === "") {
    errorMessage += "저자명을 입력해주세요.\n";
  }
  if (authorDesc === "") {
    errorMessage += "설명을 입력해주세요.\n";  // This line checks for empty description
  }

  if (errorMessage !== "") {
    document.getElementById("error_message").textContent = errorMessage;
    return false;
  } else {
    document.getElementById("error_message").textContent = "";
    return true;
  }
}
</script>
</head>

<body>
  <table width="550" class=tbl-ex>
    <tr><td>
      <form name="insertForm" id="insertForm" method="post" action="insertAuthorTable33333333 copy.jsp" onsubmit="return validateForm()">
        <input type="hidden" name="author_id" id="author_id" />
        저자명 : <input type="text" name="author_name" id="author_name" required />
        <div id="error_message" style="color: red; margin-bottom: 20px;"></div> 설명 : <input type="text" name="author_desc" id="author_desc"/>
        &nbsp;<input type="button" id="save" value="업데이트"/>
        &nbsp;<input type="button" id="new" value="신규"/>
      </form>
    </td></tr>
  </table>
  <br>
  
  <table width=550 class=tbl-ex>
  <tr>
    <th>저자번호</th>
    <th>저자명</th>
    <th>설명</th>
  </tr>
  
  <%
  try{
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
    int count = 0;
    while(rs.next()){
      count++;
      
      if(count%2 == 0){
    	  out.println("<tr class='even' onclick='selectAuthor(this)'>");
        
      }else{
    	  out.println("<tr class='odd' onclick='selectAuthor(this)'>");
      }
      
      out.println("<td>" + rs.getInt("author_id")+ "<a href='deleteAuthorTable.jsp?author_id="+rs.getInt("author_id")+"' >(삭제)</a>" + "</td>");
      out.println("<td>" + rs.getString("author_name") + "</td>");
      out.println("<td>" + rs.getString("author_desc") + "</td>");
      
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