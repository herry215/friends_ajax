<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>

<%! 
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "webdb1";
  String pass = "1234";
  
  String sql = "SELECT id, "
             + " name, "
             + " phone, "
             + " email, "
             + " memo "
             + " FROM friends "
             + " ORDER BY id";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>친구정보 저장</title>
<style type="text/css" media="screen">
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    margin: 50px auto; 
    font-family: "맑은고딕";
    font-size: 0.9em;
    max-width: 800px;
}

form, table {
    width: 100%; 
    border-collapse: collapse; 
    margin: 20px 0; 
    border: 1px solid #ddd; 
    border-radius: 8px;
    overflow: hidden;
    padding: 15px;
    background: #f9f9f9;
}

form div {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

form div input, form div textarea {
    width: 75%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

form div textarea {
    height: 100px;
    resize: none;
}

form div label {
    width: 20%;
    font-weight: bold;
    text-align: right;
    margin-right: 10px;
}

button {
    width: 80px; 
    padding: 5px;
    margin: 5px;
    border: none;
    border-radius: 4px;
    background-color: #007BFF; 
    color: white;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

.tbl-ex {
    margin-top: 20px;
    border-collapse: collapse;
}

.tbl-ex th, .tbl-ex td {
    padding: 10px; 
    border: 1px solid #ddd;
    text-align: left;
}
    

.error-message {
    color: red;
    font-weight: bold;
    display: none; /* 처음에는 숨겨놓고, 에러 발생 시 display: block; 으로 변경 */

}
.error-message1 {
    color: red;
    font-weight: bold;
    display: none; /* 처음에는 숨겨놓고, 에러 발생 시 display: block; 으로 변경 */

}
.error-message2 {
    color: red;
    font-weight: bold;
    display: none; /* 처음에는 숨겨놓고, 에러 발생 시 display: block; 으로 변경 */
}

.tbl-ex tr.even { background-color: #f9f9f9; }
.tbl-ex tr:hover { background-color: #e9e9e9; cursor: pointer; }
</style>

<script>
$(function() {
    // 테이블 행 클릭 시 값 설정
    $("#tbl-ex tbody").on("click", "tr", function() {
        var id = $(this).find("td").eq(0).text().trim(); // 아이디
        var name = $(this).find("td").eq(1).text().trim(); // 이름
        var phone = $(this).find("td").eq(2).text().trim(); // 휴대폰 번호
        var email = $(this).find("td").eq(3).text().trim(); // 이메일
        var memo = $(this).find("td").eq(4).text().trim(); // 메모

        // 폼 필드에 값 설정
        $("#id").val(id);
        $("#name").val(name);
        $("#phone").val(phone);
        $("#email").val(email);
        $("#memo").val(memo);
    });

    // 버튼 클릭 시 폼 전송 처리
    $("#update").on("click", function() {
        $("#insertForm").attr("action", "updateFriendsTable.jsp").submit();
    });

    $("#insert").on("click", function() {
        $("#insertForm").attr("action", "insertFriendsTable.jsp").submit();
    });

    $("#delete").on("click", function() {
        $("#insertForm").attr("action", "deleteFriendsTable.jsp").submit();
    });
    
});
</script>

<script>
$(function() {
    // 전체 선택 / 해제
    $("#selectAll").on("click", function() {
        $("input[name='selectedIds']").prop("checked", $(this).prop("checked"));
    });

    // 삭제 버튼 클릭 시 선택된 ID들 전송
    $("#delete").on("click", function() {
        const selectedIds = $("input[name='selectedIds']:checked")
            .map(function() { return $(this).val(); })
            .get()
            .join(",");

        if (selectedIds) {
            $("<input>").attr({
                type: "hidden",
                name: "selectedIds",
                value: selectedIds
            }).appendTo("#insertForm");
            $("#insertForm").attr("action", "deleteFriendsTable.jsp").submit();
        } else {
            alert("삭제할 항목을 선택해주세요.");
        }
    });
});
</script>
<script> //한글이외의 값이 들어오면 에러문구 추가
$(document).ready(function() {
    // 이름 입력 검사
    $("#name").on("input", function() {
	    var koreanRegex = /^[ㄱ-ㅎ|가-힣]+$/; // 전체 문자열이 한글인지 확인하는 정규 표현식
	    var inputValue = $(this).val();

	    if (!koreanRegex.test(inputValue)) {
	    	$(this).val("");
	      $("#error-message").text("한글만 입력해주세요.").show();
	      
	    } else {
	      $("#error-message").hide(); // 정상적인 입력 시 오류 메시지 숨김
	    }	
    });
});
</script>
<script> //핸드폰 번호 하이픈 으로 자동 수정
$(document).ready(function() {
    $("#phone").on("input", function() {
	    var phoneRegex = /^[0-9-]+$/;
	    var inputValue = $(this).val();
	    var formattedValue = inputValue.replace(/[^0-9]/g, ''); // 숫자만 추출

	    // 번호에 맞춰 하이픈 추가
	    formattedValue = formattedValue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	    
	    if (!phoneRegex.test(inputValue)) {
	      $("#error-message1").text("번호 형식이 올바르지 않습니다. 숫자만 입력해주세요.").show();
	      $(this).val(formattedValue); // 올바른 형식으로 수정 
	    } else {
	    $("#error-message1").text("번호 형식이 올바르지 않습니다. 숫자만 입력해주세요.").hide();
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
<script>//이메일 패턴 확인
$(document).ready(function() {
    $('#emailError').hide(); 

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
<script> //전체 항목에 값이 입력되어있지 않으면 알람띄움
$(document).ready(function() {
    $("#insert").click(function() {
        // 입력 값 가져오기
        const name = $("#name").val();
        const phone = $("#phone").val();
        const email = $("#email").val();
        const memo = $("#memo").val();

        // 모든 입력 항목에 값이 있는지 확인
        if (name === "" || phone === "" || email === "") {
            alert("모든 항목을 입력해주세요.");
            return false; 
        }
    });
});
</script>
</head>
<body>

<form name="insertForm" id="insertForm" method="post">
    <div>
        <label for="name">이름</label>
            <input type="text" name="name" id="name" size="40px" placeholder="한글만 입력해주세요">
    	<div id="error-message" class="error-message"></div>
    </div>
	    <div>
	        <label for="phone">휴대폰</label>
	            <input type="text" name="phone" id="phone" maxlength="11" size="40px" placeholder="010 1234 5678 형식으로 입력해주세요">
	    	<div id="error-message1" class="error-message1"></div>
	    </div>
    <div>
        <label for="email">이메일</label>
			<input type="text" name="email" id="email" size="40px" placeholder="###@####.com 형식으로 입력해주세요.">
		<div id="emailError" class="error-message2">올바른 이메일 형식이 아닙니다.</div>
    </div>
    <div>
        <label for="memo">메모</label>
        <textarea name="memo" id="memo" placeholder="메모해주세요"></textarea>
        <div></div>
    </div>
    <div style="text-align: center;">
        <input type="hidden" name="id" id="id">
        <button type="button" id="insert">신규</button>
        <button type="button" id="update">수정</button>
        <button type="button" id="delete">삭제</button>
    </div>
</form>

<table id="tbl-ex" class="tbl-ex">
    <thead>
        <tr>
        	<th><input type="checkbox" id="selectAll"></th>
            <th>이름</th>
            <th>휴대폰</th>
            <th>이메일</th>
            <th>메모</th>
        </tr>
    </thead>
    <tbody>
        <%
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String rowClass = (rs.getRow() % 2 == 0) ? "even" : "odd";
        %>
        <tr class="<%= rowClass %>">
            <td><input type="checkbox" name="selectedIds" value="<%= rs.getInt("id") %>"></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("memo") %></td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        %>
    </tbody>
</table>

</body>
</html>
