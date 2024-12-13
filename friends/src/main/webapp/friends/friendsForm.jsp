<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*" %>
<%@ page import="com.javaex.dao.FriendDaoImpl" %>
<%@ page import="com.javaex.vo.FriendVo" %>
<%@ page import="java.util.List" %>

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
    flex-direction: column; /* 세로로 배치 */
    justify-content: flex-start;
    align-items: flex-start;
    margin-bottom: 20px; /* div 간격 조정 */
    height: auto; /* 높이를 내용에 맞게 */
}

form div label {
    width: 100%; /* 세로로 배치되므로 100% */
    font-weight: bold;
    margin-bottom: 5px;
}

form div input,
form div textarea,
form div button {
    width: calc(100% - 20px); /* 동일한 가로 길이, div padding 고려 */
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

form div textarea {
    resize: none;
    height: 100px;
}

form div button {
    width: 100px; /* 동일 버튼 너비 */
    padding: 8px;
    margin-top: 10px;
    background-color: #007BFF;
    color: white;
    cursor: pointer;
}

form div button:hover {
    background-color: #0056b3;
}

.error-message {
    margin-top: 5px; /* 입력 필드와 메시지 간격 */
    color: red;
    font-size: 0.8em;
    align-self: flex-start; /* 왼쪽 정렬 */
    white-space: nowrap; /* 메시지가 길어져도 줄바꿈되지 않도록 */
}

button {
    width: 100px;
    padding: 8px;
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

.tbl-ex tr.even { background-color: #f9f9f9; }
.tbl-ex tr:hover { background-color: #e9e9e9; cursor: pointer; }
</style>

<script>
    function refreshTable() {
        $.ajax({
            url: "/test222/friends/getFriendsTable.jsp", // 테이블 데이터만 반환하는 JSP
            type: "get",
            dataType: "html", // HTML 형태로 데이터 받음
            success: function(data) {
                $("#tbl-ex tbody").html(data); // tbody 내용만 교체
            },
            error: function(XHR, status, error) {
                console.error("테이블 갱신 실패: " + status + " : " + error);
            }
        });
    }
    function autoHyphen(value){
        return value
            .replace(/[^0-9]/g, "")
            .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3")
            .replace(/(\-{1,2})$/g, "");
    };

$(function() {
    let isPhoneChecked = false; // phone_check 여부
    let isEmailChecked = false; // email_check 여부

    refreshTable();

    $("#name").on("input", function() {
        var koreanRegex = /^[ㄱ-ㅎ|가-힣]+$/; // 전체 문자열이 한글인지 확인하는 정규 표현식
        const maxLength = 10;
        let inputValue = $(this).val();

        if (inputValue.length > maxLength) {
            $(this).val(inputValue.slice(0, maxLength));
        }
        if (!koreanRegex.test(inputValue)) {
            $(this).val("");
            $("#error-message").text("한글만 입력해주세요.").show();

        } else {
            $("#error-message").hide(); // 정상적인 입력 시 오류 메시지 숨김
        }
    });

    $("#phone").on("input", function () {
        let inputValue = $(this).val().replace(/[^0-9]/g, ""); // 숫자 이외 제거
        if (inputValue.length > 11) {
            inputValue = inputValue.slice(0, 11); // 최대 길이 11로 제한
        }
        const formattedValue = autoHyphen(inputValue); // 형식화
        $(this).val(formattedValue); // 입력 필드 값 업데이트
    });

    $("#email").on("input", function () {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식
        let inputValue = $(this).val();

        if (!emailRegex.test(inputValue)) {
            $("#email-error").text("유효한 이메일 형식이 아닙니다.").css("color", "red").show();
            if(inputValue.length==0){
                $("#email-error").hide();//길이가 0일때
            }
        }
        else {
            $("#email-error").hide(); // 유효한 이메일 입력 시 메시지 숨김
        }
    });


    $("#insert, #update").click(function() {
        // 입력 값 가져오기
        const name = $("#name").val();
        const phone = $("#phone").val();
        const email = $("#email").val();
        const memo = $("#memo").val();

        // 모든 입력 항목에 값이 있는지 확인
        if (name === "" || phone === "" || email === ""||memo==="") {
            alert("모든 항목을 입력해주세요.");
            return false;
        }
    });
    // 테이블 행 클릭 시 값 설정
    $("#tbl-ex tbody").on("click", "tr", function() {
        var id = $(this).find("td").eq(0).find("input[type='checkbox']").val(); // 아이디
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

    $("#phone_check").on("click", function() {
        const phone = $("#phone").val();
        if (!phone) {
            $("#phone-error").text("휴대폰 번호를 입력해주세요.").show();
            return;
        }

        const params = { phone: phone };
        $.ajax({
            url: "/test222/friends/api/phone.jsp",
            type: "post",
            data: params,
            dataType: "json",
            success: function(result) {
                if (result) {
                    $("#phone-error").text("사용 가능한 번호입니다.").css("color", "green").show();
                    isPhoneChecked = true; // 검사 완료
                } else {
                    $("#phone-error").text("중복된 번호입니다.").css("color", "red").show();
                    isPhoneChecked = false;
                }
            },
            error: function(XHR, status, error) {
                $("#phone-error").text("번호 검사 중 오류 발생.").css("color", "red").show();
            }
        });
    });

    $("#email_check").on("click", function() {
        const email = $("#email").val();
        if (!email) {
            $("#email-error").text("이메일을 입력해주세요.").show();
            return;
        }

        const params = { email: email };
        $.ajax({
            url: "/test222/friends/api/email.jsp",
            type: "post",
            data: params,
            dataType: "json",
            success: function(result) {
                if (result) {
                    $("#email-error").text("사용 가능한 이메일입니다.").css("color", "green").show();
                    isEmailChecked = true; // 검사 완료
                } else {
                    $("#email-error").text("중복된 이메일입니다.").css("color", "red").show();
                    isEmailChecked = false;
                }
            },
            error: function(XHR, status, error) {
                $("#email-error").text("이메일 검사 중 오류 발생.").css("color", "red").show();
            }
        });
    });


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
            var params = {selectedIds:selectedIds}
            $.ajax({
                url : "/test222/friends/deleteFriendsTable.jsp",
                type : "post",
                data : params,
                dataType : "json",
                success : function(result) {
                    console.log(result);
                    if(result){
                        alert("delete success");
                        refreshTable(); // 테이블 내용만 갱신
                    }else {
                        alert("delete fail");
                    }
                },
                error : function(XHR, status, error) {
                    console.error(status + " : " + error);
                }
            });
        } else {
            alert("삭제할 항목을 선택해주세요.");
        }
    });
    // 버튼 클릭 시 폼 전송 처리
    $("#update").on("click", function() {
        var params = { id:$("#id").val(),name:$("#name").val(),
            phone:$("#phone").val(),email:$("#email").val(),memo:$("#memo").val()}
        $.ajax({
            url : "/test222/friends/updateFriendsTable.jsp",
            type : "post",
            data : params,
            dataType : "json",
            success : function(result) {
                console.log(result);
                if(result){
                    alert("update success");
                    refreshTable(); // 테이블 내용만 갱신
                }else {
                    alert("update fail");
                }
            },
            error : function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    $("#insert").on("click", function() {
        if (!isPhoneChecked || !isEmailChecked) {
            alert("휴대폰과 이메일 검사를 완료해주세요.");
            return;
        }

        const name = $("#name").val();
        const phone = $("#phone").val();
        const email = $("#email").val();
        const memo = $("#memo").val();

        if (!name || !phone || !email || !memo) {
            alert("모든 항목을 입력해주세요.");
            return;
        }

        const params = { name: name, phone: phone, email: email, memo: memo };
        $.ajax({
            url: "/test222/friends/insertFriendsTable.jsp",
            type: "post",
            data: params,
            dataType: "json",
            success: function(result) {
                if (result) {
                    alert("신규 등록 성공!");
                    refreshTable();
                } else {
                    alert("신규 등록 실패.");
                }
            },
            error: function(XHR, status, error) {
                alert("신규 등록 중 오류 발생.");
            }
        });
    });

});
</script>
</head>
<body>
<div id="particles-js"></div>
<div id="apptitle">
    <h1>Friends App</h1>
</div>
<form name="insertForm" id="insertForm" method="post">
    <div>
        <label for="name">이름</label>
        <input type="text" name="name" id="name" placeholder="이름을 입력하세요">
        <span class="error-message" id="name-error" style="display: none; color: red; font-size: 0.8em;"></span>
    </div>
    <div>
        <label for="phone">휴대폰</label>
        <input type="text" name="phone" id="phone" placeholder="010-XXXX-XXXX">
        <button type="button" id="phone_check">중복검사</button>
        <span class="error-message" id="phone-error" style="display: none;">유효한 번호를 입력하세요.</span>
    </div>

    <div>
        <label for="email">이메일</label>
        <input type="text" name="email" id="email" placeholder="example@example.com">
        <button type="button" id="email_check">중복검사</button>
        <span class="error-message" id="email-error" style="display: none;">유효한 이메일을 입력하세요.</span>
    </div>

    <div>
        <label for="memo">메모</label>
        <textarea name="memo" id="memo" placeholder="간단한 메모를 작성하세요"></textarea>
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

    </tbody>
</table>

</body>
</html>
