<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<html>
<head>
    <title>예약</title>
</head>
<style>
    .reservationNav {
        text-align: center;
        color: #8D7B68;
        transition: color 0.3s; /* 색상 변경에 대한 transition 설정 */
        cursor: pointer;
        font-weight: 500;
    }

    .reservationNav:hover {
        color: #8D7B68;
        font-weight: 900;
    }
    .remaining {
        border: 5px solid#8D7B68;
        border-radius: 107px;
        display: inline-block; /* display 속성을 inline-block으로 변경 */
        width: 130px;
        height: 130px;
        padding: 30px 25px 29px 26px;
        margin: 60px 90px 60px 90px;
        font-size: 24px;
        text-align: center; /* 가운데 정렬을 위해 text-align 추가 */
    }
    .remaining > p {
        font-size: 13px;
        font-weight: 600;
    }
    a {
        text-decoration: none; /* 밑줄 제거 */
        color: #8D7B68; /* 부모 요소의 텍스트 색상 상속 */

    }

</style>
<jsp:include page="../common/header.jsp"/>


<section style="justify-content: center; display: flex;">

    <table style="width: 1020px; height: 300px">
        <tr>
            <td style="width: 200px; justify-content: center;"></td>
            <td style="width: 700px; font-weight: 900;color: #8D7B68; font-size: 30px; "><b>예약</b></td>
        </tr>
        <tr>
            <td class="reservationNav"><a style="text-decoration: none; color: #8D7B68;" href="${ path }/reservation/reservationHome/timereservation">시간제 예약</a></td>
            <td rowspan="4"><a><img src="${ path }/images/reservation1.png"></a></td>
        </tr>
        <tr>
            <td class="reservationNav"><a style="text-decoration: none; color: #8D7B68;" href="${ path }/reservation/reservationHome/fixedtermseat">기간제 예약</a></td>
        </tr>
        <tr>
            <td class="reservationNav"><a style="text-decoration: none; color: #8D7B68;" href="${ path }/reservation/reservationHome/studyroomreservation">스터디룸</a></td>
        </tr>
        <tr>
            <td class="reservationNav"><a style="text-decoration: none; color: #8D7B68;" href="${ path }/reservation/reservationHome/selectlocker">사물함</a></td>
        </tr>

    </table>
</section>
<br> <br>
<section style="justify-content: center;display: flex;">
    <div style="border-bottom: 3px solid;color: #8D7B68;width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>


<br><br> <br> <br>

<section style="justify-content: center; display: flex;">
    <div class="d-grid gap-2 col-3">
        <button type="button" class="btn text-white" style="background-color: #8D7B68;">
            <a style="text-decoration: none; color: white;" href="${ path }/reservation/reservationHome/paymentcompleted">결제완료 페이지</a></button>
    </div>
</section>

<br><br><br>

<section style="justify-content: center; display: flex;">
    <table>
        <tr>
            <td class="remaining"><p>개인석</p></td>
            <td class="remaining"><p>스터디룸</p></td>
            <td class="remaining"><p>사물함</p></td>
        </tr>
    </table>
</section>



<br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="../common/footer.jsp"/>
</html>
