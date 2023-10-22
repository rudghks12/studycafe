<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="../common/header.jsp"/>
<style>
    #complete {
        min-height: 1000px;
    }

    .step-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 50px;
        margin-bottom: 30px;
    }

    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 150px;
        height: 120px;
    }

    .step-number {
        width: 60px;
        height: 60px;
        background-color: #ccc;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 30px;
    }

    .step3 {
        background-color: #8D7B68;
        color: white;
    }

    .step-text {
        margin-top: 10px;
        font-weight: bold;
    }

    #enroll_icon {
        width: 200px;
        height: 200px;
        display: block;
        margin: 0 auto;
        margin-top: 70px;
        margin-bottom: 70px;
    }

    #enroll_complete {
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    #enroll_button {
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 100px;
    }

    #enroll_home {
        background-color: #8D7B68;
        color: white;
        font-size: 18px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        margin-top: 20px;
        margin-bottom: 20px;
        width: 360px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
    }

    #enroll_home:hover {
        background-color: #685948;
    }
</style>

<section id="complete">
    <div class="step-container">
        <div class="step">
            <div class="step-number">01</div>
            <div class="step-text">이용약관동의</div>
        </div>
        <div class="step">
            <div class="step-number">02</div>
            <div class="step-text">회원가입</div>
        </div>
        <div class="step">
            <div class="step-number step3">03</div>
            <div class="step-text">가입완료</div>
        </div>
    </div>
    <div style="border-top: 2px solid #8D7B68; margin-bottom: 50px;"></div>

    <div id="enroll_complete">
        <i class="fa-regular fa-circle-check fa-bounce" id="enroll_icon" style="color: #8D7B68;"></i>
        <h1>회원가입이 완료되었습니다.</h1>
        <h3>${ enroll_name } 님 환영합니다~!</h3>
    </div>
    <div id="enroll_button">
        <button id="enroll_home" onclick="location.href='${ path }/'">홈으로</button>
    </div>
</section>


<jsp:include page="../common/footer.jsp"/>