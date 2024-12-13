<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ page import="com.javaex.dao.GuestbookDao"%>
<%@ page import="com.javaex.dao.GuestbookDaoImpl"%>
<%@ page import="com.javaex.vo.GuestbookVo"%>

<%@ page import="java.util.List"%>

<%
  GuestbookDao dao = new GuestbookDaoImpl();

  List<GuestbookVo> list = dao.getList();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록 리스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
  <form id="guestbookForm" action="add.jsp" method="post">
    <table border='1'>
      <tr>
        <td>이름</td>
        <td><input type="text" name="name" id="name" size="30px"></td>
        <td>이메일</td>
        <td><input type="password" name="password" id="password" size="20px"></td>
      </tr>
      <tr>
        <td colspan="4"><textarea name="content" id="content" cols="60" rows="10"></textarea></td>
      </tr>
      <tr>
        <td colspan="4"><input type="submit" value="확인" id="submitBtn"></td>
      </tr>
    </table>
  </form>
  <br>
  <br>

  <% for (GuestbookVo vo: list) { %>
  
    <script>
    $(document).ready(function() {
      $("#submitBtn").click(function() {
        var name = $("#name").val();
        var password = $("#password").val();
        var content = $("#content").val();

        if (name.trim() === "" || password.trim() === "" || content.trim() === "") {
          alert("모든 항목을 입력해주세요.");
          return false;
        } else {
          $("#guestbookForm").submit();
        }
      });
    });
  </script>
  
  <form action="deleteform.jsp" method="get">
    <table border='1'>
      <tr>
        <td width="10px"><%= vo.getNo() %></td>
        <td width="30px"><%= vo.getName() %></td>
        <td width="50px"><%= vo.getRegDate() %></td>
        <td width="20px"><input type="submit" value="삭제"></td>
      </tr>
      <tr>
        <td colspan="4">
          <textarea name="content" cols="60" rows="4" readonly><%= vo.getContent() %></textarea>
        </td>
      </tr>
    </table>
    <input type="hidden" name="no" value="<%= vo.getNo() %>">
  </form>

  <% } %>

</body>
</html>