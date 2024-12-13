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
<style>
.error-message {
    color: red;
    font-weight: bold;
}
</style>

<body>
  <form id="guestbookForm" action="###add.jsp" method="post" 	>
    <table border='0'>
      <tr>
        <td>이름</td>
        <td><input type="text" name="name" id="name" size="40px" placeholder="한글만 입력해주세요">
        <td id="error-message" class="error-message" style="color: red; font-weight: bold; display: inline-block;"></td><%-- 이름 --%>
        <td>
    </td>
        </td>
        <tr>
        <td>휴대폰</td>
        <td><input type="text" name="phone" id="phone" maxlength="11" size="40px" placeholder="01012345678 형식으로 입력해주세요"></td>
        <td id="error-message1" class="error-message1" style="color: red; font-weight: bold; display: inline-block;"></td>  <%-- 핸드폰 --%>
      <tr>
        <td>이메일</td>
        <td><input type="text" name="email" id="email" size="40px" placeholder="hong@####.com형식으로 입력해주세요."></td>
        <td id="emailError" class="error-message2" style="color: red; font-weight: bold; display: inline-block;">올바른 이메일 형식이 아닙니다.</td>
      </tr>
      <tr>
        <td colspan="4"><textarea name="content" id="content" cols="60" rows="10" placeholder="메모해주세요. 10자 이상"></textarea></td>
      </tr>
      <tr>
        <td colspan="4"><input type="submit" value="확인" id="submitBtn"></td>
      </tr>
    </table>
  </form>
  <br>
  <br>

  <% for (GuestbookVo vo: list) { %>
  
  <script>  //아무것도 없으면 입력해달라는 창이뜨는 스크립트
    $(document).ready(function() {
      $("#submitBtn").click(function() {
        var name = $("#name").val();
        var email = $("#email").val();
        var content = $("#content").val();
        var email = $("#email").val();

        if (name.trim() === "" || email.trim() === "" || content.trim() === "" || email.trim() === "") {
          //alert("모든 항목을 입력해주세요.");
          return false;
        } else {
          $("#guestbookForm").submit();
        }
      });
    });
  </script>
  <script>   // 이름 입력시 한글만 허용하는 정규 표현식
  $(document).ready(function() {
	  $("#name").on("input", function() {
	    var koreanRegex = /^[가-힣]+$/; // 전체 문자열이 한글인지 확인하는 정규 표현식
	    var inputValue = $(this).val();

	    if (!koreanRegex.test(inputValue)) {
	      $("#error-message").text("한글만 입력해주세요.").show();
	    } else {
	      $("#error-message").hide(); // 정상적인 입력 시 오류 메시지 숨김
	    }
	  });
	});
  </script>
  
<script> //핸드폰 번호에 하이폰 입력하게끔 수정
  $(document).ready(function() {
	  $("#phone").on("input", function() {
	    // 숫자와 하이픈만 허용하는 정규 표현식
	    var phoneRegex = /^[0-9-]+$/;
	    var inputValue = $(this).val();
	    var formattedValue = inputValue.replace(/[^0-9]/g, ''); // 숫자만 추출

	    // 번호에 맞춰 하이픈 추가
	    formattedValue = formattedValue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	    
	    if (!phoneRegex.test(inputValue)) {
	      // 잘못된 형식의 입력이면 에러 메시지 표시
	      //alert("휴대폰 번호 형식이 올바르지 않습니다. 숫자만 입력해주세요.");
	      $("#error-message1").text("번호 형식이 올바르지 않습니다. 숫자만 입력해주세요.").show();
	      $(this).val(formattedValue); // 올바른 형식으로 수정
	      
	    } else {
	      $(this).val(formattedValue);
	    }
	  });
	});
  </script>

  
  <script> //010 으로 시작하는지 체크
$(document).ready(function() {
  $("#phone").load("input", function() {
    var phoneNumber = $(this).val();
    if (phoneNumber.substr(0, 3) !== "010") {
      $(this).val("010");
    }
  });
});
</script>

<script>
$(document).ready(function() {
    $('#emailError').hide(); // 처음에 오류 메시지를 숨깁니다.

    $('#email').on('input', function() {
        const email = $(this).val();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(email)) {
            $('#emailError').show(); // 이메일 형식이 올바르지 않으면 오류 메시지 표시
        } else {
            $('#emailError').hide(); // 이메일 형식이 올바르면 오류 메시지 숨김
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