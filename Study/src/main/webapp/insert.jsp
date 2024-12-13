<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <% 
	request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    String password = request.getParameter("password");

    String file = request.getParameter("file");
    String authorId = request.getParameter("authorId");

    out.println("<span> id ::" + id+"</span>");
    out.println("<span> pw ::" + password+"</span>");
    out.println("<span> file :: " + file+"</span>");
    out.println("<span>auid:: 	" + authorId+"</span>");
    
    
    
    
    int count = 0;
    //count = pstmt.excutedata;
    if(count == 1){
    	out.println("입력 성공");
    }else{
    	out.println("입력 실패");
    }

    %>
</body>
</html>