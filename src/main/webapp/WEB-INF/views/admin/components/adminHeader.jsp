<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<section>
    <div style="display: flex; align-items: center; margin-bottom: -25px;">
        <i class="fa-solid fa-user-tie fa-2xl" style="color: #8D7B68; width: 50px; height: 50px; margin: 25px 25px;"></i>
        <div style="font-size: x-large; margin-left: -20px; color: #8D7B68;">관리자 페이지</div>
    </div>
</section>