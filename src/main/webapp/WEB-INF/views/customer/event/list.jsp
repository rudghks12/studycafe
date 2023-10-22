<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../../common/header.jsp"/>

<style>
    /* 글쓰기 버튼 스타일 */
    .listbutton {
        background-color: #8D7B68;
        color: white;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 18px;
        border: none; /* 테두리 없앰 */
        margin: 20px 0px;
        margin-right: 120px;
    }
    .listbutton:hover{
        background-color: #685948;
    }

    .listbutton2{
        background-color: #8D7B68;
        color: white;
        border-radius: 5px;
        padding: 10px 10px;
        font-size: 15px;
        border: none; /* 테두리 없앰 */
        margin: 20px 0px;
        margin-right: 120px;
    }
    .listbutton2:hover{
        background-color: #685948;
    }

    /* 커스텀 링크 스타일 */
    .custom-link {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }

    /* 이미지 스타일 */
    img {
        max-width: 1280px;
        height: auto;
    }

    .image-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(255, 255, 255, 0.001); /* 텍스트 배경의 투명도 설정 */
        padding: 20px; /* 원하는 크기로 설정합니다. */
        font-size: 36px; /* 원하는 글꼴 크기로 설정합니다. */
        font-weight: bold; /* 글씨를 굵게 설정합니다. */
        color: white; /* 글씨색을 흰색으로 설정합니다. */
    }


    /*  페이지네이션 스타일   */
    .page-link {
        color: black;
        /*font-weight: bold;*/
    }

    .page-link.disabled {
        color: white;
        background-color: #8D7B68;
        border-color: #8D7B68;
    }

    .page-link:hover:not(.page-link.active) {
        color: #8D7B68;
    }

    .page-link:focus {
        box-shadow: none;
    }

    /* 테이블 스타일 */
    table {
        /*border-collapse: collapse;*/
        width: 80%;
        font-size: 16px;
        color: #4a4a4a; /* 텍스트 색상 */
        margin: 0 auto;
    }

    .table-th, .table-td {
        border-bottom: 1px solid #ddd;
        padding: 12px;
        text-align: center;
        vertical-align: middle; /* 수직 중앙 정렬을 위한 속성 추가 */
    }


    .table-th {
        font-size: 24px;
        color: black;
        text-align: left;
        margin-right: 50px; /* 오른쪽 여백 추가 */
    }

    .table-td {
        text-align: left;
        margin-right: 10px; /* 오른쪽 여백 추가 */
    }


    .table-tr:hover {
        background-color:#cfdad9;
        color:white;
        cursor: pointer;
    }/* 마우스 오버시 배경과 글자 색상 변경 */

    /* headname 클래스 배경색 */
    .headname {

        width: 80%;
        margin: auto;
        margin-top: 60px;
        background-color: rgba(47, 20, 15, 0.64); /* 원하는 배경색 코드로 설정 */
        border-bottom: 3px solid #dfe0e1; /* 아래쪽 선 추가 (검은색) */

    }
    .table-header {
        font-size: 22px; /* Make the font size larger */
        font-weight: bold; /* Make the font bold */
        text-align: center;
        color: black;
        /*background: whitesmoke;*/
        border-bottom: 3px solid #8D7B68;

    }
    .table-header th {
        padding-bottom: 10px;
    }
    .buttonsearch{
    background-color: #8D7B68; color: white; border: none; border-radius: 5px;padding: 4px 20px;
    }
    .buttonsearch:hover{
        background-color: #685948;
    }
    /* 푸터 스타일 */
    footer {
        box-shadow: none !important;
        border: none !important;
    }
</style>

