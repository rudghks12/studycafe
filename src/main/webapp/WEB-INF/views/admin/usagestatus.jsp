<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="components/adminHeader.jsp"/>

<section>
    <div>
        <div style="border-top: 2px solid #8D7B68; margin-top: 5px;"></div>
        <div style="text-align: center; margin: 50px 0px; font-size: xxx-large; color: #8D7B68; font-weight: bold;">
            이용 현황
        </div>
    </div>
    <div style="justify-content: center; display: flex">
        <nav id="usage-nav">
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-seat-tab" data-bs-toggle="tab" data-bs-target="#nav-seat" type="button" role="tab" aria-controls="nav-seat" aria-selected="true">좌석</button>
                <button class="nav-link" id="nav-locker-tab" data-bs-toggle="tab" data-bs-target="#nav-locker" type="button" role="tab" aria-controls="nav-locker" aria-selected="false">사물함</button>
            </div>
        </nav>
    </div>
    <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade show active" id="nav-seat" role="tabpanel" aria-labelledby="nav-seat-tab">
            <div style="justify-content: center; display: flex;">
                <div style="width: 700px; height: 1800px; position: absolute; z-index: 1;"></div>
                <jsp:include page="../common/seatingchart.jsp"/>
            </div>
        </div>
        <div class="tab-pane fade" id="nav-locker" role="tabpanel" aria-labelledby="nav-locker-tab">
            <div style="justify-content: center; display: flex;">
                <jsp:include page="../common/lockers.jsp"/>
            </div>
        </div>
    </div>
</section>



<script>
    selected = "X"
</script>

<style>

    #usage-nav {
        width: 1280px;
    }
</style>
<jsp:include page="../common/footer.jsp"/>