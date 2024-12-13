<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
	  $("#myForm").submit(function(event) {
		    event.preventDefault();

		    var lastName = $("#lastName").val();
		    var firstName = $("#firstName").val();
		    var email = $("#email").val();

		    if (lastName === "" || firstName === "" || email === "") {
		      $("#error-message").text("모든 항목을 입력해주세요.").show();
		      return false; // form 제출 방지
		    } else {
		      $("#error-message").hide(); // 에러 메시지 숨기기
		      // 모든 항목이 입력되었으므로 form 제출
		      $(this).unbind('submit').submit();
		    }
		  });

	// 입력값이 변경될 때마다 submit 버튼 활성화 여부 확인
	$("#lastName, #firstName, #email").on("input", function() {
	  var lastName = $("#lastName").val();
	  var firstName = $("#firstName").val();
	  var email = $("#email").val();

	  if (lastName !== "" && firstName !== "" && email !== "") {
		$("input[type=submit]").prop("disabled", false);
	  } else {
		$("input[type=submit]").prop("disabled", true);
	  }
	});
  });
</script>
<body>
	<h1>메일 리스트 가입</h1>
	<p>
		메일 리스트에 가입하려면,<br> 아래 항목을 기입하고 submit 버튼을 클릭하세요.
	</p>
	<form action="insert.jsp" method="post">
		Last name(성): <input type="text" name="ln" value=""><br>
		First name(이름): <input type="text" name="fn" value=""><br>
		Email address: <input type="text" name="email" value=""><br>
		<input type="submit" value="등록">
	</form> 
	<br>
	<p>
		<a href="list.jsp">리스트 바로가기</a>
	</p>
</body>
</html>