<section sstyle= "margin: auto; max-width:1280px;">
    <div>
        <div style="position: relative; margin-bottom: 80px;">
            <img src="${path}/images/notice2.png.jpg" alt="이벤트">
            <div class="image-text">이벤트</div>
        </div>

        <c:if test="${ empty list }">
            <h3 style=" min-height: 600px;">진행중인 이벤트가 없습니다.  <a href="${path}/customer/event/list" class="custom-link"> <button class="listbutton2" style="margin-left: 50px;"> 뒤로가기</button></h3>

        </c:if>

        <c:if test="${not empty list}">

        <form action="${path}/customer/event/list" method="get" style="text-align: right; margin-right: 150px;">
            <div style="display: inline-block;">
                <input type="text" name="searchTitle" placeholder="제목으로 검색">
                <input type="submit"  class="buttonsearch" value="검색" >
            </div>
        </form>

            <table>

                <!-- 테이블 헤더 부분 수정 -->

                <tr class="table-header" >
                    <th>진행 상태</th>
                    <th>이벤트</th>
                    <th>등록일</th>
                </tr>


                <c:forEach var="event" items="${list}">
                    <tr class="table-tr">
                        <td class="table-td" style="text-align: center">
                            <c:choose>
                                <c:when test="${event.kind == '진행중'}">
                                    <span style="font-weight: bold; color:#f12424; font-size: 15px; min-height: 24px;">[${event.kind}]</span>
                                </c:when>
                                <c:when test="${event.kind == '종료됨'}">
                                    <span style="color: rgba(59,58,58,0.94); font-size: 15px; min-height: 24px;">[${event.kind}]</span>
                                </c:when>
                                <c:otherwise>
                                    [${event.kind}]
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="table-td" style="text-align: center;">
                            <a href="${path}/customer/event/detail/${event.no}" class="custom-link">
                                <c:choose>
                                    <c:when test="${event.kind == '진행중'}">
                                        <span style="color: #000000; font-weight: bold;">${event.title}</span>
                                    </c:when>
                                    <c:when test="${event.kind == '종료됨'}">
                                        <span style="color: gray;">${event.title}</span>
                                    </c:when>
                                    <c:otherwise>${event.title}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td class="table-td table-date" style="text-align: center">
            <span style="color: gray;">
                <c:choose>
                    <c:when test="${event.kind == '진행중'}">
                        <span style="color: #000000;" >
                            <fmt:formatDate value="${event.createDate}" pattern="yyyy.MM.dd" />
                        </span>
                    </c:when>
                    <c:otherwise>
                        <fmt:formatDate value="${event.createDate}" pattern="yyyy.MM.dd" />
                    </c:otherwise>
                </c:choose>
            </span>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>


        <div style="display: flex; justify-content: center; align-items: center; margin: 30px;">
            <nav aria-label="Page navigation example" style="display: flex;">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=1">
                        <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                    </a></li>
                    <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=${pageInfo.prevPage}">
                        <span class="material-symbols-outlined">keyboard_arrow_left</span>
                    </a></li>
                    <c:forEach var="current" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                        <c:if test="${empty param.page}">
                            <c:if test="${current == 1}">
                                <li class="page-item"><a class="page-link active disabled" href="${path}/customer/event/list?page=${current}">${current}</a></li>
                            </c:if>
                            <c:if test="${current != 1}">
                                <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=${current}">${current}</a></li>
                            </c:if>
                        </c:if>
                        <c:if test="${not empty param.page}">
                            <c:if test="${current == param.page}">
                                <li class="page-item"><a class="page-link active disabled" href="${path}/customer/event/list?page=${current}">${current}</a></li>
                            </c:if>
                            <c:if test="${current != param.page}">
                                <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=${current}">${current}</a></li>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=${pageInfo.nextPage}">
                        <span class="material-symbols-outlined">keyboard_arrow_right</span>
                    </a></li>
                    <li class="page-item"><a class="page-link" href="${path}/customer/event/list?page=${pageInfo.maxPage}">
                        <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                    </a></li>
                </ul>
            </nav>

        </div>
        <security:authorize access="hasRole('ROLE_ADMIN')">
        <div style="position: relative;">
            <a href="${path}/customer/event/add" class="custom-link" style="position: absolute; top: -100px; right: 50px;">
                <button class="listbutton">글쓰기</button>
            </a>
        </div>
        </security:authorize>


</section>
<script>

</script>

<jsp:include page="../../common/footer.jsp"/>
