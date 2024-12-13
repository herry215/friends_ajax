<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javaex.dao.FriendDaoImpl" %>
<%@ page import="com.javaex.vo.FriendVo" %>
<%
    try {
        FriendDaoImpl dao = new FriendDaoImpl();
        List<FriendVo> list = dao.getList();

        for (FriendVo li : list) {
            String rowClass = (li.getId() % 2 == 0) ? "even" : "odd";
%>
<tr class="<%= rowClass %>">
    <td><input type="checkbox" name="selectedIds" value="<%= li.getId() %>"></td>
    <td><%= li.getName() %></td>
    <td><%= li.getPhone() %></td>
    <td><%= li.getEmail() %></td>
    <td><%= li.getMemo() %></td>
</tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>