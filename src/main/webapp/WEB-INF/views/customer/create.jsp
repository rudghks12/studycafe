<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<html>
<head>
    <title>새로운 공지사항 등록</title>
</head>
<body>
<h1>새로운 공지사항 등록</h1>
<form action="/customer/notice/create" method="POST">
    <label for="title">제목:</label>
    <input type="text" id="title" name="title" required><br><br>
    <label for="content">내용:</label><br>
    <textarea id="content" name="content" rows="5" cols="40" required></textarea><br><br>
    <input type="submit" value="등록">
</form>
</body>
</html>
